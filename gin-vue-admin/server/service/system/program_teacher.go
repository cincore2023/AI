package system

import (
	"context"
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
	"gorm.io/gorm"
)

type TeacherService struct{}

// CreateTeacher 创建讲师管理记录
// Author [yourname](https://github.com/yourname)
func (teacherService *TeacherService) CreateTeacher(ctx context.Context, teacher *system.Teacher) (err error) {
	err = global.GVA_DB.Create(teacher).Error
	return err
}

// DeleteTeacher 删除讲师管理记录
// Author [yourname](https://github.com/yourname)
func (teacherService *TeacherService) DeleteTeacher(ctx context.Context, ID string, userID uint) (err error) {
	err = global.GVA_DB.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&system.Teacher{}).Where("id = ?", ID).Update("deleted_by", userID).Error; err != nil {
			return err
		}
		if err = tx.Delete(&system.Teacher{}, "id = ?", ID).Error; err != nil {
			return err
		}
		return nil
	})
	return err
}

// DeleteTeacherByIds 批量删除讲师管理记录
// Author [yourname](https://github.com/yourname)
func (teacherService *TeacherService) DeleteTeacherByIds(ctx context.Context, IDs []string, deleted_by uint) (err error) {
	err = global.GVA_DB.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&system.Teacher{}).Where("id in ?", IDs).Update("deleted_by", deleted_by).Error; err != nil {
			return err
		}
		if err := tx.Where("id in ?", IDs).Delete(&system.Teacher{}).Error; err != nil {
			return err
		}
		return nil
	})
	return err
}

// UpdateTeacher 更新讲师管理记录
// Author [yourname](https://github.com/yourname)
func (teacherService *TeacherService) UpdateTeacher(ctx context.Context, teacher system.Teacher) (err error) {
	err = global.GVA_DB.Model(&system.Teacher{}).Where("id = ?", teacher.ID).Updates(&teacher).Error
	return err
}

// GetTeacher 根据ID获取讲师管理记录
// Author [yourname](https://github.com/yourname)
func (teacherService *TeacherService) GetTeacher(ctx context.Context, ID string) (teacher system.Teacher, err error) {
	err = global.GVA_DB.Where("id = ?", ID).First(&teacher).Error
	return
}

// GetTeacherInfoList 分页获取讲师管理记录
// Author [yourname](https://github.com/yourname)
func (teacherService *TeacherService) GetTeacherInfoList(ctx context.Context, info systemReq.TeacherSearch) (list []system.Teacher, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	// 创建db
	db := global.GVA_DB.Model(&system.Teacher{})
	var teachers []system.Teacher
	// 如果有条件搜索 下方会自动创建搜索语句
	if len(info.CreatedAtRange) == 2 {
		db = db.Where("created_at BETWEEN ? AND ?", info.CreatedAtRange[0], info.CreatedAtRange[1])
	}

	if info.Sort != nil {
		db = db.Where("sort = ?", *info.Sort)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}

	if limit != 0 {
		db = db.Limit(limit).Offset(offset)
	}

	err = db.Find(&teachers).Error
	return teachers, total, err
}
func (teacherService *TeacherService) GetTeacherPublic(ctx context.Context) {
	// 此方法为获取数据源定义的数据
	// 请自行实现
}
