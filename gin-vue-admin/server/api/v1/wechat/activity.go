package wechat

import (
	"strconv"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/service"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

var (
	activitiesService           = service.ServiceGroupApp.SystemServiceGroup.ActivitiesService
	activityRegistrationService = service.ServiceGroupApp.SystemServiceGroup.ActivityRegistrationService
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
	Details          string  `json:"details"`          // 活动详情
	Salesperson      *string `json:"salesperson"`      // 销售员ID
}

// WxActivityRegistrationRequest 活动报名请求参数
type WxActivityRegistrationRequest struct {
	ActivityID uint `json:"activityID" binding:"required"` // 活动ID
}

// WxParticipantInfoRequest 参与者信息请求参数
type WxParticipantInfoRequest struct {
	RegistrationID   uint   `json:"registrationID" binding:"required"`   // 报名ID
	ParticipantName  string `json:"participantName" binding:"required"`  // 参与人姓名
	ParticipantPhone string `json:"participantPhone" binding:"required"` // 参与人手机号
}

// WxActivityRegistrationResponse 活动报名响应
type WxActivityRegistrationResponse struct {
	RegistrationID   uint   `json:"registrationID"`   // 报名ID
	VerificationCode string `json:"verificationCode"` // 核销码
	PaymentStatus    string `json:"paymentStatus"`    // 支付状态
	ParticipantName  string `json:"participantName"`  // 参与人姓名
	ParticipantPhone string `json:"participantPhone"` // 参与人手机号
	RegistrationType string `json:"registrationType"` // 报名方式: paid-付费报名, free-免费报名, code-兑换码报名
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
		Details:          "",
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
	if activity.Details != nil {
		wxActivity.Details = *activity.Details
	}
	if activity.Salesperson != nil {
		wxActivity.Salesperson = activity.Salesperson
	}

	global.GVA_LOG.Info("活动详情获取成功",
		zap.Uint("id", wxActivity.ID),
		zap.String("activityName", wxActivity.ActivityName))
	response.OkWithDetailed(wxActivity, "获取成功", c)
}

// WxRegisterForActivity 用户报名活动
// @Tags     WechatApi
// @Summary  用户报名活动
// @Description 用户报名参加活动，生成待支付订单
// @Accept   application/json
// @Produce  application/json
// @Param    data  body      WxActivityRegistrationRequest                    true  "活动报名请求"
// @Success  200   {object}  response.Response{data=string,msg=string}  "报名成功"
// @Failure  400   {object}  response.Response{msg=string}                  "请求参数错误"
// @Failure  401   {object}  response.Response{msg=string}                  "未登录或登录已过期"
// @Failure  500   {object}  response.Response{msg=string}                  "服务器内部错误"
// @Router   /api/wx/Activities/register [post]
func (w *WechatActivityApi) WxRegisterForActivity(c *gin.Context) {
	// 获取当前用户ID
	userID := utils.GetUserID(c)

	var req WxActivityRegistrationRequest
	err := c.ShouldBindJSON(&req)
	if err != nil {
		global.GVA_LOG.Error("参数绑定失败!", zap.Error(err))
		response.FailWithMessage("请求参数错误: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("用户报名活动请求",
		zap.Uint("userID", userID),
		zap.Uint("activityID", req.ActivityID))

	// 调用service进行报名
	registration, err := activityRegistrationService.RegisterForActivity(c.Request.Context(), userID, req.ActivityID)
	if err != nil {
		global.GVA_LOG.Error("活动报名失败!", zap.Error(err))
		response.FailWithMessage("活动报名失败: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("活动报名成功",
		zap.Uint("userID", userID),
		zap.Uint("activityID", req.ActivityID),
		zap.Uint("registrationID", registration.ID))
	response.OkWithMessage("报名成功", c)
}

// WxGetActivityRegistrationStatus 获取活动报名状态
// @Tags     WechatApi
// @Summary  获取活动报名状态
// @Description 获取用户对指定活动的报名状态
// @Accept   application/json
// @Produce  application/json
// @Param    activityID  query      int                                          true  "活动ID"
// @Success  200         {object}  response.Response{data=WxActivityRegistrationResponse,msg=string}  "获取成功"
// @Failure  400         {object}  response.Response{msg=string}                                    "请求参数错误"
// @Failure  401         {object}  response.Response{msg=string}                                    "未登录或登录已过期"
// @Failure  500         {object}  response.Response{msg=string}                                    "服务器内部错误"
// @Router   /api/wx/Activities/registration-status [get]
func (w *WechatActivityApi) WxGetActivityRegistrationStatus(c *gin.Context) {
	// 获取当前用户ID
	userID := utils.GetUserID(c)

	// 获取活动ID参数
	activityIDStr := c.Query("activityID")
	activityID, err := strconv.ParseUint(activityIDStr, 10, 32)
	if err != nil {
		global.GVA_LOG.Error("活动ID参数错误", zap.String("activityID", activityIDStr), zap.Error(err))
		response.FailWithMessage("活动ID参数错误", c)
		return
	}

	global.GVA_LOG.Info("获取活动报名状态请求",
		zap.Uint("userID", userID),
		zap.Uint64("activityID", activityID))

	// 获取报名状态
	registration, err := activityRegistrationService.GetActivityRegistrationByUserAndActivity(c.Request.Context(), userID, uint(activityID))
	if err != nil {
		global.GVA_LOG.Error("获取活动报名状态失败!", zap.Error(err))
		response.FailWithMessage("获取活动报名状态失败: "+err.Error(), c)
		return
	}

	// 如果没有报名记录，返回空状态
	if registration.ID == 0 {
		response.OkWithDetailed(WxActivityRegistrationResponse{}, "获取成功", c)
		return
	}

	// 构建响应数据
	responseData := WxActivityRegistrationResponse{
		RegistrationID:   registration.ID,
		VerificationCode: registration.VerificationCode,
		PaymentStatus:    registration.PaymentStatus,
		RegistrationType: "", // 初始化报名方式
	}

	// 安全地获取参与者信息
	if registration.ParticipantName != nil {
		responseData.ParticipantName = *registration.ParticipantName
	}
	if registration.ParticipantPhone != nil {
		responseData.ParticipantPhone = *registration.ParticipantPhone
	}

	// 安全地获取报名方式
	if registration.RegistrationType != nil {
		responseData.RegistrationType = *registration.RegistrationType
	}

	global.GVA_LOG.Info("获取活动报名状态成功",
		zap.Uint("userID", userID),
		zap.Uint64("activityID", activityID),
		zap.Uint("registrationID", registration.ID))
	response.OkWithDetailed(responseData, "获取成功", c)
}

// WxUpdateParticipantInfo 更新参与者信息
// @Tags     WechatApi
// @Summary  更新参与者信息
// @Description 支付成功后更新参与者信息
// @Accept   application/json
// @Produce  application/json
// @Param    data  body      WxParticipantInfoRequest                         true  "参与者信息"
// @Success  200   {object}  response.Response{msg=string}                  "更新成功"
// @Failure  400   {object}  response.Response{msg=string}                  "请求参数错误"
// @Failure  401   {object}  response.Response{msg=string}                  "未登录或登录已过期"
// @Failure  500   {object}  response.Response{msg=string}                  "服务器内部错误"
// @Router   /api/wx/Activities/participant-info [post]
func (w *WechatActivityApi) WxUpdateParticipantInfo(c *gin.Context) {
	// 获取当前用户ID
	userID := utils.GetUserID(c)

	var req WxParticipantInfoRequest
	err := c.ShouldBindJSON(&req)
	if err != nil {
		global.GVA_LOG.Error("参数绑定失败!", zap.Error(err))
		response.FailWithMessage("请求参数错误: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("更新参与者信息请求",
		zap.Uint("userID", userID),
		zap.Uint("registrationID", req.RegistrationID),
		zap.String("participantName", req.ParticipantName),
		zap.String("participantPhone", req.ParticipantPhone))

	// 更新参与者信息
	err = activityRegistrationService.UpdateParticipantInfo(c.Request.Context(), req.RegistrationID, req.ParticipantName, req.ParticipantPhone, userID)
	if err != nil {
		global.GVA_LOG.Error("更新参与者信息失败!", zap.Error(err))
		response.FailWithMessage("更新参与者信息失败: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("更新参与者信息成功",
		zap.Uint("userID", userID),
		zap.Uint("registrationID", req.RegistrationID))
	response.OkWithMessage("信息更新成功", c)
}

// WxPartnerRedemptionCode 合伙人使用兑换码报名活动
// @Tags     WechatApi
// @Summary  合伙人使用兑换码报名活动
// @Description 合伙人用户使用兑换码报名参加活动，自动获取用户姓名和手机号
// @Accept   application/json
// @Produce  application/json
// @Param    data  body      WxPartnerRedemptionCodeRequest                    true  "合伙人兑换码报名请求"
// @Success  200   {object}  response.Response{data=WxPartnerRedemptionCodeResponse,msg=string}  "报名成功"
// @Failure  400   {object}  response.Response{msg=string}                  "请求参数错误"
// @Failure  401   {object}  response.Response{msg=string}                  "未登录或登录已过期"
// @Failure  500   {object}  response.Response{msg=string}                  "服务器内部错误"
// @Router   /api/wx/Activities/partner-redemption [post]
func (w *WechatActivityApi) WxPartnerRedemptionCode(c *gin.Context) {
	// 获取当前用户ID
	userID := utils.GetUserID(c)

	var req WxActivityRegistrationRequest
	c.ShouldBindJSON(&req)

	global.GVA_LOG.Info("合伙人使用兑换码报名活动请求",
		zap.Uint("userID", userID),
		zap.Uint("activityID", req.ActivityID))

	// 检查用户是否为合伙人
	user, err := wxUserService.GetWechatUser(c.Request.Context(), strconv.Itoa(int(userID)))
	if err != nil {
		global.GVA_LOG.Error("获取用户信息失败!", zap.Error(err))
		response.FailWithMessage("获取用户信息失败: "+err.Error(), c)
		return
	}

	// 检查用户类型是否为合伙人
	if user.UserType == nil || *user.UserType != "partner" {
		global.GVA_LOG.Warn("非合伙人用户尝试使用兑换码报名", zap.Uint("userID", userID))
		response.FailWithMessage("只有合伙人用户可以使用兑换码报名", c)
		return
	}

	// 调用service进行兑换码报名，传递空的兑换码
	registration, err := activityRegistrationService.PartnerRedemptionCode(c.Request.Context(), userID, req.ActivityID, "")
	if err != nil {
		global.GVA_LOG.Error("合伙人兑换码报名失败!", zap.Error(err))
		response.FailWithMessage("报名失败: "+err.Error(), c)
		return
	}

	// 构建响应数据
	responseData := WxActivityRegistrationResponse{
		RegistrationID:   registration.ID,
		VerificationCode: registration.VerificationCode,
		PaymentStatus:    registration.PaymentStatus,
		RegistrationType: "", // 初始化报名方式
	}

	// 安全地获取参与者信息
	if registration.ParticipantName != nil {
		responseData.ParticipantName = *registration.ParticipantName
	}
	if registration.ParticipantPhone != nil {
		responseData.ParticipantPhone = *registration.ParticipantPhone
	}

	// 安全地获取报名方式
	if registration.RegistrationType != nil {
		responseData.RegistrationType = *registration.RegistrationType
	}

	global.GVA_LOG.Info("合伙人兑换码报名成功",
		zap.Uint("userID", userID),
		zap.Uint("activityID", req.ActivityID),
		zap.Uint("registrationID", registration.ID))
	response.OkWithDetailed(responseData, "报名成功", c)
}

// WxUpdatePaymentStatus 更新支付状态（内部使用，由支付回调调用）
func (w *WechatActivityApi) WxUpdatePaymentStatus(c *gin.Context, registrationID uint, status string, userID uint) error {
	err := activityRegistrationService.UpdatePaymentStatus(c.Request.Context(), registrationID, status, userID)
	if err != nil {
		global.GVA_LOG.Error("更新支付状态失败!", zap.Error(err))
		return err
	}

	global.GVA_LOG.Info("更新支付状态成功",
		zap.Uint("registrationID", registrationID),
		zap.String("status", status))
	return nil
}
