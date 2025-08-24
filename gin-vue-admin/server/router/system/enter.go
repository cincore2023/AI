package system

import api "github.com/flipped-aurora/gin-vue-admin/server/api/v1"

type RouterGroup struct {
	ApiRouter
	JwtRouter
	SysRouter
	BaseRouter
	InitRouter
	MenuRouter
	UserRouter
	CasbinRouter
	AutoCodeRouter
	AuthorityRouter
	DictionaryRouter
	OperationRecordRouter
	DictionaryDetailRouter
	AuthorityBtnRouter
	SysExportTemplateRouter
	SysParamsRouter
	CategoryRouter
	PosterRouter
	BannerRouter
	TeacherRouter
	BenefitRouter
	CourseRouter
	WechatUserRouter
	WechatRouter
	CodeRouter
	ActivitiesRouter
}

var (
	dbApi               = api.ApiGroupApp.SystemApiGroup.DBApi
	jwtApi              = api.ApiGroupApp.SystemApiGroup.JwtApi
	baseApi             = api.ApiGroupApp.SystemApiGroup.BaseApi
	casbinApi           = api.ApiGroupApp.SystemApiGroup.CasbinApi
	systemApi           = api.ApiGroupApp.SystemApiGroup.SystemApi
	sysParamsApi        = api.ApiGroupApp.SystemApiGroup.SysParamsApi
	autoCodeApi         = api.ApiGroupApp.SystemApiGroup.AutoCodeApi
	authorityApi        = api.ApiGroupApp.SystemApiGroup.AuthorityApi
	apiRouterApi        = api.ApiGroupApp.SystemApiGroup.SystemApiApi
	dictionaryApi       = api.ApiGroupApp.SystemApiGroup.DictionaryApi
	authorityBtnApi     = api.ApiGroupApp.SystemApiGroup.AuthorityBtnApi
	authorityMenuApi    = api.ApiGroupApp.SystemApiGroup.AuthorityMenuApi
	autoCodePluginApi   = api.ApiGroupApp.SystemApiGroup.AutoCodePluginApi
	autocodeHistoryApi  = api.ApiGroupApp.SystemApiGroup.AutoCodeHistoryApi
	operationRecordApi  = api.ApiGroupApp.SystemApiGroup.OperationRecordApi
	autoCodePackageApi  = api.ApiGroupApp.SystemApiGroup.AutoCodePackageApi
	dictionaryDetailApi = api.ApiGroupApp.SystemApiGroup.DictionaryDetailApi
	autoCodeTemplateApi = api.ApiGroupApp.SystemApiGroup.AutoCodeTemplateApi
	exportTemplateApi   = api.ApiGroupApp.SystemApiGroup.SysExportTemplateApi
	categoryApi         = api.ApiGroupApp.SystemApiGroup.CategoryApi
	posterApi           = api.ApiGroupApp.SystemApiGroup.PosterApi
	bannerApi           = api.ApiGroupApp.SystemApiGroup.BannerApi
	teacherApi          = api.ApiGroupApp.SystemApiGroup.TeacherApi
	benefitApi          = api.ApiGroupApp.SystemApiGroup.BenefitApi
	courseApi           = api.ApiGroupApp.SystemApiGroup.CourseApi
	wxUserApi           = api.ApiGroupApp.SystemApiGroup.WechatUserApi
	wechatApi           = api.ApiGroupApp.SystemApiGroup.WechatApi
	codeApi             = api.ApiGroupApp.SystemApiGroup.CodeApi
	activitiesApi       = api.ApiGroupApp.SystemApiGroup.ActivitiesApi
)
