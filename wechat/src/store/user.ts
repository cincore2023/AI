import type { IWechatUser } from '@/api/types/login'
import { defineStore } from 'pinia'
import { ref } from 'vue'
import { wxLogin as _wxLogin, getWxCode } from '@/api/login'
import { toast } from '@/utils/toast'

// 初始化状态 - 改为微信用户结构
const wechatUserState: IWechatUser = {
  ID: 0,
  nickname: '',
  openId: '',
  isActive: true,
}

export const useUserStore = defineStore(
  'user',
  () => {
    // 定义用户信息
    const wechatUser = ref<IWechatUser>({ ...wechatUserState })
    const token = ref<string>('')
    const isLoggedIn = ref<boolean>(false)

    const isMember = computed(() => {
      return !!wechatUser.value.membershipExpiryDate
    })

    // 设置微信用户信息
    const setWechatUser = (user: IWechatUser) => {
      console.log('设置微信用户信息', user)
      wechatUser.value = user
    }

    // 设置token
    const setToken = (newToken: string) => {
      token.value = newToken
      isLoggedIn.value = !!newToken
    }

    // 删除用户信息
    const removeUserInfo = () => {
      wechatUser.value = { ...wechatUserState }
      token.value = ''
      isLoggedIn.value = false
      uni.removeStorageSync('wechatUser')
      uni.removeStorageSync('token')
    }

    /**
     * 获取用户信息（保留给后续扩展）
     */
    const getUserInfo = async () => {
      // 这里可以根据需要获取微信用户的详细信息
      // 暂时直接返回当前用户信息
      return {
        data: wechatUser.value,
      }
    }

    /**
     * 退出登录 并 删除用户信息
     */
    const logout = async () => {
      // 微信用户没有后端注销接口，直接清理本地数据
      removeUserInfo()
      toast.success('退出登录成功')
    }

    /**
     * 微信登录
     */
    const wxLogin = async () => {
      try {
        // 获取微信小程序登录的code
        const codeData = await getWxCode()
        console.log('微信登录code', codeData)

        if (!codeData.code) {
          throw new Error('获取微信登录code失败')
        }

        const res = await _wxLogin({ code: codeData.code })
        console.log('微信登录响应', res)

        // 检查响应数据结构
        if (!res || !res.data) {
          throw new Error('服务器响应数据为空')
        }

        if (!res.data.user) {
          throw new Error('服务器返回的用户信息为空')
        }

        if (!res.data.token) {
          throw new Error('服务器返回的token为空')
        }

        // 设置微信用户信息
        setWechatUser(res.data.user)
        setToken(res.data.token)

        // 存储到本地
        uni.setStorageSync('wechatUser', res.data.user)
        uni.setStorageSync('token', res.data.token)

        return res
      }
      catch (error) {
        console.error('微信登录错误:', error)
        throw error
      }
    }

    return {
      wechatUser,
      token,
      isLoggedIn,
      wxLogin,
      getUserInfo,
      logout,
      setWechatUser,
      setToken,
      removeUserInfo,
      isMember,
    }
  },
  {
    persist: true,
  },
)
