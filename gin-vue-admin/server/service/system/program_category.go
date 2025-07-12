package system

import (
	"context"
	"errors"
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"gorm.io/gorm"
)

type CategoryService struct{}

// CreateCategory 创建分类记录
// Author [yourname](https://github.com/yourname)
func (categoryService *CategoryService) CreateCategory(ctx context.Context, category *system.Category) (err error) {
	err = global.GVA_DB.Create(category).Error
	return err
}

// DeleteCategory 删除分类记录
// Author [yourname](https://github.com/yourname)
func (categoryService *CategoryService) DeleteCategory(ctx context.Context, ID string, userID uint) (err error) {
	var count int64
	err = global.GVA_DB.Find(&system.Category{}, "parent_id = ?", ID).Count(&count).Error
	if count > 0 {
		return errors.New("此节点存在子节点不允许删除")
	}
	if err != nil {
		return err
	}
	err = global.GVA_DB.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&system.Category{}).Where("id = ?", ID).Update("deleted_by", userID).Error; err != nil {
			return err
		}
		if err = tx.Delete(&system.Category{}, "id = ?", ID).Error; err != nil {
			return err
		}
		return nil
	})
	return err
}

// DeleteCategoryByIds 批量删除分类记录
// Author [yourname](https://github.com/yourname)
func (categoryService *CategoryService) DeleteCategoryByIds(ctx context.Context, IDs []string, deleted_by uint) (err error) {
	err = global.GVA_DB.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&system.Category{}).Where("id in ?", IDs).Update("deleted_by", deleted_by).Error; err != nil {
			return err
		}
		if err := tx.Where("id in ?", IDs).Delete(&system.Category{}).Error; err != nil {
			return err
		}
		return nil
	})
	return err
}

// UpdateCategory 更新分类记录
// Author [yourname](https://github.com/yourname)
func (categoryService *CategoryService) UpdateCategory(ctx context.Context, category system.Category) (err error) {
	err = global.GVA_DB.Model(&system.Category{}).Where("id = ?", category.ID).Updates(&category).Error
	return err
}

// GetCategory 根据ID获取分类记录
// Author [yourname](https://github.com/yourname)
func (categoryService *CategoryService) GetCategory(ctx context.Context, ID string) (category system.Category, err error) {
	err = global.GVA_DB.Where("id = ?", ID).First(&category).Error
	return
}

// GetCategoryInfoList 分页获取分类记录,Tree模式下不添加分页和搜索
// Author [yourname](https://github.com/yourname)
func (categoryService *CategoryService) GetCategoryInfoList(ctx context.Context) (list []*system.Category, err error) {
	// 创建db
	db := global.GVA_DB.Model(&system.Category{})
	var categorys []*system.Category

	err = db.Find(&categorys).Error

	return utils.BuildTree(categorys), err
}
func (categoryService *CategoryService) GetCategoryPublic(ctx context.Context) {
	// 此方法为获取数据源定义的数据
	// 请自行实现
}
