package system

import (
	"context"
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
	"gorm.io/gorm"
)

type CourseService struct{}

// CreateCourse 创建课程管理记录
// Author [yourname](https://github.com/yourname)
func (courseService *CourseService) CreateCourse(ctx context.Context, course *system.Course) (err error) {
	err = global.GVA_DB.Create(course).Error
	return err
}

// DeleteCourse 删除课程管理记录
// Author [yourname](https://github.com/yourname)
func (courseService *CourseService) DeleteCourse(ctx context.Context, ID string, userID uint) (err error) {
	err = global.GVA_DB.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&system.Course{}).Where("id = ?", ID).Update("deleted_by", userID).Error; err != nil {
			return err
		}
		if err = tx.Delete(&system.Course{}, "id = ?", ID).Error; err != nil {
			return err
		}
		return nil
	})
	return err
}

// DeleteCourseByIds 批量删除课程管理记录
// Author [yourname](https://github.com/yourname)
func (courseService *CourseService) DeleteCourseByIds(ctx context.Context, IDs []string, deleted_by uint) (err error) {
	err = global.GVA_DB.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&system.Course{}).Where("id in ?", IDs).Update("deleted_by", deleted_by).Error; err != nil {
			return err
		}
		if err := tx.Where("id in ?", IDs).Delete(&system.Course{}).Error; err != nil {
			return err
		}
		return nil
	})
	return err
}

// UpdateCourse 更新课程管理记录
// Author [yourname](https://github.com/yourname)
func (courseService *CourseService) UpdateCourse(ctx context.Context, course system.Course) (err error) {
	err = global.GVA_DB.Model(&system.Course{}).Where("id = ?", course.ID).Updates(&course).Error
	return err
}

// GetCourse 根据ID获取课程管理记录
// Author [yourname](https://github.com/yourname)
func (courseService *CourseService) GetCourse(ctx context.Context, ID string) (course system.Course, err error) {
	err = global.GVA_DB.Where("id = ?", ID).First(&course).Error
	return
}

// GetCourseInfoList 分页获取课程管理记录
// Author [yourname](https://github.com/yourname)
func (courseService *CourseService) GetCourseInfoList(ctx context.Context, info systemReq.CourseSearch) (list []system.Course, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	// 创建db
	db := global.GVA_DB.Model(&system.Course{})
	var courses []system.Course
	// 如果有条件搜索 下方会自动创建搜索语句
	if len(info.CreatedAtRange) == 2 {
		db = db.Where("created_at BETWEEN ? AND ?", info.CreatedAtRange[0], info.CreatedAtRange[1])
	}

	if info.Teacher != nil {
		db = db.Where("teacher = ?", *info.Teacher)
	}
	if info.Category != nil {
		db = db.Where("category = ?", *info.Category)
	}
	if info.Type != nil && *info.Type != "" {
		db = db.Where("type = ?", *info.Type)
	}
	if info.StartPrice != nil && info.EndPrice != nil {
		db = db.Where("price BETWEEN ? AND ? ", *info.StartPrice, *info.EndPrice)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	var OrderStr string
	orderMap := make(map[string]bool)
	orderMap["id"] = true
	orderMap["created_at"] = true
	orderMap["sort"] = true
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

	err = db.Find(&courses).Error
	return courses, total, err
}
func (courseService *CourseService) GetCourseDataSource(ctx context.Context) (res map[string][]map[string]any, err error) {
	res = make(map[string][]map[string]any)

	category := make([]map[string]any, 0)

	global.GVA_DB.Table("program_categories").Where("deleted_at IS NULL").Select("category_name as label,id as value").Scan(&category)
	res["category"] = category
	teacher := make([]map[string]any, 0)

	global.GVA_DB.Table("program_teacher").Where("deleted_at IS NULL").Select("name as label,id as value").Scan(&teacher)
	res["teacher"] = teacher
	return
}
func (courseService *CourseService) GetCoursePublic(ctx context.Context) {
	// 此方法为获取数据源定义的数据
	// 请自行实现
}
