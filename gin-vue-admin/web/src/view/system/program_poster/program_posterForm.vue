
<template>
  <div>
    <div class="gva-form-box">
      <el-form :model="formData" ref="elFormRef" label-position="right" :rules="rule" label-width="80px">
        <el-form-item label="二维码信息:" prop="text">
    <el-input v-model="formData.text" :clearable="false" placeholder="请输入二维码信息" />
</el-form-item>
        <el-form-item label="背景图:" prop="bgImg">
    <SelectImage
     v-model="formData.bgImg"
     file-type="image"
    />
</el-form-item>
        <el-form-item label="开关:" prop="switchButton">
    <el-switch v-model="formData.switchButton" active-color="#13ce66" inactive-color="#ff4949" active-text="是" inactive-text="否" clearable ></el-switch>
</el-form-item>
        <el-form-item label="大小:" prop="size">
    <el-input v-model="formData.size" :clearable="false" placeholder="请输入大小" />
</el-form-item>
        <el-form-item label="圆角:" prop="radius">
    <el-input v-model="formData.radius" :clearable="false" placeholder="请输入圆角" />
</el-form-item>
        <el-form-item label="距离顶部:" prop="top">
    <el-input v-model="formData.top" :clearable="false" placeholder="请输入距离顶部" />
</el-form-item>
        <el-form-item label="距离左侧:" prop="left">
    <el-input v-model="formData.left" :clearable="true" placeholder="请输入距离左侧" />
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
  createPoster,
  updatePoster,
  findPoster
} from '@/api/system/program_poster'

defineOptions({
    name: 'PosterForm'
})

// 自动获取字典
import { getDictFunc } from '@/utils/format'
import { useRoute, useRouter } from "vue-router"
import { ElMessage } from 'element-plus'
import { ref, reactive } from 'vue'
// 图片选择组件
import SelectImage from '@/components/selectImage/selectImage.vue'


const route = useRoute()
const router = useRouter()

// 提交按钮loading
const btnLoading = ref(false)

const type = ref('')
const formData = ref({
            text: '',
            bgImg: "",
            switchButton: false,
            size: '',
            radius: '',
            top: '',
            left: '',
        })
// 验证规则
const rule = reactive({
               text : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               bgImg : [{
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
      const res = await findPoster({ ID: route.query.id })
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
               res = await createPoster(formData.value)
               break
             case 'update':
               res = await updatePoster(formData.value)
               break
             default:
               res = await createPoster(formData.value)
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
