// 自动生成模板CourseFavorite
package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
)

// 课程收藏 结构体  CourseFavorite
type CourseFavorite struct {
	global.GVA_MODEL
	UserID    uint `json:"userId" form:"userId" gorm:"comment:用户ID;column:user_id;not null;" binding:"required"`       //用户ID
	CourseID  uint `json:"courseId" form:"courseId" gorm:"comment:课程ID;column:course_id;not null;" binding:"required"` //课程ID
	CreatedBy uint `gorm:"column:created_by;comment:创建者"`
	UpdatedBy uint `gorm:"column:updated_by;comment:更新者"`
	DeletedBy uint `gorm:"column:deleted_by;comment:删除者"`
}

// TableName 课程收藏 CourseFavorite自定义表名 course_favorites
func (CourseFavorite) TableName() string {
	return "course_favorites"
}
