package system

import (
	"context"
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
	"go.uber.org/zap"
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
	if info.Hot != nil {
		db = db.Where("hot = ?", *info.Hot)
	}
	if info.Exquisite != nil {
		db = db.Where("exquisite = ?", *info.Exquisite)
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

// GetCoursePublic 获取微信小程序课程列表
func (courseService *CourseService) GetCoursePublic(page, pageSize int, hot, exquisite *bool, category *int, keyword string) (list []system.Course, total int64, err error) {
	limit := pageSize
	offset := pageSize * (page - 1)

	// 创建db查询，只查询已上架的课程
	db := global.GVA_DB.Model(&system.Course{}).Where("on_sale = ?", true)

	var courses []system.Course

	// 根据筛选条件添加查询条件
	if hot != nil {
		db = db.Where("hot = ?", *hot)
	}
	if exquisite != nil {
		db = db.Where("exquisite = ?", *exquisite)
	}
	if category != nil {
		db = db.Where("category = ?", *category)
	}
	// 添加标题模糊搜索
	if keyword != "" {
		db = db.Where("course_title ILIKE ?", "%"+keyword+"%")
	}

	// 获取总数
	err = db.Count(&total).Error
	if err != nil {
		return
	}

	// 排序：优先按照sort字段升序，然后按创建时间降序
	db = db.Order("sort ASC, created_at DESC")

	// 分页
	if limit != 0 {
		db = db.Limit(limit).Offset(offset)
	}

	err = db.Find(&courses).Error
	return courses, total, err
}

// GetCourseDetailPublic 获取微信小程序课程详情
func (courseService *CourseService) GetCourseDetailPublic(id uint) (course system.Course, err error) {
	// 查询已上架的课程详情
	err = global.GVA_DB.Where("id = ? AND on_sale = ?", id, true).First(&course).Error
	return
}

// CourseDetailWithTeacher 课程详情及讲师信息结构体
type CourseDetailWithTeacher struct {
	Course  system.Course   `json:"course"`
	Teacher *system.Teacher `json:"teacher"`
}

// GetCourseDetailWithTeacher 获取课程详情及讲师信息
func (courseService *CourseService) GetCourseDetailWithTeacher(id uint) (*CourseDetailWithTeacher, error) {
	var course system.Course
	var teacher system.Teacher

	// 查询已上架的课程详情
	err := global.GVA_DB.Where("id = ? AND on_sale = ?", id, true).First(&course).Error
	if err != nil {
		return nil, err
	}

	// 查询对应的讲师信息（如果存在）
	var teacherPtr *system.Teacher = nil
	if course.Teacher != nil {
		err = global.GVA_DB.Where("id = ?", *course.Teacher).First(&teacher).Error
		if err == nil {
			teacherPtr = &teacher
		}
		// 讲师不存在不影响课程详情的返回，只记录日志
		if err != nil && err.Error() != "record not found" {
			global.GVA_LOG.Warn("获取课程讲师信息失败",
				zap.Uint("courseId", id),
				zap.Int("teacherId", *course.Teacher),
				zap.Error(err))
		}
	}

	return &CourseDetailWithTeacher{
		Course:  course,
		Teacher: teacherPtr,
	}, nil
}
