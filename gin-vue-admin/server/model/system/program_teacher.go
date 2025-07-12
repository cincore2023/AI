// 自动生成模板Teacher
package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
)

// 讲师管理 结构体  Teacher
type Teacher struct {
	global.GVA_MODEL
	Avatar       string  `json:"avatar" form:"avatar" gorm:"column:avatar;" binding:"required"`          //头像
	Name         *string `json:"name" form:"name" gorm:"column:name;" binding:"required"`                //讲师姓名
	Description  *string `json:"description" form:"description" gorm:"column:description;"`              //讲师描述
	Introduction *string `json:"introduction" form:"introduction" gorm:"column:introduction;type:text;"` //讲师介绍
	Sort         *int    `json:"sort" form:"sort" gorm:"default:0;column:sort;"`                         //讲师排序
	CreatedBy    uint    `gorm:"column:created_by;comment:创建者"`
	UpdatedBy    uint    `gorm:"column:updated_by;comment:更新者"`
	DeletedBy    uint    `gorm:"column:deleted_by;comment:删除者"`
}

// TableName 讲师管理 Teacher自定义表名 program_teacher
func (Teacher) TableName() string {
	return "program_teacher"
}
