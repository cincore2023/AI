<script setup lang="ts">
import { onHide, onLaunch, onShow } from '@dcloudio/uni-app'
import { usePageAuth } from '@/hooks/usePageAuth'
import { useThemeStore } from '@/store'
import 'abortcontroller-polyfill/dist/abortcontroller-polyfill-only'

usePageAuth()

// 初始化主题
const themeStore = useThemeStore()

onLaunch(() => {
  console.log('App Launch')
  // 初始化主题
  themeStore.initTheme()
})
onShow(() => {
  console.log('App Show')
})
onHide(() => {
  console.log('App Hide')
})
</script>

<style lang="scss">
@import 'sard-uniapp/index.scss';
@import '@/style/theme.scss';

#app {
  background: linear-gradient(to bottom, #d4e6f1 0%, #d5e8d4 15%, var(--bg-primary) 30%, var(--bg-primary) 100%);
  min-height: 100vh;
}
</style>
