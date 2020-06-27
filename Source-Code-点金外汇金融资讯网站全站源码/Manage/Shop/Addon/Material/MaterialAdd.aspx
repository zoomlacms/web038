﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialAdd.aspx.cs" Inherits="ZoomLaCMS.Manage.Shop.Addon.Material.MaterialAdd" MasterPageFile="~/Manage/I/Index.Master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title><%=Resources.L.原料管理 %></title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<%=Call.SetBread( new Bread[] {
new Bread("/{manage}/I/Main.aspx",Resources.L.工作台),
new Bread("../../ProductManage.aspx",Resources.L.商城管理),
new Bread("/{manage}/Shop/Addon/exp/DeliverType.aspx",Resources.L.商城设置),
new Bread("/{manage}/Shop/Addon/Material/MaterialAdd.aspx",Resources.L.原料列表),
new Bread(){url="", text=Resources.L.原料管理}
}) %>
<div class="container-fluid pr-0">
<div class="row sysRow list_choice">
<table class="table table-bordered table-striped sys_table">
    <tr><th class="w12rem_lg"><%=Resources.L.原料名称 %></th><td><ZL:TextBox runat="server" ID="Name_T" class="form-control max20rem" AllowEmpty="false"/></td></tr>
    <tr><th><%=Resources.L.单位 %></th>
	<td>
		<div class="input-group">
			<asp:TextBox runat="server" ID="Unit_T" class="form-control max20rem" Text="<%$Resources:L,件 %>" />
			<div id="Unitd" class="input-group-append">
				<button type="button" class="btn btn-outline-info"><%=Resources.L.件 %></button>
				<button type="button" class="btn btn-outline-info">KG</button>
				<button type="button" class="btn btn-outline-info"><%=Resources.L.包 %></button>
				<button type="button" class="btn btn-outline-info"><%=Resources.L.箱 %></button>
				<button type="button" class="btn btn-outline-info"><%=Resources.L.罐 %></button>
				<button type="button" class="btn btn-outline-info"><%=Resources.L.只 %></button>
			</div>
		</div>
     </td></tr>
    <tr><th><%=Resources.L.备注 %></th><td>
        <asp:TextBox runat="server" ID="Remind_T" TextMode="MultiLine" class="m50rem_50" />
                   </td></tr>
    <tr><td></td><td>
        <asp:Button runat="server" ID="Save_Btn" Text="<%$Resources:L,保存信息 %>" class="btn btn-info" OnClick="Save_Btn_Click" />
        <a href="Default.aspx" class="btn btn-outline-info"><%=Resources.L.返回列表 %></a>
                 </td></tr>
</table>
</div>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script>
    $(function () {
        $("#Unitd .btn").click(function () { $("#Unit_T").val($(this).text()); });
    })
</script>
</asp:Content>