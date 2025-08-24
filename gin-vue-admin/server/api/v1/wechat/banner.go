package wechat

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type WechatBannerApi struct{}

// WxBannerRequest 微信轮播图请求参数
type WxBannerRequest struct {
	Type string `json:"type" form:"type"` // 轮播图类型，默认为home
}

// WxBannerResponse 微信轮播图响应
type WxBannerResponse struct {
	Banners []WxBannerItem `json:"banners"` // 轮播图列表
}

// WxBannerItem 微信轮播图项目
type WxBannerItem struct {
	ID       uint   `json:"id"`       // 轮播图 ID
	ImageUrl string `json:"imageUrl"` // 图片地址
	LinkUrl  string `json:"linkUrl"`  // 跳转链接
	Order    int    `json:"order"`    // 排序
	Type     string `json:"type"`     // 类型
}

// WxGetBanners 获取微信小程序轮播图
// @Tags     WechatApi
// @Summary  获取微信小程序轮播图
// @Description 获取小程序首页轮播图列表，不需要鉴权
// @Accept   application/json
// @Produce  application/json
// @Param    type  query     string                                                 false  "轮播图类型"
// @Success  200   {object}  response.Response{data=WxBannerResponse,msg=string}   "获取成功"
// @Failure  400   {object}  response.Response{msg=string}                          "请求参数错误"
// @Failure  500   {object}  response.Response{msg=string}                          "服务器内部错误"
// @Router   /api/wxBanners [get]
func (w *WechatBannerApi) WxGetBanners(c *gin.Context) {
	ctx := c.Request.Context()

	// 获取查询参数
	bannerType := c.DefaultQuery("type", "home") // 默认获取home类型的轮播图

	global.GVA_LOG.Info("获取微信轮播图", zap.String("type", bannerType))

	// 调用bannerService获取轮播图数据
	banners, err := bannerService.GetBannerPublic(ctx, bannerType)
	if err != nil {
		global.GVA_LOG.Error("获取轮播图失败!", zap.Error(err))
		response.FailWithMessage("获取轮播图失败: "+err.Error(), c)
		return
	}

	// 转换为微信接口响应格式
	wxBanners := make([]WxBannerItem, 0, len(banners))
	for _, banner := range banners {
		wxBanner := WxBannerItem{
			ID:       banner.ID,
			ImageUrl: "",
			LinkUrl:  "",
			Order:    0,
			Type:     "",
		}

		// 安全地获取指针值
		if banner.ImageUrl != nil {
			wxBanner.ImageUrl = *banner.ImageUrl
		}
		if banner.LinkUrl != nil {
			wxBanner.LinkUrl = *banner.LinkUrl
		}
		if banner.Order != nil {
			wxBanner.Order = *banner.Order
		}
		if banner.Type != nil {
			wxBanner.Type = *banner.Type
		}

		wxBanners = append(wxBanners, wxBanner)
	}

	// 构建响应数据
	wxBannerResponse := WxBannerResponse{
		Banners: wxBanners,
	}

	global.GVA_LOG.Info("轮播图获取成功", zap.Int("count", len(wxBanners)))
	response.OkWithDetailed(wxBannerResponse, "获取成功", c)
}
