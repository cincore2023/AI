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
func (bannerService *BannerService) GetBannerPublic(ctx context.Context) {
	// 此方法为获取数据源定义的数据
	// 请自行实现
}
