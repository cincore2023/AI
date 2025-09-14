import type { IWechatUserWithSalesperson } from '@/api/types/login'
import { defineStore } from 'pinia'
import { computed, ref } from 'vue'
import { wxLogin as _wxLogin, getWxCode } from '@/api/login'
import { wxGetUserInfo } from '@/api/wechat/userinfo'
import { toast } from '@/utils/toast'

// 初始化状态 - 改为微信用户结构
const wechatUserState: IWechatUserWithSalesperson = {
  ID: 0,
  nickname: '',
  openId: '',
  isActive: true,
}

export const useUserStore = defineStore(
  'user',
  () => {
    // 定义用户信息
    const wechatUser = ref<IWechatUserWithSalesperson>({ ...wechatUserState })
    const token = ref<string>('')
    const isLoggedIn = ref<boolean>(false)

    const isMember = computed(() => {
      if (!wechatUser.value.membership_expiry_date) {
        return false
      }

      try {
        const expiryDate = new Date(wechatUser.value.membership_expiry_date)
        return expiryDate > new Date()
      }
      catch (e) {
        console.error('解析会员过期时间失败', e)
        return false
      }
    })

    // 设置微信用户信息
    const setWechatUser = (user: IWechatUserWithSalesperson) => {
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
      uni.removeStorageSync('token')
    }

    /**
     * 获取用户信息
     */
    const getUserInfo = async () => {
      try {
        const res = await wxGetUserInfo()
        console.log('res', res)
        if (res.data) {
          setWechatUser(res.data)
        }
        return res
      }
      catch (error) {
        console.error('获取用户信息失败:', error)
        throw error
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
        const res = await _wxLogin({ code: codeData.code })
        // 设置微信用户信息
        setWechatUser(res.data.user)
        setToken(res.data.token)
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