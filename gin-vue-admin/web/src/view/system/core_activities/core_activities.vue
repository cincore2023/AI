<template>
  <div>
    <div class="gva-search-box">
      <el-form ref="elSearchFormRef" :inline="true" :model="searchInfo" class="demo-form-inline"
               @keyup.enter="onSubmit">
        <el-form-item label="创建日期" prop="createdAtRange">
          <template #label>
            <span>
          创建日期
          <el-tooltip content="搜索范围是开始日期（包含）至结束日期（不包含）">
            <el-icon><QuestionFilled/></el-icon>
          </el-tooltip>
        </span>
          </template>

          <el-date-picker
              v-model="searchInfo.createdAtRange"
              class="w-[380px]"
              type="datetimerange"
              range-separator="至"
              start-placeholder="开始时间"
              end-placeholder="结束时间"
          />
        </el-form-item>

        <el-form-item label="活动名称" prop="activityName">
          <el-input v-model="searchInfo.activityName" placeholder="搜索条件"/>
        </el-form-item>

        <el-form-item label="活动价格" prop="price">
          <div class="flex flex-wrap flex-row gap-2">
            <el-input class="w-40" v-model.number="searchInfo.startPrice" placeholder="最小值"/>
            —
            <el-input class="w-40" v-model.number="searchInfo.endPrice" placeholder="最大值"/>
          </div>
        </el-form-item>

        <el-form-item label="分类" prop="category">
          <el-select v-model="searchInfo.category" filterable placeholder="请选择分类" :clearable="false">
            <el-option v-for="(item,key) in dataSource.category" :key="key" :label="item.label" :value="item.value"/>
          </el-select>
        </el-form-item>

        <el-form-item label="状态" prop="status">
          <el-select v-model="searchInfo.status" clearable placeholder="请选择">
            <el-option key="true" label="是" value="true"></el-option>
            <el-option key="false" label="否" value="false"></el-option>
          </el-select>
        </el-form-item>


        <template v-if="showAllQuery">
          <!-- 将需要控制显示状态的查询条件添加到此范围内 -->
        </template>

        <el-form-item>
          <el-button type="primary" icon="search" @click="onSubmit">查询</el-button>
          <el-button icon="refresh" @click="onReset">重置</el-button>
          <el-button link type="primary" icon="arrow-down" @click="showAllQuery=true" v-if="!showAllQuery">展开
          </el-button>
          <el-button link type="primary" icon="arrow-up" @click="showAllQuery=false" v-else>收起</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="gva-table-box">
      <div class="gva-btn-list">
        <el-button type="primary" icon="plus" @click="openDialog()">新增</el-button>
        <el-button icon="delete" style="margin-left: 10px;" :disabled="!multipleSelection.length" @click="onDelete">
          删除
        </el-button>
        <ExportTemplate template-id="system_Activities"/>
        <ExportExcel template-id="system_Activities" filterDeleted/>
        <ImportExcel template-id="system_Activities" @on-success="getTableData"/>
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

        <el-table-column align="left" label="活动信息" prop="activityName" min-width="300">
          <template #default="scope">
            <div class="flex flex-row gap-3">
              <el-image style="height: 100px; border-radius: 5px" :src="getUrl(scope.row.coverPicture)"
                        fit="cover"/>
              <div class="flex justify-around flex-col">
                <span>
                  <span class="font-bold">{{ scope.row.activityName }}</span> &nbsp;
                  <span>{{ formatDate(scope.row.startTime, 'MM-dd') }}-{{
                      formatDate(scope.row.endTime, 'MM-dd')
                    }}</span>
                </span>
                <span class="text-red-700 font-bold ">¥{{ scope.row.price }}</span>
              </div>
            </div>
          </template>
        </el-table-column>

        <el-table-column align="left" label="分类" prop="category" width="150">
          <template #default="scope">
            <span>{{ filterDataSource(dataSource.category, scope.row.category) }}</span>
          </template>
        </el-table-column>


        <el-table-column align="center" label="状态" prop="status" width="120">
          <template #default="scope">{{ formatBoolean(scope.row.status) }}</template>
        </el-table-column>

        <el-table-column sortable align="left" label="排序" prop="sortOrder" width="120"/>

        <el-table-column sortable align="left" label="创建日期" prop="CreatedAt" width="180">
          <template #default="scope">{{ formatDate(scope.row.CreatedAt) }}</template>
        </el-table-column>

        <el-table-column align="left" label="操作" fixed="right" :min-width="appStore.operateMinWith">
          <template #default="scope">
            <el-button type="primary" link class="table-button" @click="getDetails(scope.row)">
              <el-icon style="margin-right: 5px">
                <InfoFilled/>
              </el-icon>
              查看
            </el-button>
            <el-button type="primary" link icon="edit" class="table-button" @click="updateActivitiesFunc(scope.row)">
              编辑
            </el-button>
            <el-button type="primary" link icon="delete" @click="deleteRow(scope.row)">删除</el-button>
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
        <el-form-item label="活动名称:" prop="activityName">
          <el-input v-model="formData.activityName" :clearable="false" placeholder="请输入活动名称"/>
        </el-form-item>
        <el-form-item label="活动价格:" prop="price">
          <el-input-number v-model="formData.price" style="width:100%" :precision="2" :clearable="false"/>
        </el-form-item>
        <el-form-item label="分类:" prop="category">
          <el-select v-model="formData.category" placeholder="请选择分类" filterable style="width:100%"
                     :clearable="false">
            <el-option v-for="(item,key) in dataSource.category" :key="key" :label="item.label" :value="item.value"/>
          </el-select>
        </el-form-item>
        <el-form-item label="封面图:" prop="coverPicture">
          <SelectImage
              v-model="formData.coverPicture"
              file-type="image"
          />
        </el-form-item>
        <el-form-item label="展示报名人数:" prop="actualEnrollment">
          <el-input v-model.number="formData.actualEnrollment" :clearable="false" placeholder="请输入展示报名人数"/>
        </el-form-item>
        <el-form-item label="状态:" prop="status">
          <el-switch v-model="formData.status" active-color="#13ce66" inactive-color="#ff4949" active-text="是"
                     inactive-text="否" clearable></el-switch>
        </el-form-item>
        <el-form-item label="排序:" prop="sortOrder">
          <el-input v-model.number="formData.sortOrder" :clearable="false" placeholder="请输入排序"/>
        </el-form-item>
        <el-form-item label="开始时间:" prop="startTime">
          <el-date-picker v-model="formData.startTime" type="date" style="width:100%" placeholder="选择日期"
                          :clearable="false"/>
        </el-form-item>
        <el-form-item label="结束时间:" prop="endTime">
          <el-date-picker v-model="formData.endTime" type="date" style="width:100%" placeholder="选择日期"
                          :clearable="false"/>
        </el-form-item>
        <el-form-item label="展示开始时间:" prop="showStartTime">
          <el-date-picker v-model="formData.showStartTime" type="date" style="width:100%" placeholder="选择日期"
                          :clearable="false"/>
        </el-form-item>
        <el-form-item label="展示结束时间:" prop="showEndTime">
          <el-date-picker v-model="formData.showEndTime" type="date" style="width:100%" placeholder="选择日期"
                          :clearable="false"/>
        </el-form-item>
      </el-form>
    </el-drawer>

    <el-drawer destroy-on-close :size="appStore.drawerSize" v-model="detailShow" :show-close="true"
               :before-close="closeDetailShow" title="查看">
      <el-descriptions :column="1" border>
        <el-descriptions-item label="活动名称">
          {{ detailFrom.activityName }}
        </el-descriptions-item>
        <el-descriptions-item label="活动价格">
          <span class="text-red-700 font-bold ">¥{{ detailFrom.price }}</span>
        </el-descriptions-item>
        <el-descriptions-item label="分类">
          <template #default="scope">
            <span>{{ filterDataSource(dataSource.category, detailFrom.category) }}</span>
          </template>
        </el-descriptions-item>
        <el-descriptions-item label="封面图">
          <el-image style="height: 100px; border-radius: 5px" :src="getUrl(detailFrom.coverPicture)" fit="cover"/>
        </el-descriptions-item>
        <el-descriptions-item label="展示报名人数">
          {{ detailFrom.actualEnrollment }}
        </el-descriptions-item>
        <el-descriptions-item label="状态">
          {{ formatBoolean(detailFrom.status) }}
        </el-descriptions-item>
        <el-descriptions-item label="排序">
          {{ detailFrom.sortOrder }}
        </el-descriptions-item>
        <el-descriptions-item label="开始时间">
          {{ formatDate(detailFrom.startTime) }}
        </el-descriptions-item>
        <el-descriptions-item label="结束时间">
          {{ formatDate(detailFrom.endTime) }}
        </el-descriptions-item>
        <el-descriptions-item label="展示开始时间">
          {{ formatDate(detailFrom.showStartTime) }}
        </el-descriptions-item>
        <el-descriptions-item label="展示结束时间">
          {{ formatDate(detailFrom.showEndTime) }}
        </el-descriptions-item>
      </el-descriptions>
    </el-drawer>

  </div>
