<script setup lang="ts">
import {computed, onMounted, ref} from 'vue'
import {useMemberStore} from '@/store/member'

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

const systemInfo = uni.getWindowInfo()

const courseId = ref('')
const memberStore = useMemberStore()
const isMember = computed(() => memberStore.isMember)
const activeTab = ref(0)

const BottomStyle = computed(() => ({
  paddingBottom: `${systemInfo.windowHeight - systemInfo.safeArea.bottom}px` || '0px',
  paddingTop: '20rpx',
}))

const tabList = ref([
  {title: '预览'},
  {title: '讲师'},
  {title: '资料'},
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
    {title: '课程介绍与环境搭建', duration: '15分钟'},
    {title: '前端开发基础', duration: '45分钟'},
    {title: 'Vue.js 框架实战', duration: '60分钟'},
    {title: '后端API设计', duration: '90分钟'},
    {title: '数据库设计与优化', duration: '75分钟'},
    {title: '项目部署与运维', duration: '45分钟'},
  ],
  instructor: {
    name: '张教授',
    title: '资深软件工程师',
    avatar: '/static/images/avatar.jpg',
    bio: '拥有10年软件开发经验，曾在多家知名互联网公司担任技术负责人。专注于前端架构设计和后端系统优化，参与过多个大型项目的技术架构设计。',
  },
  materials: [
    {name: '课程大纲.pdf', size: '2.3MB', url: '#'},
    {name: '代码示例.zip', size: '15.7MB', url: '#'},
    {name: '学习资料.docx', size: '8.1MB', url: '#'},
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
  <view class="h-full flex flex-col">
    <!-- 头部 -->
    <HeaderSimple title="课程详情" :show-back="true"/>
    <scroll-view class="flex flex-1 flex-col" :scroll-y="true" :show-scrollbar="false">
      <!-- 课程图片轮播 -->
      <HomeSwiper/>

      <!-- 课程信息 -->
      <view class="course-info">
        <!-- 价格信息 -->
        <view class="price-section flex items-center justify-between">
          <view class="price-info">
            <text class="price-label">价格:</text>
            <text class="price-value">¥{{ courseDetail.price }}</text>
            <text v-if="isMember" class="member-free">会员免费</text>
          </view>
          <view class="course-stats">
            已学习: {{ courseDetail.studentCount }}人
          </view>
        </view>

        <view class="course-title">
          {{ courseDetail.title }}
        </view>

        <!-- 会员状态提示 -->
        <view v-if="!isMember" class="member-notice member-notice-non">
          <view class="notice-content">
            <text class="notice-icon">☆</text>
            <text class="notice-text">成为会员可免费观看该课程</text>
            <text class="notice-arrow">→</text>
          </view>
        </view>

        <view v-else class="member-notice member-notice-member">
          <view class="notice-content">
            <text class="notice-icon">☆</text>
            <text class="notice-text">您是会员，可免费观看</text>
          </view>
        </view>
      </view>

      <!-- 标签页 -->
      <view class="tab-container">
        <sar-tabs
            v-model:current="activeTab"
            :list="tabList"
            class="course-tabs"
        />
      </view>

      <!-- 标签页内容 -->
      <view class="tab-content">
        <!-- 预览/详情内容 -->
        <view v-if="activeTab === 0" class="content-section">
          <view v-if="!isMember" class="preview-limit">
            <view class="limit-text">
              非会员用户，无详情，仅可查看预览内容
            </view>
            <view class="limit-subtext">
              开通会员后可查看完整课程内容
            </view>
          </view>
          <view v-else class="content-detail">
            <view class="content-card">
              <view class="card-title">
                课程简介
              </view>
              <view class="card-content">
                {{ courseDetail.description }}
              </view>
            </view>
            <view class="content-card">
              <view class="card-title">
                课程大纲
              </view>
              <view class="chapter-list">
                <view
                    v-for="(chapter, index) in courseDetail.chapters"
                    :key="index"
                    class="chapter-item"
                >
                  <view class="chapter-number">
                    {{ index + 1 }}
                  </view>
                  <text class="chapter-title">{{ chapter.title }}</text>
                  <text class="chapter-duration">{{ chapter.duration }}</text>
                </view>
              </view>
            </view>
          </view>
        </view>

        <!-- 讲师信息 -->
        <view v-if="activeTab === 1" class="content-section">
          <view class="instructor-info">
            <image
                :src="courseDetail.instructor.avatar"
                class="instructor-avatar"
            />
            <view class="instructor-details">
              <view class="instructor-name">
                {{ courseDetail.instructor.name }}
              </view>
              <view class="instructor-title">
                {{ courseDetail.instructor.title }}
              </view>
            </view>
          </view>
          <view class="instructor-bio">
            {{ courseDetail.instructor.bio }}
          </view>
        </view>

        <!-- 资料下载 -->
        <view v-if="activeTab === 2" class="content-section">
          <view class="material-list">
            <view
                v-for="(material, index) in courseDetail.materials"
                :key="index"
                class="material-item"
            >
              <view class="material-info">
                <view class="material-icon">
                  📄
                </view>
                <view class="material-details">
                  <view class="material-name">
                    {{ material.name }}
                  </view>
                  <view class="material-size">
                    {{ material.size }}
                  </view>
                </view>
              </view>
              <button
                  class="material-download-btn"
                  :class="[
                  isMember ? 'download-active' : 'download-disabled',
                ]"
                  :disabled="!isMember"
                  @click="downloadMaterial(material)"
              >
                {{ isMember ? '下载' : '会员专享' }}
              </button>
            </view>
          </view>
        </view>
      </view>
    </scroll-view>

    <!-- 底部操作栏 -->
    <view class="bottom-actions" :style="BottomStyle">
      <view class="action-buttons">
        <sar-button type="text">
          <view class="action-btn">
            <view class="action-icon">
              🏠
            </view>
            <view class="action-text">
              首页
            </view>
          </view>
        </sar-button>
        <sar-button type="text">
          <view class="action-btn">
            <view class="action
            papxicon">
              ⭐
            </view>
            <view class="action-text">
              收藏
            </view>
          </view>

        </sar-button>
        <sar-button type="text">
          <view class="action-btn">
            <view class="action-icon">
              📤
            </view>
            <view class="action-text">
              分享
            </view>
          </view>

        </sar-button>
      </view>
      <sar-button class="main-action-btn" round inline theme="secondary" @click="handleAction">
        {{ isMember ? '您是会员，可免费观看' : '开通会员，免费看' }}
      </sar-button>
    </view>
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

<style lang="scss" scoped>
.course-info {
  padding: var(--spacing-md);
  background-color: var(--bg-primary);
}

.course-title {
  font-size: 36rpx;
  font-weight: bold;
  color: var(--text-primary);
  margin-bottom: var(--spacing-sm);
  line-height: 1.4;
}

.course-stats {
  font-size: 26rpx;
  color: var(--text-secondary);
}

.price-section {
  margin-bottom: var(--spacing-md);
}

.price-info {
  display: flex;
  align-items: center;
  gap: var(--spacing-sm);
}

.price-label {
  font-size: 26rpx;
  color: var(--text-secondary);
}

.price-value {
  font-size: 32rpx;
  font-weight: bold;
  color: var(--error-color);
}

.member-free {
  font-size: 24rpx;
  color: var(--success-color);
  background: rgba(82, 196, 26, 0.1);
  padding: 4rpx 12rpx;
  border-radius: var(--radius-sm);
}

.member-notice {
  padding: var(--spacing-md);
  border-radius: var(--radius-md);
  margin-bottom: var(--spacing-md);

  &.member-notice-non {
    background: rgba(250, 173, 20, 0.1);
    border: 1px solid rgba(250, 173, 20, 0.3);
  }

  &.member-notice-member {
    background: rgba(82, 196, 26, 0.1);
    border: 1px solid rgba(82, 196, 26, 0.3);
  }
}

.notice-content {
  display: flex;
  align-items: center;
}

.notice-icon {
  font-size: 32rpx;
  margin-right: var(--spacing-sm);
  color: var(--warning-color);
}

.member-notice-member .notice-icon {
  color: var(--success-color);
}

.notice-text {
  flex: 1;
  font-size: 26rpx;
  color: var(--text-primary);
}

.notice-arrow {
  font-size: 32rpx;
  color: var(--text-secondary);
}

.tab-container {
  background-color: var(--bg-primary);
  border-top: 1px solid var(--border-primary);
}

.course-tabs {
  --sar-tabs-item-color: var(--text-tertiary);
  --sar-tabs-item-active-color: var(--primary-color);
  --sar-tabs-item-active-font-weight: bold;
  --sar-tabs-line-color: var(--primary-color);
}

.tab-content {
  background-color: var(--bg-primary);
  min-height: 400rpx;
}

.content-section {
  padding: var(--spacing-md);
}

.preview-limit {
  text-align: center;
  padding: var(--spacing-xl) 0;
}

.limit-text {
  font-size: 26rpx;
  color: var(--text-tertiary);
  margin-bottom: var(--spacing-sm);
}

.limit-subtext {
  font-size: 22rpx;
  color: var(--text-tertiary);
}

.content-detail {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-md);
}

