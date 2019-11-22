<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShoppingCar.aspx.cs" Inherits="ShoppingCar.ShoppingCar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            【购物车】<asp:Literal ID="ltCurUser" runat="server"></asp:Literal>
            <asp:SqlDataSource ProviderName="System.Data.SqlClient" ID="sqlGoods" runat="server" ConnectionString="<%$ ConnectionStrings:SMDBConnectionString %>" DeleteCommand="upDelScarInfoBySciID" DeleteCommandType="StoredProcedure" SelectCommand="upGetInfoByScid" SelectCommandType="StoredProcedure" UpdateCommand="upUpdateNumBySciID" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="scID" SessionField="scID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="scNum" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:GridView ID="grdGoods" runat="server" AutoGenerateColumns="False" BorderStyle="None" DataSourceID="sqlGoods" EnableModelValidation="True" GridLines="None" PageSize="3" ShowFooter="True" OnRowDataBound="">
            </asp:GridView>
        </div>
    </form>
</body>
</html>
