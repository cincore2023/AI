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

        <el-form-item label="讲师" prop="teacher">
          <el-select v-model="searchInfo.teacher" filterable placeholder="请选择讲师" :clearable="false">
            <el-option v-for="(item,key) in dataSource.teacher" :key="key" :label="item.label" :value="item.value"/>
          </el-select>
        </el-form-item>

        <el-form-item label="分类" prop="category">
          <el-select v-model="searchInfo.category" filterable placeholder="请选择分类" :clearable="false">
            <el-option v-for="(item,key) in dataSource.category" :key="key" :label="item.label" :value="item.value"/>
          </el-select>
        </el-form-item>

        <el-form-item label="类型" prop="type">
          <el-select v-model="searchInfo.type" placeholder="请选择分类类型">
            <el-option v-for="item in typeOptions" :key="item.value" :label="item.label" :value="item.value"/>
          </el-select>
        </el-form-item>

        <el-form-item label="价格" prop="price">
          <div class="flex flex-row gap-2">
            <el-input class="w-40" v-model.number="searchInfo.startPrice" placeholder="最小值"/>
            —
            <el-input class="w-40" v-model.number="searchInfo.endPrice" placeholder="最大值"/>
          </div>
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

        <el-table-column align="left" label="课程信息" prop="courseTitle" width="300">
          <template #default="scope">
            <div class="flex flex-row gap-3">
              <el-image style="height: 100px; border-radius: 5px" :src="getUrl(scope.row.coverImage)"
                        fit="cover"/>
              <div class="flex flex-col">
                <span class="font-bold">{{ scope.row.courseTitle }}</span>
                <span class="text-gray-400">{{ filterDataSource(dataSource.teacher, scope.row.teacher) }}</span>
                <div>
                  <del class="text-gray-500 font-bold ">¥{{ scope.row.originalPrice }}</del> &nbsp;
                  <span class="text-red-700 font-bold ">¥{{ scope.row.price }}</span>
                </div>
              </div>
            </div>
          </template>
        </el-table-column>

        <el-table-column align="left" label="分类" prop="category" width="180">
          <template #default="scope">{{ filterDataSource(dataSource.category, scope.row.category) }}</template>
        </el-table-column>

        <el-table-column align="left" label="类型" prop="type" width="120">
          <template #default="scope">{{ typeMap.get(scope.row.type) }}</template>
        </el-table-column>

        <el-table-column align="left" label="上架状态" prop="onSale" width="120">
          <template #default="scope">{{ formatBoolean(scope.row.onSale) }}</template>
        </el-table-column>

        <el-table-column align="left" label="展示学习人数" prop="apprenticeCount" width="120"/>
        <el-table-column sortable align="left" label="创建日期" prop="CreatedAt" width="180">
          <template #default="scope">{{ formatDate(scope.row.CreatedAt) }}</template>
        </el-table-column>
        <el-table-column sortable align="left" label="排序" prop="sort" width="120"/>
        <el-table-column align="left" label="操作" fixed="right" :min-width="appStore.operateMinWith">
          <template #default="scope">
            <el-button type="primary" link class="table-button" @click="getDetails(scope.row)">
              <el-icon style="margin-right: 5px">
                <InfoFilled/>
              </el-icon>
              查看
            </el-button>
            <el-button type="primary" link icon="edit" class="table-button" @click="updateCourseFunc(scope.row)">编辑
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
        <el-form-item label="课程名称:" prop="courseTitle">
          <el-input v-model="formData.courseTitle" :clearable="false" placeholder="请输入课程名称"/>
        </el-form-item>
        <el-form-item label="讲师:" prop="teacher">
          <el-select v-model="formData.teacher" placeholder="请选择讲师" filterable style="width:100%"
                     :clearable="false">
            <el-option v-for="(item,key) in dataSource.teacher" :key="key" :label="item.label" :value="item.value"/>
          </el-select>
        </el-form-item>
        <el-form-item label="分类:" prop="category">
          <el-select v-model="formData.category" placeholder="请选择分类" filterable style="width:100%"
                     :clearable="false">
            <el-option v-for="(item,key) in dataSource.category" :key="key" :label="item.label" :value="item.value"/>
          </el-select>
        </el-form-item>
        <el-form-item label="封面图:" prop="coverImage">
          <SelectImage
              v-model="formData.coverImage"
              file-type="image"
          />
        </el-form-item>
        <el-form-item label="类型:" prop="type">
          <el-select v-model="formData.type" placeholder="请选择分类类型">
            <el-option v-for="item in typeOptions" :key="item.value" :label="item.label" :value="item.value"/>
          </el-select>
        </el-form-item>
        <el-form-item label="价格:" prop="price">
          <el-input-number v-model="formData.price" style="width:100%" :precision="2" :clearable="false"/>
        </el-form-item>
        <el-form-item label="划线价格:" prop="originalPrice">
          <el-input-number v-model="formData.originalPrice" style="width:100%" :precision="2" :clearable="false"/>
        </el-form-item>
        <el-form-item label="上架状态:" prop="onSale">
          <el-switch v-model="formData.onSale" active-color="#13ce66" inactive-color="#ff4949" active-text="是"
                     inactive-text="否" clearable></el-switch>
        </el-form-item>
        <el-form-item label="排序:" prop="sort">
          <el-input v-model.number="formData.sort" :clearable="false" placeholder="请输入排序"/>
        </el-form-item>
        <el-form-item label="前台展示人数:" prop="apprenticeCount">
          <el-input v-model.number="formData.apprenticeCount" :clearable="false" placeholder="请输入前台展示"/>
        </el-form-item>

        <el-form-item label="试看详情:" prop="viewDetails">
          <RichEdit v-model="formData.viewDetails"/>
        </el-form-item>
        <el-form-item label="课程详情:" prop="courseDetails">
          <RichEdit v-model="formData.courseDetails"/>
        </el-form-item>
      </el-form>
    </el-drawer>

    <el-drawer destroy-on-close :size="appStore.drawerSize" v-model="detailShow" :show-close="true"
               :before-close="closeDetailShow" title="查看">
      <el-descriptions :column="1" border>
        <el-descriptions-item label="课程名称">
          {{ detailFrom.courseTitle }}
        </el-descriptions-item>
        <el-descriptions-item label="讲师">
          <template #default="scope">
            <span>{{ filterDataSource(dataSource.teacher, detailFrom.teacher) }}</span>
          </template>
        </el-descriptions-item>
        <el-descriptions-item label="分类">
          <template #default="scope">
            <span>{{ filterDataSource(dataSource.category, detailFrom.category) }}</span>
          </template>
        </el-descriptions-item>
        <el-descriptions-item label="封面图">
          <el-image style="width: 50px; height: 50px" :preview-src-list="returnArrImg(detailFrom.coverImage)"
                    :src="getUrl(detailFrom.coverImage)" fit="cover"/>
        </el-descriptions-item>
        <el-descriptions-item label="类型">
          {{ detailFrom.type }}
        </el-descriptions-item>
        <el-descriptions-item label="价格">
          {{ detailFrom.price }}
        </el-descriptions-item>
        <el-descriptions-item label="划线价格">
          {{ detailFrom.originalPrice }}
        </el-descriptions-item>
        <el-descriptions-item label="上架状态">
          {{ detailFrom.onSale }}
        </el-descriptions-item>
        <el-descriptions-item label="排序">
          {{ detailFrom.sort }}
        </el-descriptions-item>
        <el-descriptions-item label="试看详情">
          <RichView v-model="detailFrom.viewDetails"/>
        </el-descriptions-item>
        <el-descriptions-item label="课程详情">
          <RichView v-model="detailFrom.courseDetails"/>
        </el-descriptions-item>
        <el-descriptions-item label="展示学习人数">
          {{ detailFrom.apprenticeCount }}
        </el-descriptions-item>
      </el-descriptions>
    </el-drawer>

  </div>
