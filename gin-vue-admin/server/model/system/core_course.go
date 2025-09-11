// 自动生成模板Course
package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
)

// 课程管理 结构体  Course
type Course struct {
	global.GVA_MODEL
	CourseTitle     *string  `json:"courseTitle" form:"courseTitle" gorm:"comment:课程名称;column:course_title;" binding:"required"`                    //课程名称
	Teacher         *int     `json:"teacher" form:"teacher" gorm:"comment:讲师;column:teacher;" binding:"required"`                                   //讲师
	Category        *int     `json:"category" form:"category" gorm:"comment:课程分类;column:category;" binding:"required"`                              //分类
	CoverImage      string   `json:"coverImage" form:"coverImage" gorm:"comment:封面图片;column:cover_image;" binding:"required"`                       //封面图
	Type            *string  `json:"type" form:"type" gorm:"default:img;comment:图文或视频;column:type;" binding:"required"`                             //类型
	Price           *float64 `json:"price" form:"price" gorm:"comment:课程售价;column:price;" binding:"required"`                                       //价格
	OriginalPrice   *float64 `json:"originalPrice" form:"originalPrice" gorm:"comment:标注原价;column:original_price;"`                                 //划线价格
	OnSale          *bool    `json:"onSale" form:"onSale" gorm:"default:true;comment:表示课程是否已上架销售;column:on_sale;"`                                  //上架状态
	Sort            *int     `json:"sort" form:"sort" gorm:"comment:排序显示;column:sort;"`                                                             //排序
	ViewDetails     *string  `json:"viewDetails" form:"viewDetails" gorm:"comment:试看详情;column:view_details;type:text;"`                             //试看详情
	CourseDetails   *string  `json:"courseDetails" form:"courseDetails" gorm:"comment:课程介绍等内容;column:course_details;type:text;" binding:"required"` //课程详情
	ApprenticeCount *int     `json:"apprenticeCount" form:"apprenticeCount" gorm:"comment:虚拟人数;column:apprentice_count;"`                           //展示学习人数
	Hot             *bool    `json:"hot" form:"hot" gorm:"default:false;column:hot;"`                                                               //是否推荐
	Exquisite       *bool    `json:"exquisite" form:"exquisite" gorm:"default:false;column:exquisite;"`                                             //精品推荐
	Salesperson     *string  `json:"salesperson" form:"salesperson" gorm:"comment:销售员;column:salesperson;"`                                         //销售员
	CreatedBy       uint     `gorm:"column:created_by;comment:创建者"`
	UpdatedBy       uint     `gorm:"column:updated_by;comment:更新者"`
	DeletedBy       uint     `gorm:"column:deleted_by;comment:删除者"`
}

// TableName 课程管理 Course自定义表名 core_courses
func (Course) TableName() string {
	return "core_courses"
}
