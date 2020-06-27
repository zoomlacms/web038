﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddUserFunc.aspx.cs" Inherits="ZoomLaCMS.Manage.Config.AddUserFunc"  MasterPageFile="~/Manage/I/Index.master"%>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title><%=Resources.L.添加会员导航 %></title>
<link type="text/css" href="/dist/css/bootstrap-switch.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
	<%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx",Resources.L.工作台),
        new Bread("SearchFunc.aspx",Resources.L.会员导航),
        new Bread() {url="UserFunc.aspx?LinkType=3", text=Resources.L.添加会员导航,addon="" }}
		)
    %>
<asp:HiddenField ID="hideid" runat="server" />
<div class="container-fluid pr-0">
<div class="row sysRow list_choice">
		<table class="table table-striped table-bordered">
				<tr>
                    <th class="max20rem"><%=Resources.L.功能名称 %><span class="text-danger">*</span>
                    </th>
					<td>
						<asp:TextBox ID="txtName" onblur="checkname()"  runat="server" class="form-control max20rem"></asp:TextBox>
						<small class="text-muted"><%=Resources.L.功能名称_notice %></small>
						<span class="text-danger" id="txtName_span"></span>
						<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" ErrorMessage="<%$Resources:L,功能名称_notice1 %>" Display="Dynamic" ControlToValidate="txtName"></asp:RequiredFieldValidator>
						<br />
						<span runat="server" id="Span1"></span>
					</td>
				</tr>
				<tr>
                    <th><%=Resources.L.文件路径 %><span class="text-danger">*</span>
                    </th>
					<td>
						<asp:TextBox ID="txtFileUrl"  runat="server" class="form-control max20rem"></asp:TextBox>
						<small class="text-muted"><%=Resources.L.文件路径_notice %></small>
					</td>
				</tr>
				<tr>
					<th><%=Resources.L.图标地址 %></th>
					<td>
                        <i id="ItemIcon_T_icon"></i>
                        <div class="input-group mb-3">
                            <asp:TextBox ID="ItemIcon_T" runat="server" CssClass="form-control max20rem"></asp:TextBox>
                            <div class="input-group-append">
                                <input type="button" class="btn btn-info" onclick="ShowComDiag('/common/icon2.html', '选择图标');" value="<%=Resources.L.选择图标 %>" />
                            </div>
                        </div>

					</td>
				</tr> 
				<tr>
					<th><%=Resources.L.用户权限 %></th>
					<td> 
						 <asp:Repeater ID="selGroup_Rpt" EnableViewState="false" runat="server">
							<ItemTemplate>
								<label><input type="checkbox" name="selGroup" <%#GetChecked() %> value="<%#Eval("GroupID") %>" /><%#Eval("GroupName") %></label> 
							</ItemTemplate>
						</asp:Repeater>
						<small class="text-muted"><%=Resources.L.用户权限_notice %></small>
					</td>
				</tr>
				<tr>
					<th><%=Resources.L.是否推荐 %></th> 
					<td>
						<input type="checkbox" runat="server" id="IsEliteLevel" class="switchChk" />
					</td>
					</tr>
				<tr>
					<th><%=Resources.L.打开方式 %></th>
					<td>
						<asp:RadioButtonList ID="rdoOpenType" runat="server" RepeatDirection="Horizontal">
							<asp:ListItem Selected="True" Value="0" Text="<%$Resources:L,原窗口打开 %>"></asp:ListItem>
							<asp:ListItem Value="1" Text="<%$Resources:L,新窗口打开 %>"></asp:ListItem>
						</asp:RadioButtonList>
					</td>
				</tr>
				<tr>
					<th><%=Resources.L.支持移动 %></th>
					<td>
						<asp:RadioButtonList ID="SupportMobile" runat="server" RepeatDirection="Horizontal">
							<asp:ListItem Selected="True" Value="1" Text="<%$Resources:L,支持 %>"></asp:ListItem>
							<asp:ListItem Value="0" Text="<%$Resources:L,不支持 %>"></asp:ListItem>
						</asp:RadioButtonList>
					</td>
				</tr>
				<tr>
					<th><%=Resources.L.块大小 %></th>
					<td>
						<asp:RadioButtonList ID="MotroSize" runat="server" RepeatDirection="Horizontal">
							<asp:ListItem Selected="True" Value="3" Text="<%$Resources:L,大 %>"></asp:ListItem>
							<asp:ListItem Value="2" Text="<%$Resources:L,中 %>"></asp:ListItem>
							<asp:ListItem Value="1" Text="<%$Resources:L,小 %>"></asp:ListItem>
						</asp:RadioButtonList>
					</td>
				</tr>
				<tr>
					 <asp:HiddenField ID="txtOrderID" runat="server" />
					</tr>
            <tr>
                <td></td>
                <td>
                    <button type="button" id="Edit_Btn" runat="server" class="btn btn-info" onclick="CheckSubmit()"><%=Resources.L.添加导航 %></button>
		<asp:Button ID="EBtnSubmit" class="btn btn-outline-info" Text="<%$Resources:L,添加导航 %>" style="display:none;" runat="server" OnClick="EBtnSubmit_Click" />
		 <asp:HiddenField ID="EditSearchName_Hid" runat="server" />
		<input type="button" class="btn btn-outline-info" name="Button2" value="<%=Resources.L.返回列表 %>" onclick="location.href = 'SearchFunc.aspx'" id="Button2" />
                </td>
            </tr>
		</table>
</div></div>
<div id="icons" style="display:none"></div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script src="/dist/js/bootstrap-switch.js"></script>
<script src="/JS/Controls/ZL_Dialog.js" type="text/javascript"></script>
<script>
var diag = new ZL_Dialog();
$().ready(function () {
	$("[name='linktype_ch']").change(function () {//显示用户组
		ShowUserGroup();
	}); 
	//全选操作
	$("#usercheck_ch").click(function () {
		var obj = $(this);
		obj.closest('td').find('input').each(function (i, v) {
			$(v)[0].checked = obj[0].checked;
		});
	});
})
//检查名字是否重复
function checkname() {
	if ($("#EditSearchName_Hid").val() != "" && $("#EditSearchName_Hid").val() == $("#txtName").val()) {
		if (formflag)
		{ $("#EBtnSubmit").click(); }
		return;
	}
	$.post('AddUserFunc.aspx', { action: 'checkname', name: $("#txtName").val() }, function (data) {
		if (data == "-1") {
			$("#Edit_Btn").attr('disabled', 'disabled');
			$("#txtName_span").text('功能名重复!请重新修改功能名');
			formflag = false;
		}
		else {
			$("#txtName_span").text('');
			$("#Edit_Btn").removeAttr('disabled');
			if (formflag)
			{ $("#EBtnSubmit").click(); }
		}
	})
}
var formflag = false;//表单控制
function CheckSubmit() {
	formflag = true;
	checkname();
}
var zlicon = { id: "" };
zlicon.back = function (icon) {
    if (!icon) { icon = $(zlicon.id).val(); }
    $(zlicon.id).val(icon);
    $(zlicon.id + "_icon").attr("class", icon);
    CloseComDiag();
}
zlicon.init = function (id) {
    zlicon.id = id;
    zlicon.back($(id).val());
    $(id).change(function () { setTimeout(zlicon.back, 50); });
}
zlicon.init("#ItemIcon_T");
</script>
</asp:Content>