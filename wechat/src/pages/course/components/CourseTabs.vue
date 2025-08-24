<script setup lang="ts">
interface Props {
  activeTab: number
  tabList: Array<{ title: string }>
  isMember: boolean
}

interface Emits {
  (e: 'update:activeTab', value: number): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

const updateActiveTab = (index: number) => {
  emit('update:activeTab', index)
}
</script>

<template>
  <view class="tab-container pb-4">
    <sar-tabs
      v-model:current="activeTab"
      :list="tabList"
      class="course-tabs"
      @change="updateActiveTab"
    />
  </view>
</template>

<style lang="scss" scoped>
.tab-container {
  border-top: 1px solid var(--border-primary);
}

.course-tabs {
  --sar-tabs-item-color: var(--text-tertiary);
  --sar-tabs-item-active-color: var(--primary-color);
  --sar-tabs-item-active-font-weight: bold;
  --sar-tabs-line-color: var(--primary-color);
}
</style> 