</template>

<script setup>
import {
  getActivitiesDataSource,
  createActivities,
  deleteActivities,
  deleteActivitiesByIds,
  updateActivities,
  findActivities,
  getActivitiesList
} from '@/api/system/core_activities'

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
import {useAppStore} from "@/pinia"

// 导出组件
import ExportExcel from '@/components/exportExcel/exportExcel.vue'
// 导入组件
import ImportExcel from '@/components/exportExcel/importExcel.vue'
// 导出模板组件
import ExportTemplate from '@/components/exportExcel/exportTemplate.vue'
import SelectImage from "@/components/selectImage/selectImage.vue";
import {getUrl} from "@/utils/image";


defineOptions({
  name: 'Activities'
})

// 提交按钮loading
const btnLoading = ref(false)
const appStore = useAppStore()

// 控制更多查询条件显示/隐藏状态
const showAllQuery = ref(false)

// 自动化生成的字典（可能为空）以及字段
const formData = ref({
  activityName: '',
  price: 0,
  category: undefined,
  coverPicture: '',
  actualEnrollment: 0,
  status: false,
  sortOrder: 0,
  startTime: new Date(),
  endTime: new Date(),
  showStartTime: new Date(),
  showEndTime: new Date(),
})
const dataSource = ref([])
const getDataSourceFunc = async () => {
  const res = await getActivitiesDataSource()
  if (res.code === 0) {
    dataSource.value = {
      category: res.data.category.filter(item => item.type === "activity" && item.parent_id !== 0),
    }
    console.log(dataSource.value)
  }
}
getDataSourceFunc()


