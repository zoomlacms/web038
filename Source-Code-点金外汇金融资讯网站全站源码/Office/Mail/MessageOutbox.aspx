﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MessageOutbox.aspx.cs" Inherits="ZoomLaCMS.MIS.OA.Mail.MessageOutbox"  MasterPageFile="~/Office/OAMain.master"  ValidateRequest="false"%>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>发件箱</title>
<script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" src="/JS/SelectCheckBox.js"></script>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="m-1">
        <div class="input-group max20rem mb-2">
            <asp:TextBox runat="server" ID="searchText" placeholder="请输入需要查询的信息" CssClass="form-control" />
            <span class="input-group-append">
                <asp:Button runat="server" CssClass="btn btn-outline-secondary" ID="searchBtn" Text="搜索" OnClick="searchBtn_Click" />
            </span>
        </div>
        <div class="margin_t5">
            <ZL:ExGridView runat="server" ID="EGV" CssClass="table table-striped table-bordered w-100" AutoGenerateColumns="false" AllowPaging="true" PageSize="10" EnableTheming="False" GridLines="None" CellPadding="2" CellSpacing="1" Width="98%" EmptyDataText="当前没有信息!!" OnPageIndexChanging="EGV_PageIndexChanging" OnRowCommand="EGV_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="选择" ItemStyle-HorizontalAlign="center">
                        <ItemTemplate>
                            <input type="checkbox" name="idChk" value='<%#Eval("MsgID") %>' />
                        </ItemTemplate>
                        <HeaderStyle ></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="主题">
                        <HeaderStyle  />
                        <ItemTemplate>
                            <%# Eval("Title", "{0}")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="收件人">
                        <ItemTemplate>
                            <%# GetUserName(Eval("Incept","{0}")) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="PostDate" HeaderText="发送日期" 
                        ItemStyle-HorizontalAlign="center">
                        <HeaderStyle ></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="操作"  ItemStyle-HorizontalAlign="center">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDel" runat="server" CommandName="DeleteMsg" OnClientClick="if(!this.disabled) return confirm('确实要删除此信息到垃圾箱吗？');"
                                CommandArgument='<%# Eval("MsgID")%>' Text="删除"></asp:LinkButton>
                            <asp:LinkButton ID="lbRead" runat="server" CommandName="ReadMsg" CommandArgument='<%# Eval("MsgID")%>'>阅读信息</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </ZL:ExGridView>
        </div>
    <div class="sysBtline">
        <asp:Button ID="Button2" runat="server" Text="批量删除" OnClick="Button2_Click" OnClientClick="return confirm('要将邮件批量置入回收站吗!!!');" class="btn btn-outline-danger" />
    </div>
 </div>
</asp:Content>

