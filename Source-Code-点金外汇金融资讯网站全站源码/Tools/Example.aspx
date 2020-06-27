<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Example.aspx.cs" Inherits="ZoomLaCMS.Tools.Example" MasterPageFile="~/Common/Master/Empty.master" %>


<asp:Content runat="server" ContentPlaceHolderID="head"></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
   <asp:TextBox runat="server" ID="T1" TextMode="MultiLine" style="width:800px;height:500px;"></asp:TextBox>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="Script">
<script>
var HtmlUtil = {
    htmlEncode:function (html){
        var temp = document.createElement ("div");
        (temp.textContent != undefined ) ? (temp.textContent = html) : (temp.innerText = html);
        var output = temp.innerHTML;
        temp = null;
        return output;
    },
    htmlDecode:function (text){
        var temp = document.createElement("div");
        temp.innerHTML = text;
        var output = temp.innerText || temp.textContent;
        temp = null;
        return output;
    }
    };
    var result = JSON.parse(HtmlUtil.htmlDecode('[{&quot;url&quot;:&quot;System/field/images/20190323/201903230UoHKq.jpg&quot;,&quot;desc&quot;:&quot;&quot;}]'));
    console.log(result);
</script>
</asp:Content>