// 验证规则
const rule = reactive({
  activityName: [{
    required: true,
    message: '',
    trigger: ['input', 'blur'],
  },
    {
      whitespace: true,
      message: '不能只输入空格',
      trigger: ['input', 'blur'],
    }
  ],
  category: [{
    required: true,
    message: '',
    trigger: ['input', 'blur'],
  },
  ],
  coverPicture: [{
    required: true,
    message: '',
    trigger: ['input', 'blur'],
  },
    {
      whitespace: true,
      message: '不能只输入空格',
      trigger: ['input', 'blur'],
    }
  ],
  startTime: [{
    required: true,
    message: '',
    trigger: ['input', 'blur'],
  },
  ],
  endTime: [{
    required: true,
    message: '',
    trigger: ['input', 'blur'],
  },
  ],
  showStartTime: [{
    required: true,
    message: '',
    trigger: ['input', 'blur'],
  },
  ],
  showEndTime: [{
    required: true,
    message: '',
    trigger: ['input', 'blur'],
  },
  ],
})

const elFormRef = ref()
const elSearchFormRef = ref()

// =========== 表格控制部分 ===========
const page = ref(1)
const total = ref(0)
const pageSize = ref(10)
const tableData = ref([])
const searchInfo = ref({})
// 排序
const sortChange = ({prop, order}) => {
  const sortMap = {
    CreatedAt: "CreatedAt",
    ID: "ID",
    price: 'price',
    sortOrder: 'sort_order',
  }

  let sort = sortMap[prop]
  if (!sort) {
    sort = prop.replace(/[A-Z]/g, match => `_${match.toLowerCase()}`)
  }

  searchInfo.value.sort = sort
  searchInfo.value.order = order
  getTableData()
}
// 重置
const onReset = () => {
  searchInfo.value = {}
  getTableData()
}

// 搜索
const onSubmit = () => {
  elSearchFormRef.value?.validate(async (valid) => {
    if (!valid) return
    page.value = 1
    if (searchInfo.value.status === "") {
      searchInfo.value.status = null
    }
    getTableData()
  })
}

// 分页
const handleSizeChange = (val) => {
  pageSize.value = val
  getTableData()
}

// 修改页面容量
const handleCurrentChange = (val) => {
  page.value = val
  getTableData()
}

// 查询
const getTableData = async () => {
  const table = await getActivitiesList({page: page.value, pageSize: pageSize.value, ...searchInfo.value})
  if (table.code === 0) {
    tableData.value = table.data.list
    total.value = table.data.total
    page.value = table.data.page
    pageSize.value = table.data.pageSize
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
    deleteActivitiesFunc(row)
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
    const res = await deleteActivitiesByIds({IDs})
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
const updateActivitiesFunc = async (row) => {
  const res = await findActivities({ID: row.ID})
  type.value = 'update'
  if (res.code === 0) {
    formData.value = res.data
    dialogFormVisible.value = true
  }
}


// 删除行
const deleteActivitiesFunc = async (row) => {
  const res = await deleteActivities({ID: row.ID})
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
const openDialog = () => {
  type.value = 'create'
  dialogFormVisible.value = true
}

// 关闭弹窗
const closeDialog = () => {
  dialogFormVisible.value = false
  formData.value = {
    activityName: '',
    price: 0,
    category: undefined,
    coverPicture: '',
    actualEnrollment: 0,
    status: false,
    sortOrder: 0,
    startTime: new Date(),
    endTime: new Date(),
    showStartTime: new Date(),
    showEndTime: new Date(),
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
        res = await createActivities(formData.value)
        break
      case 'update':
        res = await updateActivities(formData.value)
        break
      default:
        res = await createActivities(formData.value)
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
  const res = await findActivities({ID: row.ID})
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
