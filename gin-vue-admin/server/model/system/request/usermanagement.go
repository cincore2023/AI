package request

import (
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"time"
)

type WechatUserSearch struct {
	CreatedAtRange            []time.Time `json:"createdAtRange" form:"createdAtRange[]"`
	Nickname                  *string     `json:"nickname" form:"nickname"`
	PhoneNumber               *string     `json:"phone_number" form:"phone_number"`
	MembershipExpiryDateRange []time.Time `json:"membership_expiry_dateRange" form:"membership_expiry_dateRange[]"`
	IsActive                  *bool       `json:"is_active" form:"is_active"`
	request.PageInfo
	Sort  string `json:"sort" form:"sort"`
	Order string `json:"order" form:"order"`
}
