package system

import (
	"context"
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
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

// GetActivitiesInfoList 分页获取活动管理记
// GetActivitiesInfoList 分页获取活动管理记录
func (activitiesService *ActivitiesService) GetActivitiesInfoList(ctx context.Context, info systemReq.ActivitiesSearch) (list []system.Activities, total int64, err error) {
func (activitiesService *ActivitiesService)GetActivitiesInfoList(ctx context.Context, info systemReq.ActivitiesSearch) (list []system.Activities, total int64, err error) {
	limit := info.PageSize
	// 创建db
    // 创建db
	var activitiess []system.Activities
	// 如果有条件搜索 下方会自动创建搜索语句
	if len(info.CreatedAtRange) == 2 {
		db = db.Where("created_at BETWEEN ? AND ?", info.CreatedAtRange[0], info.CreatedAtRange[1])
	}

	if info.ActivityName != nil && *info.ActivityName != "" {
		db = db.Where("activity_name LIKE ?", "%"+*info.ActivityName+"%")
	}
    }
	if info.StartPrice != nil && info.EndPrice != nil {
		db = db.Where("price BETWEEN ? AND ? ", *info.StartPrice, *info.EndPrice)
	if info.Category != nil {
		db = db.Where("category = ?", *info.Category)
	}
	if info.Status != nil {
		db = db.Where("status = ?", *info.Status)
	}
    }
	if err != nil {
		return
	}
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
       }

		db = db.Limit(limit).Offset(offset)
	}
    }

	return activitiess, total, err
	return  activitiess, total, err
func (activitiesService *ActivitiesService) GetActivitiesDataSource(ctx context.Context) (res map[string][]map[string]any, err error) {
func (activitiesService *ActivitiesService)GetActivitiesDataSource(ctx context.Context) (res map[string][]map[string]any, err error) {

	category := make([]map[string]any, 0)

	global.GVA_DB.Table("program_categories").Where("deleted_at IS NULL").Select("category_name as label,id as value").Scan(&category)
	res["category"] = category
	   res["category"] = category
	return
func (activitiesService *ActivitiesService) GetActivitiesPublic(ctx context.Context) {
	// 此方法为获取数据源定义的数据
	// 请自行实现
    // 请自行实现
}
