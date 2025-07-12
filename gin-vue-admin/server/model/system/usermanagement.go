// 自动生成模板WechatUser
package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"time"
)

// 用户管理 结构体  WechatUser
type WechatUser struct {
	global.GVA_MODEL
	OpenId                   *string    `json:"openId" form:"openId" gorm:"column:open_id;"`                                                            //小程序Id
	Nickname                 *string    `json:"nickname" form:"nickname" gorm:"column:nickname;" binding:"required"`                                    //昵称
	PhoneNumber              *string    `json:"phone_number" form:"phone_number" gorm:"column:phone_number;" binding:"required"`                        //手机号
	Salesperson              *int       `json:"salesperson" form:"salesperson" gorm:"column:salesperson;"`                                              //销售员
	RelationshipChannel      *int       `json:"relationship_channel" form:"relationship_channel" gorm:"column:relationship_channel;"`                   //关系渠道
	BenefitLevel             *int       `json:"benefit_level" form:"benefit_level" gorm:"column:benefit_level;"`                                        //权益等级
	WithdrawableIncome       *float64   `json:"withdrawable_income" form:"withdrawable_income" gorm:"column:withdrawable_income;"`                      //可提现收入
	CumulativeIncome         *float64   `json:"cumulative_income" form:"cumulative_income" gorm:"column:cumulative_income;"`                            //累计收入
	MembershipExpiryDate     *time.Time `json:"membership_expiry_date" form:"membership_expiry_date" gorm:"column:membership_expiry_date;"`             //会员到期时间
	MembershipRedemptionCode *string    `json:"membership_redemption_code" form:"membership_redemption_code" gorm:"column:membership_redemption_code;"` //会员兑换码
	ActivityRedemptionCode   *string    `json:"activity_redemption_code" form:"activity_redemption_code" gorm:"column:activity_redemption_code;"`       //活动兑换码
	IsActive                 *bool      `json:"is_active" form:"is_active" gorm:"column:is_active;"`                                                    //是否启用
	CreatedBy                uint       `gorm:"column:created_by;comment:创建者"`
	UpdatedBy                uint       `gorm:"column:updated_by;comment:更新者"`
	DeletedBy                uint       `gorm:"column:deleted_by;comment:删除者"`
}

// TableName 用户管理 WechatUser自定义表名 User
func (WechatUser) TableName() string {
	return "User"
}
