package system

import (
	"context"
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
)

type PosterService struct{}

// CreatePoster 创建推广海报记录
// Author [yourname](https://github.com/yourname)
func (posterService *PosterService) CreatePoster(ctx context.Context, poster *system.Poster) (err error) {
	err = global.GVA_DB.Create(poster).Error
	return err
}

// DeletePoster 删除推广海报记录
// Author [yourname](https://github.com/yourname)
func (posterService *PosterService) DeletePoster(ctx context.Context, ID string) (err error) {
	err = global.GVA_DB.Delete(&system.Poster{}, "id = ?", ID).Error
	return err
}

// DeletePosterByIds 批量删除推广海报记录
// Author [yourname](https://github.com/yourname)
func (posterService *PosterService) DeletePosterByIds(ctx context.Context, IDs []string) (err error) {
	err = global.GVA_DB.Delete(&[]system.Poster{}, "id in ?", IDs).Error
	return err
}

// UpdatePoster 更新推广海报记录
// Author [yourname](https://github.com/yourname)
func (posterService *PosterService) UpdatePoster(ctx context.Context, poster system.Poster) (err error) {
	err = global.GVA_DB.Model(&system.Poster{}).Where("id = ?", poster.ID).Updates(&poster).Error
	return err
}

// GetPoster 根据ID获取推广海报记录
// Author [yourname](https://github.com/yourname)
func (posterService *PosterService) GetPoster(ctx context.Context, ID string) (poster system.Poster, err error) {
	err = global.GVA_DB.Where("id = ?", ID).First(&poster).Error
	return
}

// GetPosterInfoList 分页获取推广海报记录
// Author [yourname](https://github.com/yourname)
func (posterService *PosterService) GetPosterInfoList(ctx context.Context, info systemReq.PosterSearch) (list []system.Poster, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	// 创建db
	db := global.GVA_DB.Model(&system.Poster{})
	var posters []system.Poster
	// 如果有条件搜索 下方会自动创建搜索语句
	if len(info.CreatedAtRange) == 2 {
		db = db.Where("created_at BETWEEN ? AND ?", info.CreatedAtRange[0], info.CreatedAtRange[1])
	}

	err = db.Count(&total).Error
	if err != nil {
		return
	}

	if limit != 0 {
		db = db.Limit(limit).Offset(offset)
	}

	err = db.Find(&posters).Error
	return posters, total, err
}
func (posterService *PosterService) GetPosterPublic(ctx context.Context) {
	// 此方法为获取数据源定义的数据
	// 请自行实现
}
