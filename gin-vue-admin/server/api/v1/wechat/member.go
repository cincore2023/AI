package wechat

import (
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type WechatMemberApi struct{}

// OpenMemberRequest 开通会员请求参数
type OpenMemberRequest struct {
	// 无需参数，会员档位和金额由后端固定
}

// OpenMemberResponse 开通会员响应
type OpenMemberResponse struct {
	OrderNo string  `json:"orderNo"` // 订单编号
	Amount  float64 `json:"amount"`  // 支付金额
}

// OpenMember 开通会员
// @Tags     WechatMemberApi
// @Summary  开通会员
// @Description 用户开通会员接口，创建订单并返回支付信息
// @Accept   application/json
// @Produce  application/json
// @Success  200   {object}  response.Response{data=OpenMemberResponse,msg=string}  "返回订单信息用于支付"
// @Failure  400   {object}  response.Response{msg=string}                         "请求参数错误"
// @Failure  401   {object}  response.Response{msg=string}                         "未登录或登录已过期"
// @Failure  500   {object}  response.Response{msg=string}                         "服务器内部错误"
// @Router   /api/wx/member/open [post]
func (w *WechatMemberApi) OpenMember(c *gin.Context) {
	// 获取当前用户ID
	userID := utils.GetUserID(c)
	if userID == 0 {
		global.GVA_LOG.Error("获取用户信息失败")
		response.FailWithMessage("获取用户信息失败", c)
		return
	}

	// 获取用户详细信息
	var wxUser system.WechatUser
	err := global.GVA_DB.Where("id = ?", userID).First(&wxUser).Error
	if err != nil {
		global.GVA_LOG.Error("获取用户信息失败!", zap.Error(err))
		response.FailWithMessage("获取用户信息失败: "+err.Error(), c)
		return
	}

	// 创建订单
	orderNo := utils.GenerateOrderNumber() // 生成订单号
	amount := 199.0                        // 固定会员费用199元，可根据需求调整

	// 创建订单记录（简化实现，实际应包含更多订单信息）
	order := system.Order{
		OrderNo:       orderNo,
		UserID:        userID,
		Amount:        amount,
		ActualAmount:  amount,
		Status:        "pending", // 待支付
		PaymentMethod: "wechat",  // 微信支付
	}

	err = global.GVA_DB.Create(&order).Error
	if err != nil {
		global.GVA_LOG.Error("创建订单失败!", zap.Error(err))
		response.FailWithMessage("创建订单失败: "+err.Error(), c)
		return
	}

	// 返回订单信息，前端根据此信息调用支付接口
	responseData := OpenMemberResponse{
		OrderNo: orderNo,
		Amount:  amount,
	}

	global.GVA_LOG.Info("会员开通订单创建成功", zap.Uint("userID", userID), zap.String("orderNo", orderNo), zap.Float64("amount", amount))
	response.OkWithDetailed(responseData, "订单创建成功，请调用支付接口完成支付", c)
}

// MemberPaymentCallback 会员支付回调
// @Tags     WechatMemberApi
// @Summary  会员支付回调
// @Description 支付成功后的回调处理，更新用户会员状态
// @Accept   application/json
// @Produce  application/json
// @Param    orderNo  path      string  true  "订单编号"
// @Success  200   {object}  response.Response{msg=string}  "支付处理成功"
// @Failure  400   {object}  response.Response{msg=string}  "请求参数错误"
// @Failure  500   {object}  response.Response{msg=string}  "服务器内部错误"
// @Router   /api/wx/member/callback/{orderNo} [post]
func (w *WechatMemberApi) MemberPaymentCallback(c *gin.Context) {
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
	updateData := map[string]interface{}{
		"status":       "paid",
		"payment_time": time.Now().Unix(),
	}

	err = global.GVA_DB.Model(&system.Order{}).Where("order_no = ?", orderNo).Updates(updateData).Error
	if err != nil {
		global.GVA_LOG.Error("更新订单状态失败!", zap.String("orderNo", orderNo), zap.Error(err))
		response.FailWithMessage("更新订单状态失败: "+err.Error(), c)
		return
	}

	// 更新用户会员过期时间（默认开通一年）
	expiryDate := time.Now().AddDate(1, 0, 0) // 一年后
	updateUserData := map[string]interface{}{
		"membership_expiry_date": &expiryDate,
		"updated_by":             order.UserID,
	}

	err = global.GVA_DB.Model(&system.WechatUser{}).Where("id = ?", order.UserID).Updates(updateUserData).Error
	if err != nil {
		global.GVA_LOG.Error("更新用户会员状态失败!", zap.Uint("userID", order.UserID), zap.Error(err))
		response.FailWithMessage("更新用户会员状态失败: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("会员开通成功", zap.Uint("userID", order.UserID), zap.String("orderNo", orderNo))
	response.OkWithMessage("会员开通成功", c)
}
