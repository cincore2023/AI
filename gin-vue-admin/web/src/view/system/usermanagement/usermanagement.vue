
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
      
            <el-form-item label="昵称" prop="nickname">
  <el-input v-model="searchInfo.nickname" placeholder="搜索条件" />
</el-form-item>
            
            <el-form-item label="手机号" prop="phone_number">
  <el-input v-model="searchInfo.phone_number" placeholder="搜索条件" />
</el-form-item>
            
            <el-form-item label="会员到期时间" prop="membership_expiry_date">
  <template #label>
    <span>
      会员到期时间
      <el-tooltip content="搜索范围是开始日期（包含）至结束日期（不包含）">
        <el-icon><QuestionFilled /></el-icon>
      </el-tooltip>
    </span>
  </template>
<el-date-picker class="w-[380px]" v-model="searchInfo.membership_expiry_dateRange" type="datetimerange" range-separator="至"  start-placeholder="开始时间" end-placeholder="结束时间"></el-date-picker></el-form-item>
            
            <el-form-item label="是否启用" prop="is_active">
  <el-select v-model="searchInfo.is_active" clearable placeholder="请选择">
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
        
            <el-table-column align="left" label="小程序Id" prop="openId" width="120" />

            <el-table-column align="left" label="昵称" prop="nickname" width="120" />

            <el-table-column align="left" label="手机号" prop="phone_number" width="120" />

            <el-table-column align="left" label="销售员" prop="salesperson" width="120" />

            <el-table-column align="left" label="关系渠道" prop="relationship_channel" width="120" />

            <el-table-column sortable align="left" label="权益等级" prop="benefit_level" width="120" />

            <el-table-column sortable align="left" label="可提现收入" prop="withdrawable_income" width="120" />

            <el-table-column sortable align="left" label="累计收入" prop="cumulative_income" width="120" />

            <el-table-column align="left" label="会员到期时间" prop="membership_expiry_date" width="180">
   <template #default="scope">{{ formatDate(scope.row.membership_expiry_date) }}</template>
</el-table-column>
            <el-table-column align="left" label="会员兑换码" prop="membership_redemption_code" width="120" />

            <el-table-column align="left" label="活动兑换码" prop="activity_redemption_code" width="120" />

            <el-table-column align="left" label="是否启用" prop="is_active" width="120">
    <template #default="scope">{{ formatBoolean(scope.row.is_active) }}</template>
</el-table-column>
        <el-table-column align="left" label="操作" fixed="right" :min-width="appStore.operateMinWith">
            <template #default="scope">
            <el-button  type="primary" link class="table-button" @click="getDetails(scope.row)"><el-icon style="margin-right: 5px"><InfoFilled /></el-icon>查看</el-button>
            <el-button  type="primary" link icon="edit" class="table-button" @click="updateWechatUserFunc(scope.row)">编辑</el-button>
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
            <el-form-item label="小程序Id:" prop="openId">
    <el-input v-model="formData.openId" :clearable="true" placeholder="请输入小程序Id" />
</el-form-item>
            <el-form-item label="昵称:" prop="nickname">
    <el-input v-model="formData.nickname" :clearable="false" placeholder="请输入昵称" />
</el-form-item>
            <el-form-item label="手机号:" prop="phone_number">
    <el-input v-model="formData.phone_number" :clearable="false" placeholder="请输入手机号" />
</el-form-item>
            <el-form-item label="销售员:" prop="salesperson">
    <el-input v-model.number="formData.salesperson" :clearable="false" placeholder="请输入销售员" />
</el-form-item>
            <el-form-item label="关系渠道:" prop="relationship_channel">
    <el-input v-model.number="formData.relationship_channel" :clearable="false" placeholder="请输入关系渠道" />
</el-form-item>
            <el-form-item label="权益等级:" prop="benefit_level">
    <el-input v-model.number="formData.benefit_level" :clearable="false" placeholder="请输入权益等级" />
</el-form-item>
            <el-form-item label="可提现收入:" prop="withdrawable_income">
    <el-input-number v-model="formData.withdrawable_income" style="width:100%" :precision="2" :clearable="false" />
</el-form-item>
            <el-form-item label="累计收入:" prop="cumulative_income">
    <el-input-number v-model="formData.cumulative_income" style="width:100%" :precision="2" :clearable="false" />
</el-form-item>
            <el-form-item label="会员到期时间:" prop="membership_expiry_date">
    <el-date-picker v-model="formData.membership_expiry_date" type="date" style="width:100%" placeholder="选择日期" :clearable="false" />
</el-form-item>
            <el-form-item label="会员兑换码:" prop="membership_redemption_code">
    <el-input v-model="formData.membership_redemption_code" :clearable="false" placeholder="请输入会员兑换码" />
</el-form-item>
            <el-form-item label="活动兑换码:" prop="activity_redemption_code">
    <el-input v-model="formData.activity_redemption_code" :clearable="false" placeholder="请输入活动兑换码" />
