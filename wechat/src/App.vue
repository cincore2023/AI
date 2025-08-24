<script setup lang="ts">
import { onHide, onLaunch, onShow } from '@dcloudio/uni-app'
import { usePageAuth } from '@/hooks/usePageAuth'
import { useThemeStore } from '@/store'
import { AppStore } from '@/store/app'
import { CourseStore } from '@/store/course'
import 'abortcontroller-polyfill/dist/abortcontroller-polyfill-only'

usePageAuth()

// 初始化主题
const themeStore = useThemeStore()
const appStore = AppStore()
const courseStore = CourseStore()

// 初始化数据
function initData() {
  appStore.getBannerList()
  appStore.getTeacherList()
  courseStore.getHotCourse()
  courseStore.getExquisiteCourse()
  courseStore.getCategory()
}

onLaunch(() => {
  initData()
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
@import '@/style/index.scss';

#app,
.layout-container {
  min-height: 100vh;
  background-image: linear-gradient(to bottom, #d4e6f1 0%, #d5e8d4 15%, #F6F6F6 30%, #F6F6F6 100%);
}
</style>
