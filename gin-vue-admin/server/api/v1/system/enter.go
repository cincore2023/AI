package system

import "github.com/flipped-aurora/gin-vue-admin/server/service"

type ApiGroup struct {
	DBApi
	JwtApi
	BaseApi
	SystemApi
	CasbinApi
	AutoCodeApi
	SystemApiApi
	AuthorityApi
	DictionaryApi
	AuthorityMenuApi
	OperationRecordApi
	DictionaryDetailApi
	AuthorityBtnApi
	SysExportTemplateApi
	AutoCodePluginApi
	AutoCodePackageApi
	AutoCodeHistoryApi
	AutoCodeTemplateApi
	SysParamsApi
	CategoryApi
	PosterApi
	BannerApi
	TeacherApi
	BenefitApi
	CourseApi
	WechatUserApi
	CodeApi
	ActivitiesApi
}

var (
	apiService              = service.ServiceGroupApp.SystemServiceGroup.ApiService
	jwtService              = service.ServiceGroupApp.SystemServiceGroup.JwtService
	menuService             = service.ServiceGroupApp.SystemServiceGroup.MenuService
	userService             = service.ServiceGroupApp.SystemServiceGroup.UserService
	initDBService           = service.ServiceGroupApp.SystemServiceGroup.InitDBService
	casbinService           = service.ServiceGroupApp.SystemServiceGroup.CasbinService
	baseMenuService         = service.ServiceGroupApp.SystemServiceGroup.BaseMenuService
	authorityService        = service.ServiceGroupApp.SystemServiceGroup.AuthorityService
	dictionaryService       = service.ServiceGroupApp.SystemServiceGroup.DictionaryService
	authorityBtnService     = service.ServiceGroupApp.SystemServiceGroup.AuthorityBtnService
	systemConfigService     = service.ServiceGroupApp.SystemServiceGroup.SystemConfigService
	sysParamsService        = service.ServiceGroupApp.SystemServiceGroup.SysParamsService
	operationRecordService  = service.ServiceGroupApp.SystemServiceGroup.OperationRecordService
	dictionaryDetailService = service.ServiceGroupApp.SystemServiceGroup.DictionaryDetailService
	autoCodeService         = service.ServiceGroupApp.SystemServiceGroup.AutoCodeService
	autoCodePluginService   = service.ServiceGroupApp.SystemServiceGroup.AutoCodePlugin
	autoCodePackageService  = service.ServiceGroupApp.SystemServiceGroup.AutoCodePackage
	autoCodeHistoryService  = service.ServiceGroupApp.SystemServiceGroup.AutoCodeHistory
	autoCodeTemplateService = service.ServiceGroupApp.SystemServiceGroup.AutoCodeTemplate
	categoryService         = service.ServiceGroupApp.SystemServiceGroup.CategoryService
	posterService           = service.ServiceGroupApp.SystemServiceGroup.PosterService
	bannerService           = service.ServiceGroupApp.SystemServiceGroup.BannerService
	teacherService          = service.ServiceGroupApp.SystemServiceGroup.TeacherService
	benefitService          = service.ServiceGroupApp.SystemServiceGroup.BenefitService
	courseService           = service.ServiceGroupApp.SystemServiceGroup.CourseService
	wxUserService           = service.ServiceGroupApp.SystemServiceGroup.WechatUserService
	codeService             = service.ServiceGroupApp.SystemServiceGroup.CodeService
	activitiesService       = service.ServiceGroupApp.SystemServiceGroup.ActivitiesService
)
