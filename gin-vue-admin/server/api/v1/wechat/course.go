package wechat

import (
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
	"strconv"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type WechatCourseApi struct{}

type WxCategoryResponse struct {
	Categories []WxCategoryItem `json:"categories"` // 分类列表
}

// WxCategoryItem 微信分类项目
type WxCategoryItem struct {
	ID           uint             `json:"id"`           // 分类 ID
	CategoryName string           `json:"categoryName"` // 分类名称
	Status       bool             `json:"status"`       // 状态
	SortOrder    int              `json:"sortOrder"`    // 排序
	Type         string           `json:"type"`         // 分类类型
	Children     []WxCategoryItem `json:"children"`     // 子分类
	ParentID     int              `json:"parentID"`     // 父分类ID
}

// WxCourseRequest 微信课程查询请求参数
type WxCourseRequest struct {
	Page      int    `json:"page" form:"page"`           // 页码，默认为1
	PageSize  int    `json:"pageSize" form:"pageSize"`   // 每页数量，默认为20
	Hot       *bool  `json:"hot" form:"hot"`             // 是否推荐
	Exquisite *bool  `json:"exquisite" form:"exquisite"` // 是否精品
	Category  *int   `json:"category" form:"category"`   // 分类ID
	Keyword   string `json:"keyword" form:"keyword"`     // 标题搜索关键词
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

// WxCourseDetailItem 微信课程详情项目
type WxCourseDetailItem struct {
	ID              uint                 `json:"id"`              // 课程 ID
	CourseTitle     string               `json:"courseTitle"`     // 课程名称
	CoverImage      string               `json:"coverImage"`      // 封面图片
	Type            string               `json:"type"`            // 类型（img/video）
	Price           float64              `json:"price"`           // 课程售价
	OriginalPrice   float64              `json:"originalPrice"`   // 标注原价
	OnSale          bool                 `json:"onSale"`          // 上架状态
	Hot             bool                 `json:"hot"`             // 是否推荐
	Exquisite       bool                 `json:"exquisite"`       // 是否精品
	Sort            int                  `json:"sort"`            // 排序
	ViewDetails     string               `json:"viewDetails"`     // 课程简介
	ApprenticeCount int                  `json:"apprenticeCount"` // 学员数量
	Teacher         int                  `json:"teacher"`         // 讲师ID
	Category        int                  `json:"category"`        // 分类ID
	CourseDetails   string               `json:"courseDetails"`   // 课程详情内容
	TeacherInfo     *WxCourseTeacherInfo `json:"teacherInfo"`     // 讲师信息（可为空）
}

// WxCourseTeacherInfo 课程详情中的讲师信息
type WxCourseTeacherInfo struct {
	ID           uint   `json:"id"`           // 讲师 ID
	Avatar       string `json:"avatar"`       // 头像地址
	Name         string `json:"name"`         // 讲师姓名
	Description  string `json:"description"`  // 讲师描述
	Introduction string `json:"introduction"` // 讲师介绍
}

// WxCourseFavoriteRequest 微信课程收藏请求
type WxCourseFavoriteRequest struct {
	CourseID uint `json:"courseId" form:"courseId" binding:"required"` // 课程ID
}

// WxCourseFavoriteResponse 微信课程收藏响应
type WxCourseFavoriteResponse struct {
	IsFavorite bool `json:"isFavorite"` // 是否已收藏
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
// @Param    keyword    query     string                                                 false  "标题搜索关键词"
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

	// 解析搜索关键词参数
	req.Keyword = c.Query("keyword")

	global.GVA_LOG.Info("获取微信课程列表",
		zap.Int("page", req.Page),
		zap.Int("pageSize", req.PageSize),
		zap.Any("hot", req.Hot),
		zap.Any("exquisite", req.Exquisite),
		zap.Any("category", req.Category),
		zap.String("keyword", req.Keyword))

	// 调用courseService获取课程数据
	courses, total, err := courseService.GetCoursePublic(req.Page, req.PageSize, req.Hot, req.Exquisite, req.Category, req.Keyword)
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

// WxGetCategories 获取微信小程序课程分类列表
// @Tags     WechatApi
// @Summary  获取微信小程序课程分类列表
// @Description 获取小程序课程分类列表，不需要鉴权
// @Accept   application/json
// @Produce  application/json
// @Param    type       query     string                                                   false  "分类类型（course/activity等）"
// @Success  200        {object}  response.Response{data=WxCategoryResponse,msg=string} "获取成功"
// @Failure  400        {object}  response.Response{msg=string}                        "请求参数错误"
// @Failure  500        {object}  response.Response{msg=string}                        "服务器内部错误"
// @Router   /api/wxCategories [get]
func (w *WechatCourseApi) WxGetCategories(c *gin.Context) {

	// 调用categoryService获取分类数据
	categories, err := categoryService.GetCategoryPublic()
	if err != nil {
		global.GVA_LOG.Error("获取分类列表失败!", zap.Error(err))
		response.FailWithMessage("获取分类列表失败: "+err.Error(), c)
		return
	}

	// 转换为微信接口响应格式
	wxCategories := convertToWxCategories(categories)

	// 构建响应数据
	wxCategoryResponse := WxCategoryResponse{
		Categories: wxCategories,
	}

	global.GVA_LOG.Info("分类列表获取成功",
		zap.Int("count", len(wxCategories)))
	response.OkWithDetailed(wxCategoryResponse, "获取成功", c)
}

// convertToWxCategories 转换分类数据为微信格式
func convertToWxCategories(categories []*system.Category) []WxCategoryItem {
	wxCategories := make([]WxCategoryItem, 0, len(categories))

	for _, category := range categories {
		wxCategory := WxCategoryItem{
			ID:           category.ID,
			CategoryName: "",
			Status:       false,
			SortOrder:    0,
			Type:         "",
			Children:     make([]WxCategoryItem, 0),
			ParentID:     category.ParentID,
		}

		// 安全地获取指针值
		if category.CategoryName != nil {
			wxCategory.CategoryName = *category.CategoryName
		}
		if category.Status != nil {
			wxCategory.Status = *category.Status
		}
		if category.SortOrder != nil {
			wxCategory.SortOrder = *category.SortOrder
		}
		if category.Type != nil {
			wxCategory.Type = *category.Type
		}

		// 递归处理子分类
		if len(category.Children) > 0 {
			wxCategory.Children = convertToWxCategories(category.Children)
		}

		wxCategories = append(wxCategories, wxCategory)
	}

	return wxCategories
}

// WxGetCourseDetail 获取微信小程序课程详情
// @Tags     WechatApi
// @Summary  获取微信小程序课程详情
// @Description 获取小程序课程详情，不需要鉴权
// @Accept   application/json
// @Produce  application/json
// @Param    id         path      int                                                    true   "课程ID"
// @Success  200        {object}  response.Response{data=WxCourseDetailItem,msg=string} "获取成功"
// @Failure  400        {object}  response.Response{msg=string}                          "请求参数错误"
// @Failure  404        {object}  response.Response{msg=string}                          "课程不存在"
// @Failure  500        {object}  response.Response{msg=string}                          "服务器内部错误"
// @Router   /api/wxCourses/{id} [get]
func (w *WechatCourseApi) WxGetCourseDetail(c *gin.Context) {
	// 获取路径参数
	idStr := c.Param("id")
	if idStr == "" {
		response.FailWithMessage("课程ID不能为空", c)
		return
	}

	// 转换ID为整数
	id, err := strconv.ParseUint(idStr, 10, 32)
	if err != nil {
		global.GVA_LOG.Error("课程ID格式错误!", zap.String("id", idStr), zap.Error(err))
		response.FailWithMessage("课程ID格式错误", c)
		return
	}

	global.GVA_LOG.Info("获取微信课程详情", zap.Uint64("id", id))

	// 调用courseService获取课程详情和讲师信息
	courseWithTeacher, err := courseService.GetCourseDetailWithTeacher(uint(id))
	if err != nil {
		if err.Error() == "record not found" {
			global.GVA_LOG.Info("课程不存在或未上架", zap.Uint64("id", id))
			response.FailWithMessage("课程不存在或未上架", c)
			return
		}
		global.GVA_LOG.Error("获取课程详情失败!", zap.Error(err))
		response.FailWithMessage("获取课程详情失败: "+err.Error(), c)
		return
	}

	course := courseWithTeacher.Course

	// 转换为微信接口响应格式
	wxCourseDetail := WxCourseDetailItem{
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
		CourseDetails:   "",
		TeacherInfo:     nil,
	}

	// 安全地获取课程指针值
	if course.CourseTitle != nil {
		wxCourseDetail.CourseTitle = *course.CourseTitle
	}
	if course.Type != nil {
		wxCourseDetail.Type = *course.Type
	}
	if course.Price != nil {
		wxCourseDetail.Price = *course.Price
	}
	if course.OriginalPrice != nil {
		wxCourseDetail.OriginalPrice = *course.OriginalPrice
	}
	if course.OnSale != nil {
		wxCourseDetail.OnSale = *course.OnSale
	}
	if course.Hot != nil {
		wxCourseDetail.Hot = *course.Hot
	}
	if course.Exquisite != nil {
		wxCourseDetail.Exquisite = *course.Exquisite
	}
	if course.Sort != nil {
		wxCourseDetail.Sort = int(*course.Sort)
	}
	if course.ViewDetails != nil {
		wxCourseDetail.ViewDetails = *course.ViewDetails
	}
	if course.ApprenticeCount != nil {
		wxCourseDetail.ApprenticeCount = int(*course.ApprenticeCount)
	}
	if course.Category != nil {
		wxCourseDetail.Category = int(*course.Category)
	}
	if course.Teacher != nil {
		wxCourseDetail.Teacher = *course.Teacher
	}
	if course.CourseDetails != nil {
		wxCourseDetail.CourseDetails = *course.CourseDetails
	}

	// 处理讲师信息
	if courseWithTeacher.Teacher != nil {
		teacher := courseWithTeacher.Teacher
		wxTeacherInfo := &WxCourseTeacherInfo{
			ID:           teacher.ID,
			Avatar:       teacher.Avatar,
			Name:         "",
			Description:  "",
			Introduction: "",
		}

		// 安全地获取讲师指针值
		if teacher.Name != nil {
			wxTeacherInfo.Name = *teacher.Name
		}
		if teacher.Description != nil {
			wxTeacherInfo.Description = *teacher.Description
		}
		if teacher.Introduction != nil {
			wxTeacherInfo.Introduction = *teacher.Introduction
		}

		wxCourseDetail.TeacherInfo = wxTeacherInfo
	}

	global.GVA_LOG.Info("课程详情获取成功", zap.Uint("id", course.ID))
	response.OkWithDetailed(wxCourseDetail, "获取成功", c)
}

// WxToggleCourseFavorite 收藏/取消收藏课程
// @Tags     WechatApi
// @Summary  收藏/取消收藏课程
// @Description 收藏或取消收藏课程，需要鉴权
// @Accept   application/json
// @Produce  application/json
// @Param    data       body      WxCourseFavoriteRequest                            true   "课程ID"
// @Success  200        {object}  response.Response{data=WxCourseFavoriteResponse,msg=string} "操作成功"
// @Failure  400        {object}  response.Response{msg=string}                        "请求参数错误"
// @Failure  500        {object}  response.Response{msg=string}                        "服务器内部错误"
// @Router   /api/wxCourses/favorite [post]
// @Security ApiKeyAuth
func (w *WechatCourseApi) WxToggleCourseFavorite(c *gin.Context) {
	// 获取用户ID（从JWT中获取）
	claims, _ := c.Get("claims")
	waitUse := claims.(*systemReq.CustomClaims)
	userID := waitUse.BaseClaims.ID

	// 获取请求参数
	var req WxCourseFavoriteRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		response.FailWithMessage("参数错误: "+err.Error(), c)
		return
	}

	// 检查课程是否存在且已上架
	_, err := courseService.GetCourseDetailPublic(req.CourseID)
	if err != nil {
		if err.Error() == "record not found" {
			response.FailWithMessage("课程不存在或未上架", c)
			return
		}
		global.GVA_LOG.Error("获取课程详情失败!", zap.Error(err))
		response.FailWithMessage("获取课程详情失败: "+err.Error(), c)
		return
	}

	// 检查是否已收藏
	isFavorite, err := courseFavoriteService.IsCourseFavorite(c.Request.Context(), userID, req.CourseID)
	if err != nil {
		global.GVA_LOG.Error("检查课程收藏状态失败!", zap.Error(err))
		response.FailWithMessage("检查课程收藏状态失败: "+err.Error(), c)
		return
	}

	// 如果已收藏则取消收藏，否则添加收藏
	if isFavorite {
		// 取消收藏
		err = courseFavoriteService.DeleteCourseFavorite(c.Request.Context(), userID, req.CourseID)
		if err != nil {
			global.GVA_LOG.Error("取消课程收藏失败!", zap.Error(err))
			response.FailWithMessage("取消课程收藏失败: "+err.Error(), c)
			return
		}
		global.GVA_LOG.Info("课程取消收藏成功", zap.Uint("userID", userID), zap.Uint("courseID", req.CourseID))
		response.OkWithDetailed(WxCourseFavoriteResponse{IsFavorite: false}, "已取消收藏", c)
	} else {
		// 添加收藏
		courseFavorite := &system.CourseFavorite{
			UserID:   userID,
			CourseID: req.CourseID,
		}
		err = courseFavoriteService.CreateCourseFavorite(c.Request.Context(), courseFavorite)
		if err != nil {
			global.GVA_LOG.Error("课程收藏失败!", zap.Error(err))
			response.FailWithMessage("课程收藏失败: "+err.Error(), c)
			return
		}
		global.GVA_LOG.Info("课程收藏成功", zap.Uint("userID", userID), zap.Uint("courseID", req.CourseID), zap.Uint("favoriteID", courseFavorite.ID))
		response.OkWithDetailed(WxCourseFavoriteResponse{IsFavorite: true}, "已添加收藏", c)
	}
}

// WxIsCourseFavorite 检查课程是否已收藏
// @Tags     WechatApi
// @Summary  检查课程是否已收藏
// @Description 检查课程是否已被当前用户收藏，需要鉴权
// @Accept   application/json
// @Produce  application/json
// @Param    id   path      int                                                    true   "课程ID"
// @Success  200        {object}  response.Response{data=WxCourseFavoriteResponse,msg=string} "获取成功"
// @Failure  400        {object}  response.Response{msg=string}                        "请求参数错误"
// @Failure  500        {object}  response.Response{msg=string}                        "服务器内部错误"
// @Router   /api/wxCourses/{id}/favorite [get]
// @Security ApiKeyAuth
func (w *WechatCourseApi) WxIsCourseFavorite(c *gin.Context) {
	// 获取用户ID（从JWT中获取）
	claims, _ := c.Get("claims")
	waitUse := claims.(*systemReq.CustomClaims)
	userID := waitUse.BaseClaims.ID

	// 获取路径参数
	idStr := c.Param("id")
	if idStr == "" {
		response.FailWithMessage("课程ID不能为空", c)
		return
	}

	// 转换ID为整数
	id, err := strconv.ParseUint(idStr, 10, 32)
	if err != nil {
		global.GVA_LOG.Error("课程ID格式错误!", zap.String("id", idStr), zap.Error(err))
		response.FailWithMessage("课程ID格式错误", c)
		return
	}

	// 检查是否已收藏
	isFavorite, err := courseFavoriteService.IsCourseFavorite(c.Request.Context(), userID, uint(id))
	if err != nil {
		global.GVA_LOG.Error("检查课程收藏状态失败!", zap.Error(err))
		response.FailWithMessage("检查课程收藏状态失败: "+err.Error(), c)
		return
	}

	response.OkWithDetailed(WxCourseFavoriteResponse{IsFavorite: isFavorite}, "获取成功", c)
}
