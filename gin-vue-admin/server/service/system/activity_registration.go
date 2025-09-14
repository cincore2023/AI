package system

import (
	"context"
	"errors"
	"fmt"
	"math/rand"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type ActivityRegistrationService struct{}

// CreateActivityRegistration 创建活动报名记录
func (activityRegistrationService *ActivityRegistrationService) CreateActivityRegistration(ctx context.Context, activityRegistration *system.ActivityRegistration) (err error) {
	err = global.GVA_DB.Create(activityRegistration).Error
	return err
}

// GetActivityRegistration 根据ID获取活动报名记录
func (activityRegistrationService *ActivityRegistrationService) GetActivityRegistration(ctx context.Context, ID string) (activityRegistration system.ActivityRegistration, err error) {
	err = global.GVA_DB.Where("id = ?", ID).First(&activityRegistration).Error
	return
}

// GetActivityRegistrationByUserAndActivity 根据用户ID和活动ID获取活动报名记录
func (activityRegistrationService *ActivityRegistrationService) GetActivityRegistrationByUserAndActivity(ctx context.Context, userID, activityID uint) (activityRegistration system.ActivityRegistration, err error) {
	err = global.GVA_DB.Where("user_id = ? AND activity_id = ?", userID, activityID).First(&activityRegistration).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		// 如果没有找到记录，返回空结构体和nil错误
		return system.ActivityRegistration{}, nil
	}
	return
}

