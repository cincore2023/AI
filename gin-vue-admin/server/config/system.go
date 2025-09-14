package config

type System struct {
	DbType        string `mapstructure:"db-type" json:"db-type" yaml:"db-type"`    // 数据库类型:mysql(默认)|sqlite|sqlserver|postgresql
	OssType       string `mapstructure:"oss-type" json:"oss-type" yaml:"oss-type"` // Oss类型
	RouterPrefix  string `mapstructure:"router-prefix" json:"router-prefix" yaml:"router-prefix"`
	Addr          int    `mapstructure:"addr" json:"addr" yaml:"addr"` // 端口值
	LimitCountIP  int    `mapstructure:"iplimit-count" json:"iplimit-count" yaml:"iplimit-count"`
	LimitTimeIP   int    `mapstructure:"iplimit-time" json:"iplimit-time" yaml:"iplimit-time"`
	UseMultipoint bool   `mapstructure:"use-multipoint" json:"use-multipoint" yaml:"use-multipoint"`    // 多点登录拦截
	UseRedis      bool   `mapstructure:"use-redis" json:"use-redis" yaml:"use-redis"`                   // 使用redis
	UseMongo      bool   `mapstructure:"use-mongo" json:"use-mongo" yaml:"use-mongo"`                   // 使用mongo
	UseStrictAuth bool   `mapstructure:"use-strict-auth" json:"use-strict-auth" yaml:"use-strict-auth"` // 使用树形角色分配模式
	WxAppID       string `mapstructure:"wx-app-id" json:"wx-app-id" yaml:"wx-app-id"`                   // 微信小程序AppID
	WxAppSecret   string `mapstructure:"wx-app-secret" json:"wx-app-secret" yaml:"wx-app-secret"`       // 微信小程序AppSecret
	WxMchID       string `mapstructure:"wx-mch-id" json:"wx-mch-id" yaml:"wx-mch-id"`                   // 微信支付商户号
	WxAPIKey      string `mapstructure:"wx-api-key" json:"wx-api-key" yaml:"wx-api-key"`                // 微信支付API密钥
}
