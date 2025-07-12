
<template>
  <div>
    <div class="gva-form-box">
      <el-form :model="formData" ref="elFormRef" label-position="right" :rules="rule" label-width="80px">
        <el-form-item label="活动名称:" prop="activityName">
    <el-input v-model="formData.activityName" :clearable="false" placeholder="请输入活动名称" />
</el-form-item>
        <el-form-item label="活动价格:" prop="price">
    <el-input-number v-model="formData.price" style="width:100%" :precision="2" :clearable="false" />
</el-form-item>
        <el-form-item label="分类:" prop="category">
    <el-select v-model="formData.category" placeholder="请选择分类" filterable style="width:100%" :clearable="false">
        <el-option v-for="(item,key) in dataSource.category" :key="key" :label="item.label" :value="item.value" />
    </el-select>
</el-form-item>
        <el-form-item label="封面图:" prop="coverPicture">
    <el-input v-model="formData.coverPicture" :clearable="false" placeholder="请输入封面图" />
</el-form-item>
        <el-form-item label="展示报名人数:" prop="actualEnrollment">
    <el-input v-model.number="formData.actualEnrollment" :clearable="false" placeholder="请输入展示报名人数" />
</el-form-item>
        <el-form-item label="状态:" prop="status">
    <el-switch v-model="formData.status" active-color="#13ce66" inactive-color="#ff4949" active-text="是" inactive-text="否" clearable ></el-switch>
</el-form-item>
        <el-form-item label="排序:" prop="sortOrder">
    <el-input v-model.number="formData.sortOrder" :clearable="false" placeholder="请输入排序" />
</el-form-item>
        <el-form-item label="开始时间:" prop="startTime">
    <el-date-picker v-model="formData.startTime" type="date" style="width:100%" placeholder="选择日期" :clearable="false" />
</el-form-item>
        <el-form-item label="结束时间:" prop="endTime">
    <el-date-picker v-model="formData.endTime" type="date" style="width:100%" placeholder="选择日期" :clearable="false" />
</el-form-item>
        <el-form-item label="展示开始时间:" prop="showStartTime">
    <el-date-picker v-model="formData.showStartTime" type="date" style="width:100%" placeholder="选择日期" :clearable="false" />
</el-form-item>
        <el-form-item label="展示结束时间:" prop="showEndTime">
    <el-date-picker v-model="formData.showEndTime" type="date" style="width:100%" placeholder="选择日期" :clearable="false" />
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
    getActivitiesDataSource,
  createActivities,
  updateActivities,
  findActivities
} from '@/api/system/core_activities'

defineOptions({
    name: 'ActivitiesForm'
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
// 验证规则
const rule = reactive({
               activityName : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               category : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               coverPicture : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               startTime : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               endTime : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               showStartTime : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
               showEndTime : [{
                   required: true,
                   message: '',
                   trigger: ['input','blur'],
               }],
})

const elFormRef = ref()
  const dataSource = ref([])
  const getDataSourceFunc = async()=>{
    const res = await getActivitiesDataSource()
    if (res.code === 0) {
      dataSource.value = res.data
    }
  }
  getDataSourceFunc()

// 初始化方法
const init = async () => {
 // 建议通过url传参获取目标数据ID 调用 find方法进行查询数据操作 从而决定本页面是create还是update 以下为id作为url参数示例
    if (route.query.id) {
      const res = await findActivities({ ID: route.query.id })
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
