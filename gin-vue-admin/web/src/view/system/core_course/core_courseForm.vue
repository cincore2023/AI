
<template>
  <div>
    <div class="gva-form-box">
      <el-form :model="formData" ref="elFormRef" label-position="right" :rules="rule" label-width="80px">
        <el-form-item label="课程名称:" prop="courseTitle">
    <el-input v-model="formData.courseTitle" :clearable="false" placeholder="请输入课程名称" />
</el-form-item>
        <el-form-item label="讲师:" prop="teacher">
    <el-select v-model="formData.teacher" placeholder="请选择讲师" filterable style="width:100%" :clearable="false">
        <el-option v-for="(item,key) in dataSource.teacher" :key="key" :label="item.label" :value="item.value" />
    </el-select>
</el-form-item>
        <el-form-item label="分类:" prop="category">
    <el-select v-model="formData.category" placeholder="请选择分类" filterable style="width:100%" :clearable="false">
        <el-option v-for="(item,key) in dataSource.category" :key="key" :label="item.label" :value="item.value" />
    </el-select>
</el-form-item>
        <el-form-item label="封面图:" prop="coverImage">
    <SelectImage
     v-model="formData.coverImage"
     file-type="image"
    />
</el-form-item>
        <el-form-item label="类型:" prop="type">
    <el-input v-model="formData.type" :clearable="true" placeholder="请输入类型" />
</el-form-item>
        <el-form-item label="价格:" prop="price">
    <el-input-number v-model="formData.price" style="width:100%" :precision="2" :clearable="false" />
</el-form-item>
        <el-form-item label="划线价格:" prop="originalPrice">
    <el-input-number v-model="formData.originalPrice" style="width:100%" :precision="2" :clearable="false" />
</el-form-item>
        <el-form-item label="上架状态:" prop="onSale">
    <el-switch v-model="formData.onSale" active-color="#13ce66" inactive-color="#ff4949" active-text="是" inactive-text="否" clearable ></el-switch>
</el-form-item>
        <el-form-item label="排序:" prop="sort">
    <el-input v-model.number="formData.sort" :clearable="false" placeholder="请输入排序" />
</el-form-item>
        <el-form-item label="试看详情:" prop="viewDetails">
    <RichEdit v-model="formData.viewDetails"/>
</el-form-item>
        <el-form-item label="课程详情:" prop="courseDetails">
    <RichEdit v-model="formData.courseDetails"/>
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
    getCourseDataSource,
  createCourse,
  updateCourse,
  findCourse
} from '@/api/system/core_course'

defineOptions({
    name: 'CourseForm'
})

// 自动获取字典
import { getDictFunc } from '@/utils/format'
import { useRoute, useRouter } from "vue-router"
import { ElMessage } from 'element-plus'
import { ref, reactive } from 'vue'
// 图片选择组件
import SelectImage from '@/components/selectImage/selectImage.vue'
// 富文本组件
import RichEdit from '@/components/richtext/rich-edit.vue'


const route = useRoute()
const router = useRouter()

// 提交按钮loading
const btnLoading = ref(false)

const type = ref('')
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
        })
// 验证规则
const rule = reactive({
               courseTitle : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               teacher : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               category : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               coverImage : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               type : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               price : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               courseDetails : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
})

const elFormRef = ref()
  const dataSource = ref([])
  const getDataSourceFunc = async()=>{
    const res = await getCourseDataSource()
    if (res.code === 0) {
      dataSource.value = res.data
    }
  }
  getDataSourceFunc()

// 初始化方法
const init = async () => {
 // 建议通过url传参获取目标数据ID 调用 find方法进行查询数据操作 从而决定本页面是create还是update 以下为id作为url参数示例
    if (route.query.id) {
      const res = await findCourse({ ID: route.query.id })
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
