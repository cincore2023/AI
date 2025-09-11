package system

import (
	"context"
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
)

type CourseFavoriteService struct{}

// CreateCourseFavorite 创建课程收藏记录
func (courseFavoriteService *CourseFavoriteService) CreateCourseFavorite(ctx context.Context, courseFavorite *system.CourseFavorite) (err error) {
	err = global.GVA_DB.Create(courseFavorite).Error
	return err
}

// DeleteCourseFavorite 删除课程收藏记录
func (courseFavoriteService *CourseFavoriteService) DeleteCourseFavorite(ctx context.Context, userID, courseID uint) (err error) {
	err = global.GVA_DB.Where("user_id = ? AND course_id = ?", userID, courseID).Delete(&system.CourseFavorite{}).Error
	return err
}

// GetCourseFavoriteByUserAndCourse 根据用户ID和课程ID获取收藏记录
func (courseFavoriteService *CourseFavoriteService) GetCourseFavoriteByUserAndCourse(ctx context.Context, userID, courseID uint) (courseFavorite system.CourseFavorite, err error) {
	err = global.GVA_DB.Where("user_id = ? AND course_id = ?", userID, courseID).First(&courseFavorite).Error
	return
}

// GetCourseFavoritesByUser 根据用户ID获取收藏课程列表
func (courseFavoriteService *CourseFavoriteService) GetCourseFavoritesByUser(ctx context.Context, userID uint, page, pageSize int) (list []system.CourseFavorite, total int64, err error) {
	limit := pageSize
	offset := pageSize * (page - 1)

	db := global.GVA_DB.Model(&system.CourseFavorite{}).Where("user_id = ?", userID)

	// 获取总数
	err = db.Count(&total).Error
	if err != nil {
		return
	}

	// 分页
	if limit != 0 {
		db = db.Limit(limit).Offset(offset)
	}

	err = db.Find(&list).Error
	return
}

// IsCourseFavorite 检查课程是否已被用户收藏
func (courseFavoriteService *CourseFavoriteService) IsCourseFavorite(ctx context.Context, userID, courseID uint) (bool, error) {
	var count int64
	err := global.GVA_DB.Model(&system.CourseFavorite{}).Where("user_id = ? AND course_id = ?", userID, courseID).Count(&count).Error
	if err != nil {
		return false, err
	}
	return count > 0, nil
}
