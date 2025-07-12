
<template>
  <div>
    <div class="gva-form-box">
      <el-form :model="formData" ref="elFormRef" label-position="right" :rules="rule" label-width="80px">
        <el-form-item label="图片URL:" prop="imageUrl">
    <el-input v-model="formData.imageUrl" :clearable="false" placeholder="请输入图片URL" />
</el-form-item>
        <el-form-item label="链接URL:" prop="linkUrl">
    <el-input v-model="formData.linkUrl" :clearable="false" placeholder="请输入链接URL" />
</el-form-item>
        <el-form-item label="排序:" prop="order">
    <el-input v-model.number="formData.order" :clearable="false" placeholder="请输入排序" />
</el-form-item>
        <el-form-item label="状态:" prop="status">
    <el-input v-model.number="formData.status" :clearable="false" placeholder="请输入状态" />
</el-form-item>
        <el-form-item label="轮播图位置:" prop="type">
    <el-input v-model="formData.type" :clearable="true" placeholder="请输入轮播图位置" />
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
  createBanner,
  updateBanner,
  findBanner
} from '@/api/system/program_banner'

defineOptions({
    name: 'BannerForm'
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
            imageUrl: '',
            linkUrl: '',
            order: 0,
            status: 0,
            type: '',
        })
// 验证规则
const rule = reactive({
               imageUrl : [{
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
      const res = await findBanner({ ID: route.query.id })
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
               res = await createBanner(formData.value)
               break
             case 'update':
               res = await updateBanner(formData.value)
               break
             default:
               res = await createBanner(formData.value)
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
