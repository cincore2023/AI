import { defineStore } from 'pinia'

export interface MemberInfo {
  isMember: boolean
  memberLevel: string
  expireDate: string
  benefits: string[]
}

export const useMemberStore = defineStore('member', {
  state: () => ({
    memberInfo: {
      isMember: false,
      memberLevel: '',
      expireDate: '',
      benefits: []
    } as MemberInfo
  }),

  getters: {
    isMember: (state) => state.memberInfo.isMember,
    memberLevel: (state) => state.memberInfo.memberLevel,
    expireDate: (state) => state.memberInfo.expireDate,
    benefits: (state) => state.memberInfo.benefits
  },

  actions: {
    // 检查会员状态
    async checkMemberStatus() {
      try {
        // 这里应该调用API检查会员状态
        // const response = await http.get('/api/member/status')
        // this.memberInfo = response.data
        
        // 模拟会员状态
        this.memberInfo = {
          isMember: Math.random() > 0.5,
          memberLevel: 'VIP',
          expireDate: '2024-12-31',
          benefits: ['免费观看所有课程', '优先客服支持', '专属学习资料']
        }
      } catch (error) {
        console.error('检查会员状态失败:', error)
      }
    },

    // 开通会员
    async activateMember() {
      try {
        // 这里应该调用API开通会员
        // const response = await http.post('/api/member/activate')
        
        // 模拟开通成功
        this.memberInfo.isMember = true
        this.memberInfo.memberLevel = 'VIP'
        this.memberInfo.expireDate = '2024-12-31'
        
        uni.showToast({
          title: '会员开通成功',
          icon: 'success'
        })
      } catch (error) {
        console.error('开通会员失败:', error)
        uni.showToast({
          title: '开通失败，请重试',
          icon: 'error'
        })
      }
    },

    // 取消会员
    async cancelMember() {
      try {
        // 这里应该调用API取消会员
        // const response = await http.post('/api/member/cancel')
        
        // 模拟取消成功
        this.memberInfo.isMember = false
        this.memberInfo.memberLevel = ''
        this.memberInfo.expireDate = ''
        
        uni.showToast({
          title: '会员已取消',
          icon: 'success'
        })
      } catch (error) {
        console.error('取消会员失败:', error)
        uni.showToast({
          title: '取消失败，请重试',
          icon: 'error'
        })
      }
    }
  }
}) 