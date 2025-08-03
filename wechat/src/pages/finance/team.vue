<script setup lang="ts">
import { reactive, ref } from 'vue'
import HeaderSimple from '@/components/Header/HeaderSimple.vue'

interface TeamMember {
  id: string
  userId: string
  userName: string
  userAvatar: string
  isMember: boolean
  memberExpireTime?: string
  registerTime: string
  activationMethod?: string
}

const activeTab = ref('team')

const teamMembers = ref<TeamMember[]>([
  {
    id: '1',
    userId: '123212',
    userName: '陈',
    userAvatar: '/static/images/avatar.jpg',
    isMember: true,
    memberExpireTime: '2025-02-02 19:32:21',
    registerTime: '2022-08-25 08:15:19',
    activationMethod: '兑换码开通',
  },
  {
    id: '2',
    userId: '123213',
    userName: '李',
    userAvatar: '/static/images/avatar.jpg',
    isMember: true,
    memberExpireTime: '2025-02-02 19:32:21',
    registerTime: '2022-08-25 08:15:20',
    activationMethod: '线上支付',
  },
  {
    id: '3',
    userId: '123214',
    userName: '王',
    userAvatar: '/static/images/avatar.jpg',
    isMember: false,
    registerTime: '2022-08-25 08:15:21',
  },
  {
    id: '4',
    userId: '123215',
    userName: '张',
    userAvatar: '/static/images/avatar.jpg',
    isMember: true,
    memberExpireTime: '2025-02-02 19:32:21',
    registerTime: '2022-08-25 08:15:22',
    activationMethod: '兑换码开通',
  },
  {
    id: '5',
    userId: '123216',
    userName: '刘',
    userAvatar: '/static/images/avatar.jpg',
    isMember: false,
    registerTime: '2022-08-25 08:15:23',
  },
])

const searchForm = reactive({
  keyword: '',
  registerTime: '',
  activationMethod: '',
})

const timeOptions = [
  { label: '全部时间', value: '' },
  { label: '最近7天', value: '7days' },
  { label: '最近30天', value: '30days' },
  { label: '最近90天', value: '90days' },
]

const activationOptions = [
  { label: '全部方式', value: '' },
  { label: '兑换码开通', value: 'code' },
  { label: '线上支付', value: 'online' },
]

function handleSearch() {
  // 实现搜索逻辑
  console.log('搜索:', searchForm)
}

function handleReset() {
  searchForm.keyword = ''
  searchForm.registerTime = ''
  searchForm.activationMethod = ''
}

function handleActivateMember(member: TeamMember) {
  uni.showModal({
    title: '开通会员',
    content: `确定要为 ${member.userName} 开通会员吗？`,
    success: (res) => {
      if (res.confirm) {
        // 这里应该调用API开通会员
        uni.showToast({
          title: '开通成功',
          icon: 'success',
        })
      }
    },
  })
}

function handleRenewMember(member: TeamMember) {
  uni.showModal({
    title: '会员续费',
    content: `确定要为 ${member.userName} 续费会员吗？`,
    success: (res) => {
      if (res.confirm) {
        // 这里应该调用API续费会员
        uni.showToast({
          title: '续费成功',
          icon: 'success',
        })
      }
    },
  })
}

const value1 = ref('1')
const value2 = ref('1')
</script>

