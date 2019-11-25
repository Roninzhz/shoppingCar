<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShoppingCar.aspx.cs" Inherits="ShoppingCar.ShoppingCar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>购物车</title>
    <link href="App_Themes/theme1/css.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            【购物车】<asp:Literal ID="ltCurUser" runat="server"></asp:Literal>
            ----------------------------------------------------------------------------------------------
            <asp:SqlDataSource ProviderName="System.Data.SqlClient" ID="sqlGoods" runat="server" ConnectionString="<%$ ConnectionStrings:SMDBConnectionString %>" DeleteCommand="upDelScarInfoBySciID" DeleteCommandType="StoredProcedure" SelectCommand="upGetInfoByScid" SelectCommandType="StoredProcedure" UpdateCommand="upUpdateNumBySciID" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="scID" SessionField="scID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="scNum" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:GridView ID="grdGoods" runat="server" AutoGenerateColumns="False" BorderStyle="None" DataSourceID="sqlGoods" EnableModelValidation="True" GridLines="None" PageSize="3" ShowFooter="True" OnRowDataBound="grdGoods_RowDataBound" OnSelectedIndexChanged="grdGoods_SelectedIndexChanged" Height="166px" DataKeyNames="sciID">
                <HeaderStyle CssClass="hstyle" />
                <FooterStyle CssClass="fstyle" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkSelect" runat="server" AutoPostBack="True" Checked="True" />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:LinkButton ID="lbtnSelectAll" runat="server" Text="取消全选" OnClick="lbtnSelectAll_Click" OnClientClick="return confirm('确定取消全选');"></asp:LinkButton>
                        </FooterTemplate>
                        <ItemStyle CssClass="center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="宝贝">
                        <ItemTemplate>   
                            <a href='<%# Eval("gdID","GoodsDetails.aspx?gdid={0}") %>'>
                                <asp:Image ID="img1" runat="server" CssClass="noborder"  ImageUrl='<%# Eval("gdImage","images/goods/l{0}") %>'/>
                            </a>
                        </ItemTemplate>
                        <FooterTemplate>
                            <a href="GoodList.aspx">继续挑选商品</a>
                        </FooterTemplate>
                        <ItemStyle CssClass="center" />
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="名称">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlkName" runat="server" NavigateUrl='<%# Eval("gdID","GoodsDetails.aspx?gdid={0}") %>' Text='<%# Eval("gdName") %>' />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:LinkButton ID="lbtnClear" runat="server" Text="清空购物车" OnClick="lbtClear_Click"></asp:LinkButton>
                        </FooterTemplate>
                        <ItemStyle CssClass="name" />
                    </asp:TemplateField>

                    <asp:BoundField DataField="gdPrice" HeaderText="单价（元）" ItemStyle-CssClass="center" DataFormatString="{0:C}">

<ItemStyle CssClass="center"></ItemStyle>
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="数量" ItemStyle-CssClass="center">
                        <ItemTemplate>
                            <asp:TextBox ID="txtNum" runat="server" Width="20px" Text='<%# Bind("scNum") %>' />
                            <asp:ImageButton ID="ibtnUpdate"  ImageUrl="images/icon/edit.png" runat="server" CausesValidation="false" ToolTip="单击更新数量" CommandName="Update" AlternateText="更新" OnClientClick="return confirm('确定要修改该商品的数量？');"/>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Literal ID="ltlTotal" runat="server" Text="商品总价"></asp:Literal>
                        </FooterTemplate>
                        <ItemStyle CssClass="center" />
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="小计（元）" ItemStyle-CssClass="center">
                        <ItemTemplate>
                            <asp:Literal ID="ltlSum" runat="server" Text='<%# Eval("scSum","{0:f}")%>' />
                        </ItemTemplate>
                        <ItemStyle CssClass="center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="False">
                        <ItemTemplate>   
                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="false" CommandName="Delete" Text="删除" OnClientClick="return confirm('确定从该购物车中删除该商品');"/>
                        </ItemTemplate>
                        <FooterTemplate>
                            <a href="Order.aspx">
                                <asp:ImageButton ID="imageComp" runat="server" CssClass="noborder" ImageUrl="images/icon/comp.jpg" />
                            </a>
                        </FooterTemplate>
                        <ItemStyle CssClass="center" />
                    </asp:TemplateField>
                </Columns>
                <AlternatingRowStyle BackColor="#e2f2ff" />
                <EmptyDataTemplate>
                    <span style="font-size:1.2pt;">购物车内没有任何物品</span>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