.content-card {
  background: var(--bg-secondary);
  border-radius: var(--radius-md);
  padding: var(--spacing-md);
}

.card-title {
  font-size: 28rpx;
  font-weight: bold;
  color: var(--text-primary);
  margin-bottom: var(--spacing-sm);
}

.card-content {
  font-size: 26rpx;
  color: var(--text-secondary);
  line-height: 1.6;
}

.chapter-list {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-sm);
}

.chapter-item {
  display: flex;
  align-items: center;
  font-size: 26rpx;
  color: var(--text-secondary);
}

.chapter-number {
  width: 48rpx;
  height: 48rpx;
  background: var(--primary-color);
  color: var(--text-inverse);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 22rpx;
  margin-right: var(--spacing-md);
}

.chapter-title {
  flex: 1;
}

.chapter-duration {
  font-size: 22rpx;
  color: var(--text-tertiary);
}

.instructor-info {
  display: flex;
  align-items: center;
  margin-bottom: var(--spacing-md);
}

.instructor-avatar {
  width: 128rpx;
  height: 128rpx;
  border-radius: 50%;
  margin-right: var(--spacing-md);
}

.instructor-details {
  flex: 1;
}

.instructor-name {
  font-size: 28rpx;
  font-weight: bold;
  color: var(--text-primary);
  margin-bottom: var(--spacing-xs);
}

