
<template>
  <div>
    <div class="gva-search-box">
      <el-form ref="elSearchFormRef" :inline="true" :model="searchInfo" class="demo-form-inline" @keyup.enter="onSubmit">
      <el-form-item label="创建日期" prop="createdAtRange">
      <template #label>
        <span>
          创建日期
          <el-tooltip content="搜索范围是开始日期（包含）至结束日期（不包含）">
            <el-icon><QuestionFilled /></el-icon>
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
      

        <template v-if="showAllQuery">
          <!-- 将需要控制显示状态的查询条件添加到此范围内 -->
        </template>

        <el-form-item>
          <el-button type="primary" icon="search" @click="onSubmit">查询</el-button>
          <el-button icon="refresh" @click="onReset">重置</el-button>
          <el-button link type="primary" icon="arrow-down" @click="showAllQuery=true" v-if="!showAllQuery">展开</el-button>
          <el-button link type="primary" icon="arrow-up" @click="showAllQuery=false" v-else>收起</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="gva-table-box">
        <div class="gva-btn-list">
            <el-button  type="primary" icon="plus" @click="openDialog()">新增</el-button>
            <el-button  icon="delete" style="margin-left: 10px;" :disabled="!multipleSelection.length" @click="onDelete">删除</el-button>
            
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
        <el-table-column type="selection" width="55" />
        
        <el-table-column sortable align="left" label="日期" prop="CreatedAt"width="180">
            <template #default="scope">{{ formatDate(scope.row.CreatedAt) }}</template>
        </el-table-column>
        
            <el-table-column align="left" label="交易编号" prop="transactionId" width="120" />

            <el-table-column align="left" label="用户昵称" prop="username" width="120" />

            <el-table-column align="left" label="手机号" prop="phoneNumber" width="120" />

            <el-table-column align="left" label="交易类型" prop="transactionType" width="120" />

            <el-table-column align="left" label="兑换码类型" prop="codeType" width="120" />

            <el-table-column sortable align="left" label="数量" prop="quantity" width="120" />

            <el-table-column sortable align="left" label="交易后余量" prop="remainingQuantity" width="120" />

            <el-table-column align="left" label="详情" prop="details" width="120" />

            <el-table-column sortable align="left" label="交易时间" prop="transactionTime" width="180">
   <template #default="scope">{{ formatDate(scope.row.transactionTime) }}</template>
</el-table-column>
        <el-table-column align="left" label="操作" fixed="right" :min-width="appStore.operateMinWith">
            <template #default="scope">
            <el-button  type="primary" link class="table-button" @click="getDetails(scope.row)"><el-icon style="margin-right: 5px"><InfoFilled /></el-icon>查看</el-button>
            <el-button  type="primary" link icon="edit" class="table-button" @click="updateCodeFunc(scope.row)">编辑</el-button>
            <el-button   type="primary" link icon="delete" @click="deleteRow(scope.row)">删除</el-button>
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
    <el-drawer destroy-on-close :size="appStore.drawerSize" v-model="dialogFormVisible" :show-close="false" :before-close="closeDialog">
       <template #header>
              <div class="flex justify-between items-center">
                <span class="text-lg">{{type==='create'?'新增':'编辑'}}</span>
                <div>
                  <el-button :loading="btnLoading" type="primary" @click="enterDialog">确 定</el-button>
                  <el-button @click="closeDialog">取 消</el-button>
                </div>
              </div>
            </template>

          <el-form :model="formData" label-position="top" ref="elFormRef" :rules="rule" label-width="80px">
            <el-form-item label="交易编号:" prop="transactionId">
    <el-input v-model="formData.transactionId" :clearable="false" placeholder="请输入交易编号" />
</el-form-item>
            <el-form-item label="用户昵称:" prop="username">
    <el-input v-model="formData.username" :clearable="false" placeholder="请输入用户昵称" />
</el-form-item>
            <el-form-item label="手机号:" prop="phoneNumber">
    <el-input v-model="formData.phoneNumber" :clearable="false" placeholder="请输入手机号" />
</el-form-item>
            <el-form-item label="交易类型:" prop="transactionType">
    <el-input v-model.number="formData.transactionType" :clearable="false" placeholder="请输入交易类型" />
</el-form-item>
            <el-form-item label="兑换码类型:" prop="codeType">
    <el-input v-model.number="formData.codeType" :clearable="false" placeholder="请输入兑换码类型" />
</el-form-item>
            <el-form-item label="数量:" prop="quantity">
    <el-input v-model.number="formData.quantity" :clearable="false" placeholder="请输入数量" />
</el-form-item>
            <el-form-item label="交易后余量:" prop="remainingQuantity">
    <el-input v-model.number="formData.remainingQuantity" :clearable="false" placeholder="请输入交易后余量" />
</el-form-item>
            <el-form-item label="详情:" prop="details">
    <el-input v-model="formData.details" :clearable="false" placeholder="请输入详情" />
