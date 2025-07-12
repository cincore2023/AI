export const categoryType = [
  {value: 'course', label: '课程分类'},
  {value: 'activity', label: '活动分类'},
  {value: 'material', label: '素材分类'},
  {value: 'ai', label: '智能体分类'},
]

export const categoryTypeMap = new Map(categoryType.map(item => [item.value, item.label]));
