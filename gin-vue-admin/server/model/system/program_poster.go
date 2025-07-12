// 自动生成模板Poster
package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
)

// 推广海报 结构体  Poster
type Poster struct {
	global.GVA_MODEL
	Text         *string `json:"text" form:"text" gorm:"column:text;" binding:"required"`                         //二维码信息
	BgImg        string  `json:"bgImg" form:"bgImg" gorm:"column:bg_img;" binding:"required"`                     //背景图
	SwitchButton *bool   `json:"switchButton" form:"switchButton" gorm:"comment:控制功能开启与关闭;column:switch_button;"` //开关
	SizeSlider   *string `json:"size" form:"size" gorm:"comment:改变元素大小;column:size_slider;"`                      //大小
	Radius       *string `json:"radius" form:"radius" gorm:"comment:圆角;column:radius;"`                           //圆角
	Top          *string `json:"top" form:"top" gorm:"comment:距离顶部;column:top;"`                                  //距离顶部
	Left         *string `json:"left" form:"left" gorm:"column:left;"`                                            //距离左侧
}

// TableName 推广海报 Poster自定义表名 program_poster
func (Poster) TableName() string {
	return "program_poster"
}