</el-form-item>
            <el-form-item label="交易时间:" prop="transactionTime">
    <el-date-picker v-model="formData.transactionTime" type="date" style="width:100%" placeholder="选择日期" :clearable="false" />
</el-form-item>
          </el-form>
    </el-drawer>

    <el-drawer destroy-on-close :size="appStore.drawerSize" v-model="detailShow" :show-close="true" :before-close="closeDetailShow" title="查看">
            <el-descriptions :column="1" border>
                    <el-descriptions-item label="交易编号">
    {{ detailFrom.transactionId }}
</el-descriptions-item>
                    <el-descriptions-item label="用户昵称">
    {{ detailFrom.username }}
</el-descriptions-item>
                    <el-descriptions-item label="手机号">
    {{ detailFrom.phoneNumber }}
</el-descriptions-item>
                    <el-descriptions-item label="交易类型">
    {{ detailFrom.transactionType }}
</el-descriptions-item>
                    <el-descriptions-item label="兑换码类型">
    {{ detailFrom.codeType }}
</el-descriptions-item>
                    <el-descriptions-item label="数量">
    {{ detailFrom.quantity }}
</el-descriptions-item>
                    <el-descriptions-item label="交易后余量">
    {{ detailFrom.remainingQuantity }}
</el-descriptions-item>
                    <el-descriptions-item label="详情">
    {{ detailFrom.details }}
</el-descriptions-item>
                    <el-descriptions-item label="交易时间">
    {{ detailFrom.transactionTime }}
</el-descriptions-item>
            </el-descriptions>
        </el-drawer>

  </div>
</template>

<script setup>
import {
  createCode,
  deleteCode,
  deleteCodeByIds,
  updateCode,
  findCode,
  getCodeList
} from '@/api/system/finance_code'

// 全量引入格式化工具 请按需保留
import { getDictFunc, formatDate, formatBoolean, filterDict ,filterDataSource, returnArrImg, onDownloadFile } from '@/utils/format'
import { ElMessage, ElMessageBox } from 'element-plus'
import { ref, reactive } from 'vue'
import { useAppStore } from "@/pinia"




defineOptions({
    name: 'Code'
})

// 提交按钮loading
const btnLoading = ref(false)
const appStore = useAppStore()

// 控制更多查询条件显示/隐藏状态
const showAllQuery = ref(false)

// 自动化生成的字典（可能为空）以及字段
const formData = ref({
            transactionId: '',
            username: '',
            phoneNumber: '',
            transactionType: 0,
            codeType: 0,
            quantity: 0,
            remainingQuantity: 0,
            details: '',
            transactionTime: new Date(),
        })



// 验证规则
const rule = reactive({
               username : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               },
               {
                   whitespace: true,
                   message: '不能只输入空格',
                   trigger: ['input', 'blur'],
              }
              ],
               phoneNumber : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               },
               {
                   whitespace: true,
                   message: '不能只输入空格',
                   trigger: ['input', 'blur'],
              }
              ],
               transactionType : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               },
              ],
               codeType : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               },
              ],
               quantity : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               },
              ],
               details : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               },
               {
                   whitespace: true,
                   message: '不能只输入空格',
                   trigger: ['input', 'blur'],
              }
              ],
               transactionTime : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
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
const sortChange = ({ prop, order }) => {
  const sortMap = {
    CreatedAt:"CreatedAt",
    ID:"ID",
            quantity: 'quantity',
            remainingQuantity: 'remaining_quantity',
            transactionTime: 'transaction_time',
  }

  let sort = sortMap[prop]
  if(!sort){
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
  elSearchFormRef.value?.validate(async(valid) => {
    if (!valid) return
    page.value = 1
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
const getTableData = async() => {
  const table = await getCodeList({ page: page.value, pageSize: pageSize.value, ...searchInfo.value })
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
const setOptions = async () =>{
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
            deleteCodeFunc(row)
        })
    }

// 多选删除
const onDelete = async() => {
  ElMessageBox.confirm('确定要删除吗?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(async() => {
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
      const res = await deleteCodeByIds({ IDs })
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
const updateCodeFunc = async(row) => {
    const res = await findCode({ ID: row.ID })
    type.value = 'update'
    if (res.code === 0) {
        formData.value = res.data
        dialogFormVisible.value = true
    }
}


// 删除行
const deleteCodeFunc = async (row) => {
    const res = await deleteCode({ ID: row.ID })
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
        transactionId: '',
        username: '',
        phoneNumber: '',
        transactionType: 0,
        codeType: 0,
        quantity: 0,
        remainingQuantity: 0,
        details: '',
        transactionTime: new Date(),
        }
}
// 弹窗确定
const enterDialog = async () => {
     btnLoading.value = true
     elFormRef.value?.validate( async (valid) => {
             if (!valid) return btnLoading.value = false
              let res
              switch (type.value) {
                case 'create':
                  res = await createCode(formData.value)
                  break
                case 'update':
                  res = await updateCode(formData.value)
                  break
                default:
                  res = await createCode(formData.value)
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
  const res = await findCode({ ID: row.ID })
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