// GetActivityRegistrationInfoList 分页获取活动报名记录
func (activityRegistrationService *ActivityRegistrationService) GetActivityRegistrationInfoList(ctx context.Context, info systemReq.ActivityRegistrationSearch) (list []system.ActivityRegistration, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	// 创建db
	db := global.GVA_DB.Model(&system.ActivityRegistration{})
	var activityRegistrations []system.ActivityRegistration
	// 如果有条件搜索 下方会自动创建搜索语句
	if len(info.CreatedAtRange) == 2 {
		db = db.Where("created_at BETWEEN ? AND ?", info.CreatedAtRange[0], info.CreatedAtRange[1])
	}
	if info.UserID != nil {
		db = db.Where("user_id = ?", *info.UserID)
	}
	if info.ActivityID != nil {
		db = db.Where("activity_id = ?", *info.ActivityID)
	}
	if info.PaymentStatus != nil && *info.PaymentStatus != "" {
		db = db.Where("payment_status = ?", *info.PaymentStatus)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	var OrderStr string
	orderMap := make(map[string]bool)
	orderMap["id"] = true
	orderMap["created_at"] = true
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

	err = db.Find(&activityRegistrations).Error
	return activityRegistrations, total, err
}

// GenerateVerificationCode 生成唯一的核销码
func (activityRegistrationService *ActivityRegistrationService) GenerateVerificationCode() string {
	// 生成12位随机字符串作为核销码
	const charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	const length = 12
	rand.Seed(time.Now().UnixNano())

	// 重试机制，确保生成的核销码唯一
	for i := 0; i < 3; i++ {
		b := make([]byte, length)
		for j := range b {
			b[j] = charset[rand.Intn(len(charset))]
		}
		code := string(b)

		// 检查数据库中是否已存在该核销码
		var count int64
		global.GVA_DB.Model(&system.ActivityRegistration{}).Where("verification_code = ?", code).Count(&count)
		if count == 0 {
			return code
		}
	}

	// 如果重试3次 still 有重复，使用时间戳+随机数确保唯一性
	timestamp := time.Now().UnixNano()
	random := rand.Intn(999999)
	return fmt.Sprintf("%012d%06d", timestamp%1000000000000, random%1000000)[:12]
}

// RegisterForActivity 用户报名活动
func (activityRegistrationService *ActivityRegistrationService) RegisterForActivity(ctx context.Context, userID, activityID uint) (*system.ActivityRegistration, error) {
	// 检查用户是否已经报名过该活动
	existingRegistration, err := activityRegistrationService.GetActivityRegistrationByUserAndActivity(ctx, userID, activityID)
	if err != nil {
		return nil, err
	}

	// 如果已经存在报名记录且已支付，返回现有记录
	if existingRegistration.ID != 0 && existingRegistration.PaymentStatus == "paid" {
		return &existingRegistration, nil
	}

	// 获取活动信息以获取报名方式
	var activity system.Activities
	err = global.GVA_DB.Where("id = ?", activityID).First(&activity).Error
	if err != nil {
		return nil, fmt.Errorf("获取活动信息失败: %v", err)
	}

	// 确定报名方式，默认为paid
	registrationType := "paid"
	if activity.RegistrationType != nil && *activity.RegistrationType != "" {
		registrationType = *activity.RegistrationType
	}

	// 如果存在未支付的记录，更新它
	if existingRegistration.ID != 0 {
		// 生成新的核销码
		verificationCode := activityRegistrationService.GenerateVerificationCode()
		updateData := map[string]interface{}{
			"verification_code": verificationCode,
			"registration_type": registrationType, // 更新报名方式
			"updated_by":        userID,
			"updated_at":        time.Now(),
		}

		err = global.GVA_DB.Model(&system.ActivityRegistration{}).Where("id = ?", existingRegistration.ID).Updates(updateData).Error
		if err != nil {
			return nil, err
		}

		// 重新查询更新后的记录
		updatedRegistration, err := activityRegistrationService.GetActivityRegistration(ctx, fmt.Sprintf("%d", existingRegistration.ID))
		if err != nil {
			return nil, err
		}

		return &updatedRegistration, nil
	}

	// 创建新的报名记录
	verificationCode := activityRegistrationService.GenerateVerificationCode()
	newRegistration := &system.ActivityRegistration{
		UserID:           userID,
		ActivityID:       activityID,
		RegistrationType: &registrationType, // 设置报名方式
		VerificationCode: verificationCode,
		PaymentStatus:    "pending", // 初始状态为待支付
		CreatedBy:        userID,
		UpdatedBy:        userID,
	}

	err = global.GVA_DB.Create(newRegistration).Error
	if err != nil {
		return nil, err
	}

	global.GVA_LOG.Info("用户报名活动",
		zap.Uint("userID", userID),
		zap.Uint("activityID", activityID),
		zap.String("verificationCode", verificationCode),
		zap.String("registrationType", registrationType))

	return newRegistration, nil
}

// PartnerRedemptionCode 合伙人使用兑换码报名活动
func (activityRegistrationService *ActivityRegistrationService) PartnerRedemptionCode(ctx context.Context, userID, activityID uint, redemptionCode string) (*system.ActivityRegistration, error) {
	// 检查用户是否已经报名过该活动
	existingRegistration, err := activityRegistrationService.GetActivityRegistrationByUserAndActivity(ctx, userID, activityID)
	if err != nil {
		return nil, err
	}

	// 如果已经存在报名记录且已支付，返回现有记录
	if existingRegistration.ID != 0 && existingRegistration.PaymentStatus == "paid" {
		return &existingRegistration, nil
	}

	// 获取活动信息以获取报名方式
	var activity system.Activities
	err = global.GVA_DB.Where("id = ?", activityID).First(&activity).Error
	if err != nil {
		return nil, fmt.Errorf("获取活动信息失败: %v", err)
	}

	// 检查活动报名方式是否为兑换码报名
	if activity.RegistrationType == nil || *activity.RegistrationType != "code" {
		return nil, fmt.Errorf("该活动不支持兑换码报名")
	}

	// 获取用户信息
	var user system.WechatUser
	err = global.GVA_DB.Where("id = ?", userID).First(&user).Error
	if err != nil {
		return nil, fmt.Errorf("获取用户信息失败: %v", err)
	}

	// 确定报名方式，默认为code
	registrationType := "code"
	if activity.RegistrationType != nil && *activity.RegistrationType != "" {
		registrationType = *activity.RegistrationType
	}

	// 如果存在未支付的记录，更新它
	if existingRegistration.ID != 0 {
		// 生成新的核销码
		verificationCode := activityRegistrationService.GenerateVerificationCode()
		updateData := map[string]interface{}{
			"verification_code": verificationCode,
			"registration_type": registrationType,
			"payment_status":    "paid", // 兑换码直接设置为已支付
			"payment_time":      time.Now(),
			"updated_by":        userID,
			"updated_at":        time.Now(),
		}

		// 自动填充参与者信息
		if user.Nickname != nil {
			updateData["participant_name"] = *user.Nickname
		}
		if user.PhoneNumber != nil {
			updateData["participant_phone"] = *user.PhoneNumber
		}

		err = global.GVA_DB.Model(&system.ActivityRegistration{}).Where("id = ?", existingRegistration.ID).Updates(updateData).Error
		if err != nil {
			return nil, err
		}

		// 重新查询更新后的记录
		updatedRegistration, err := activityRegistrationService.GetActivityRegistration(ctx, fmt.Sprintf("%d", existingRegistration.ID))
		if err != nil {
			return nil, err
		}

		return &updatedRegistration, nil
	}

	// 创建新的报名记录
	verificationCode := activityRegistrationService.GenerateVerificationCode()
	newRegistration := &system.ActivityRegistration{
		UserID:           userID,
		ActivityID:       activityID,
		RegistrationType: &registrationType,
		VerificationCode: verificationCode,
		PaymentStatus:    "paid", // 兑换码直接设置为已支付
		PaymentTime:      &[]time.Time{time.Now()}[0],
		CreatedBy:        userID,
		UpdatedBy:        userID,
	}

	// 自动填充参与者信息
	if user.Nickname != nil {
		newRegistration.ParticipantName = user.Nickname
	}
	if user.PhoneNumber != nil {
		newRegistration.ParticipantPhone = user.PhoneNumber
	}

	err = global.GVA_DB.Create(newRegistration).Error
	if err != nil {
		return nil, err
	}

	global.GVA_LOG.Info("合伙人兑换码报名活动",
		zap.Uint("userID", userID),
		zap.Uint("activityID", activityID),
		zap.String("verificationCode", verificationCode),
		zap.String("registrationType", registrationType))

	return newRegistration, nil
}

// UpdateParticipantInfo 更新参与者信息
func (activityRegistrationService *ActivityRegistrationService) UpdateParticipantInfo(ctx context.Context, registrationID uint, name, phone string, userID uint) error {
	updateData := map[string]interface{}{
		"participant_name":  name,
		"participant_phone": phone,
		"updated_by":        userID,
		"updated_at":        time.Now(),
	}

	err := global.GVA_DB.Model(&system.ActivityRegistration{}).Where("id = ?", registrationID).Updates(updateData).Error
	if err != nil {
		return err
	}

	global.GVA_LOG.Info("更新参与者信息",
		zap.Uint("registrationID", registrationID),
		zap.String("name", name),
		zap.String("phone", phone))

	return nil
}

// UpdatePaymentStatus 更新支付状态
func (activityRegistrationService *ActivityRegistrationService) UpdatePaymentStatus(ctx context.Context, registrationID uint, status string, userID uint) error {
	updateData := map[string]interface{}{
		"payment_status": status,
		"updated_by":     userID,
		"updated_at":     time.Now(),
	}

	// 如果是支付成功，设置支付时间
	if status == "paid" {
		now := time.Now()
		updateData["payment_time"] = &now
	}

	err := global.GVA_DB.Model(&system.ActivityRegistration{}).Where("id = ?", registrationID).Updates(updateData).Error
	if err != nil {
		return err
	}

	global.GVA_LOG.Info("更新支付状态",
		zap.Uint("registrationID", registrationID),
		zap.String("status", status))

	return nil
}
