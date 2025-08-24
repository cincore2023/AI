<script setup lang="ts">
import { ref } from 'vue'
import { AppStore } from '@/store/app'

const { banner } = AppStore()

// 轮播图数据
const swiperList = computed(() => {
  return banner.filter(item => item.type === 'home')
})

const current = ref(0)

function handleSwiperChange(e: any) {
  current.value = e.detail.current
}

// 暴露方法给父组件
defineExpose({
  current,
  swiperList,
})
</script>

<template>
  <view class="home-swiper">
    <view class="swiper-container relative overflow-hidden rounded-lg">
      <swiper
        :current="current"
        autoplay
        :interval="3000"
        circular
        @change="handleSwiperChange"
      >
        <swiper-item v-for="item in swiperList" :key="item.id" class="h-40">
          <image :src="item.imageUrl" class="h-full w-full object-cover" mode="aspectFill" />
        </swiper-item>
      </swiper>

      <!-- 轮播指示器 -->
      <sar-swiper-dot
        :current="current"
        type="dot-bar"
        :list="swiperList"
        field="title"
      />
    </view>
  </view>
</template>

<style lang="scss" scoped>
.swiper-container {
  position: relative;
  border-radius: 16rpx;
  overflow: hidden;
  box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.1);
}
</style>
