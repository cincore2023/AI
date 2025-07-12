// 自动生成模板Category
package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
)

// 分类 结构体  Category
type Category struct {
	global.GVA_MODEL
	CategoryName *string     `json:"categoryName" form:"categoryName" gorm:"column:category_name;" binding:"required"` //分类名称
	Status       *bool       `json:"status" form:"status" gorm:"default:true;column:status;"`                          //状态
	SortOrder    *int        `json:"sortOrder" form:"sortOrder" gorm:"column:sort_order;"`                             //排序
	Type         *string     `json:"type" form:"type" gorm:"default:course;column:type;"`                              //分类类型
	CreatedBy    uint        `gorm:"column:created_by;comment:创建者"`
	UpdatedBy    uint        `gorm:"column:updated_by;comment:更新者"`
	DeletedBy    uint        `gorm:"column:deleted_by;comment:删除者"`
	Children     []*Category `json:"children" gorm:"-"` //子节点
	ParentID     int         `json:"parentID" gorm:"column:parent_id;comment:父节点"`
}

// TableName 分类 Category自定义表名 program_categories
func (Category) TableName() string {
	return "program_categories"
}

// GetChildren 实现TreeNode接口
func (s *Category) GetChildren() []*Category {
	return s.Children
}

// SetChildren 实现TreeNode接口
func (s *Category) SetChildren(children *Category) {
	s.Children = append(s.Children, children)
}

// GetID 实现TreeNode接口
func (s *Category) GetID() int {
	return int(s.ID)
}

// GetParentID 实现TreeNode接口
func (s *Category) GetParentID() int {
	return s.ParentID
}
