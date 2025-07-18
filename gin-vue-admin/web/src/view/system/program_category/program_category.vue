<template>
  <div>
    <div class="gva-table-box">
      <div class="gva-btn-list">
        <el-button type="primary" icon="plus" @click="openDialog()">新增</el-button>
        <el-button icon="delete" style="margin-left: 10px;" :disabled="!multipleSelection.length" @click="onDelete">
          删除
        </el-button>

      </div>
      <el-table
          ref="multipleTable"
          style="width: 100%"
          tooltip-effect="dark"
          :data="tableData"
          row-key="ID"
          @selection-change="handleSelectionChange"
          @sort-change="sortChange"
      >
        <el-table-column type="selection" width="55"/>

        <el-table-column align="left" label="分类名称" prop="categoryName"/>

        <el-table-column align="left" label="状态" prop="status">
          <template #default="scope">{{ formatBoolean(scope.row.status) }}</template>
        </el-table-column>

        <el-table-column align="left" label="分类类型" prop="type">
          <template #default="scope">{{ categoryTypeMap.get(scope.row.type) }}</template>
        </el-table-column>

        <el-table-column align="left" label="操作" fixed="right" :min-width="200">
          <template #default="scope">
            <el-button type="primary" link class="table-button" @click="openDialog(scope.row)">
              <el-icon style="margin-right: 5px">
                <InfoFilled/>
              </el-icon>
              新增子节点
            </el-button>
            <el-button type="primary" link icon="edit" class="table-button" @click="updateCategoryFunc(scope.row)">
              编辑
            </el-button>
            <el-button v-if="!scope.row.children?.length" type="primary" link icon="delete"
                       @click="deleteRow(scope.row)">删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <div class="gva-pagination">
        <el-pagination
            layout="total, sizes, prev, pager, next, jumper"
            :current-page="page"
            :page-size="pageSize"
            :page-sizes="[10, 30, 50, 100]"
            :total="total"
            @current-change="handleCurrentChange"
            @size-change="handleSizeChange"
        />
      </div>
    </div>
    <el-drawer destroy-on-close :size="appStore.drawerSize" v-model="dialogFormVisible" :show-close="false"
               :before-close="closeDialog">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">{{ type === 'create' ? '新增' : '编辑' }}</span>
          <div>
            <el-button :loading="btnLoading" type="primary" @click="enterDialog">确 定</el-button>
            <el-button @click="closeDialog">取 消</el-button>
          </div>
        </div>
      </template>

      <el-form :model="formData" label-position="top" ref="elFormRef" :rules="rule" label-width="80px">
        <el-form-item label="父节点:" prop="parentID">
          <el-tree-select
              v-model="formData.parentID"
              :data="[rootNode,...tableData]"
              check-strictly
              :render-after-expand="false"
              :props="defaultProps"
              clearable
              style="width: 240px"
              placeholder="根节点"
          />
        </el-form-item>
        <el-form-item label="分类名称:" prop="categoryName">
          <el-input v-model="formData.categoryName" :clearable="false" placeholder="请输入分类名称"/>
        </el-form-item>
        <el-form-item label="状态:" prop="status">
          <el-switch v-model="formData.status" active-color="#13ce66" inactive-color="#ff4949" active-text="显示"
                     inactive-text="隐藏" clearable></el-switch>
        </el-form-item>

        <el-form-item label="分类类型:" prop="type">
          <el-select v-model="formData.type" placeholder="请选择分类类型">
            <el-option v-for="item in categoryType" :key="item.value" :label="item.label" :value="item.value"/>
          </el-select>
        </el-form-item>
      </el-form>
    </el-drawer>

    <el-drawer destroy-on-close :size="appStore.drawerSize" v-model="detailShow" :show-close="true"
               :before-close="closeDetailShow" title="查看">
      <el-descriptions :column="1" border>
        <el-descriptions-item label="父节点">
          <el-tree-select
              v-model="detailFrom.parentID"
              :data="[rootNode,...tableData]"
              check-strictly
              disabled
              :render-after-expand="false"
              :props="defaultProps"
              clearable
              style="width: 240px"
              placeholder="根节点"
          />
        </el-descriptions-item>
        <el-descriptions-item label="分类名称">
          {{ detailFrom.categoryName }}
        </el-descriptions-item>
        <el-descriptions-item label="状态">
          {{ formatBoolean(detailFrom.status) }}
        </el-descriptions-item>
      </el-descriptions>
    </el-drawer>

  </div>
</template>

<script setup>
import {
  createCategory,
  deleteCategory,
  deleteCategoryByIds,
  updateCategory,
  findCategory,
  getCategoryList
} from '@/api/system/program_category'
import {categoryType, categoryTypeMap} from './index'

// 全量引入格式化工具 请按需保留
import {
  getDictFunc,
  formatDate,
  formatBoolean,
  filterDict,
  filterDataSource,
  returnArrImg,
  onDownloadFile
} from '@/utils/format'
import {ElMessage, ElMessageBox} from 'element-plus'
import {ref, reactive} from 'vue'
import {useAppStore} from '@/pinia'


