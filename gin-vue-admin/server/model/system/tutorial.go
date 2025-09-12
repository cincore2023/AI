// 自动生成模板Tutorial
package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
)

// 教程管理 结构体  Tutorial
type Tutorial struct {
	global.GVA_MODEL
	CategoryID     uint   `json:"categoryId" form:"categoryId" gorm:"comment:教程分类ID;column:category_id;not null;" binding:"required"`                     // 教程分类ID
	TutorialName   string `json:"tutorialName" form:"tutorialName" gorm:"comment:教程名称;column:tutorial_name;not null;" binding:"required"`                 // 教程名称
	TutorialImage  string `json:"tutorialImage" form:"tutorialImage" gorm:"comment:教程图片;column:tutorial_image;not null;" binding:"required"`              // 教程图片
	TutorialDetail string `json:"tutorialDetail" form:"tutorialDetail" gorm:"comment:教程详情;column:tutorial_detail;type:text;not null;" binding:"required"` // 教程详情
	Sort           int    `json:"sort" form:"sort" gorm:"comment:排序;column:sort;default:0;"`                                                              // 排序
	Status         string `json:"status" form:"status" gorm:"comment:状态;column:status;default:published;not null;"`                                       // 状态: published-已发布, draft-草稿
	CreatedBy      uint   `gorm:"column:created_by;comment:创建者"`
	UpdatedBy      uint   `gorm:"column:updated_by;comment:更新者"`
	DeletedBy      uint   `gorm:"column:deleted_by;comment:删除者"`
}

// TableName 教程管理 Tutorial自定义表名 tutorials
func (Tutorial) TableName() string {
	return "tutorials"
}
