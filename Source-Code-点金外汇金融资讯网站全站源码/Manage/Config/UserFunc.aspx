﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserFunc.aspx.cs" Inherits="ZoomLaCMS.Manage.Config.UserFunc" MasterPageFile="~/Manage/I/Index.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title><%=Resources.L.会员导航 %></title>
</asp:Content> 
<asp:Content runat="server" ContentPlaceHolderID="Content">
	<%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx",Resources.L.工作台),
        new Bread() {url="", text=Resources.L.会员导航 +"<a href='AddUserFunc.aspx?LinkType=3'> ["+Resources.L.添加会员导航 +"]</a>",addon="" }}
		)
    %>
    <ul class="nav nav-tabs list_choice" id="linktype_ul">
      <li class="nav-item" data-id="-100" role="presentation" ><a class="nav-link" href="UserFunc.aspx?EliteLevel=-100"><%=Resources.L.所有 %></a></li> 
      <li class="nav-item" data-id="1" role="presentation"><a class="nav-link" href="UserFunc.aspx?EliteLevel=1"><%=Resources.L.推荐 %></a></li>
      <li class="nav-item" data-id="0" role="presentation"><a class="nav-link" href="UserFunc.aspx?EliteLevel=0"><%=Resources.L.普通 %></a></li> 
    </ul>
    <div class="table-responsive">
        <ZL:ExGridView runat="server" ID="EGV" AutoGenerateColumns="False" PageSize="20" AllowPaging="true" OnPageIndexChanging="EGV_PageIndexChanging"
            CssClass="table table-striped table-bordered" IsHoldState="false" OnRowDataBound="gvCard_RowDataBound" OnRowCommand="EGV_RowCommand">
            <Columns>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                    <ItemTemplate>
                        <input  type="checkbox" name="idchk" value='<%#Eval("id") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%$Resources:L,名称 %>" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                    <ItemTemplate>
                        <a href='<%#Eval("id","AddUserFunc.aspx?menu=edit&id={0}") %>' title="<%=Resources.L.点击编辑导航 %>"><%#Eval("Name") %></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%$Resources:L,状态 %>" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                    <ItemTemplate>
                        <asp:Label ID="lblState" runat="server" Text='<%# Eval("state") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%$Resources:L,会员组 %>" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                    <ItemTemplate>
                        <%#GetUserGroup() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%$Resources:L,文件或地址路径 %>">
                    <ItemTemplate>
             <%--           <asp:HyperLink ID="hlLink" runat="server" NavigateUrl='<%#Eval("FlieUrl") %>' Text='<%#Eval("FlieUrl") %>' ToolTip='<%# Eval("Name") %>' Visible="false" />--%>
                        <a href="<%# Eval("FileUrl") %>" title="<%# Eval("Name") %>" target="_blank"><%#Eval("FileUrl") %></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%$Resources:L,图标地址 %>">
                    <ItemTemplate>
                        <span class="font_red"><%#GetItemIcon() %></span>：<asp:Label ID="lblpic" runat="server" Text='<%# Eval("ico") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%$Resources:L,手动排序 %>">
                     <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <input type="number" min="1" class="text_x text-center" name="order_T" value="<%#Eval("OrderID") %>" />
                        <input type="hidden" name="order_Hid" value="<%#Eval("ID")+":"+Eval("OrderID")+":"+Eval("OrderID") %>" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%$Resources:L,连接类型 %>" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                    <ItemTemplate>
                        <asp:Label ID="linkType" runat="server"></asp:Label> 
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%$Resources:L,操作 %>" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                    <ItemTemplate>
                        <asp:LinkButton runat="server" CommandArgument='<%#Eval("ID") %>' CommandName="del2" OnClientClick="return confirm('确定要删除吗');"><i class="zi zi_trash"></i><%=Resources.L.删除 %></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </ZL:ExGridView>
        <div style="height:70px;"></div>
        <div class="Conent_fix">
        <asp:Button ID="BtnDelete" runat="server" CssClass="btn btn-outline-danger mb-1" OnClick="BtnDelete_Click" OnClientClick="if(!IsSelectedId()){alert('请选择内容');return false;}else{return confirm('确定删除？')}" Text="<%$Resources:L,删除导航 %>"/>
        <asp:Button ID="Button1" runat="server" Text="<%$Resources:L,批量启用 %>" CssClass="btn btn-outline-info mb-1" OnClick="Btnuse_Click" />
        <asp:Button ID="Button2" runat="server" Text="<%$Resources:L,批量停用 %>" CssClass="btn btn-outline-danger mb-1" OnClick="Btnstop_Click" />
        <asp:Button ID="Button3" runat="server" Text="<%$Resources:L,保存排序 %>" CssClass="btn btn-outline-info mb-1" OnClick="saveOrder_Btn_Click" OnClientClick="return confirm('确定要保存修改后的排序吗!!!');"/>
    </div>
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/JS/SelectCheckBox.js"></script>
    <script src="/JS/ZL_Regex.js"></script>
    <script>
        $().ready(function () {
            ZL_Regex.B_Num("input[type=number]");
            $("#AllID_Chk").click(function () {//EGV 全选
                selectAllByName(this, "chkSel");
            });

            var EliteLevel = '<%=EliteLevel %>'; 
            $("#linktype_ul [data-id='" + EliteLevel + "']").find("a").addClass('active');
        }) 
    </script>
</asp:Content>
