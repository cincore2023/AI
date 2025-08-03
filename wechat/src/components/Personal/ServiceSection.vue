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
  <view class="bg-white p-4 mb-4">
    <view class="flex justify-between items-center mb-4">
      <text class="text-xl font-bold text-gray-800">我的服务</text>
      <view class="flex items-center">
        <text class="text-xs text-gray-500 mr-2">销售专员:</text>
        <view
          class="bg-blue-500 text-white px-3 py-1 rounded text-xs"
          @click="handleBindSales"
        >
          <text class="mr-1">🔗</text>
          <text>立即绑定</text>
        </view>
      </view>
    </view>

    <view class="grid grid-cols-3 gap-4">
      <view
        v-for="(service, index) in serviceList"
        :key="index"
        class="bg-gray-100 p-4 rounded-lg text-center"
        @click="handleServiceClick(service)"
      >
        <view class="text-3xl mb-2">{{ service.icon }}</view>
        <text class="text-sm text-gray-700">{{ service.title }}</text>
      </view>
    </view>
  </view>
</template> 