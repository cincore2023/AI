<script setup lang="ts">
import { ref } from 'vue'

interface SwiperItem {
  id: string
  image: string
  title: string
  link?: string
}

// 轮播图数据
const swiperList = ref<SwiperItem[]>([
  {
    id: '1',
    image: 'https://picsum.photos/400/200?random=1',
    title: '老夫聊发少年狂，左牵黄，右擎苍，锦帽貂裘，千骑卷平冈。',
  },
  {
    id: '2',
    image: 'https://picsum.photos/400/200?random=2',
    title: '为报倾城随太守，亲射虎，看孙郎。',
  },
  {
    id: '3',
    image: 'https://picsum.photos/400/200?random=3',
    title: '酒酣胸胆尚开张。鬓微霜，又何妨！持节云中，何日遣冯唐？会挽雕弓如满月，西北望，射天狼。',
  },
])

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
        <swiper-item
          v-for="(item, index) in swiperList"
          :key="index"
          class="h-40"
        >
          <image
            :src="item.image"
            class="h-full w-full object-cover"
            mode="aspectFill"
          />
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
