package wechat

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"strconv"
)

type WechatCourseApi struct{}

// WxCourseRequest 微信课程查询请求参数
type WxCourseRequest struct {
	Page      int   `json:"page" form:"page"`           // 页码，默认为1
	PageSize  int   `json:"pageSize" form:"pageSize"`   // 每页数量，默认为20
	Hot       *bool `json:"hot" form:"hot"`             // 是否推荐
	Exquisite *bool `json:"exquisite" form:"exquisite"` // 是否精品
	Category  *int  `json:"category" form:"category"`   // 分类ID
}

// WxCourseResponse 微信课程响应
type WxCourseResponse struct {
	Courses  []WxCourseListItem `json:"courses"`  // 课程列表
	Total    int64              `json:"total"`    // 总数
	Page     int                `json:"page"`     // 当前页码
	PageSize int                `json:"pageSize"` // 每页数量
}

// WxCourseListItem 微信课程列表项目
type WxCourseListItem struct {
	ID              uint    `json:"id"`              // 课程 ID
	CourseTitle     string  `json:"courseTitle"`     // 课程名称
	CoverImage      string  `json:"coverImage"`      // 封面图片
	Type            string  `json:"type"`            // 类型（img/video）
	Price           float64 `json:"price"`           // 课程售价
	OriginalPrice   float64 `json:"originalPrice"`   // 标注原价
	OnSale          bool    `json:"onSale"`          // 上架状态
	Hot             bool    `json:"hot"`             // 是否推荐
	Exquisite       bool    `json:"exquisite"`       // 是否精品
	Sort            int     `json:"sort"`            // 排序
	ViewDetails     string  `json:"viewDetails"`     // 课程简介
	ApprenticeCount int     `json:"apprenticeCount"` // 学员数量
	Teacher         uint    `json:"teacher"`         // 讲师ID
	Category        int     `json:"category"`        // 分类ID
}

// WxGetCourses 获取微信小程序课程列表
// @Tags     WechatApi
// @Summary  获取微信小程序课程列表
// @Description 获取小程序课程列表，支持分页和筛选，不需要鉴权
// @Accept   application/json
// @Produce  application/json
// @Param    page       query     int                                                    false  "页码，默认为1"
// @Param    pageSize   query     int                                                    false  "每页数量，默认为20"
// @Param    hot        query     bool                                                   false  "是否推荐"
// @Param    exquisite  query     bool                                                   false  "是否精品"
// @Param    category   query     int                                                    false  "分类ID"
// @Success  200        {object}  response.Response{data=WxCourseResponse,msg=string}   "获取成功"
// @Failure  400        {object}  response.Response{msg=string}                          "请求参数错误"
// @Failure  500        {object}  response.Response{msg=string}                          "服务器内部错误"
// @Router   /api/wxCourses [get]
func (w *WechatCourseApi) WxGetCourses(c *gin.Context) {
	// 获取查询参数
	var req WxCourseRequest

	// 解析页码参数
	pageStr := c.DefaultQuery("page", "1")
	page, err := strconv.Atoi(pageStr)
	if err != nil || page < 1 {
		page = 1
	}
	req.Page = page

	// 解析每页数量参数
	pageSizeStr := c.DefaultQuery("pageSize", "20")
	pageSize, err := strconv.Atoi(pageSizeStr)
	if err != nil || pageSize < 1 || pageSize > 100 {
		pageSize = 20
	}
	req.PageSize = pageSize

	// 解析筛选参数
	if hotStr := c.Query("hot"); hotStr != "" {
		if hot, err := strconv.ParseBool(hotStr); err == nil {
			req.Hot = &hot
		}
	}

	if exquisiteStr := c.Query("exquisite"); exquisiteStr != "" {
		if exquisite, err := strconv.ParseBool(exquisiteStr); err == nil {
			req.Exquisite = &exquisite
		}
	}

	if categoryStr := c.Query("category"); categoryStr != "" {
		if category, err := strconv.Atoi(categoryStr); err == nil {
			req.Category = &category
		}
	}

	global.GVA_LOG.Info("获取微信课程列表",
		zap.Int("page", req.Page),
		zap.Int("pageSize", req.PageSize),
		zap.Any("hot", req.Hot),
		zap.Any("exquisite", req.Exquisite),
		zap.Any("category", req.Category))

	// 调用courseService获取课程数据
	courses, total, err := courseService.GetCoursePublic(req.Page, req.PageSize, req.Hot, req.Exquisite, req.Category)
	if err != nil {
		global.GVA_LOG.Error("获取课程列表失败!", zap.Error(err))
		response.FailWithMessage("获取课程列表失败: "+err.Error(), c)
		return
	}

	// 转换为微信接口响应格式
	wxCourses := make([]WxCourseListItem, 0, len(courses))
	for _, course := range courses {
		wxCourse := WxCourseListItem{
			ID:              course.ID,
			CourseTitle:     "",
			CoverImage:      course.CoverImage,
			Type:            "",
			Price:           0,
			OriginalPrice:   0,
			OnSale:          false,
			Hot:             false,
			Exquisite:       false,
			Sort:            0,
			ViewDetails:     "",
			ApprenticeCount: 0,
			Teacher:         0,
			Category:        0,
		}

		// 安全地获取指针值
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
		if course.Hot != nil {
			wxCourse.Hot = *course.Hot
		}
		if course.Exquisite != nil {
			wxCourse.Exquisite = *course.Exquisite
		}
		if course.Sort != nil {
			wxCourse.Sort = int(*course.Sort)
		}
		if course.ViewDetails != nil {
			wxCourse.ViewDetails = *course.ViewDetails
		}
		if course.ApprenticeCount != nil {
			wxCourse.ApprenticeCount = int(*course.ApprenticeCount)
		}
		if course.Category != nil {
			wxCourse.Category = int(*course.Category)
		}

		wxCourses = append(wxCourses, wxCourse)
	}

	// 构建响应数据
	wxCourseResponse := WxCourseResponse{
		Courses:  wxCourses,
		Total:    total,
		Page:     req.Page,
		PageSize: req.PageSize,
	}

	global.GVA_LOG.Info("课程列表获取成功",
		zap.Int("count", len(wxCourses)),
		zap.Int64("total", total))
	response.OkWithDetailed(wxCourseResponse, "获取成功", c)
}
