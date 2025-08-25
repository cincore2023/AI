<script setup lang="ts">
import BindRequiredModal from '@/components/Personal/Modals/BindRequiredModal.vue'

import MembershipModal from '@/components/Personal/Modals/MembershipModal.vue'
import PromotionPosterModal from '@/components/Personal/Modals/PromotionPosterModal.vue'
import PartnerSection from '@/components/Personal/PartnerSection.vue'
import ServiceSection from '@/components/Personal/ServiceSection.vue'
import UserInfoSection from '@/components/Personal/UserInfoSection.vue'

interface PartnerInfo {
  withdrawableIncome: number
  totalIncome: number
  teamCount: number
  withdrawing: number
  withdrawn: number
  memberCode: number
  activityCode: number
}

// 绑定销售专员相关
const showBindSalesModal = ref(false)
const bindSalesPhone = ref('')

// 会员开通相关
const showMembershipModal = ref(false)
const showBindSalesRequiredModal = ref(false)
const hasBoundSales = ref(false) // 模拟是否已绑定销售专员

// 推广码海报相关
const showPromotionPosterModal = ref(false)

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

  // memberStore.activateMember()
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
  showPromotionPosterModal.value = true
}

// 下载推广海报
function handleDownloadPoster(poster: any) {
  // 这里可以实现保存图片到相册的逻辑
  uni.showModal({
    title: '保存海报',
    content: `确定要保存"${poster.name}"海报到相册吗？`,
    success: (res) => {
      if (res.confirm) {
        // 调用保存图片到相册的API
        uni.saveImageToPhotosAlbum({
          filePath: poster.preview,
          success: () => {
            uni.showToast({
              title: '保存成功',
              icon: 'success',
            })
            showPromotionPosterModal.value = false
          },
          fail: () => {
            uni.showToast({
              title: '保存失败',
              icon: 'none',
            })
          },
        })
      }
    },
  })
}

onMounted(async () => {
  // 检查会员状态
  // await memberStore.checkMemberStatus()
})
</script>

<template>
  <view class="default-layout-content">
    <!-- 头部 -->
    <HeaderSimple title="个人中心" :show-back="false" :show-right="true"/>

    <scroll-view class="no-scrollbar flex flex-1 flex-col" :scroll-y="true" :show-scrollbar="false" enhanced="true">
      <!-- 用户信息区域 -->
      <UserInfoSection @renew="handleRenew" />

      <!-- 我的服务 -->
      <ServiceSection @bind-sales="handleBindSales" />

      <!-- 合伙人中心 -->
      <PartnerSection :partner-info="partnerInfo" @income-details="handleIncomeDetails" @generate-code="handleGenerateCode"/>
    </scroll-view>
  </view>

  <!-- 会员开通弹框 -->
  <MembershipModal v-model:show="showMembershipModal" @confirm="confirmMembership"/>

  <!-- 需要绑定销售专员提示弹框 -->
  <BindRequiredModal
    v-model:show="showBindSalesRequiredModal"
    @confirm="handleBindSalesFromRequired"
  />

  <!-- 推广码海报弹窗 -->
  <PromotionPosterModal
    v-model:visible="showPromotionPosterModal"
    @download="handleDownloadPoster"
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
