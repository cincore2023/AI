
<template>
  <div>
    <div class="gva-form-box">
      <el-form :model="formData" ref="elFormRef" label-position="right" :rules="rule" label-width="80px">
        <el-form-item label="等级:" prop="level">
    <el-input-number v-model="formData.level" style="width:100%" :precision="2" :clearable="false" />
</el-form-item>
        <el-form-item label="名称:" prop="levelName">
    <el-input v-model="formData.levelName" :clearable="false" placeholder="请输入名称" />
</el-form-item>
        <el-form-item label="会员提成:" prop="memberCommission">
    <el-input-number v-model="formData.memberCommission" style="width:100%" :precision="2" :clearable="false" />
</el-form-item>
        <el-form-item label="活动提成:" prop="activityCommission">
    <el-input-number v-model="formData.activityCommission" style="width:100%" :precision="2" :clearable="false" />
</el-form-item>
        <el-form-item label="数字人提成:" prop="digitalPersonCommission">
    <el-input-number v-model="formData.digitalPersonCommission" style="width:100%" :precision="2" :clearable="false" />
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
  createBenefit,
  updateBenefit,
  findBenefit
} from '@/api/system/program_benefit'

defineOptions({
    name: 'BenefitForm'
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
            level: 0,
            levelName: '',
            memberCommission: 0,
            activityCommission: 0,
            digitalPersonCommission: 0,
        })
// 验证规则
const rule = reactive({
               level : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               levelName : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               memberCommission : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               activityCommission : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               digitalPersonCommission : [{
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
      const res = await findBenefit({ ID: route.query.id })
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
               res = await createBenefit(formData.value)
               break
             case 'update':
               res = await updateBenefit(formData.value)
               break
             default:
               res = await createBenefit(formData.value)
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
