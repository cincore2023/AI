package request

import (
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"time"
)

type ActivitiesSearch struct {
	CreatedAtRange []time.Time `json:"createdAtRange" form:"createdAtRange[]"`
	ActivityName   *string     `json:"activityName" form:"activityName"`
	StartPrice     *float64    `json:"startPrice" form:"startPrice"`
	EndPrice       *float64    `json:"endPrice" form:"endPrice"`
	Category       *int        `json:"category" form:"category"`
	Status         *bool       `json:"status" form:"status"`
	request.PageInfo
	Sort  string `json:"sort" form:"sort"`
	Order string `json:"order" form:"order"`
}
