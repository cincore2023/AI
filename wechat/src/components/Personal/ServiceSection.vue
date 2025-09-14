<script setup lang="ts">
import { storeToRefs } from 'pinia'
import BindSalesModal from '@/components/Personal/Modals/BindSalesModal.vue'
import { useUserStore } from '@/store/user'

const { wechatUser } = storeToRefs(useUserStore())

interface ServiceItem {
  icon: string
  title: string
  path?: string
  open?: string
}

const bindSalesModalRef = ref()

// 我的服务列表
const serviceList = ref<ServiceItem[]>([
  { icon: '📊', title: '我的活动', path: '/pages/activities/index' },
  { icon: '📚', title: '我的课程', path: '/pages/course/index' },
  { icon: '📁', title: '我的素材', path: '/pages/material/index' },
  { icon: '🤖', title: '我的智能体', path: '/pages/ai/index' },
  { icon: '🎧', title: '联系客服', open: 'contact' },
  { icon: '📖', title: '教程中心', path: '/pages/tutorial/index' },
])

function handleServiceClick(service: ServiceItem) {
  if (service.path) {
    uni.navigateTo({
      url: service.path,
    })
  }
}

function handleBindSales() {
  bindSalesModalRef.value?.show()
}
</script>

<template>
  <view class="bg-white p-4">
    <view class="mb-6 flex items-center justify-between">
      <text class="text-lg text-gray-800 font-bold">我的服务</text>
      <view class="flex items-center">
        <text class="mr-3 text-xs text-gray-500">销售专员:</text>
        <view
          v-if="!wechatUser?.salesperson" class="rounded bg-blue-500 px-3 py-1 text-3 text-white"
          @click="handleBindSales"
        >
          <text>立即绑定</text>
        </view>
        <view>
          {{ wechatUser.salespersonInfo?.nickname || wechatUser.salespersonInfo?.phoneNumber }}
        </view>
      </view>
    </view>

    <view class="grid grid-cols-3 gap-5">
      <sar-button
        v-for="(service, index) in serviceList"
        :key="index"
        root-class="rounded-lg bg-gray-100 p-5 items-center justify-center"
        type="mild"
        inline
        :open-type="service.open"
        @click="handleServiceClick(service)"
      >
        <text class="whitespace-nowrap text-xs text-gray-700">{{ service.title }}</text>
      </sar-button>
    </view>
  </view>

  <!-- 绑定销售专员弹框 -->
  <BindSalesModal ref="bindSalesModalRef" />
</template>
