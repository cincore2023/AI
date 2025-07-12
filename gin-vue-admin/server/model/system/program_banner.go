// 自动生成模板Banner
package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
)

// 轮播管理 结构体  Banner
type Banner struct {
	global.GVA_MODEL
	ImageUrl *string `json:"imageUrl" form:"imageUrl" gorm:"comment:轮播图图片地址;column:image_url;" binding:"required"` //图片URL
	LinkUrl  *string `json:"linkUrl" form:"linkUrl" gorm:"comment:点击图片跳转的链接;column:link_url;"`                     //链接URL
	Order    *int    `json:"order" form:"order" gorm:"comment:轮播图顺序;column:order;"`                                //排序
	Status   *int    `json:"status" form:"status" gorm:"comment:轮播图状态，例如：1-启用，0-禁用;column:status;"`                //状态
	Type     *string `json:"type" form:"type" gorm:"default:home;column:type;"`                                    //轮播图位置
}

// TableName 轮播管理 Banner自定义表名 program_banner
func (Banner) TableName() string {
	return "program_banner"
}
