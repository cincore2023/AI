<!-- 使用 type="home" 属性设置首页，其他页面不需要设置，默认为page -->
<route lang="jsonc" type="home">
{
"layout": "tabbar",
"style": {
"navigationStyle": "custom",
"navigationBarTitleText": "首页"
}
}
</route>

<script lang="ts" setup>
import HeaderWithSearch from '@/components/Header/HeaderWithSearch.vue'

import FeaturedCoursesSection from '@/components/Home/FeaturedCoursesSection.vue'
import HomeSwiper from '@/components/Home/HomeSwiper.vue'
import IconSlider from '@/components/Home/IconSlider.vue'
import InstructorTeamSection from '@/components/Home/InstructorTeamSection.vue'
import RecommendedSection from '@/components/Home/RecommendedSection.vue'

import { useThemeStore } from '@/store'

// 使用主题store
const themeStore = useThemeStore()
</script>

<template>
  <view class="home-content px-4">
    <!-- 头部组件 -->
    <HeaderWithSearch />

    <!-- 页面内容 -->
    <scroll-view
      class="no-scrollbar flex flex-1 flex-col"
      :scroll-y="true"
      :show-scrollbar="false"
      enhanced="true"
    >
      <!-- 首页轮播图 -->
      <HomeSwiper />

      <!-- 图标滑动组件 -->
      <IconSlider />

      <!-- 推荐课程 -->
      <RecommendedSection />

      <!-- 精选课程 -->
      <FeaturedCoursesSection />

      <!-- 讲师团队 -->
      <InstructorTeamSection />
    </scroll-view>
  </view>
</template>

<style lang="scss" scoped>
.home-content {
  height: 100%;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.theme-test-section {
  background-color: var(--bg-primary);
  color: var(--text-primary);
  box-shadow: var(--shadow-sm);
}
</style>
