<script setup lang="ts">
import BindRequiredModal from '@/components/Personal/Modals/BindRequiredModal.vue'

import BindSalesModal from '@/components/Personal/Modals/BindSalesModal.vue'
import MembershipModal from '@/components/Personal/Modals/MembershipModal.vue'
import PartnerSection from '@/components/Personal/PartnerSection.vue'
import ServiceSection from '@/components/Personal/ServiceSection.vue'
import UserInfoSection from '@/components/Personal/UserInfoSection.vue'

import { useMemberStore } from '@/store/member'

interface ServiceItem {
  icon: string
  title: string
  path: string
}

interface PartnerInfo {
  withdrawableIncome: number
  totalIncome: number
  teamCount: number
  withdrawing: number
  withdrawn: number
  memberCode: number
  activityCode: number
}

const memberStore = useMemberStore()

// 绑定销售专员相关
const showBindSalesModal = ref(false)
const bindSalesPhone = ref('')

// 会员开通相关
const showMembershipModal = ref(false)
const showBindSalesRequiredModal = ref(false)
const hasBoundSales = ref(false) // 模拟是否已绑定销售专员

// 我的服务列表
const serviceList = ref<ServiceItem[]>([
  { icon: '📊', title: '我的活动', path: '/pages/activities/index' },
  { icon: '📚', title: '我的课程', path: '/pages/course/index' },
  { icon: '📁', title: '我的素材', path: '/pages/material/index' },
  { icon: '🤖', title: '我的智能体', path: '/pages/ai/index' },
  { icon: '🎧', title: '联系客服', path: '/pages/service/index' },
  { icon: '📖', title: '教程中心', path: '/pages/tutorial/index' },
])

// 合伙人信息
const partnerInfo = ref<PartnerInfo>({
  withdrawableIncome: 1000.20,
  totalIncome: 1000.20,
  teamCount: 1200,
  withdrawing: 1200,
  withdrawn: 1800,
  memberCode: 99,
  activityCode: 5,
})

// 用户信息
const userInfo = ref({
  nickname: '微信昵称',
  phone: '185****0617',
  avatar: '/static/images/avatar.jpg',
  memberExpireDate: '2021-12-12',
})

// 处理服务点击
function handleServiceClick(service: ServiceItem) {
  uni.navigateTo({
    url: service.path,
  })
}

// 修改昵称
function handleModifyNickname() {
  uni.showModal({
    title: '修改昵称',
    content: '请输入新的昵称',
    editable: true,
    success: (res) => {
      if (res.confirm && res.content) {
        userInfo.value.nickname = res.content
        uni.showToast({
          title: '修改成功',
          icon: 'success',
        })
      }
    },
  })
}

// 立即续费/开通会员
function handleRenew() {
  showMembershipModal.value = true
}

// 确认开通会员
function confirmMembership() {
  // 检查是否已绑定销售专员
  if (!hasBoundSales.value) {
    showBindSalesRequiredModal.value = true
    return
  }

  // 这里应该调用API开通会员
  // const response = await http.post('/api/membership/activate')

  memberStore.activateMember()
  uni.showToast({
    title: '会员开通成功',
    icon: 'success',
  })

  showMembershipModal.value = false
}

// 绑定销售专员
function handleBindSales() {
  showBindSalesModal.value = true
}

// 确认绑定销售专员
function confirmBindSales() {
  if (!bindSalesPhone.value.trim()) {
    uni.showToast({
      title: '请输入销售专员手机号',
      icon: 'none',
    })
    return
  }

  // 这里应该调用API绑定销售专员
  // const response = await http.post('/api/sales/bind', { phone: bindSalesPhone.value })

  hasBoundSales.value = true
  uni.showToast({
    title: '绑定成功',
    icon: 'success',
  })

  showBindSalesModal.value = false
  bindSalesPhone.value = ''
}

// 取消绑定销售专员
function cancelBindSales() {
  showBindSalesModal.value = false
  bindSalesPhone.value = ''
}

// 从需要绑定提示弹框跳转到绑定弹框
function handleBindSalesFromRequired() {
  showBindSalesRequiredModal.value = false
  showBindSalesModal.value = true
}


// 收支明细
function handleIncomeDetails() {
  uni.navigateTo({
    url: '/pages/finance/transactions',
  })
}

// 生成推广码
function handleGenerateCode() {
  uni.showToast({
    title: '推广码已生成',
    icon: 'success',
  })
}

onMounted(async () => {
  // 检查会员状态
  await memberStore.checkMemberStatus()
})
</script>

<template>
  <view class="default-layout-content">
    <!-- 头部 -->
    <HeaderSimple
      title="个人中心"
      :show-back="false"
      :show-right="true"
    />

    <scroll-view
      class="no-scrollbar flex flex-1 flex-col"
      :scroll-y="true"
      :show-scrollbar="false"
      enhanced="true"
    >
      <!-- 用户信息区域 -->
      <UserInfoSection
        :user-info="userInfo"
        @modify-nickname="handleModifyNickname"
        @renew="handleRenew"
      />

      <!-- 我的服务 -->
      <ServiceSection
        :service-list="serviceList"
        @service-click="handleServiceClick"
        @bind-sales="handleBindSales"
      />

      <!-- 合伙人中心 -->
      <PartnerSection
        :partner-info="partnerInfo"
        @income-details="handleIncomeDetails"
        @generate-code="handleGenerateCode"
      />
    </scroll-view>
  </view>

  <!-- 绑定销售专员弹框 -->
  <BindSalesModal
    v-model:show="showBindSalesModal"
    v-model:bind-sales-phone="bindSalesPhone"
    @confirm="confirmBindSales"
    @cancel="cancelBindSales"
  />

  <!-- 会员开通弹框 -->
  <MembershipModal
    v-model:show="showMembershipModal"
    @confirm="confirmMembership"
  />

  <!-- 需要绑定销售专员提示弹框 -->
  <BindRequiredModal
    v-model:show="showBindSalesRequiredModal"
    @confirm="handleBindSalesFromRequired"
  />
</template>

<route lang="jsonc" type="page">
{
  "layout": "tabbar",
  "style": {
    "navigationStyle": "custom",
    "navigationBarTitleText": "个人中心"
  }
}
</route>
