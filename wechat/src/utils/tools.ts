export function hidePhoneNumber(phoneNumber: string) {
  // 检查手机号长度
  if (phoneNumber.length < 4) {
    return '****' // 如果手机号长度小于4，返回四个星号
  }

  // 获取末尾四位数
  const lastFourDigits = phoneNumber.slice(-4)

  // 隐藏中间的数字
  const hiddenPart = phoneNumber.slice(0, -4).replace(/\d/g, '*')

  // 返回隐藏后的手机号
  return hiddenPart + lastFourDigits
}
