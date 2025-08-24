package wechat

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type WechatTeacherApi struct{}

// WxTeacherRequest 微信讲师请求参数
type WxTeacherRequest struct {
	Sort string `json:"sort" form:"sort"` // 排序方式：asc 或 desc，默认为 desc
}

// WxTeacherResponse 微信讲师响应
type WxTeacherResponse struct {
	Teachers []WxTeacherItem `json:"teachers"` // 讲师列表
}

// WxTeacherItem 微信讲师项目
type WxTeacherItem struct {
	ID           uint   `json:"id"`           // 讲师 ID
	Avatar       string `json:"avatar"`       // 头像地址
	Name         string `json:"name"`         // 讲师姓名
	Description  string `json:"description"`  // 讲师描述
	Introduction string `json:"introduction"` // 讲师介绍
	Sort         int    `json:"sort"`         // 排序
}

// WxGetTeachers 获取微信小程序讲师列表
// @Tags     WechatApi
// @Summary  获取微信小程序讲师列表
// @Description 获取小程序讲师列表，不需要鉴权
// @Accept   application/json
// @Produce  application/json
// @Param    sort  query     string                                                 false  "排序方式（asc/desc）"
// @Success  200   {object}  response.Response{data=WxTeacherResponse,msg=string}   "获取成功"
// @Failure  400   {object}  response.Response{msg=string}                          "请求参数错误"
// @Failure  500   {object}  response.Response{msg=string}                          "服务器内部错误"
// @Router   /api/wxTeachers [get]
func (w *WechatTeacherApi) WxGetTeachers(c *gin.Context) {
	// 获取查询参数
	sortType := c.DefaultQuery("sort", "desc") // 默认按sort字段降序排列
	
	global.GVA_LOG.Info("获取微信讲师列表", zap.String("sort", sortType))
	
	// 调用teacherService获取讲师数据
	teachers, err := teacherService.GetTeacherPublic()
	if err != nil {
		global.GVA_LOG.Error("获取讲师列表失败!", zap.Error(err))
		response.FailWithMessage("获取讲师列表失败: "+err.Error(), c)
		return
	}
	
	// 转换为微信接口响应格式
	wxTeachers := make([]WxTeacherItem, 0, len(teachers))
	for _, teacher := range teachers {
		wxTeacher := WxTeacherItem{
			ID:           teacher.ID,
			Avatar:       teacher.Avatar,
			Name:         "",
			Description:  "",
			Introduction: "",
			Sort:         0,
		}
		
		// 安全地获取指针值
		if teacher.Name != nil {
			wxTeacher.Name = *teacher.Name
		}
		if teacher.Description != nil {
			wxTeacher.Description = *teacher.Description
		}
		if teacher.Introduction != nil {
			wxTeacher.Introduction = *teacher.Introduction
		}
		if teacher.Sort != nil {
			wxTeacher.Sort = *teacher.Sort
		}
		
		wxTeachers = append(wxTeachers, wxTeacher)
	}
	
	// 构建响应数据
	wxTeacherResponse := WxTeacherResponse{
		Teachers: wxTeachers,
	}
	
	global.GVA_LOG.Info("讲师列表获取成功", zap.Int("count", len(wxTeachers)))
	response.OkWithDetailed(wxTeacherResponse, "获取成功", c)
}

// WxTeacherDetailResponse 微信讲师详情响应
type WxTeacherDetailResponse struct {
	Teacher WxTeacherDetailItem `json:"teacher"` // 讲师详情
}

// WxTeacherDetailItem 微信讲师详情项目
type WxTeacherDetailItem struct {
	ID           uint            `json:"id"`           // 讲师 ID
	Avatar       string          `json:"avatar"`       // 头像地址
	Name         string          `json:"name"`         // 讲师姓名
	Description  string          `json:"description"`  // 讲师描述
	Introduction string          `json:"introduction"` // 讲师介绍
	Sort         int             `json:"sort"`         // 排序
	Courses      []WxCourseItem  `json:"courses"`      // 讲师的课程列表
}

// WxCourseItem 微信课程项目
type WxCourseItem struct {
	ID              uint    `json:"id"`              // 课程 ID
	CourseTitle     string  `json:"courseTitle"`     // 课程名称
	CoverImage      string  `json:"coverImage"`      // 封面图片
	Type            string  `json:"type"`            // 类型（img/video）
	Price           float64 `json:"price"`           // 课程售价
	OriginalPrice   float64 `json:"originalPrice"`   // 标注原价
	OnSale          bool    `json:"onSale"`          // 上架状态
	Sort            int     `json:"sort"`            // 排序
	ViewDetails     string  `json:"viewDetails"`     // 课程简介
	CourseDetails   string  `json:"courseDetails"`   // 课程详情
	ApprenticeCount int     `json:"apprenticeCount"` // 学员数量
}

