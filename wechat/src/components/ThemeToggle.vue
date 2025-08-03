<script setup lang="ts">
import { useThemeStore } from '@/store'

const themeStore = useThemeStore()

function handleToggleTheme() {
  themeStore.toggleTheme()
}
</script>

<template>
  <view class="theme-toggle">
    <button
      class="theme-btn flex items-center justify-center rounded-lg px-4 py-2 transition-all duration-300"
      @click="handleToggleTheme"
    >
      <text class="theme-icon mr-2">{{ themeStore.currentTheme === 'light' ? '🌙' : '☀️' }}</text>
      <text class="theme-text">{{ themeStore.getCurrentThemeName() }}主题</text>
    </button>
  </view>
</template>

<style lang="scss" scoped>
.theme-toggle {
  display: inline-block;
}

.theme-btn {
  font-size: 28rpx;
  border: none;
  outline: none;
  background-color: var(--bg-secondary);
  color: var(--text-primary);

  &:active {
    transform: scale(0.95);
    background-color: var(--bg-tertiary);
  }
}

.theme-icon {
  font-size: 32rpx;
}

.theme-text {
  font-weight: 500;
}
</style>
