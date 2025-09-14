// 自动生成模板Order
package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
)

// 订单管理 结构体  Order
type Order struct {
	global.GVA_MODEL
	OrderNo        string  `json:"orderNo" form:"orderNo" gorm:"comment:订单编号;column:order_no;index;not null;" binding:"required"` // 订单编号
	UserID         uint    `json:"userId" form:"userId" gorm:"comment:用户ID;column:user_id;index;not null;" binding:"required"`    // 用户ID
	ActivityID     *uint   `json:"activityId" form:"activityId" gorm:"comment:活动ID;column:activity_id;index;"`                    // 活动ID
	ReferenceID    *uint   `json:"referenceId" form:"referenceId" gorm:"comment:关联ID;column:reference_id;index;"`                 // 关联ID（可以是活动报名ID等）
	OrderType      string  `json:"orderType" form:"orderType" gorm:"comment:订单类型;column:order_type;default:activity"`             // 订单类型: activity-活动, member-会员
	Amount         float64 `json:"amount" form:"amount" gorm:"comment:订单金额;column:amount;not null;" binding:"required"`           // 订单金额
	ActualAmount   float64 `json:"actualAmount" form:"actualAmount" gorm:"comment:实付金额;column:actual_amount;not null;"`           // 实付金额
	DiscountAmount float64 `json:"discountAmount" form:"discountAmount" gorm:"comment:优惠金额;column:discount_amount;"`              // 优惠金额
	Status         string  `json:"status" form:"status" gorm:"comment:订单状态;column:status;default:pending;not null;"`              // 订单状态: pending-待支付, paid-已支付, cancelled-已取消, refunded-已退款
	PaymentMethod  string  `json:"paymentMethod" form:"paymentMethod" gorm:"comment:支付方式;column:payment_method;"`                 // 支付方式: wechat, alipay, balance
	PaymentTime    *int64  `json:"paymentTime" form:"paymentTime" gorm:"comment:支付时间;column:payment_time;"`                       // 支付时间
	TradeNo        string  `json:"tradeNo" form:"tradeNo" gorm:"comment:第三方交易号;column:trade_no;"`                                 // 第三方交易号
	Remark         string  `json:"remark" form:"remark" gorm:"comment:订单备注;column:remark;type:text;"`                             // 订单备注
	CreatedBy      uint    `gorm:"column:created_by;comment:创建者"`
	UpdatedBy      uint    `gorm:"column:updated_by;comment:更新者"`
	DeletedBy      uint    `gorm:"column:deleted_by;comment:删除者"`
}

// TableName 订单管理 Order自定义表名 orders
func (Order) TableName() string {
	return "orders"
}