<template>
  <view class="default-layout-content">
    <!-- 头部 -->
    <HeaderSimple title="我的团队" :show-back="true" />

    <scroll-view
      class="no-scrollbar flex flex-1 flex-col"
      :scroll-y="true"
      :show-scrollbar="false"
      enhanced="true"
    >
      <!-- 搜索和筛选 -->
      <view class="search-section">
        <view class="search-row">
          <sar-input v-model="searchForm.keyword" placeholder="用户" class="search-input">
            <template #prepend>
              <text class="search-icon">🔍</text>
            </template>
          </sar-input>
        </view>

        <sar-dropdown class="filter-row">
          <sar-dropdown-item v-model="searchForm.registerTime" placeholder="注册时间" :options="timeOptions" />
          <sar-dropdown-item v-model="searchForm.activationMethod" placeholder="开通方式" :options="activationOptions" />
        </sar-dropdown>

        <view class="button-row">
          <sar-button type="solid" size="small" theme="primary" @click="handleSearch">
            查询
          </sar-button>
          <sar-button type="outline" size="small" theme="default" @click="handleReset">
            重置
          </sar-button>
        </view>
      </view>

      <!-- 团队成员列表 -->
      <view class="team-list">
        <view
          v-for="member in teamMembers"
          :key="member.id"
          class="member-item"
        >
          <view class="member-header">
            <view class="user-info">
              <image :src="member.userAvatar" class="user-avatar" />
              <view class="user-details">
                <text class="user-name">{{ member.userName }}</text>
                <text class="user-id">(id:{{ member.userId }})</text>
              </view>
            </view>
            <view class="member-status">
              <sar-tag
                :theme="member.isMember ? 'success' : 'default'"
                size="small"
              >
                {{ member.isMember ? '会员' : '普通用户' }}
              </sar-tag>
            </view>
          </view>

          <view class="member-content">
            <view class="info-row">
              <text class="info-label">注册时间:</text>
              <text class="info-value">{{ member.registerTime }}</text>
            </view>

            <view v-if="member.isMember" class="info-row">
              <text class="info-label">会员到期:</text>
              <text class="info-value">{{ member.memberExpireTime }}</text>
            </view>

            <view v-if="member.activationMethod" class="info-row">
              <text class="info-label">开通方式:</text>
              <text class="info-value">{{ member.activationMethod }}</text>
            </view>
          </view>

          <view class="member-actions">
            <sar-button
              v-if="!member.isMember"
              type="solid"
              size="small"
              theme="primary"
              @click="handleActivateMember(member)"
            >
              开通会员
            </sar-button>
            <sar-button
              v-else
              type="outline"
              size="small"
              theme="primary"
              @click="handleRenewMember(member)"
            >
              续费会员
            </sar-button>
          </view>
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<style lang="scss" scoped>
.search-section {
  padding: var(--spacing-md) 0;
}

.search-row {
  margin-bottom: var(--spacing-sm);
}

.search-input {
  width: 100%;
}

.search-icon {
  font-size: 24rpx;
  color: var(--text-tertiary);
}

.button-row {
  display: flex;
  gap: var(--spacing-sm);
  margin-top: var(--spacing-sm);
}

.filter-row {
  display: flex;
  gap: var(--spacing-md);
}

.filter-item {
  flex: 1;
}

.member-item {
  background-color: var(--bg-primary);
  border-radius: var(--radius-md);
  padding: var(--spacing-md);
  margin-bottom: var(--spacing-md);
  border: 1px solid var(--border-primary);
}

.member-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: var(--spacing-md);
  padding-bottom: var(--spacing-sm);
}

.user-info {
  display: flex;
  align-items: center;
  gap: var(--spacing-sm);
}

.user-avatar {
  width: 64rpx;
  height: 64rpx;
  border-radius: 50%;
}

.user-details {
  display: flex;
  flex-direction: column;
}

.user-name {
  font-size: 28rpx;
  font-weight: bold;
  color: var(--text-primary);
}

.user-id {
  font-size: 22rpx;
  color: var(--text-secondary);
}

.member-status {
  display: flex;
  align-items: center;
}

.member-content {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-xs);
  margin-bottom: var(--spacing-md);
}

.info-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.info-label {
  font-size: 24rpx;
  color: var(--text-secondary);
}

.info-value {
  font-size: 24rpx;
  color: var(--text-primary);
}

.member-actions {
  display: flex;
  justify-content: flex-end;
}
</style>

<route lang="jsonc" type="page">
{
"layout": "default",
"style": {
"navigationStyle": "custom",
"navigationBarTitleText": "我的团队"
}
}
</route>
