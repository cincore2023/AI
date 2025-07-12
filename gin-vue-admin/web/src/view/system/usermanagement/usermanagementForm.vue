
<template>
  <div>
    <div class="gva-form-box">
      <el-form :model="formData" ref="elFormRef" label-position="right" :rules="rule" label-width="80px">
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
        <el-form-item>
          <el-button :loading="btnLoading" type="primary" @click="save">保存</el-button>
          <el-button type="primary" @click="back">返回</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import {
  createWechatUser,
  updateWechatUser,
  findWechatUser
} from '@/api/system/usermanagement'

defineOptions({
    name: 'WechatUserForm'
})

// 自动获取字典
import { getDictFunc } from '@/utils/format'
import { useRoute, useRouter } from "vue-router"
import { ElMessage } from 'element-plus'
import { ref, reactive } from 'vue'


const route = useRoute()
const router = useRouter()

// 提交按钮loading
const btnLoading = ref(false)

const type = ref('')
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
               }],
               phone_number : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
})

const elFormRef = ref()

// 初始化方法
const init = async () => {
 // 建议通过url传参获取目标数据ID 调用 find方法进行查询数据操作 从而决定本页面是create还是update 以下为id作为url参数示例
    if (route.query.id) {
      const res = await findWechatUser({ ID: route.query.id })
      if (res.code === 0) {
        formData.value = res.data
        type.value = 'update'
      }
    } else {
      type.value = 'create'
    }
}

init()
// 保存按钮
const save = async() => {
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
           }
       })
}

// 返回按钮
const back = () => {
    router.go(-1)
}

</script>

<style>
</style>
