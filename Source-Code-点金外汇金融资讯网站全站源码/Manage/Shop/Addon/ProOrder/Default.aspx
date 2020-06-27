﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ZoomLaCMS.Manage.Shop.Addon.ProOrder.Default" MasterPageFile="~/Manage/I/Index.Master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title><%=Resources.L.申购单列表 %></title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div id="BreadDiv" class="mysite">
		<ol id="BreadNav" class="breadcrumb fixed-top">
			<li class="breadcrumb-item"><a href='<%=CustomerPageAction.customPath2 %>Main.aspx'><%=Resources.L.工作台 %></a></li>
			<li class="breadcrumb-item"><a href='<%=CustomerPageAction.customPath2+"Shop/ProductManage.aspx" %>'><%=Resources.L.商品管理 %></a></li>
			<li class="breadcrumb-item"><a href='<%=Request.RawUrl %>'><%=Resources.L.申购单列表 %></a></li>
			<div id="help" class="pull-right text-center"><a href="javascript:;" id="sel_btn" class="help_btn" onclick="selbox.toggle();"><i class="zi zi_search"></i></a></div>
			<div id="sel_box" class="padding5">
			</div>
		</ol>
    </div>
<div class="table-responsive-md list_choice">
<ZL:ExGridView ID="EGV" runat="server" AutoGenerateColumns="False" PageSize="10" IsHoldState="false" 
    OnPageIndexChanging="EGV_PageIndexChanging" AllowPaging="True" AllowSorting="True" OnRowCommand="EGV_RowCommand" OnRowDataBound="EGV_RowDataBound"
    CssClass="table table-striped table-bordered" EnableTheming="False" EnableModelValidation="True" EmptyDataText="<%$Resources:L,数据为空 %>">
    <Columns>
        <asp:TemplateField ItemStyle-CssClass="w12rem_lg">
            <ItemTemplate>
                <input type="checkbox" name="idchk" value="<%#Eval("ID") %>" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="w12rem_lg" />
        <asp:TemplateField HeaderText="<%$Resources:L,订单编号 %>" ItemStyle-CssClass="w12rem_lg">
            <ItemTemplate>
                <a href="ProOrderInfo.aspx?ID=<%#Eval("ID") %>"><%#Eval("OrderNo") %></a>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="<%$Resources:L,店铺名称 %>">
            <ItemTemplate>
                <%#ShowStoreName() %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="<%$Resources:L,订货人 %>">
            <ItemTemplate>
                <a href="javascript:;" onclick="user.showuinfo('<%#Eval("UserID") %>');"><%#Eval("AddUser") %></a>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderText="<%$Resources:L,订单金额 %>" DataField="OrdersAmount" DataFormatString="{0:F2}"  />
<%--        <asp:TemplateField HeaderText="订单状态">
            <ItemTemplate>
                <%#GetOrderStatus() %>
            </ItemTemplate>
        </asp:TemplateField>--%>
        <asp:TemplateField HeaderText="<%$Resources:L,物流状态 %>">
            <ItemTemplate>
                <%#GetExpStatus() %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="AddTime" DataFormatString="{0:yyyy年MM月dd日}" HeaderText="<%$Resources:L,创建时间 %>" ItemStyle-CssClass="w12rem_lg"/>
        <asp:TemplateField HeaderText="<%$Resources:L,操作 %>" ItemStyle-CssClass="w12rem_lg">
            <ItemTemplate>
                <a href="ProOrderInfo.aspx?id=<%#Eval("ID") %>"><i class="zi zi_pencilalt" title="<%=Resources.L.修改 %>"></i></a>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</ZL:ExGridView>
</div>
<div class="alert alert-light">
<a href="../Material/MatReport.aspx" class="btn btn-outline-info"><%=Resources.L.查看原料汇总 %></a>
<asp:Button runat="server" ID="BatSend_Btn" Text="<%$Resources:L,批量发货 %>" OnClick="BatSend_Btn_Click" class="btn btn-outline-info" />
<%--<asp:Button runat="server" ID="BatFinish_Btn" Text="批量完结" OnClick="BatFinish_Btn_Click" class="btn btn-info" />--%>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script src="/JS/Controls/ZL_Dialog.js"></script>
</asp:Content>