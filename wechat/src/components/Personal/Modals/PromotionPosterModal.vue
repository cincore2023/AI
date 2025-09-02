<script setup lang="ts">
interface PosterItem {
  id: string
  name: string
  qrCode: string
  preview: string
}

interface Props {
  visible: boolean
}

interface Emits {
  (e: 'update:visible', value: boolean): void

  (e: 'download', poster: PosterItem): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

// 海报列表
const posterList = ref<PosterItem[]>([
  {
    id: '1',
    name: '经典版',
    qrCode: '/static/images/avatar.png',
    preview: '/static/images/avatar.png',
  },
  {
    id: '2',
    name: '科技版',
    qrCode: '/static/images/avatar.png',
    preview: '/static/images/avatar.png',
  },
  {
    id: '3',
    name: '简约版',
    qrCode: '/static/images/avatar.png',
    preview: '/static/images/avatar.png',
  },
])

// 当前选中的海报索引
const currentIndex = ref(0)

// 关闭弹窗
function handleClose() {
  emit('update:visible', false)
}

// 轮播切换事件
function handleSwiperChange(e: any) {
  currentIndex.value = e.detail.current
}

// 下载海报
function handleDownload() {
  const currentPoster = posterList.value[currentIndex.value]
  emit('download', currentPoster)
}
</script>

<template>
  <sar-popup :visible="visible" @overlay-click="handleClose">
    <view class="w-[80vw]">
      <!-- 海报轮播 -->
      <swiper
        class="h-800rpx w-full"
        :indicator-dots="true"
        :autoplay="false"
        :interval="3000"
        :duration="500"
        indicator-color="rgba(255, 255, 255, 0.3)"
        indicator-active-color="#fff"
        @change="handleSwiperChange"
      >
        <swiper-item v-for="(poster, index) in posterList" :key="index" class="flex-center">
          <image :src="poster.qrCode" class="h-full w-full" mode="widthFix" />
        </swiper-item>
      </swiper>
      <!-- 操作按钮 -->
      <sar-button type="default" @click="handleDownload">
        保存到相册
      </sar-button>
    </view>
  </sar-popup>
</template>
