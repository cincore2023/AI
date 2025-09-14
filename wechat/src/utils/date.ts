import dayjs from 'dayjs'

/**
 * 日期格式化工具函数（Day.js实现）
 */

/**
 * 将日期字符串格式化为 YYYY-MM-DD 格式
 * @param dateStr 日期字符串
 * @returns 格式化后的日期字符串 YYYY-MM-DD
 */
export function formatDate(dateStr: string | undefined): string {
  if (!dateStr) {
    return ''
  }

  try {
    // 使用Day.js解析日期（自动处理时区和非法日期）
    const day = dayjs(dateStr)

    // 验证日期有效性
    if (!day.isValid()) {
      return ''
    }
    return day.format('YYYY-MM-DD')
  }
  catch (error) {
    console.error('日期格式化失败:', error)
    return ''
  }
}
