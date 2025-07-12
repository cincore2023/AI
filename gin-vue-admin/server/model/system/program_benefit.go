// 自动生成模板Benefit
package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
)

// 权益等级 结构体  Benefit
type Benefit struct {
	global.GVA_MODEL
	Level                   *float64 `json:"level" form:"level" gorm:"column:level;" binding:"required"`                                                         //等级
	LevelName               *string  `json:"levelName" form:"levelName" gorm:"column:level_name;" binding:"required"`                                            //名称
	MemberCommission        *float64 `json:"memberCommission" form:"memberCommission" gorm:"column:member_commission;" binding:"required"`                       //会员提成
	ActivityCommission      *float64 `json:"activityCommission" form:"activityCommission" gorm:"column:activity_commission;" binding:"required"`                 //活动提成
	DigitalPersonCommission *float64 `json:"digitalPersonCommission" form:"digitalPersonCommission" gorm:"column:digital_person_commission;" binding:"required"` //数字人提成
	CreatedBy               uint     `gorm:"column:created_by;comment:创建者"`
	UpdatedBy               uint     `gorm:"column:updated_by;comment:更新者"`
	DeletedBy               uint     `gorm:"column:deleted_by;comment:删除者"`
}

// TableName 权益等级 Benefit自定义表名 program_benefit
func (Benefit) TableName() string {
	return "program_benefit"
}
