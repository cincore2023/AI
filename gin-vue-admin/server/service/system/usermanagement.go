package system

import (
	"context"
	"errors"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
	"gorm.io/gorm"
)

type WechatUserService struct{}

// CreateWechatUser 创建用户管理记录
// Author [yourname](https://github.com/yourname)
func (wxUserService *WechatUserService) CreateWechatUser(ctx context.Context, wxUser *system.WechatUser) (err error) {
	err = global.GVA_DB.Create(wxUser).Error
	return err
}

// DeleteWechatUser 删除用户管理记录
// Author [yourname](https://github.com/yourname)
func (wxUserService *WechatUserService) DeleteWechatUser(ctx context.Context, ID string, userID uint) (err error) {
	err = global.GVA_DB.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&system.WechatUser{}).Where("id = ?", ID).Update("deleted_by", userID).Error; err != nil {
			return err
		}
		if err = tx.Delete(&system.WechatUser{}, "id = ?", ID).Error; err != nil {
			return err
		}
		return nil
	})
	return err
}

// DeleteWechatUserByIds 批量删除用户管理记录
// Author [yourname](https://github.com/yourname)
func (wxUserService *WechatUserService) DeleteWechatUserByIds(ctx context.Context, IDs []string, deleted_by uint) (err error) {
	err = global.GVA_DB.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&system.WechatUser{}).Where("id in ?", IDs).Update("deleted_by", deleted_by).Error; err != nil {
			return err
		}
		if err := tx.Where("id in ?", IDs).Delete(&system.WechatUser{}).Error; err != nil {
			return err
		}
		return nil
	})
	return err
}

// UpdateWechatUser 更新用户管理记录
// Author [yourname](https://github.com/yourname)
func (wxUserService *WechatUserService) UpdateWechatUser(ctx context.Context, wxUser system.WechatUser) (err error) {
	err = global.GVA_DB.Model(&system.WechatUser{}).Where("id = ?", wxUser.ID).Updates(&wxUser).Error
	return err
}

// GetWechatUser 根据ID获取用户管理记录
// Author [yourname](https://github.com/yourname)
func (wxUserService *WechatUserService) GetWechatUser(ctx context.Context, ID string) (wxUser system.WechatUser, err error) {
	err = global.GVA_DB.Where("id = ?", ID).First(&wxUser).Error
	return
}

// GetWechatUserInfoList 分页获取用户管理记录
// Author [yourname](https://github.com/yourname)
func (wxUserService *WechatUserService) GetWechatUserInfoList(ctx context.Context, info systemReq.WechatUserSearch) (list []system.WechatUser, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	// 创建db
	db := global.GVA_DB.Model(&system.WechatUser{})
	var wxUsers []system.WechatUser
	// 如果有条件搜索 下方会自动创建搜索语句
	if len(info.CreatedAtRange) == 2 {
		db = db.Where("created_at BETWEEN ? AND ?", info.CreatedAtRange[0], info.CreatedAtRange[1])
	}

	if info.Nickname != nil && *info.Nickname != "" {
		db = db.Where("nickname LIKE ?", "%"+*info.Nickname+"%")
	}
	if info.PhoneNumber != nil && *info.PhoneNumber != "" {
		db = db.Where("phone_number LIKE ?", "%"+*info.PhoneNumber+"%")
	}
	if len(info.MembershipExpiryDateRange) == 2 {
		db = db.Where("membership_expiry_date BETWEEN ? AND ? ", info.MembershipExpiryDateRange[0], info.MembershipExpiryDateRange[1])
	}
	if info.IsActive != nil {
		db = db.Where("is_active = ?", *info.IsActive)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	var OrderStr string
	orderMap := make(map[string]bool)
	orderMap["id"] = true
	orderMap["created_at"] = true
	orderMap["benefit_level"] = true
	orderMap["withdrawable_income"] = true
	orderMap["cumulative_income"] = true
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

	err = db.Find(&wxUsers).Error
	return wxUsers, total, err
}
func (wxUserService *WechatUserService) GetWechatUserPublic(ctx context.Context) {
	// 此方法为获取数据源定义的数据
	// 请自行实现
}

// BindSalesperson 绑定销售员
func (wxUserService *WechatUserService) BindSalesperson(ctx context.Context, userID uint, salespersonPhone string) error {
	// 1. 首先通过手机号查找销售员
	var salesperson system.WechatUser
	err := global.GVA_DB.Where("phone_number = ? AND is_active = ?", salespersonPhone, true).First(&salesperson).Error
	if err != nil {
		if err == gorm.ErrRecordNotFound {
			return errors.New("没有该销售员")
		}
		return err
	}

	// 2. 更新用户的销售员和关系渠道
	updateData := map[string]interface{}{
		"salesperson":          int(salesperson.ID),
		"relationship_channel": int(salesperson.ID),
		"updated_by":           userID,
	}

	err = global.GVA_DB.Model(&system.WechatUser{}).Where("id = ?", userID).Updates(updateData).Error
	if err != nil {
		return err
	}

	return nil
}

// GetSalespersonByPhone 通过手机号获取销售员信息
func (wxUserService *WechatUserService) GetSalespersonByPhone(ctx context.Context, phone string) (*system.WechatUser, error) {
	var salesperson system.WechatUser
	err := global.GVA_DB.Where("phone_number = ? AND is_active = ?", phone, true).First(&salesperson).Error
	if err != nil {
		if err == gorm.ErrRecordNotFound {
			return nil, errors.New("没有该销售员")
		}
		return nil, err
	}
	return &salesperson, nil
}
