﻿<%@ WebHandler Language="C#" Class="Base64" %>

using System;
using System.Web;
using System.Web.SessionState;
using ZoomLa.BLL;
using ZoomLa.BLL.Helper;
using ZoomLa.Common;
using ZoomLa.Components;
using ZoomLa.Model;

//仅用于Base64上传（只允许上传图片）
public class Base64 :IHttpHandler, IRequiresSessionState
{
    B_Admin badmin = new B_Admin();
    B_User buser = new B_User();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
        context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
        string base64str = context.Request.Form["base64"];//上传的base64字符串
        string action = context.Request.Form["action"];
        string uploadPath = "";
        string saveName = function.GetRandomString(6) + ".jpg";
        string result = "";
        try
        {
            switch (action)
            {
                default:
                    if (buser.CheckLogin())
                    {
                        M_UserInfo mu = buser.GetLogin();
                        uploadPath = ZLHelper.GetUploadDir_User(mu, "dai");
                    }
                    else if (badmin.CheckLogin())
                    {
                        M_AdminInfo adminMod = B_Admin.GetLogin();
                        uploadPath = ZLHelper.GetUploadDir_Admin(adminMod, "dai");
                    }
                    else //Not Login
                    {
                        uploadPath = ZLHelper.GetUploadDir_Anony("dai");
                    }
                    break;
            }
            ImgHelper imghelper = new ImgHelper();
            imghelper.Base64ToImg(uploadPath + saveName, base64str);
            result = uploadPath + saveName;
            context.Response.Write(result); context.Response.End();
        }
        catch (Exception ex)
        {
            ZLLog.L(ZLEnum.Log.fileup, new M_Log()
            {
                Source = context.Request.RawUrl,
                Message = "上传失败|文件名:" + uploadPath+saveName + "|" + "原因:" + ex.Message
            });
        }

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}