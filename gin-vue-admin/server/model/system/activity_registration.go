// 自动生成模板ActivityRegistration
package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
)

// 活动报名 结构体  ActivityRegistration
type ActivityRegistration struct {
	global.GVA_MODEL
	UserID           uint   `json:"userId" form:"userId" gorm:"comment:用户ID;column:user_id;index;not null;" binding:"required"`                       // 用户ID
	ActivityID       uint   `json:"activityId" form:"activityId" gorm:"comment:活动ID;column:activity_id;index;not null;" binding:"required"`           // 活动ID
	StudentName      string `json:"studentName" form:"studentName" gorm:"comment:学员姓名;column:student_name;not null;" binding:"required"`              // 学员姓名
	StudentPhone     string `json:"studentPhone" form:"studentPhone" gorm:"comment:学员电话;column:student_phone;not null;" binding:"required"`           // 学员电话
	RegistrationNo   string `json:"registrationNo" form:"registrationNo" gorm:"comment:报名编号;column:registration_no;index;not null;"`                  // 报名编号
	RegistrationType string `json:"registrationType" form:"registrationType" gorm:"comment:报名方式;column:registration_type;default:purchase;not null;"` // 报名方式: purchase-购买, code-码
	Code             string `json:"code" form:"code" gorm:"comment:报名码;column:code;"`                                                                 // 报名码
	OrderID          uint   `json:"orderId" form:"orderId" gorm:"comment:订单ID;column:order_id;"`                                                      // 订单ID
	Status           string `json:"status" form:"status" gorm:"comment:核销状态;column:status;default:pending;not null;"`                                 // 核销状态: pending-待确认, confirmed-已确认, cancelled-已取消
	Remark           string `json:"remark" form:"remark" gorm:"comment:备注;column:remark;type:text;"`                                                  // 备注
	CreatedBy        uint   `gorm:"column:created_by;comment:创建者"`
	UpdatedBy        uint   `gorm:"column:updated_by;comment:更新者"`
	DeletedBy        uint   `gorm:"column:deleted_by;comment:删除者"`
}

// TableName 活动报名 ActivityRegistration自定义表名 activity_registrations
func (ActivityRegistration) TableName() string {
	return "activity_registrations"
}
