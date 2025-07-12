package system

import (
	"context"
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type ActivitiesService struct{}

// CreateActivities 创建活动管理记录
// Author [yourname](https://github.com/yourname)
func (activitiesService *ActivitiesService) CreateActivities(ctx context.Context, activities *system.Activities) (err error) {
	err = global.GVA_DB.Create(activities).Error
	return err
}

// DeleteActivities 删除活动管理记录
// Author [yourname](https://github.com/yourname)
func (activitiesService *ActivitiesService) DeleteActivities(ctx context.Context, ID string, userID uint) (err error) {
	err = global.GVA_DB.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&system.Activities{}).Where("id = ?", ID).Update("deleted_by", userID).Error; err != nil {
			return err
		}
		if err = tx.Delete(&system.Activities{}, "id = ?", ID).Error; err != nil {
			return err
		}
		return nil
	})
	return err
}

// DeleteActivitiesByIds 批量删除活动管理记录
// Author [yourname](https://github.com/yourname)
func (activitiesService *ActivitiesService) DeleteActivitiesByIds(ctx context.Context, IDs []string, deleted_by uint) (err error) {
	err = global.GVA_DB.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&system.Activities{}).Where("id in ?", IDs).Update("deleted_by", deleted_by).Error; err != nil {
			return err
		}
		if err := tx.Where("id in ?", IDs).Delete(&system.Activities{}).Error; err != nil {
			return err
		}
		return nil
	})
	return err
}

// UpdateActivities 更新活动管理记录
// Author [yourname](https://github.com/yourname)
func (activitiesService *ActivitiesService) UpdateActivities(ctx context.Context, activities system.Activities) (err error) {
	err = global.GVA_DB.Model(&system.Activities{}).Where("id = ?", activities.ID).Updates(&activities).Error
	return err
}

// GetActivities 根据ID获取活动管理记录
// Author [yourname](https://github.com/yourname)
func (activitiesService *ActivitiesService) GetActivities(ctx context.Context, ID string) (activities system.Activities, err error) {
	err = global.GVA_DB.Where("id = ?", ID).First(&activities).Error
	return
}

// GetActivitiesInfoList 分页获取活动管理记录
func (activitiesService *ActivitiesService) GetActivitiesInfoList(ctx context.Context, info systemReq.ActivitiesSearch) (list []system.Activities, total int64, err error) {
	// 设置默认分页参数
	if info.Page <= 0 {
		info.Page = 1
	}
	if info.PageSize <= 0 {
		info.PageSize = 10
	}
	if info.PageSize > 100 {
		info.PageSize = 100
	}

	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)

	// 添加调试日志
	global.GVA_LOG.Info("服务层分页参数", zap.Int("page", info.Page), zap.Int("pageSize", info.PageSize), zap.Int("limit", limit), zap.Int("offset", offset))

	// 创建db
	db := global.GVA_DB.Model(&system.Activities{})
	var activitiess []system.Activities
	// 如果有条件搜索 下方会自动创建搜索语句
	if len(info.CreatedAtRange) == 2 {
		db = db.Where("created_at BETWEEN ? AND ?", info.CreatedAtRange[0], info.CreatedAtRange[1])
	}

	if info.ActivityName != nil && *info.ActivityName != "" {
		db = db.Where("activity_name LIKE ?", "%"+*info.ActivityName+"%")
	}
	if info.StartPrice != nil && info.EndPrice != nil {
		db = db.Where("price BETWEEN ? AND ? ", *info.StartPrice, *info.EndPrice)
	}
	if info.Category != nil {
		db = db.Where("category = ?", *info.Category)
	}
	if info.Status != nil {
		db = db.Where("status = ?", *info.Status)
	}

	// 获取总数
	err = db.Count(&total).Error
	if err != nil {
		return
	}

	// 添加调试日志
	global.GVA_LOG.Info("总数查询结果", zap.Int64("total", total))

	var OrderStr string
	orderMap := make(map[string]bool)
	orderMap["id"] = true
	orderMap["created_at"] = true
	orderMap["price"] = true
	orderMap["sort_order"] = true
	if orderMap[info.Sort] {
		OrderStr = info.Sort
		if info.Order == "descending" {
			OrderStr = OrderStr + " desc"
		}
		db = db.Order(OrderStr)
	}

	err = db.Limit(limit).Offset(offset).Find(&activitiess).Error

	// 添加调试日志
	global.GVA_LOG.Info("查询结果", zap.Int("listLength", len(activitiess)), zap.Error(err))

	return activitiess, total, err
}

// GetActivitiesDataSource 获取活动数据源
func (activitiesService *ActivitiesService) GetActivitiesDataSource(ctx context.Context) (res map[string][]map[string]any, err error) {
	res = make(map[string][]map[string]any)
	category := make([]map[string]any, 0)

	err = global.GVA_DB.Table("program_categories").Where("deleted_at IS NULL").Select("category_name as label ,id as value, type, parent_id").Scan(&category).Error
	if err != nil {
		return
	}
	res["category"] = category
	return
}

// GetActivitiesPublic 获取公开活动数据
func (activitiesService *ActivitiesService) GetActivitiesPublic(ctx context.Context) {
	// 此方法为获取数据源定义的数据
	// 请自行实现
}