</el-form-item>
            <el-form-item label="是否启用:" prop="is_active">
    <el-switch v-model="formData.is_active" active-color="#13ce66" inactive-color="#ff4949" active-text="是" inactive-text="否" clearable ></el-switch>
</el-form-item>
          </el-form>
    </el-drawer>

    <el-drawer destroy-on-close :size="appStore.drawerSize" v-model="detailShow" :show-close="true" :before-close="closeDetailShow" title="查看">
            <el-descriptions :column="1" border>
                    <el-descriptions-item label="小程序Id">
    {{ detailFrom.openId }}
</el-descriptions-item>
                    <el-descriptions-item label="昵称">
    {{ detailFrom.nickname }}
</el-descriptions-item>
                    <el-descriptions-item label="手机号">
    {{ detailFrom.phone_number }}
</el-descriptions-item>
                    <el-descriptions-item label="销售员">
    {{ detailFrom.salesperson }}
</el-descriptions-item>
                    <el-descriptions-item label="关系渠道">
    {{ detailFrom.relationship_channel }}
</el-descriptions-item>
                    <el-descriptions-item label="权益等级">
    {{ detailFrom.benefit_level }}
</el-descriptions-item>
                    <el-descriptions-item label="可提现收入">
    {{ detailFrom.withdrawable_income }}
</el-descriptions-item>
                    <el-descriptions-item label="累计收入">
    {{ detailFrom.cumulative_income }}
</el-descriptions-item>
                    <el-descriptions-item label="会员到期时间">
    {{ detailFrom.membership_expiry_date }}
</el-descriptions-item>
                    <el-descriptions-item label="会员兑换码">
    {{ detailFrom.membership_redemption_code }}
</el-descriptions-item>
                    <el-descriptions-item label="活动兑换码">
    {{ detailFrom.activity_redemption_code }}
</el-descriptions-item>
                    <el-descriptions-item label="是否启用">
    {{ detailFrom.is_active }}
</el-descriptions-item>
            </el-descriptions>
        </el-drawer>

  </div>
</template>

<script setup>
import {
  createWechatUser,
  deleteWechatUser,
  deleteWechatUserByIds,
  updateWechatUser,
  findWechatUser,
  getWechatUserList
} from '@/api/system/usermanagement'

// 全量引入格式化工具 请按需保留
import { getDictFunc, formatDate, formatBoolean, filterDict ,filterDataSource, returnArrImg, onDownloadFile } from '@/utils/format'
import { ElMessage, ElMessageBox } from 'element-plus'
import { ref, reactive } from 'vue'
import { useAppStore } from "@/pinia"




defineOptions({
    name: 'WechatUser'
})

// 提交按钮loading
const btnLoading = ref(false)
const appStore = useAppStore()

// 控制更多查询条件显示/隐藏状态
const showAllQuery = ref(false)

// 自动化生成的字典（可能为空）以及字段
const formData = ref({
            openId: '',
            nickname: '',
            phone_number: '',
            salesperson: undefined,
            relationship_channel: 0,
            benefit_level: undefined,
            withdrawable_income: 0,
            cumulative_income: 0,
            membership_expiry_date: new Date(),
            membership_redemption_code: '',
            activity_redemption_code: '',
            is_active: false,
        })



// 验证规则
const rule = reactive({
               nickname : [{
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
               phone_number : [{
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
            benefit_level: 'benefit_level',
            withdrawable_income: 'withdrawable_income',
            cumulative_income: 'cumulative_income',
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
    if (searchInfo.value.is_active === ""){
        searchInfo.value.is_active=null
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
const getTableData = async() => {
  const table = await getWechatUserList({ page: page.value, pageSize: pageSize.value, ...searchInfo.value })
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
            deleteWechatUserFunc(row)
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
      const res = await deleteWechatUserByIds({ IDs })
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
const updateWechatUserFunc = async(row) => {
    const res = await findWechatUser({ ID: row.ID })
    type.value = 'update'
    if (res.code === 0) {
        formData.value = res.data
        dialogFormVisible.value = true
    }
}


// 删除行
const deleteWechatUserFunc = async (row) => {
    const res = await deleteWechatUser({ ID: row.ID })
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
        openId: '',
        nickname: '',
        phone_number: '',
        salesperson: undefined,
        relationship_channel: 0,
        benefit_level: undefined,
        withdrawable_income: 0,
        cumulative_income: 0,
        membership_expiry_date: new Date(),
        membership_redemption_code: '',
        activity_redemption_code: '',
        is_active: false,
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
                  res = await createWechatUser(formData.value)
                  break
                case 'update':
                  res = await updateWechatUser(formData.value)
                  break
                default:
                  res = await createWechatUser(formData.value)
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
  const res = await findWechatUser({ ID: row.ID })
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
