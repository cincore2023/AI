// 自动生成模板ActivityRegistration
package system

import (
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
)

// 活动报名 结构体
type ActivityRegistration struct {
	global.GVA_MODEL
	UserID             uint       `json:"userID" form:"userID" gorm:"column:user_id;not null;" binding:"required"`                                // 用户ID
	ActivityID         uint       `json:"activityID" form:"activityID" gorm:"column:activity_id;not null;" binding:"required"`                    // 活动ID
	RegistrationType   *string    `json:"registrationType" form:"registrationType" gorm:"column:registration_type;default:'paid'"`                // 报名方式: paid-付费报名, free-免费报名, code-兑换码报名
	VerificationCode   string     `json:"verificationCode" form:"verificationCode" gorm:"column:verification_code;size:50;"`                      // 核销码
	VerificationStatus string     `json:"verificationStatus" form:"verificationStatus" gorm:"column:verification_status;size:20;default:pending"` // 核销状态: pending-待核销, verified-已核销, cancelled-已取消
	ParticipantName    *string    `json:"participantName" form:"participantName" gorm:"column:participant_name;size:100;"`                        // 参与人姓名
	ParticipantPhone   *string    `json:"participantPhone" form:"participantPhone" gorm:"column:participant_phone;size:20;"`                      // 参与人手机号
	PaymentStatus      string     `json:"paymentStatus" form:"paymentStatus" gorm:"column:payment_status;size:20;default:pending"`                // 支付状态: pending, paid, cancelled
	PaymentTime        *time.Time `json:"paymentTime" form:"paymentTime" gorm:"column:payment_time;"`                                             // 支付时间
	CreatedBy          uint       `gorm:"column:created_by;comment:创建者"`
	UpdatedBy          uint       `gorm:"column:updated_by;comment:更新者"`
	DeletedBy          uint       `gorm:"column:deleted_by;comment:删除者"`
}

// TableName 活动报名 ActivityRegistration自定义表名 activity_registrations
func (ActivityRegistration) TableName() string {
	return "activity_registrations"
}