// WxGetTeacherDetail 获取微信小程序讲师详情
// @Tags     WechatApi
// @Summary  获取微信小程序讲师详情
// @Description 获取小程序讲师详情及其所有课程，不需要鉴权
// @Accept   application/json
// @Produce  application/json
// @Param    id    path      uint                                                           true   "讲师ID"
// @Success  200   {object}  response.Response{data=WxTeacherDetailResponse,msg=string}   "获取成功"
// @Failure  400   {object}  response.Response{msg=string}                                  "请求参数错误"
// @Failure  404   {object}  response.Response{msg=string}                                  "讲师不存在"
// @Failure  500   {object}  response.Response{msg=string}                                  "服务器内部错误"
// @Router   /api/wxTeachers/{id} [get]
func (w *WechatTeacherApi) WxGetTeacherDetail(c *gin.Context) {
	// 获取路径参数
	teacherID := c.Param("id")
	if teacherID == "" {
		response.FailWithMessage("讲师ID不能为空", c)
		return
	}
	
	global.GVA_LOG.Info("获取微信讲师详情", zap.String("teacherID", teacherID))
	
	// 获取讲师详情和相关课程
	teacherDetail, err := teacherService.GetTeacherDetailWithCourses(teacherID)
	if err != nil {
		global.GVA_LOG.Error("获取讲师详情失败!", zap.Error(err))
		// 判断是否为记录不存在的错误
		if err.Error() == "record not found" {
			response.FailWithMessage("讲师不存在", c)
		} else {
			response.FailWithMessage("获取讲师详情失败: "+err.Error(), c)
		}
		return
	}
	
	// 转换为微信接口响应格式
	wxTeacherDetail := WxTeacherDetailItem{
		ID:           teacherDetail.Teacher.ID,
		Avatar:       teacherDetail.Teacher.Avatar,
		Name:         "",
		Description:  "",
		Introduction: "",
		Sort:         0,
		Courses:      make([]WxCourseItem, 0),
	}
	
	// 安全地获取讲师指针值
	if teacherDetail.Teacher.Name != nil {
		wxTeacherDetail.Name = *teacherDetail.Teacher.Name
	}
	if teacherDetail.Teacher.Description != nil {
		wxTeacherDetail.Description = *teacherDetail.Teacher.Description
	}
	if teacherDetail.Teacher.Introduction != nil {
		wxTeacherDetail.Introduction = *teacherDetail.Teacher.Introduction
	}
	if teacherDetail.Teacher.Sort != nil {
		wxTeacherDetail.Sort = *teacherDetail.Teacher.Sort
	}
	
	// 转换课程数据
	for _, course := range teacherDetail.Courses {
		wxCourse := WxCourseItem{
			ID:              course.ID,
			CourseTitle:     "",
			CoverImage:      course.CoverImage,
			Type:            "",
			Price:           0,
			OriginalPrice:   0,
			OnSale:          false,
			Sort:            0,
			ViewDetails:     "",
			CourseDetails:   "",
			ApprenticeCount: 0,
		}
		
		// 安全地获取课程指针值
		if course.CourseTitle != nil {
			wxCourse.CourseTitle = *course.CourseTitle
		}
		if course.Type != nil {
			wxCourse.Type = *course.Type
		}
		if course.Price != nil {
			wxCourse.Price = *course.Price
		}
		if course.OriginalPrice != nil {
			wxCourse.OriginalPrice = *course.OriginalPrice
		}
		if course.OnSale != nil {
			wxCourse.OnSale = *course.OnSale
		}
		if course.Sort != nil {
			wxCourse.Sort = int(*course.Sort)
		}
		if course.ViewDetails != nil {
			wxCourse.ViewDetails = *course.ViewDetails
		}
		if course.CourseDetails != nil {
			wxCourse.CourseDetails = *course.CourseDetails
		}
		if course.ApprenticeCount != nil {
			wxCourse.ApprenticeCount = int(*course.ApprenticeCount)
		}
		
		wxTeacherDetail.Courses = append(wxTeacherDetail.Courses, wxCourse)
	}
	
	// 构建响应数据
	wxTeacherDetailResponse := WxTeacherDetailResponse{
		Teacher: wxTeacherDetail,
	}
	
	global.GVA_LOG.Info("讲师详情获取成功", 
		zap.Uint("teacherID", wxTeacherDetail.ID),
		zap.Int("coursesCount", len(wxTeacherDetail.Courses)))
	response.OkWithDetailed(wxTeacherDetailResponse, "获取成功", c)
}
