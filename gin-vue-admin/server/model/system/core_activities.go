// 自动生成模板Activities
package system

import (
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
)

// 活动管理 结构体
type Activities struct {
	global.GVA_MODEL
	ActivityName     *string    `json:"activityName" form:"activityName" gorm:"column:activity_name;" binding:"required"`      //活动名称
	Price            *float64   `json:"price" form:"price" gorm:"column:price;"`                                               //活动价格
	Category         *int       `json:"category" form:"category" gorm:"column:category;" binding:"required"`                   //分类
	CoverPicture     *string    `json:"coverPicture" form:"coverPicture" gorm:"column:cover_picture;" binding:"required"`      //封面图
	ActualEnrollment *int       `json:"actualEnrollment" form:"actualEnrollment" gorm:"default:100;column:actual_enrollment;"` //展示报名人数
	Status           *bool      `json:"status" form:"status" gorm:"default:true;column:status;"`                               //状态
	SortOrder        *int       `json:"sortOrder" form:"sortOrder" gorm:"column:sort_order;"`                                  //排序
	StartTime        *time.Time `json:"startTime" form:"startTime" gorm:"column:start_time;" binding:"required"`               //开始时间
	EndTime          *time.Time `json:"endTime" form:"endTime" gorm:"column:end_time;" binding:"required"`                     //结束时间
	ShowStartTime    *time.Time `json:"showStartTime" form:"showStartTime" gorm:"column:show_start_time;" binding:"required"`  //展示开始时间
	ShowEndTime      *time.Time `json:"showEndTime" form:"showEndTime" gorm:"column:show_end_time;" binding:"required"`        //展示结束时间
	Details          *string    `json:"details" form:"details" gorm:"column:details;type:text;"`                               //活动详情
	Salesperson      *string    `json:"salesperson" form:"salesperson" gorm:"column:salesperson;"`                             //销售员ID
	CreatedBy        uint       `gorm:"column:created_by;comment:创建者"`
	UpdatedBy        uint       `gorm:"column:updated_by;comment:更新者"`
	DeletedBy        uint       `gorm:"column:deleted_by;comment:删除者"`
}

// TableName 活动管理 Activities自定义表名 core_activities
func (Activities) TableName() string {
	return "core_activities"
}