.instructor-title {
  font-size: 24rpx;
  color: var(--text-secondary);
}

.instructor-bio {
  font-size: 26rpx;
  color: var(--text-secondary);
  line-height: 1.6;
}

.material-list {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-md);
}

.material-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: var(--spacing-md);
  background: var(--bg-secondary);
  border-radius: var(--radius-md);
}

.material-info {
  display: flex;
  align-items: center;
  flex: 1;
}

.material-icon {
  width: 64rpx;
  height: 64rpx;
  background: var(--primary-color);
  color: var(--text-inverse);
  border-radius: var(--radius-sm);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24rpx;
  margin-right: var(--spacing-md);
}

.material-details {
  flex: 1;
}

.material-name {
  font-size: 26rpx;
  font-weight: bold;
  color: var(--text-primary);
  margin-bottom: var(--spacing-xs);
}

.material-size {
  font-size: 22rpx;
  color: var(--text-tertiary);
}

.material-download-btn {
  padding: var(--spacing-sm) var(--spacing-md);
  border-radius: var(--radius-sm);
  font-size: 22rpx;
  border: none;

  &.download-active {
    background: var(--primary-color);
    color: var(--text-inverse);
  }

  &.download-disabled {
    background: var(--text-tertiary);
    color: var(--text-inverse);
  }
}

.bottom-actions {
  background-color: var(--bg-primary);
  border-top: 1px solid var(--border-primary);
  display: flex;
  align-items: center;
  gap: 26px;
}

.action-buttons {
  display: grid;
  flex: 1;
  grid-template-columns: repeat(3, 1fr);
}

.action-btn {
  padding: var(--spacing-sm) 0;
  text-align: center;
  color: var(--bg-inverse);
}

.action-icon {
  font-size: 32rpx;
  margin-bottom: var(--spacing-xs);
}

.action-text {
  font-size: 22rpx;
}

.main-action-btn {
  width: 40%;
  font-size: 26rpx;
  font-weight: bold;
  border: none;
  color: var(--text-primary);
  background-color: var(--bg-inverse);
}
</style>
