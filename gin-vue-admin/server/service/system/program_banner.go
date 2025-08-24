package system

import (
	"context"
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
)

type BannerService struct{}

// CreateBanner 创建轮播管理记录
// Author [yourname](https://github.com/yourname)
func (bannerService *BannerService) CreateBanner(ctx context.Context, banner *system.Banner) (err error) {
	err = global.GVA_DB.Create(banner).Error
	return err
}

// DeleteBanner 删除轮播管理记录
// Author [yourname](https://github.com/yourname)
func (bannerService *BannerService) DeleteBanner(ctx context.Context, ID string) (err error) {
	err = global.GVA_DB.Delete(&system.Banner{}, "id = ?", ID).Error
	return err
}

// DeleteBannerByIds 批量删除轮播管理记录
// Author [yourname](https://github.com/yourname)
func (bannerService *BannerService) DeleteBannerByIds(ctx context.Context, IDs []string) (err error) {
	err = global.GVA_DB.Delete(&[]system.Banner{}, "id in ?", IDs).Error
	return err
}

// UpdateBanner 更新轮播管理记录
// Author [yourname](https://github.com/yourname)
func (bannerService *BannerService) UpdateBanner(ctx context.Context, banner system.Banner) (err error) {
	err = global.GVA_DB.Model(&system.Banner{}).Where("id = ?", banner.ID).Updates(&banner).Error
	return err
}

// GetBanner 根据ID获取轮播管理记录
// Author [yourname](https://github.com/yourname)
func (bannerService *BannerService) GetBanner(ctx context.Context, ID string) (banner system.Banner, err error) {
	err = global.GVA_DB.Where("id = ?", ID).First(&banner).Error
	return
}

// GetBannerInfoList 分页获取轮播管理记录
// Author [yourname](https://github.com/yourname)
func (bannerService *BannerService) GetBannerInfoList(ctx context.Context, info systemReq.BannerSearch) (list []system.Banner, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	// 创建db
	db := global.GVA_DB.Model(&system.Banner{})
	var banners []system.Banner
	// 如果有条件搜索 下方会自动创建搜索语句
	if len(info.CreatedAtRange) == 2 {
		db = db.Where("created_at BETWEEN ? AND ?", info.CreatedAtRange[0], info.CreatedAtRange[1])
	}

	if info.Status != nil {
		db = db.Where("status = ?", *info.Status)
	}
	if info.Type != nil && *info.Type != "" {
		db = db.Where("type = ?", *info.Type)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	var OrderStr string
	orderMap := make(map[string]bool)
	orderMap["id"] = true
	orderMap["created_at"] = true
	orderMap["order"] = true
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

	err = db.Find(&banners).Error
	return banners, total, err
}

// GetBannerPublic 获取公开的轮播图列表
func (bannerService *BannerService) GetBannerPublic(ctx context.Context, bannerType string) (banners []system.Banner, err error) {
	// 创建查询条件：只获取启用状态的轮播图
	db := global.GVA_DB.Model(&system.Banner{})

	// 只获取启用状态的轮播图 (status = 1)
	status := 1
	db = db.Where("status = ?", status)

	// 如果指定了类型，则按类型过滤
	if bannerType != "" {
		db = db.Where("type = ?", bannerType)
	}

	// 按order字段升序排列，如果order为空则按创建时间排序
	db = db.Order(`COALESCE("order", 999999) ASC, created_at ASC`)

	// 执行查询
	err = db.Find(&banners).Error
	return banners, err
}
