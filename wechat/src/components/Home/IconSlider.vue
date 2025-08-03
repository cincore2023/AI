<script setup lang="ts">
import { ref } from 'vue'

interface IconItem {
  icon: string
  text: string
  key: string
}

// 图标数据 - 将素材库和智能体放在同一列表中
const iconList = ref<IconItem[]>([
  {
    icon: '🖼️',
    text: '素材库',
    key: 'material-library',
  },
  {
    icon: '⚛️',
    text: 'Ai智能体',
    key: 'ai-agent',
  },
  {
    icon: '🤖',
    text: '小鲸数字人',
    key: 'digital-human',
  },
  {
    icon: '🏌️',
    text: '线下',
    key: 'offline',
  },
  {
    icon: '💬',
    text: 'VIP学习群',
    key: 'vip-group',
  },
  {
    icon: '📺',
    text: '直播间',
    key: 'live-room',
  },
])

// 事件处理
function handleIconClick(item: IconItem) {
  console.log('点击图标:', item.text, item.key)
}

// 暴露方法给父组件
defineExpose({
  handleIconClick,
})
</script>

<template>
  <view class="icon-slider rounded-xl py-4">
    <scroll-view
      class="icons-scroll"
      :scroll-x="true"
      :show-scrollbar="false"
      enhanced="true"
    >
      <view class="flex items-center">
        <view
          v-for="(item, index) in iconList"
          :key="index"
          class="icon-item mr-8 min-w-16 flex flex-col items-center"
          @click="handleIconClick(item)"
        >
          <view class="icon-wrapper relative mb-2">
            <view
              class="icon h-16 w-16 flex items-center justify-center rounded-lg text-xl transition-colors duration-300"
            >
              {{ item.icon }}
            </view>
          </view>
          <text class="icon-text text-xs">{{ item.text }}</text>
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<style lang="scss" scoped>
.icons-scroll {
  // 隐藏滚动条
  &::-webkit-scrollbar {
    display: none;
  }

  // 确保内容可以滚动
  white-space: nowrap;
}

.icon-item {
  // 点击效果
  transition: transform 0.2s ease;

  &:active {
    transform: scale(0.95);
  }

  &:last-child {
    margin-right: 0;
  }
}

.icon {
  // 使用主题色
  background-color: var(--bg-secondary);
  color: var(--text-primary);

  &:active {
    background-color: var(--bg-tertiary);
  }
}

.icon-text {
  color: var(--text-primary);
  font-size: 20rpx;
  line-height: 1.2;
  // 文字完整显示，不省略
  white-space: nowrap;
  text-align: center;
}
</style>
