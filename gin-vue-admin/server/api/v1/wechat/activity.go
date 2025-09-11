package wechat

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"strconv"
)

type WechatActivityApi struct{}

// WxActivityRequest 微信活动查询请求参数
type WxActivityRequest struct {
	Page     int    `json:"page" form:"page"`         // 页码，默认为1
	PageSize int    `json:"pageSize" form:"pageSize"` // 每页数量，默认为20
	Category *int   `json:"category" form:"category"` // 分类ID
	Keyword  string `json:"keyword" form:"keyword"`   // 活动名称搜索关键词
}

// WxActivityResponse 微信活动响应
type WxActivityResponse struct {
	Activities []WxActivityItem `json:"activities"` // 活动列表
	Total      int64            `json:"total"`      // 总数
	Page       int              `json:"page"`       // 当前页码
	PageSize   int              `json:"pageSize"`   // 每页数量
}

// WxActivityItem 微信活动列表项目
type WxActivityItem struct {
	ID               uint    `json:"id"`               // 活动 ID
	ActivityName     string  `json:"activityName"`     // 活动名称
	Price            float64 `json:"price"`            // 活动价格
	Category         int     `json:"category"`         // 分类
	CoverPicture     string  `json:"coverPicture"`     // 封面图
	ActualEnrollment int     `json:"actualEnrollment"` // 展示报名人数
	SortOrder        int     `json:"sortOrder"`        // 排序
	StartTime        string  `json:"startTime"`        // 开始时间
	EndTime          string  `json:"endTime"`          // 结束时间
	ShowStartTime    string  `json:"showStartTime"`    // 展示开始时间
	ShowEndTime      string  `json:"showEndTime"`      // 展示结束时间
	Salesperson      *string `json:"salesperson"`      // 销售员ID
}

// WxActivityDetailItem 微信活动详情项目
type WxActivityDetailItem struct {
	ID               uint    `json:"id"`               // 活动 ID
	ActivityName     string  `json:"activityName"`     // 活动名称
	Price            float64 `json:"price"`            // 活动价格
	Category         int     `json:"category"`         // 分类
	CoverPicture     string  `json:"coverPicture"`     // 封面图
	ActualEnrollment int     `json:"actualEnrollment"` // 展示报名人数
	SortOrder        int     `json:"sortOrder"`        // 排序
	StartTime        string  `json:"startTime"`        // 开始时间
	EndTime          string  `json:"endTime"`          // 结束时间
	ShowStartTime    string  `json:"showStartTime"`    // 展示开始时间
	ShowEndTime      string  `json:"showEndTime"`      // 展示结束时间
	Salesperson      *string `json:"salesperson"`      // 销售员ID
}

// WxGetActivities 获取微信小程序活动列表
// @Tags     WechatApi
// @Summary  获取微信小程序活动列表
// @Description 获取小程序活动列表，只返回在展示时间内的活动，不需要鉴权
// @Accept   application/json
// @Produce  application/json
// @Param    page       query     int                                                    false  "页码，默认为1"
// @Param    pageSize   query     int                                                    false  "每页数量，默认为20"
// @Param    category   query     int                                                    false  "分类ID"
// @Param    keyword    query     string                                                 false  "活动名称搜索关键词"
// @Success  200        {object}  response.Response{data=WxActivityResponse,msg=string}  "获取成功"
// @Failure  400        {object}  response.Response{msg=string}                          "请求参数错误"
// @Failure  500        {object}  response.Response{msg=string}                          "服务器内部错误"
// @Router   /api/wxActivities [get]
func (w *WechatActivityApi) WxGetActivities(c *gin.Context) {
	// 获取查询参数
	var req WxActivityRequest

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

	// 解析分类参数
	if categoryStr := c.Query("category"); categoryStr != "" {
		if category, err := strconv.Atoi(categoryStr); err == nil {
			req.Category = &category
		}
	}

	// 解析搜索关键词参数
	req.Keyword = c.Query("keyword")

	global.GVA_LOG.Info("获取微信活动列表",
		zap.Int("page", req.Page),
		zap.Int("pageSize", req.PageSize),
		zap.Any("category", req.Category),
		zap.String("keyword", req.Keyword))

	// 调用activitiesService获取活动数据
	activities, total, err := activitiesService.GetActivitiesPublicWithTime(req.Page, req.PageSize, req.Category, req.Keyword)
	if err != nil {
		global.GVA_LOG.Error("获取活动列表失败!", zap.Error(err))
		response.FailWithMessage("获取活动列表失败: "+err.Error(), c)
		return
	}

	// 转换为微信接口响应格式
	wxActivities := make([]WxActivityItem, 0, len(activities))
	for _, activity := range activities {
		wxActivity := WxActivityItem{
			ID:               activity.ID,
			ActivityName:     "",
			Price:            0,
			Category:         0,
			CoverPicture:     "",
			ActualEnrollment: 0,
			SortOrder:        0,
			StartTime:        "",
			EndTime:          "",
			ShowStartTime:    "",
			ShowEndTime:      "",
			Salesperson:      nil,
		}

		// 安全地获取指针值
		if activity.ActivityName != nil {
			wxActivity.ActivityName = *activity.ActivityName
		}
		if activity.Price != nil {
			wxActivity.Price = *activity.Price
		}
		if activity.Category != nil {
			wxActivity.Category = *activity.Category
		}
		if activity.CoverPicture != nil {
			wxActivity.CoverPicture = *activity.CoverPicture
		}
		if activity.ActualEnrollment != nil {
			wxActivity.ActualEnrollment = *activity.ActualEnrollment
		}
		if activity.SortOrder != nil {
			wxActivity.SortOrder = *activity.SortOrder
		}
		if activity.StartTime != nil {
			wxActivity.StartTime = activity.StartTime.Format("2006-01-02 15:04:05")
		}
		if activity.EndTime != nil {
			wxActivity.EndTime = activity.EndTime.Format("2006-01-02 15:04:05")
		}
		if activity.ShowStartTime != nil {
			wxActivity.ShowStartTime = activity.ShowStartTime.Format("2006-01-02 15:04:05")
		}
		if activity.ShowEndTime != nil {
			wxActivity.ShowEndTime = activity.ShowEndTime.Format("2006-01-02 15:04:05")
		}
		if activity.Salesperson != nil {
			wxActivity.Salesperson = activity.Salesperson
		}

		wxActivities = append(wxActivities, wxActivity)
	}

	// 构建响应数据
	wxActivityResponse := WxActivityResponse{
		Activities: wxActivities,
		Total:      total,
		Page:       req.Page,
		PageSize:   req.PageSize,
	}

	global.GVA_LOG.Info("活动列表获取成功",
		zap.Int("count", len(wxActivities)),
		zap.Int64("total", total))
	response.OkWithDetailed(wxActivityResponse, "获取成功", c)
}

