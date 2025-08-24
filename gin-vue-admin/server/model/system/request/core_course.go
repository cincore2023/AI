package request

import (
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"time"
)

type CourseSearch struct {
	CreatedAtRange []time.Time `json:"createdAtRange" form:"createdAtRange[]"`
	Teacher        *int        `json:"teacher" form:"teacher"`
	Category       *int        `json:"category" form:"category"`
	Type           *string     `json:"type" form:"type"`
	StartPrice     *float64    `json:"startPrice" form:"startPrice"`
	EndPrice       *float64    `json:"endPrice" form:"endPrice"`
	Hot            *bool       `json:"hot" form:"hot"`
	Exquisite      *bool       `json:"exquisite" form:"exquisite"`

	request.PageInfo
	Sort  string `json:"sort" form:"sort"`
	Order string `json:"order" form:"order"`
}
