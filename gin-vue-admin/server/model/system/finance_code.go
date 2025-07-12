// 自动生成模板Code
package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"time"
)

// 兑换码明细 结构体  Code
type Code struct {
	global.GVA_MODEL
	TransactionID     *string    `json:"transactionId" form:"transactionId" gorm:"comment:唯一标识每笔交易的编号;column:transaction_id;"`                              //交易编号
	Username          *string    `json:"username" form:"username" gorm:"comment:用户的昵称或名称;column:username;" binding:"required"`                              //用户昵称
	PhoneNumber       *string    `json:"phoneNumber" form:"phoneNumber" gorm:"comment:用户的联系电话号码;column:phone_number;" binding:"required"`                   //手机号
	TransactionType   *int       `json:"transactionType" form:"transactionType" gorm:"comment:记录交易的性质，如增加、扣除等;column:transaction_type;" binding:"required"` //交易类型
	CodeType          *int       `json:"codeType" form:"codeType" gorm:"comment:指明是会员兑换码还是活动兑换码;column:code_type;" binding:"required"`                      //兑换码类型
	Quantity          *int       `json:"quantity" form:"quantity" gorm:"comment:表示本次交易的兑换码数量，正数表示增加，负数表示减少;column:quantity;" binding:"required"`            //数量
	RemainingQuantity *int       `json:"remainingQuantity" form:"remainingQuantity" gorm:"comment:显示交易后的兑换码剩余数量;column:remaining_quantity;"`                //交易后余量
	Details           *string    `json:"details" form:"details" gorm:"comment:提供关于该交易的额外信息，例如系统赠送、开通会员、报名活动等;column:details;" binding:"required"`           //详情
	TransactionTime   *time.Time `json:"transactionTime" form:"transactionTime" gorm:"comment:记录交易发生的具体时间;column:transaction_time;" binding:"required"`     //交易时间
}

// TableName 兑换码明细 Code自定义表名 finance_code
func (Code) TableName() string {
	return "finance_code"
}
