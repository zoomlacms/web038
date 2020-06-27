﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="ZoomLaCMS.Manage.login" MasterPageFile="~/Common/Common.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title><%=Resources.L.管理登录 %></title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<body class="sys_login"  style="background:url(<%=Call.GetRandomImg()%>);background-position: center; background-repeat:no-repeat;background-size:cover;">
<div class="container">
<div class="sys_loginBox">
<div class="text-center mb-4">
<img class="sys_loginLogo" src="<%:Call.LogoUrl%>" alt="<%:Call.SiteName%>_后台管理系统" >
</div> 
<div class="form-label-group">
<i class="zi zi_user" zico="用户标志"></i>
<asp:TextBox runat="server" ID="AdminN_T" TabIndex="1" data-enter="1" size="20"  class="form-control" autocomplete="off" placeholder="<%$Resources:L,帐户 %>"  autofocus="true"/>
</div>
<div class="form-label-group">
<i class="zi zi_lock" zico="锁定"></i>
<asp:TextBox runat="server" ID="AdminP_T" class="form-control" TabIndex="2" data-enter="2" TextMode="Password" MaxLength="18" AllowEmpty="false" autocomplete="off" placeholder="<%$Resources:L,密码 %>" required autofocus/>
</div>
<div class="form-label-group" id="safecode" runat="server">
<i class="zi zi_idCheck" zico="身份卡片"></i>
<asp:TextBox runat="server" ID="AdminCode_T" data-enter="3" MaxLength="6" class="form-control" placeholder="<%$Resources:L,管理认证码 %>"/>
</div>

<div class="form-label-group mb-3" id="CodeLi" runat="server" visible="false">
<i class="zi zi_key" zico="钥匙"></i>
<asp:TextBox runat="server" ID="VCode" TabIndex="3" data-enter="4" class="form-control" MaxLength="6" autocomplete="off" placeholder="<%$Resources:L,验证码 %>"/>
<img id="VCode_img" runat="server" title="<%=Resources.L.点击刷新验证码 %>" class="VCode_img" style=" "/>
</div>

<input type="hidden" id="VCode_hid" name="VCode_hid" />
<div class="form-label-group"  id="ZnCode_Li" runat="server" visible="false">
<asp:TextBox runat="server" ID="ZnCode_T" CssClass="form-control" placeholder="<%$Resources:L,动态口令 %>"></asp:TextBox>
</div>

<input type="button" id="IbtnEnter" data-enter="5" class="btn btn-info btn-block"  value="<%=Resources.L.登录 %>" onclick="return ajaxlogin();" /> 
<a href="AccountForm.aspx" visible="false" id="test_Link" runat="server" class="btn btn-outline-info btn-block"><%=Resources.L.申请测试帐号 %></a> 
<div class="sys_loginLink"> 
<a href="../" target="_blank" title="<%=Resources.L.首页 %>"><i class="zi zi_home" zico="家"></i></a>
<a href="../Help.html" target="_blank" title="<%=Resources.L.帮助 %>"><i class="zi zi_globe" zico="全球"></i>
<a href="http://help.z01.com/Database/" target="_blank" title="<%=Resources.L.数据字典 %>"><i class="zi zi_book" zico="书籍"></i>
</div>
</div>
</div>
<div class="clearfix"></div>
<div class="sys_login_wave_box"><div class="sys_login_wave_embed"></div></div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<style type="text/css">
.popover{width:300px; text-align:center;}
html,body {  height: 100%;}
</style>
<script src="/JS/ZL_ValidateCode.js"></script>
<script src="/JS/jquery.easing.js"></script>
<script src="/JS/Controls/Control.js"></script>
<script src="/JS/Plugs/jsencrypt.js"></script>
<script>
$(function () {
	if (self != top) { top.location = self.location; }
	//ipad||iphone
	if ($("#Apple_Hid").val() == "1") { location = "default.aspx"; }
	$("#VCode").ValidateCode();
	Control.EnableEnter();
	<%=Call.PreLoadPage()%>
})
var loginflag = false;
function ajaxlogin() {
	if (!loginflag) {
		$("#IbtnEnter").attr('disabled', 'disabled');
		$("#IbtnEnter").val('登录中..');
		var param = {
			action: 'login', user: $("#<%=AdminN_T.ClientID%>").val(),
			pwd: RSAEncrypt.encrypt($("#<%=AdminP_T.ClientID%>").val()),
			VCode_hid: $("#VCode_hid").val(),
			vcode: $("#VCode").val(),
			zncode: $("#ZnCode_T").val(),
			admincode: $("#AdminCode_T").val()
		};
		function success(data) {
			$("#IbtnEnter").removeAttr('disabled');
			if (data != "True") {
				$("#IbtnEnter").val('登录');
				$("#IbtnEnter").popover({
					animation: true,
					placement: 'bottom',
                    content: '<span style="color:red;"><i class="zi zi_exclamationCircle"></i> ' + data + '!</span> <span style="color:#999">(双击隐藏)</span>',
					html: true,
					trigger: 'manual',
					delay: { show: 10000, hide: 100 }
				});
				$("#IbtnEnter").popover('show');
				$(".popover").dblclick(function () {
				    $("#IbtnEnter").popover('dispose');
					event.preventDefault();
				});
				//setTimeout(function () { $("#IbtnEnter").popover('destroy'); }, 2000);
			} else {
				loginflag = true;
				location = "<%=ReturnUrl%>";
			}
		}
		$.post("", param, success);
	}
}
</script>
</asp:Content>