package wechat

import (
	"strconv"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
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
	RealEnrollment   int     `json:"realEnrollment"`   // 真实报名人数
	SortOrder        int     `json:"sortOrder"`        // 排序
	StartTime        string  `json:"startTime"`        // 开始时间
	EndTime          string  `json:"endTime"`          // 结束时间
	ShowStartTime    string  `json:"showStartTime"`    // 展示开始时间
	ShowEndTime      string  `json:"showEndTime"`      // 展示结束时间
	Salesperson      *string `json:"salesperson"`      // 销售员ID
	RegistrationType *string `json:"registrationType"` // 报名方式
}

// WxActivityDetailItem 微信活动详情项目
type WxActivityDetailItem struct {
	ID               uint    `json:"id"`               // 活动 ID
	ActivityName     string  `json:"activityName"`     // 活动名称
	Price            float64 `json:"price"`            // 活动价格
	Category         int     `json:"category"`         // 分类
	CoverPicture     string  `json:"coverPicture"`     // 封面图
	ActualEnrollment int     `json:"actualEnrollment"` // 展示报名人数
	RealEnrollment   int     `json:"realEnrollment"`   // 真实报名人数
	SortOrder        int     `json:"sortOrder"`        // 排序
	StartTime        string  `json:"startTime"`        // 开始时间
	EndTime          string  `json:"endTime"`          // 结束时间
	ShowStartTime    string  `json:"showStartTime"`    // 展示开始时间
	ShowEndTime      string  `json:"showEndTime"`      // 展示结束时间
	Details          string  `json:"details"`          // 活动详情
	Salesperson      *string `json:"salesperson"`      // 销售员ID
	RegistrationType *string `json:"registrationType"` // 报名方式
}

// WxUserRegisteredActivityItem 用户已报名活动项目
type WxUserRegisteredActivityItem struct {
	// 活动基本信息
	ID               uint    `json:"id"`               // 活动 ID
	ActivityName     string  `json:"activityName"`     // 活动名称
	Price            float64 `json:"price"`            // 活动价格
	Category         int     `json:"category"`         // 分类
	CoverPicture     string  `json:"coverPicture"`     // 封面图
	ActualEnrollment int     `json:"actualEnrollment"` // 展示报名人数
	RealEnrollment   int     `json:"realEnrollment"`   // 真实报名人数
	SortOrder        int     `json:"sortOrder"`        // 排序
	StartTime        string  `json:"startTime"`        // 开始时间
	EndTime          string  `json:"endTime"`          // 结束时间
	ShowStartTime    string  `json:"showStartTime"`    // 展示开始时间
	ShowEndTime      string  `json:"showEndTime"`      // 展示结束时间
	RegistrationType string  `json:"registrationType"` // 报名方式

	// 报名相关信息
	OrderNumber        string `json:"orderNumber"`        // 订单编号
	RegistrationID     uint   `json:"registrationID"`     // 报名ID
	VerificationCode   string `json:"verificationCode"`   // 核销码
	VerificationStatus string `json:"verificationStatus"` // 核销状态: pending-待核销, verified-已核销, cancelled-已取消
	PaymentStatus      string `json:"paymentStatus"`      // 支付状态: pending-待支付, paid-已支付, cancelled-已取消
	ParticipantName    string `json:"participantName"`    // 参与人姓名
	ParticipantPhone   string `json:"participantPhone"`   // 参与人手机号
	CreatedAt          string `json:"createdAt"`          // 报名时间
}

// WxUserRegisteredActivitiesResponse 用户已报名活动响应
type WxUserRegisteredActivitiesResponse struct {
	Activities []WxUserRegisteredActivityItem `json:"activities"` // 活动列表
	Total      int64                          `json:"total"`      // 总数
	Page       int                            `json:"page"`       // 当前页码
	PageSize   int                            `json:"pageSize"`   // 每页数量
}

