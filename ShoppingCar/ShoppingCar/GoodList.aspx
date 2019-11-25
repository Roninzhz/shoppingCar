<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodList.aspx.cs" Inherits="ShoppingCar.GoodList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        body {
            background-image: linear-gradient(120deg,#3498db,#8e44ad);
        }
        .tb{width:200px;height:300px;}
        a{text-decoration:none;}
        .img{width:200px;height:200px;border:0;}
        .tdl{width:110px;padding:5px;}
        .tdr{width:80px;padding:5px;}
        </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            【商品展示】<asp:Literal ID="ltCurUser" runat="server"></asp:Literal>
            <br />
            ----------------------------------------------------------------------------------<asp:DataList ID="dlstGoods" runat="server" RepeatColumns="3" DataSourceID="sqlGoods" DataKeyField="gdID" OnItemCommand="dlstGoods_ItemCommand1" >
                <ItemTemplate>
                    <table class="tb">
                        <tr>
                            <td colspan="2"><a href=""><asp:Image ID="Image1" runat="server" ToolTip='<%#Eval("gdName") %>' CssClass="img" ImageUrl='<%#Eval("gdImage","images/goods/{0}") %>' /></a></td>
                        </tr>
                        <tr><td>
                            <a href="">
                                <asp:Label ID="lbl1" runat="server" Text='<%#Eval("gdName") %>' />
                            </a>
                            </td></tr>
                        <tr><td class="tdl">价格：
                            <asp:Literal ID="lbl2" runat="server" Text='<%#Eval("gdPrice","{0:C}") %>' />
                            <td class="tdr">运费：
                            <asp:Literal ID="lt1" runat="server" Text='<%#Eval("gdFeight","{0:C}") %>' /></td>
                            </td></tr>
                        <tr><td class="tdl">已售：
                            <asp:Literal ID="lt2" runat="server" Text='<%#Eval("gdSaleQty","{0}件") %>' />
                            </td><td class="tdr">评价数：
                                 <asp:Literal ID="lt3" runat="server" Text='<%#Eval("gdEvNum") %>' />
                                 </td></tr>
                        <td class="tdaddshop">
                                <asp:ImageButton CommandName="addShop" runat="server" AlternateText="加入到购物车"/>
                                 </td>
                    </table>
                </ItemTemplate>
                <FooterTemplate>
                            <a href="ShoppingCar.aspx">购物车</a>
                </FooterTemplate>
            </asp:DataList>
            <asp:SqlDataSource ID="sqlGoods" runat="server" ConnectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=D:\DataBase\SMDB.mdf;Integrated Security=True;Connect Timeout=30" ProviderName="System.Data.SqlClient" SelectCommand="select * from [Goods]" />
            <asp:Label ID="lblCurPage" runat="server" Text="" />
            <asp:Label ID="lblTotalPage" runat="server" Text="" />
            <asp:LinkButton ID="lbtnPre" runat="server" CommandName="Pre" OnCommand="LinkBtnClick" OnClick="lbtnPre_Click">上一页</asp:LinkButton>
             <asp:LinkButton ID="lbtnNext" runat="server" CommandName="Next" OnCommand="LinkBtnClick" OnClick="lbtnNext_Click">下一页</asp:LinkButton>
                </div>
    </form>
</body>
</html>
