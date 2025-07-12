package system

import (
	"context"
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
)

type CodeService struct{}

// CreateCode 创建兑换码明细记录
// Author [yourname](https://github.com/yourname)
func (codeService *CodeService) CreateCode(ctx context.Context, code *system.Code) (err error) {
	err = global.GVA_DB.Create(code).Error
	return err
}

// DeleteCode 删除兑换码明细记录
// Author [yourname](https://github.com/yourname)
func (codeService *CodeService) DeleteCode(ctx context.Context, ID string) (err error) {
	err = global.GVA_DB.Delete(&system.Code{}, "id = ?", ID).Error
	return err
}

// DeleteCodeByIds 批量删除兑换码明细记录
// Author [yourname](https://github.com/yourname)
func (codeService *CodeService) DeleteCodeByIds(ctx context.Context, IDs []string) (err error) {
	err = global.GVA_DB.Delete(&[]system.Code{}, "id in ?", IDs).Error
	return err
}

// UpdateCode 更新兑换码明细记录
// Author [yourname](https://github.com/yourname)
func (codeService *CodeService) UpdateCode(ctx context.Context, code system.Code) (err error) {
	err = global.GVA_DB.Model(&system.Code{}).Where("id = ?", code.ID).Updates(&code).Error
	return err
}

// GetCode 根据ID获取兑换码明细记录
// Author [yourname](https://github.com/yourname)
func (codeService *CodeService) GetCode(ctx context.Context, ID string) (code system.Code, err error) {
	err = global.GVA_DB.Where("id = ?", ID).First(&code).Error
	return
}

// GetCodeInfoList 分页获取兑换码明细记录
// Author [yourname](https://github.com/yourname)
func (codeService *CodeService) GetCodeInfoList(ctx context.Context, info systemReq.CodeSearch) (list []system.Code, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	// 创建db
	db := global.GVA_DB.Model(&system.Code{})
	var codes []system.Code
	// 如果有条件搜索 下方会自动创建搜索语句
	if len(info.CreatedAtRange) == 2 {
		db = db.Where("created_at BETWEEN ? AND ?", info.CreatedAtRange[0], info.CreatedAtRange[1])
	}

	err = db.Count(&total).Error
	if err != nil {
		return
	}
	var OrderStr string
	orderMap := make(map[string]bool)
	orderMap["id"] = true
	orderMap["created_at"] = true
	orderMap["quantity"] = true
	orderMap["remaining_quantity"] = true
	orderMap["transaction_time"] = true
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

	err = db.Find(&codes).Error
	return codes, total, err
}
func (codeService *CodeService) GetCodePublic(ctx context.Context) {
	// 此方法为获取数据源定义的数据
	// 请自行实现
}