defineOptions({
  name: 'Category'
})

// 提交按钮loading
const btnLoading = ref(false)
const appStore = useAppStore()

// 控制更多查询条件显示/隐藏状态
const showAllQuery = ref(false)

// 自动化生成的字典（可能为空）以及字段
const formData = ref({
  parentID: undefined,
  categoryName: '',
  status: true,
  sortOrder: 0,
  type: ''
})


// 验证规则
const rule = reactive({
  categoryName: [{
    required: true,
    message: '',
    trigger: ['input', 'blur']
  },
    {
      whitespace: true,
      message: '不能只输入空格',
      trigger: ['input', 'blur']
    }
  ]
})

const elFormRef = ref()

// =========== 表格控制部分 ===========
const page = ref(1)
const total = ref(0)
const pageSize = ref(10)
const tableData = ref([])
const searchInfo = ref({})
// 排序
const sortChange = ({prop, order}) => {
  const sortMap = {
    CreatedAt: 'CreatedAt',
    ID: 'ID',
    sortOrder: 'sort_order'
  }

  let sort = sortMap[prop]
  if (!sort) {
    sort = prop.replace(/[A-Z]/g, match => `_${match.toLowerCase()}`)
  }

  searchInfo.value.sort = sort
  searchInfo.value.order = order
  getTableData()
}
// 树选择器配置
const defaultProps = {
  children: 'children',
  label: 'categoryName',
  value: 'ID'
}

const rootNode = {
  ID: 0,
  CategoryName: '根节点',
  children: []
}

// 查询
const getTableData = async () => {
  const table = await getCategoryList()
  if (table.code === 0) {
    tableData.value = table.data || []
  }
}

getTableData()

// ============== 表格控制部分结束 ===============

// 获取需要的字典 可能为空 按需保留
const setOptions = async () => {
}

// 获取需要的字典 可能为空 按需保留
setOptions()


// 多选数据
const multipleSelection = ref([])
// 多选
const handleSelectionChange = (val) => {
  multipleSelection.value = val
}

// 删除行
const deleteRow = (row) => {
  ElMessageBox.confirm('确定要删除吗?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    deleteCategoryFunc(row)
  })
}

// 多选删除
const onDelete = async () => {
  ElMessageBox.confirm('确定要删除吗?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(async () => {
    const IDs = []
    if (multipleSelection.value.length === 0) {
      ElMessage({
        type: 'warning',
        message: '请选择要删除的数据'
      })
      return
    }
    multipleSelection.value &&
    multipleSelection.value.map(item => {
      IDs.push(item.ID)
    })
    const res = await deleteCategoryByIds({IDs})
    if (res.code === 0) {
      ElMessage({
        type: 'success',
        message: '删除成功'
      })
      if (tableData.value.length === IDs.length && page.value > 1) {
        page.value--
      }
      getTableData()
    }
  })
}

// 行为控制标记（弹窗内部需要增还是改）
const type = ref('')

// 更新行
const updateCategoryFunc = async (row) => {
  const res = await findCategory({ID: row.ID})
  type.value = 'update'
  if (res.code === 0) {
    formData.value = res.data
    dialogFormVisible.value = true
  }
}


// 删除行
const deleteCategoryFunc = async (row) => {
  const res = await deleteCategory({ID: row.ID})
  if (res.code === 0) {
    ElMessage({
      type: 'success',
      message: '删除成功'
    })
    if (tableData.value.length === 1 && page.value > 1) {
      page.value--
    }
    getTableData()
  }
}

// 弹窗控制标记
const dialogFormVisible = ref(false)

// 打开弹窗
const openDialog = (row) => {
  type.value = 'create'
  formData.value.parentID = row ? row.ID : undefined
  formData.value.type = row ? row.type : undefined
  dialogFormVisible.value = true
}

// 关闭弹窗
const closeDialog = () => {
  dialogFormVisible.value = false
  formData.value = {
    categoryName: '',
    status: false,
    sortOrder: 0,
    type: ''
  }
}
// 弹窗确定
const enterDialog = async () => {
  btnLoading.value = true
  elFormRef.value?.validate(async (valid) => {
    if (!valid) return btnLoading.value = false
    let res
    switch (type.value) {
      case 'create':
        res = await createCategory(formData.value)
        break
      case 'update':
        res = await updateCategory(formData.value)
        break
      default:
        res = await createCategory(formData.value)
        break
    }
    btnLoading.value = false
    if (res.code === 0) {
      ElMessage({
        type: 'success',
        message: '创建/更改成功'
      })
      closeDialog()
      getTableData()
    }
  })
}

const detailFrom = ref({})

// 查看详情控制标记
const detailShow = ref(false)


// 打开详情弹窗
const openDetailShow = () => {
  detailShow.value = true
}


// 打开详情
const getDetails = async (row) => {
  // 打开弹窗
  const res = await findCategory({ID: row.ID})
  if (res.code === 0) {
    detailFrom.value = res.data
    openDetailShow()
  }
}


// 关闭详情弹窗
const closeDetailShow = () => {
  detailShow.value = false
  detailFrom.value = {}
}


</script>

<style>

</style>
