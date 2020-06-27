﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrademarkManage.aspx.cs" Inherits="ZoomLaCMS.Manage.Shop.TrademarkManage"  MasterPageFile="~/Manage/I/Index.master"%>
<asp:Content runat="server" ContentPlaceHolderID="head"><title><%=Resources.L.品牌管理 %></title>
	<%=Call.SetBread( new Bread[] {
	new Bread("/{manage}/I/Main.aspx",Resources.L.工作台),
	new Bread("ProductManage.aspx",Resources.L.商城管理),
	new Bread("/{manage}/Shop/Addon/exp/DeliverType.aspx",Resources.L.商城设置),
	new Bread(){url="", text=Resources.L.品牌管理 +"<a href='Trademark.aspx'> ["+Resources.L.添加品牌 +"]</a>"}
	}) %>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="table-responsive-md">
<ZL:ExGridView ID="EGV" runat="server" AutoGenerateColumns="False" PageSize="10" IsHoldState="false" 
    OnPageIndexChanging="EGV_PageIndexChanging" AllowPaging="True" AllowSorting="True" OnRowCommand="EGV_RowCommand" OnRowDataBound="EGV_RowDataBound"
    CssClass="table table-striped table-bordered table-hover list_choice" EnableTheming="False" EnableModelValidation="True" EmptyDataText="<%$Resources:L,数据为空 %>">
    <Columns>
        <asp:TemplateField ItemStyle-CssClass="td_xs">
            <ItemTemplate>
                <input type="checkbox" name="idchk" value="<%#Eval("ID") %>"/>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="td_s" />
        <asp:TemplateField HeaderText="<%$Resources:L,所属厂商 %>" ItemStyle-CssClass="td_l">
            <ItemTemplate>
                <a href="Producer.aspx?ID=<%#Eval("ProID") %>"><%#Eval("ProName") %></a>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderText="<%$Resources:L,品牌名称 %>" DataField="Trname" />
        <asp:BoundField HeaderText="<%$Resources:L,品牌分类 %>" DataField="TrClass" ItemStyle-CssClass="td_l"/>
        <asp:TemplateField HeaderText="<%$Resources:L,操作 %>" ItemStyle-CssClass="td_l">
            <ItemTemplate>
                <a class="option_style" href="TradeMark.aspx?id=<%#Eval("ID") %>"><i class="zi zi_pencilalt" title="<%=Resources.L.修改 %>"></i></a>
                <asp:LinkButton runat="server" CssClass="option_style" CommandName="del2" CommandArgument='<%#Eval("ID") %>' OnClientClick="return confirm('确定要删除吗');"><i class="zi zi_trashalt" title="<%=Resources.L.删除 %>"></i></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</ZL:ExGridView>
</div>
<div class="alert alert-light">
    <asp:Button runat="server" ID="BatDel_Btn" Text="<%$Resources:L,批量删除 %>" OnClick="BatDel_Btn_Click" CssClass="btn btn-outline-danger" />
</div>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">

</asp:Content>