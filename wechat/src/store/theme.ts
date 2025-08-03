import { defineStore } from 'pinia'
import { ref } from 'vue'

export type ThemeType = 'light' | 'dark'

export const useThemeStore = defineStore(
  'theme',
  () => {
    // 当前主题
    const currentTheme = ref<ThemeType>('light')

    // 初始化主题
    const initTheme = () => {
      // 从本地存储获取主题
      const savedTheme = uni.getStorageSync('theme') as ThemeType
      if (savedTheme) {
        setTheme(savedTheme)
      }
      else {
        // 默认使用浅色主题
        setTheme('light')
      }
    }

    // 设置主题
    function setTheme(theme: ThemeType) {
      currentTheme.value = theme

      // 设置HTML的data-theme属性
      // const html = document.documentElement
      // html.setAttribute('data-theme', theme)

      // 保存到本地存储
      uni.setStorageSync('theme', theme)

      console.log('主题切换为:', theme)
    }

    // 切换主题
    const toggleTheme = () => {
      const newTheme: ThemeType = currentTheme.value === 'light' ? 'dark' : 'light'
      setTheme(newTheme)

      // 显示提示
      uni.showToast({
        title: `已切换到${newTheme === 'light' ? '浅色' : '深色'}主题`,
        icon: 'success',
        duration: 1500,
      })
    }

    // 获取主题名称
    const getThemeName = (theme: ThemeType) => {
      return theme === 'light' ? '浅色' : '深色'
    }

    // 获取当前主题名称
    const getCurrentThemeName = () => {
      return getThemeName(currentTheme.value)
    }

    return {
      currentTheme,
      initTheme,
      setTheme,
      toggleTheme,
      getThemeName,
      getCurrentThemeName,
    }
  },
  {
    persist: {
      key: 'theme-store',
      storage: {
        getItem: uni.getStorageSync,
        setItem: uni.setStorageSync,
      },
    },
  },
)
