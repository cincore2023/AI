package request

import (
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
)

type ActivityRegistrationSearch struct {
	CreatedAtRange []time.Time `json:"createdAtRange" form:"createdAtRange[]"`
	UserID         *uint       `json:"userID" form:"userID"`
	ActivityID     *uint       `json:"activityID" form:"activityID"`
	PaymentStatus  *string     `json:"paymentStatus" form:"paymentStatus"`
	request.PageInfo
	Sort  string `json:"sort" form:"sort"`
	Order string `json:"order" form:"order"`
}
