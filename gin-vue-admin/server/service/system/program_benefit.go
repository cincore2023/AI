package system

import (
	"context"
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
	"gorm.io/gorm"
)

type BenefitService struct{}

// CreateBenefit 创建权益等级记录
// Author [yourname](https://github.com/yourname)
func (benefitService *BenefitService) CreateBenefit(ctx context.Context, benefit *system.Benefit) (err error) {
	err = global.GVA_DB.Create(benefit).Error
	return err
}

// DeleteBenefit 删除权益等级记录
// Author [yourname](https://github.com/yourname)
func (benefitService *BenefitService) DeleteBenefit(ctx context.Context, ID string, userID uint) (err error) {
	err = global.GVA_DB.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&system.Benefit{}).Where("id = ?", ID).Update("deleted_by", userID).Error; err != nil {
			return err
		}
		if err = tx.Delete(&system.Benefit{}, "id = ?", ID).Error; err != nil {
			return err
		}
		return nil
	})
	return err
}

// DeleteBenefitByIds 批量删除权益等级记录
// Author [yourname](https://github.com/yourname)
func (benefitService *BenefitService) DeleteBenefitByIds(ctx context.Context, IDs []string, deleted_by uint) (err error) {
	err = global.GVA_DB.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&system.Benefit{}).Where("id in ?", IDs).Update("deleted_by", deleted_by).Error; err != nil {
			return err
		}
		if err := tx.Where("id in ?", IDs).Delete(&system.Benefit{}).Error; err != nil {
			return err
		}
		return nil
	})
	return err
}

// UpdateBenefit 更新权益等级记录
// Author [yourname](https://github.com/yourname)
func (benefitService *BenefitService) UpdateBenefit(ctx context.Context, benefit system.Benefit) (err error) {
	err = global.GVA_DB.Model(&system.Benefit{}).Where("id = ?", benefit.ID).Updates(&benefit).Error
	return err
}

// GetBenefit 根据ID获取权益等级记录
// Author [yourname](https://github.com/yourname)
func (benefitService *BenefitService) GetBenefit(ctx context.Context, ID string) (benefit system.Benefit, err error) {
	err = global.GVA_DB.Where("id = ?", ID).First(&benefit).Error
	return
}

// GetBenefitInfoList 分页获取权益等级记录
// Author [yourname](https://github.com/yourname)
func (benefitService *BenefitService) GetBenefitInfoList(ctx context.Context, info systemReq.BenefitSearch) (list []system.Benefit, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	// 创建db
	db := global.GVA_DB.Model(&system.Benefit{})
	var benefits []system.Benefit
	// 如果有条件搜索 下方会自动创建搜索语句
	if len(info.CreatedAtRange) == 2 {
		db = db.Where("created_at BETWEEN ? AND ?", info.CreatedAtRange[0], info.CreatedAtRange[1])
	}

	err = db.Count(&total).Error
	if err != nil {
		return
	}
	var OrderStr string
	orderMap := make(map[string]bool)
	orderMap["id"] = true
	orderMap["created_at"] = true
	orderMap["level"] = true
	if orderMap[info.Sort] {
		OrderStr = info.Sort
		if info.Order == "descending" {
			OrderStr = OrderStr + " desc"
		}
		db = db.Order(OrderStr)
	}

	if limit != 0 {
		db = db.Limit(limit).Offset(offset)
	}

	err = db.Find(&benefits).Error
	return benefits, total, err
}
func (benefitService *BenefitService) GetBenefitPublic(ctx context.Context) {
	// 此方法为获取数据源定义的数据
	// 请自行实现
}
