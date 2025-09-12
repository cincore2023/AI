// 自动生成模板SiteConfig
package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
)

// 站点配置 结构体  SiteConfig
type SiteConfig struct {
	global.GVA_MODEL
	ConfigKey   string `json:"configKey" form:"configKey" gorm:"comment:配置键;column:config_key;uniqueIndex;not null;" binding:"required"`     // 配置键
	ConfigValue string `json:"configValue" form:"configValue" gorm:"comment:配置值;column:config_value;type:text;not null;" binding:"required"` // 配置值
	ConfigName  string `json:"configName" form:"configName" gorm:"comment:配置名称;column:config_name;not null;" binding:"required"`             // 配置名称
	ConfigType  string `json:"configType" form:"configType" gorm:"comment:配置类型;column:config_type;default:string;not null;"`                 // 配置类型: string, number, boolean, json
	IsSystem    bool   `json:"isSystem" form:"isSystem" gorm:"comment:是否系统配置;column:is_system;default:false;"`                               // 是否系统配置
	Remark      string `json:"remark" form:"remark" gorm:"comment:备注;column:remark;type:text;"`                                              // 备注
	CreatedBy   uint   `gorm:"column:created_by;comment:创建者"`
	UpdatedBy   uint   `gorm:"column:updated_by;comment:更新者"`
	DeletedBy   uint   `gorm:"column:deleted_by;comment:删除者"`
}

// TableName 站点配置 SiteConfig自定义表名 site_configs
func (SiteConfig) TableName() string {
	return "site_configs"
}