</template>

<script setup>
import {
  getCourseDataSource,
  createCourse,
  deleteCourse,
  deleteCourseByIds,
  updateCourse,
  findCourse,
  getCourseList
} from '@/api/system/core_course'
import {getUrl} from '@/utils/image'
// 图片选择组件
import SelectImage from '@/components/selectImage/selectImage.vue'
// 富文本组件
import RichEdit from '@/components/richtext/rich-edit.vue'
import RichView from '@/components/richtext/rich-view.vue'

// 全量引入格式化工具 请按需保留
import {
  formatDate,
  formatBoolean,
  filterDataSource,
  returnArrImg,
} from '@/utils/format'
import {ElMessage, ElMessageBox} from 'element-plus'
import {ref, reactive} from 'vue'
import {useAppStore} from "@/pinia"
import {typeMap, typeOptions} from './index'

defineOptions({name: 'Course'})

// 提交按钮loading
const btnLoading = ref(false)
const appStore = useAppStore()

// 控制更多查询条件显示/隐藏状态
const showAllQuery = ref(false)

// 自动化生成的字典（可能为空）以及字段
const formData = ref({
  courseTitle: '',
  teacher: undefined,
  category: undefined,
  coverImage: "",
  type: '',
  price: 0,
  originalPrice: 0,
  onSale: false,
  sort: 0,
  viewDetails: '',
  courseDetails: '',
  apprenticeCount: 100
})
const dataSource = ref([])
const getDataSourceFunc = async () => {
  const res = await getCourseDataSource()
  if (res.code === 0) {
    dataSource.value = res.data
  }
}
getDataSourceFunc()

// 验证规则
const rule = reactive({
  courseTitle: [{
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
  teacher: [{
    required: true,
    message: '',
    trigger: ['input', 'blur'],
  },
  ],
  category: [{
    required: true,
    message: '',
    trigger: ['input', 'blur'],
  },
  ],
  coverImage: [{
    required: true,
    message: '',
    trigger: ['input', 'blur'],
  },
  ],
  type: [{
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
  price: [{
    required: true,
    message: '',
    trigger: ['input', 'blur'],
  },
  ],
  courseDetails: [{
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
    sort: 'sort',
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
    if (searchInfo.value.onSale === "") {
      searchInfo.value.onSale = null
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
  const table = await getCourseList({page: page.value, pageSize: pageSize.value, ...searchInfo.value})
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
    deleteCourseFunc(row)
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
    const res = await deleteCourseByIds({IDs})
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
const updateCourseFunc = async (row) => {
  const res = await findCourse({ID: row.ID})
  type.value = 'update'
  if (res.code === 0) {
    formData.value = res.data
    dialogFormVisible.value = true
  }
}


// 删除行
const deleteCourseFunc = async (row) => {
  const res = await deleteCourse({ID: row.ID})
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
    courseTitle: '',
    teacher: undefined,
    category: undefined,
    coverImage: "",
    type: '',
    price: 0,
    originalPrice: 0,
    onSale: false,
    sort: 0,
    viewDetails: '',
    courseDetails: '',
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
        res = await createCourse(formData.value)
        break
      case 'update':
        res = await updateCourse(formData.value)
        break
      default:
        res = await createCourse(formData.value)
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
  const res = await findCourse({ID: row.ID})
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
