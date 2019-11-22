using System;

namespace ShoppingCar
{
    public partial class ShoppingCar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ltCurUser.Text = "当前用户：游客";
            if (Session["uName"] != null)
                ltCurUser.Text = "当前用户：" + Session["uName"];
            //未完成
           // else

        }
    }
}