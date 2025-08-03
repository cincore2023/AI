<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { useMemberStore } from '@/store/member'

import CourseInfo from './components/CourseInfo.vue'
import CourseTabs from './components/CourseTabs.vue'
import CourseContent from './components/CourseContent.vue'
import CourseActions from './components/CourseActions.vue'

interface Chapter {
  title: string
  duration: string
}

interface Instructor {
  name: string
  title: string
  avatar: string
  bio: string
}

interface Material {
  name: string
  size: string
  url: string
}

interface CourseDetail {
  id: string
  title: string
  description: string
  images: string[]
  price: number
  studentCount: number
  chapters: Chapter[]
  instructor: Instructor
  materials: Material[]
}


const courseId = ref('')
const memberStore = useMemberStore()
const isMember = computed(() => memberStore.isMember)
const activeTab = ref(0)



const tabList = ref([
  { title: '预览' },
  { title: '讲师' },
  { title: '资料' },
])

// 模拟课程详情数据
const courseDetail = ref<CourseDetail>({
  id: '1',
  title: '2023年软件开发工程师培训',
  description: '本课程将全面介绍现代软件开发的核心技术，包括前端开发、后端架构、数据库设计、DevOps实践等。通过实际项目案例，帮助学员掌握企业级应用开发技能。',
  images: [
    'https://picsum.photos/400/200?random=1',
    'https://picsum.photos/400/200?random=2',
    'https://picsum.photos/400/200?random=3',
  ],
  price: 1299,
  studentCount: 3223,
  chapters: [
    { title: '课程介绍与环境搭建', duration: '15分钟' },
    { title: '前端开发基础', duration: '45分钟' },
    { title: 'Vue.js 框架实战', duration: '60分钟' },
    { title: '后端API设计', duration: '90分钟' },
    { title: '数据库设计与优化', duration: '75分钟' },
    { title: '项目部署与运维', duration: '45分钟' },
  ],
  instructor: {
    name: '张教授',
    title: '资深软件工程师',
    avatar: '/static/images/avatar.jpg',
    bio: '拥有10年软件开发经验，曾在多家知名互联网公司担任技术负责人。专注于前端架构设计和后端系统优化，参与过多个大型项目的技术架构设计。',
  },
  materials: [
    { name: '课程大纲.pdf', size: '2.3MB', url: '#' },
    { name: '代码示例.zip', size: '15.7MB', url: '#' },
    { name: '学习资料.docx', size: '8.1MB', url: '#' },
  ],
})

// 处理底部按钮点击
function handleAction() {
  if (isMember.value) {
    // 会员用户直接观看
    uni.showToast({
      title: '开始学习',
      icon: 'success',
    })
  } else {
    // 非会员用户跳转会员购买
    uni.showModal({
      title: '开通会员',
      content: '开通会员即可免费观看所有课程，是否立即开通？',
      success: (res) => {
        if (res.confirm) {
          memberStore.activateMember()
        }
      },
    })
  }
}

// 下载资料
function downloadMaterial(material: Material) {
  if (!isMember.value) {
    uni.showToast({
      title: '会员专享功能',
      icon: 'none',
    })
    return
  }

  uni.showLoading({
    title: '下载中...',
  })

  setTimeout(() => {
    uni.hideLoading()
    uni.showToast({
      title: '下载成功',
      icon: 'success',
    })
  }, 2000)
}

// 检查是否为iOS设备
function checkIOSPayment() {
  // #ifdef APP-PLUS
  const systemInfo = uni.getSystemInfoSync()
  if (systemInfo.platform === 'ios') {
    uni.showModal({
      title: '绑定确认',
      content: '非常抱歉，苹果用户暂不支持购买',
      showCancel: false,
    })
  }
  // #endif
}

onMounted(async () => {
  // 获取页面参数
  const pages = getCurrentPages()
  const currentPage = pages[pages.length - 1]
  const options = currentPage.options

  if (options.id) {
    courseId.value = options.id
  }

  // 检查会员状态
  await memberStore.checkMemberStatus()

  // 根据会员状态调整标签页
  if (isMember.value) {
    tabList.value[0].title = '详情'
  }

  // 检查iOS支付限制
  checkIOSPayment()
})
</script>

<template>
  <view class="h-[100vh] flex flex-col overflow-hidden">
    <!-- 头部 -->
    <HeaderSimple title="课程详情" :show-back="true" />

    <scroll-view class="no-scrollbar flex flex-1 flex-col"
      :scroll-y="true"
      :show-scrollbar="false"
      enhanced="true">
      <!-- 课程图片轮播 -->
      <HomeSwiper />

      <!-- 课程信息 -->
      <CourseInfo
        :title="courseDetail.title"
        :price="courseDetail.price"
        :student-count="courseDetail.studentCount"
        :is-member="isMember"
      />

      <!-- 标签页 -->
      <CourseTabs
        v-model:active-tab="activeTab"
        :tab-list="tabList"
        :is-member="isMember"
      />

      <!-- 标签页内容 -->
      <CourseContent
        :active-tab="activeTab"
        :is-member="isMember"
        :description="courseDetail.description"
        :chapters="courseDetail.chapters"
        :instructor="courseDetail.instructor"
        :materials="courseDetail.materials"
        @download="downloadMaterial"
      />
    </scroll-view>

    <!-- 底部操作栏 -->
    <CourseActions :is-member="isMember" @action="handleAction"/>
  </view>
</template>

<route lang="jsonc" type="page">
{
  "style": {
    "navigationStyle": "custom",
    "navigationBarTitleText": "课程详情"
  }
}
</route>