// WxUserRegisteredActivitiesRequest 获取用户已报名活动列表请求参数
type WxUserRegisteredActivitiesRequest struct {
	Page           int    `json:"page" form:"page"`                     // 页码，默认为1
	PageSize       int    `json:"pageSize" form:"pageSize"`             // 每页数量，默认为10
	PaymentStatus  string `json:"paymentStatus" form:"paymentStatus"`   // 支付状态筛选
	StartTimeRange string `json:"startTimeRange" form:"startTimeRange"` // 开始时间范围筛选
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

// WxCreateActivityOrderResponse 创建活动订单响应
type WxCreateActivityOrderResponse struct {
	RegistrationID uint   `json:"registrationID"` // 报名ID
	AppID          string `json:"appId"`          // 应用ID
	TimeStamp      string `json:"timeStamp"`      // 时间戳
	NonceStr       string `json:"nonceStr"`       // 随机字符串
	Package        string `json:"package"`        // 订单包
	SignType       string `json:"signType"`       // 签名类型
	PaySign        string `json:"paySign"`        // 支付签名
	Amount         int    `json:"amount"`         // 支付金额(分)
	OrderNo        string `json:"orderNo"`        // 订单编号
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
			RealEnrollment:   0, // 添加真实报名人数字段
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
		// 安全地获取真实报名人数
		if activity.RealEnrollment != nil {
			wxActivity.RealEnrollment = *activity.RealEnrollment
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
		if activity.RegistrationType != nil {
			wxActivity.RegistrationType = activity.RegistrationType
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
		RealEnrollment:   0, // 添加真实报名人数字段
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
	// 安全地获取真实报名人数
	if activity.RealEnrollment != nil {
		wxActivity.RealEnrollment = *activity.RealEnrollment
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
	if activity.RegistrationType != nil {
		wxActivity.RegistrationType = activity.RegistrationType
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

	// 安安地获取报名方式
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

	// �安安地获取报名方式
	if registration.RegistrationType != nil {
		responseData.RegistrationType = *registration.RegistrationType
	}

	global.GVA_LOG.Info("合伙人兑换码报名成功",
		zap.Uint("userID", userID),
		zap.Uint("activityID", req.ActivityID),
		zap.Uint("registrationID", registration.ID))
	response.OkWithDetailed(responseData, "报名成功", c)
}

// WxCreateActivityOrder 创建活动支付订单
// @Tags     WechatApi
// @Summary  创建活动支付订单
// @Description 创建活动支付订单，返回支付信息
// @Accept   application/json
// @Produce  application/json
// @Param    data  body      WxActivityRegistrationRequest                    true  "活动报名请求"
// @Success  200   {object}  response.Response{data=WxCreateActivityOrderResponse,msg=string}  "返回订单信息用于支付"
// @Failure  400   {object}  response.Response{msg=string}                  "请求参数错误"
// @Failure  401   {object}  response.Response{msg=string}                  "未登录或登录已过期"
// @Failure  500   {object}  response.Response{msg=string}                  "服务器内部错误"
// @Router   /api/wx/Activities/create-order [post]
func (w *WechatActivityApi) WxCreateActivityOrder(c *gin.Context) {
	// 获取当前用户ID
	userID := utils.GetUserID(c)

	var req WxActivityRegistrationRequest
	err := c.ShouldBindJSON(&req)
	if err != nil {
		global.GVA_LOG.Error("参数绑定失败!", zap.Error(err))
		response.FailWithMessage("请求参数错误: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("创建活动支付订单请求",
		zap.Uint("userID", userID),
		zap.Uint("activityID", req.ActivityID))

	// 获取活动详情
	activity, err := activitiesService.GetActivityDetailWithTime(req.ActivityID)
	if err != nil {
		global.GVA_LOG.Error("获取活动详情失败!", zap.Error(err))
		response.FailWithMessage("活动不存在或未在展示期内", c)
		return
	}

	// 检查活动价格
	if activity.Price == nil || *activity.Price <= 0 {
		global.GVA_LOG.Error("活动价格无效", zap.Uint("activityID", req.ActivityID))
		response.FailWithMessage("活动价格无效", c)
		return
	}

	// 调用service进行报名（确保有报名记录）
	registration, err := activityRegistrationService.RegisterForActivity(c.Request.Context(), userID, req.ActivityID)
	if err != nil {
		global.GVA_LOG.Error("活动报名失败!", zap.Error(err))
		response.FailWithMessage("活动报名失败: "+err.Error(), c)
		return
	}

	// 生成订单号
	orderNo := utils.GenerateOrderNumber()

	// 创建订单记录
	amount := int(*activity.Price * 100) // 转换为分
	order := system.Order{
		OrderNo:       orderNo,
		UserID:        userID,
		ActivityID:    &req.ActivityID,       // 设置活动ID
		Amount:        float64(amount) / 100, // 转换回元
		ActualAmount:  float64(amount) / 100, // 转换回元
		Status:        "pending",             // 待支付
		PaymentMethod: "wechat",              // 微信支付
		OrderType:     "activity",            // 订单类型为活动
		ReferenceID:   &registration.ID,      // 关联报名记录ID
	}

	err = global.GVA_DB.Create(&order).Error
	if err != nil {
		global.GVA_LOG.Error("创建订单失败!", zap.Error(err))
		response.FailWithMessage("创建订单失败: "+err.Error(), c)
		return
	}

	// 获取客户端IP
	clientIP := getClientIP(c)

	// 配置微信支付参数
	wxPayConfig := utils.WechatPayConfig{
		AppID:     global.GVA_CONFIG.System.WxAppID,                                   // 微信小程序AppID
		MchID:     global.GVA_CONFIG.System.WxMchID,                                   // 微信支付商户号
		APIKey:    global.GVA_CONFIG.System.WxAPIKey,                                  // 微信支付API密钥
		NotifyURL: getServerURL(c) + "/api/wx/Activities/payment-callback/" + orderNo, // 支付回调地址
	}

	// 调用微信统一下单接口
	unifiedOrderResp, err := utils.CreateUnifiedOrder(
		wxPayConfig,
		*activity.ActivityName, // 商品描述
		orderNo,                // 商户订单号
		amount,                 // 总金额(分)
		clientIP,               // 终端IP
		"JSAPI",                // 交易类型
	)
	if err != nil {
		global.GVA_LOG.Error("调用微信统一下单接口失败!", zap.Error(err))
		response.FailWithMessage("调用微信支付失败: "+err.Error(), c)
		return
	}

	// 生成前端支付参数
	payParams := utils.GenerateWechatPayParams(wxPayConfig, unifiedOrderResp.PrepayID)

	responseData := WxCreateActivityOrderResponse{
		RegistrationID: registration.ID,
		AppID:          payParams.AppID,
		TimeStamp:      payParams.TimeStamp,
		NonceStr:       payParams.NonceStr,
		Package:        payParams.Package,
		SignType:       payParams.SignType,
		PaySign:        payParams.PaySign,
		Amount:         amount,
		OrderNo:        orderNo,
	}

	global.GVA_LOG.Info("活动支付订单创建成功",
		zap.Uint("userID", userID),
		zap.Uint("activityID", req.ActivityID),
		zap.String("orderNo", orderNo),
		zap.Int("amount", amount))
	response.OkWithDetailed(responseData, "订单创建成功，请调用支付接口完成支付", c)
}

// WxActivityPaymentCallback 活动支付回调
// @Tags     WechatApi
// @Summary  活动支付回调
// @Description 支付成功后的回调处理，更新报名状态
// @Accept   application/json
// @Produce  application/json
// @Param    orderNo  path      string  true  "订单编号"
// @Success  200   {object}  response.Response{msg=string}  "支付处理成功"
// @Failure  400   {object}  response.Response{msg=string}  "请求参数错误"
// @Failure  500   {object}  response.Response{msg=string}  "服务器内部错误"
// @Router   /api/wx/Activities/payment-callback/{orderNo} [post]
func (w *WechatActivityApi) WxActivityPaymentCallback(c *gin.Context) {
	orderNo := c.Param("orderNo")
	if orderNo == "" {
		global.GVA_LOG.Error("订单编号不能为空")
		response.FailWithMessage("订单编号不能为空", c)
		return
	}

	// 查找订单
	var order system.Order
	err := global.GVA_DB.Where("order_no = ?", orderNo).First(&order).Error
	if err != nil {
		global.GVA_LOG.Error("订单不存在!", zap.String("orderNo", orderNo), zap.Error(err))
		response.FailWithMessage("订单不存在: "+err.Error(), c)
		return
	}

	// 检查订单状态
	if order.Status == "paid" {
		global.GVA_LOG.Info("订单已处理", zap.String("orderNo", orderNo))
		response.OkWithMessage("订单已处理", c)
		return
	}

	// 更新订单状态为已支付
	now := time.Now().Unix()
	updateData := map[string]interface{}{
		"status":       "paid",
		"payment_time": &now,
	}

	err = global.GVA_DB.Model(&system.Order{}).Where("order_no = ?", orderNo).Updates(updateData).Error
	if err != nil {
		global.GVA_LOG.Error("更新订单状态失败!", zap.String("orderNo", orderNo), zap.Error(err))
		response.FailWithMessage("更新订单状态失败: "+err.Error(), c)
		return
	}

	// 获取关联的报名记录ID
	if order.ReferenceID == nil {
		global.GVA_LOG.Error("订单关联的报名记录ID为空!", zap.String("orderNo", orderNo))
		response.FailWithMessage("订单数据异常", c)
		return
	}

	registrationID := *order.ReferenceID

	// 更新报名记录的支付状态
	err = activityRegistrationService.UpdatePaymentStatus(c.Request.Context(), registrationID, "paid", order.UserID)
	if err != nil {
		global.GVA_LOG.Error("更新报名支付状态失败!", zap.Uint("registrationID", registrationID), zap.Error(err))
		response.FailWithMessage("更新报名状态失败: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("活动报名支付成功",
		zap.Uint("userID", order.UserID),
		zap.String("orderNo", orderNo),
		zap.Uint("registrationID", registrationID))
	response.OkWithMessage("支付处理成功", c)
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

// WxGetUserRegisteredActivities 获取用户已报名的活动列表
// @Tags     WechatApi
// @Summary  获取用户已报名的活动列表
// @Description 获取当前用户已报名的活动列表，需要登录鉴权
// @Accept   application/json
// @Produce  application/json
// @Param    page           query     int                                                    false  "页码，默认为1"
// @Param    pageSize       query     int                                                    false  "每页数量，默认为10"
// @Param    paymentStatus  query     string                                                 false  "支付状态筛选: pending-待支付, paid-已支付, cancelled-已取消"
// @Param    startTimeRange query     string                                                 false  "开始时间范围筛选: week-最近一周, month-最近一月, quarter-最近三月, halfYear-最近半年"
// @Success  200        {object}  response.Response{data=WxUserRegisteredActivitiesResponse,msg=string}  "获取成功"
// @Failure  400        {object}  response.Response{msg=string}                          "请求参数错误"
// @Failure  401        {object}  response.Response{msg=string}                          "未登录或登录已过期"
// @Failure  500        {object}  response.Response{msg=string}                          "服务器内部错误"
// @Router   /api/wx/Activities/registered [get]
func (w *WechatActivityApi) WxGetUserRegisteredActivities(c *gin.Context) {
	// 获取当前用户ID
	userID := utils.GetUserID(c)

	// 获取查询参数
	pageStr := c.DefaultQuery("page", "1")
	page, err := strconv.Atoi(pageStr)
	if err != nil || page < 1 {
		page = 1
	}

	pageSizeStr := c.DefaultQuery("pageSize", "10")
	pageSize, err := strconv.Atoi(pageSizeStr)
	if err != nil || pageSize < 1 || pageSize > 100 {
		pageSize = 10
	}

	// 获取筛选参数
	paymentStatus := c.Query("paymentStatus")
	verificationStatus := c.Query("verificationStatus")
	startTimeRange := c.Query("startTimeRange")

	global.GVA_LOG.Info("获取用户已报名活动列表",
		zap.Uint("userID", userID),
		zap.Int("page", page),
		zap.Int("pageSize", pageSize),
		zap.String("paymentStatus", paymentStatus),
		zap.String("verificationStatus", verificationStatus),
		zap.String("startTimeRange", startTimeRange))

	// 构造查询条件
	searchReq := systemReq.ActivityRegistrationSearch{
		UserID: &userID,
		PageInfo: request.PageInfo{
			Page:     page,
			PageSize: pageSize,
		},
		Sort:  "created_at",
		Order: "descending",
	}

	// 添加支付状态筛选
	if paymentStatus != "" {
		searchReq.PaymentStatus = &paymentStatus
	}

	if verificationStatus != "" {
		searchReq.VerificationStatus = &verificationStatus
	}

	// 调用service获取用户已报名的活动
	registrations, total, err := activityRegistrationService.GetActivityRegistrationInfoList(c.Request.Context(), searchReq)
	if err != nil {
		global.GVA_LOG.Error("获取用户已报名活动列表失败!", zap.Error(err))
		response.FailWithMessage("获取用户已报名活动列表失败: "+err.Error(), c)
		return
	}

	// 获取活动ID列表
	activityIDs := make([]uint, 0, len(registrations))
	for _, registration := range registrations {
		activityIDs = append(activityIDs, registration.ActivityID)
	}

	// 获取活动详情
	activities := make([]system.Activities, 0)
	if len(activityIDs) > 0 {
		db := global.GVA_DB.Where("id IN ?", activityIDs)

		// 添加时间范围筛选到活动查询
		if startTimeRange != "" {
			now := time.Now()
			var startTime time.Time
			switch startTimeRange {
			case "week":
				startTime = now.AddDate(0, 0, -7)
			case "month":
				startTime = now.AddDate(0, -1, 0)
			case "quarter":
				startTime = now.AddDate(0, -3, 0)
			case "halfYear":
				startTime = now.AddDate(0, -6, 0)
			default:
				startTime = now.AddDate(0, 0, -7) // 默认最近一周
			}
			db = db.Where("start_time >= ?", startTime)
		}

		// 按开始时间接近现在排序（升序）
		db = db.Order("start_time ASC")

		err = db.Find(&activities).Error
		if err != nil {
			global.GVA_LOG.Error("获取活动详情失败!", zap.Error(err))
			response.FailWithMessage("获取活动详情失败: "+err.Error(), c)
			return
		}
	}

	// 构建活动ID到活动详情的映射
	activityMap := make(map[uint]system.Activities)
	for _, activity := range activities {
		activityMap[activity.ID] = activity
	}

	// 转换为微信接口响应格式
	wxActivities := make([]WxUserRegisteredActivityItem, 0, len(registrations))
	for _, registration := range registrations {
		// 获取对应的活动详情
		activity, exists := activityMap[registration.ActivityID]
		if !exists {
			continue // 如果活动不存在，跳过该报名记录
		}

		// 构建活动项
		wxActivity := WxUserRegisteredActivityItem{
			ID:                 activity.ID,
			ActivityName:       "",
			Price:              0,
			Category:           0,
			CoverPicture:       "",
			ActualEnrollment:   0,
			RealEnrollment:     0,
			SortOrder:          0,
			StartTime:          "",
			EndTime:            "",
			ShowStartTime:      "",
			ShowEndTime:        "",
			RegistrationType:   "",
			OrderNumber:        "", // 订单编号需要从订单表获取
			RegistrationID:     registration.ID,
			VerificationCode:   registration.VerificationCode,
			VerificationStatus: "", // 初始化核销状态
			PaymentStatus:      registration.PaymentStatus,
			ParticipantName:    "",
			ParticipantPhone:   "",
			CreatedAt:          registration.CreatedAt.Format("2006-01-02 15:04:05"),
		}

		// 安全地获取活动指针值
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
		if activity.RealEnrollment != nil {
			wxActivity.RealEnrollment = *activity.RealEnrollment
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
		if activity.RegistrationType != nil {
			wxActivity.RegistrationType = *activity.RegistrationType
		}

		// 安全地获取报名记录指针值
		if registration.ParticipantName != nil {
			wxActivity.ParticipantName = *registration.ParticipantName
		}
		if registration.ParticipantPhone != nil {
			wxActivity.ParticipantPhone = *registration.ParticipantPhone
		}
		// 安全地获取核销状态
		if registration.VerificationStatus != "" {
			wxActivity.VerificationStatus = registration.VerificationStatus
		} else {
			// 默认核销状态为pending
			wxActivity.VerificationStatus = "pending"
		}

		// 获取订单编号
		if registration.ID > 0 {
			var order system.Order
			err = global.GVA_DB.Where("reference_id = ? AND order_type = ?", registration.ID, "activity").First(&order).Error
			if err == nil {
				wxActivity.OrderNumber = order.OrderNo
			}
		}

		wxActivities = append(wxActivities, wxActivity)
	}

	// 构建响应数据
	wxActivityResponse := WxUserRegisteredActivitiesResponse{
		Activities: wxActivities,
		Total:      total,
		Page:       page,
		PageSize:   pageSize,
	}

	global.GVA_LOG.Info("用户已报名活动列表获取成功",
		zap.Uint("userID", userID),
		zap.Int("count", len(wxActivities)),
		zap.Int64("total", total))
	response.OkWithDetailed(wxActivityResponse, "获取成功", c)
}
