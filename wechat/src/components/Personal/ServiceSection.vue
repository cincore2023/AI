<script setup lang="ts">
interface ServiceItem {
  icon: string
  title: string
  path: string
}

interface Props {
  serviceList: ServiceItem[]
}

const props = defineProps<Props>()
const emit = defineEmits<{
  serviceClick: [service: ServiceItem]
  bindSales: []
}>()

function handleServiceClick(service: ServiceItem) {
  emit('serviceClick', service)
}

function handleBindSales() {
  emit('bindSales')
}
</script>

<template>
  <view class="mb-0 bg-white p-6 pb-0">
    <view class="mb-6 flex items-center justify-between">
      <text class="text-lg text-gray-800 font-bold">我的服务</text>
      <view class="flex items-center">
        <text class="mr-3 text-xs text-gray-500">销售专员:</text>
        <view
          class="rounded bg-blue-500 px-4 py-2 text-sm text-white"
          @click="handleBindSales"
        >
          <text class="mr-2">🔗</text>
          <text>立即绑定</text>
        </view>
      </view>
    </view>

    <view class="grid grid-cols-3 gap-5">
      <view
        v-for="(service, index) in serviceList"
        :key="index"
        class="rounded-lg bg-gray-100 p-5 text-center"
        @click="handleServiceClick(service)"
      >
        <view class="mb-3 text-3xl">
          {{ service.icon }}
        </view>
        <text class="whitespace-nowrap text-xs text-gray-700">{{ service.title }}</text>
      </view>
    </view>
  </view>
</template>
