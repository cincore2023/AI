<script lang="ts" setup>
import FgTabBar from './fg-tabbar/fg-tabbar.vue'
</script>

<template>
  <view class="layout-container">
    <view class="layout-content">
      <slot />
    </view>
    <FgTabBar />
  </view>
</template>

<style lang="scss" scoped>
.layout-container {
  height: 100vh;
  display: flex;
  flex-direction: column;
  overflow: hidden;

  .layout-content {
    flex: 1;
    //padding: 0 30rpx;
    overflow: scroll;
  }
}
</style>
