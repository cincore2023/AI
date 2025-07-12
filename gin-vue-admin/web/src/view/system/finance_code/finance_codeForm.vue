
<template>
  <div>
    <div class="gva-form-box">
      <el-form :model="formData" ref="elFormRef" label-position="right" :rules="rule" label-width="80px">
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
  createCode,
  updateCode,
  findCode
} from '@/api/system/finance_code'

defineOptions({
    name: 'CodeForm'
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
               }],
               phoneNumber : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               transactionType : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               codeType : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               quantity : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               details : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               transactionTime : [{
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
      const res = await findCode({ ID: route.query.id })
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