// WxGetActivityDetail 获取微信小程序活动详情
// @Tags     WechatApi
// @Summary  获取微信小程序活动详情
// @Description 获取小程序活动详情，只返回在展示时间内的活动，不需要鉴权
// @Accept   application/json
// @Produce  application/json
// @Param    id         path      int                                                     true   "活动ID"
// @Success  200        {object}  response.Response{data=WxActivityDetailItem,msg=string} "获取成功"
// @Failure  400        {object}  response.Response{msg=string}                           "请求参数错误"
// @Failure  404        {object}  response.Response{msg=string}                           "活动不存在或未在展示期内"
// @Failure  500        {object}  response.Response{msg=string}                           "服务器内部错误"
// @Router   /api/wxActivities/{id} [get]
func (w *WechatActivityApi) WxGetActivityDetail(c *gin.Context) {
	// 获取活动ID参数
	idStr := c.Param("id")
	id, err := strconv.ParseUint(idStr, 10, 32)
	if err != nil {
		global.GVA_LOG.Error("活动ID参数错误", zap.String("id", idStr), zap.Error(err))
		response.FailWithMessage("活动ID参数错误", c)
		return
	}

	global.GVA_LOG.Info("获取微信活动详情",
		zap.Uint64("id", id))

	// 调用activitiesService获取活动详情
	activity, err := activitiesService.GetActivityDetailWithTime(uint(id))
	if err != nil {
		global.GVA_LOG.Error("获取活动详情失败!", zap.Error(err))
		response.FailWithMessage("活动不存在或未在展示期内", c)
		return
	}

	// 转换为微信接口响应格式
	wxActivity := WxActivityDetailItem{
		ID:               activity.ID,
		ActivityName:     "",
		Price:            0,
		Category:         0,
		CoverPicture:     "",
		ActualEnrollment: 0,
		SortOrder:        0,
		StartTime:        "",
		EndTime:          "",
		ShowStartTime:    "",
		ShowEndTime:      "",
		Salesperson:      nil,
	}

	// 安全地获取指针值
	if activity.ActivityName != nil {
		wxActivity.ActivityName = *activity.ActivityName
	}
	if activity.Price != nil {
		wxActivity.Price = *activity.Price
	}
	if activity.Category != nil {
		wxActivity.Category = *activity.Category
	}
	if activity.CoverPicture != nil {
		wxActivity.CoverPicture = *activity.CoverPicture
	}
	if activity.ActualEnrollment != nil {
		wxActivity.ActualEnrollment = *activity.ActualEnrollment
	}
	if activity.SortOrder != nil {
		wxActivity.SortOrder = *activity.SortOrder
	}
	if activity.StartTime != nil {
		wxActivity.StartTime = activity.StartTime.Format("2006-01-02 15:04:05")
	}
	if activity.EndTime != nil {
		wxActivity.EndTime = activity.EndTime.Format("2006-01-02 15:04:05")
	}
	if activity.ShowStartTime != nil {
		wxActivity.ShowStartTime = activity.ShowStartTime.Format("2006-01-02 15:04:05")
	}
	if activity.ShowEndTime != nil {
		wxActivity.ShowEndTime = activity.ShowEndTime.Format("2006-01-02 15:04:05")
	}
	if activity.Salesperson != nil {
		wxActivity.Salesperson = activity.Salesperson
	}

	global.GVA_LOG.Info("活动详情获取成功",
		zap.Uint("id", wxActivity.ID),
		zap.String("activityName", wxActivity.ActivityName))
	response.OkWithDetailed(wxActivity, "获取成功", c)
}
