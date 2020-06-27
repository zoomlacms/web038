﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddToSpecial.aspx.cs" Inherits="ZoomLaCMS.Manage.I.ASCX.AddToSpecial" MasterPageFile="~/Manage/I/Index.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>批量添加内容到专题</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<%=Call.SetBread(new Bread[] {
	new Bread("/{manage}/I/Main.aspx","工作台"),
	new Bread("ContentManage.aspx","内容管理"),
	new Bread() {url="", text="添加到专题",addon= "" }}
	)
%>
<div class="container-fluid pr-0">
<div class="row sysRow list_choice table-responsive-md">
    <table class="table table-striped table-bordered">
        <tr align="center">
            <th colspan="2" class="text-center">批量添加到专题</th>
        </tr>
        <tr>
            <th class="w12rem_lg" align="left">
                <strong>内容ID</strong>
            </th>
            <td class="bqright">
                <asp:TextBox ID="TxtContentID" CssClass="form-control" runat="server" Width="298px" Enabled="false"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <th>
                <strong>目标专题</strong><br />
                <font class="text-danger">提示：</font>
				<small class="text-muted"> 可以按住 “Shift”或“Ctrl”键进行多个专题的选择</small>
            </th>
            <td class="bqright">
                <asp:ListBox ID="ListSpecial" CssClass="form-control" runat="server" Rows="15" Width="300px" SelectionMode="Multiple"></asp:ListBox>
                <br />
                <input id="Button2" onclick="SelectAll()" type="button" class="btn btn-outline-info" value="选定所有专题  " />
                <input id="Button3" onclick="UnSelectAll()" type="button" class="btn btn-outline-danger" value="取消选定所有专题" />
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Button ID="Button1" runat="server" class="btn btn-outline-info" Style="width: 100px;" Text="批量处理" OnClick="Button1_Click" />
                <input name="Cancel" type="button" id="BtnCancel" class="btn btn-outline-danger" style="width: 100px;" value="取消" onclick="javascript: history.back()" />
            </td>
        </tr>
    </table>
	</div>
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script>
        function SelectAll() {
            for (var i = 0; i < document.getElementById('ListSpecial').length; i++) {
                document.getElementById('ListSpecial').options[i].selected = true;
            }
        }
        function UnSelectAll() {
            for (var i = 0; i < document.getElementById('ListSpecial').length; i++) {
                document.getElementById('ListSpecial').options[i].selected = false;
            }
        }
    </script>
</asp:Content>
