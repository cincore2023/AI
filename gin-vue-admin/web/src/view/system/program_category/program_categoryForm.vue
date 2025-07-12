
<template>
  <div>
    <div class="gva-form-box">
      <el-form :model="formData" ref="elFormRef" label-position="right" :rules="rule" label-width="80px">
          <el-form-item label="父节点:" prop="parentID" >
              <el-tree-select
                  v-model="formData.parentID"
                  :data="[rootNode,...tableData]"
                  check-strictly
                  :render-after-expand="false"
                  :props="defaultProps"
                  clearable
                  style="width: 240px"
                  placeholder="根节点"
              />
          </el-form-item>
        <el-form-item label="分类名称:" prop="categoryName">
    <el-input v-model="formData.categoryName" :clearable="false" placeholder="请输入分类名称" />
</el-form-item>
        <el-form-item label="状态:" prop="status">
    <el-switch v-model="formData.status" active-color="#13ce66" inactive-color="#ff4949" active-text="是" inactive-text="否" clearable ></el-switch>
</el-form-item>
        <el-form-item label="排序:" prop="sortOrder">
    <el-input v-model.number="formData.sortOrder" :clearable="false" placeholder="请输入排序" />
</el-form-item>
        <el-form-item label="分类类型:" prop="type">
    <el-input v-model="formData.type" :clearable="true" placeholder="请输入分类类型" />
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
    getCategoryList,
  createCategory,
  updateCategory,
  findCategory
} from '@/api/system/program_category'

defineOptions({
    name: 'CategoryForm'
})

// 自动获取字典
import { getDictFunc } from '@/utils/format'
import { useRoute, useRouter } from "vue-router"
import { ElMessage } from 'element-plus'
import { ref, reactive } from 'vue'


const route = useRoute()
const router = useRouter()
const tableData = ref([])

const defaultProps = {
  children: "children",
  label: "CategoryName",
  value: "ID"
}

const rootNode = {
  ID: 0,
  CategoryName: '根节点',
  children: []
}

const getTableData = async() => {
  const table = await getCategoryList()
  if (table.code === 0) {
    tableData.value = table.data || []
  }
}

getTableData()

// 提交按钮loading
const btnLoading = ref(false)

const type = ref('')
const formData = ref({
            parentID: undefined,
            categoryName: '',
            status: false,
            sortOrder: 0,
            type: '',
        })
// 验证规则
const rule = reactive({
               categoryName : [{
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
      const res = await findCategory({ ID: route.query.id })
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
               res = await createCategory(formData.value)
               break
             case 'update':
               res = await updateCategory(formData.value)
               break
             default:
               res = await createCategory(formData.value)
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
