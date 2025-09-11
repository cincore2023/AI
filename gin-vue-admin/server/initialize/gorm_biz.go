package initialize

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
)

func bizModel() error {
	db := global.GVA_DB
	err := db.AutoMigrate(system.Category{}, system.Poster{}, system.Banner{}, system.Teacher{}, system.Benefit{}, system.Course{}, system.WechatUser{}, system.Code{}, system.Activities{}, system.CourseFavorite{})
	if err != nil {
		return err
	}
	return nil
}
