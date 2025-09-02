package wechat

import (
	"strconv"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	exampleRes "github.com/flipped-aurora/gin-vue-admin/server/model/example/response"
	"github.com/flipped-aurora/gin-vue-admin/server/service"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type WechatImageApi struct{}

var fileUploadAndDownloadService = service.ServiceGroupApp.ExampleServiceGroup.FileUploadAndDownloadService

// WxUploadImage
// @Tags      WechatImage
// @Summary   微信小程序上传图片
// @accept    multipart/form-data
// @Produce   application/json
// @Param     file  formData  file                                                           true  "上传图片"
// @Param     classId  formData  int                                                           false  "分类ID"
// @Success   200   {object}  response.Response{data=exampleRes.ExaFileResponse,msg=string}  "上传图片,返回包括图片详情"
// @Router    /api/wx/uploadImage [post]
func (w *WechatImageApi) WxUploadImage(c *gin.Context) {
	_, header, err := c.Request.FormFile("file")
	if err != nil {
		global.GVA_LOG.Error("接收文件失败!", zap.Error(err))
		response.FailWithMessage("接收文件失败", c)
		return
	}

	// 获取并转换classId为整数
	classIdStr := c.DefaultPostForm("classId", "0")
	classIdInt, err := strconv.Atoi(classIdStr)
	if err != nil {
		classIdInt = 0 // 如果转换失败，默认为0
	}

	// 使用系统已有的文件上传服务
	file, err := fileUploadAndDownloadService.UploadFile(header, "0", classIdInt)
	if err != nil {
		global.GVA_LOG.Error("上传文件失败!", zap.Error(err))
		response.FailWithMessage("上传文件失败", c)
		return
	}
	response.OkWithDetailed(exampleRes.ExaFileResponse{File: file}, "上传成功", c)
}
