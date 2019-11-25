using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace ShoppingCar
{
    public partial class ShoppingCar : System.Web.UI.Page
    {
        double sum = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            ltCurUser.Text = "当前用户：游客";
            if (Session["uName"] != null)
                ltCurUser.Text = "当前用户：" + Session["uName"];
           else
                ClientScript.RegisterStartupScript(GetType(), "", "<script>alert('请先登录');location.href='Login.aspx';</script>");
        }

        protected void grdGoods_RowDataBound(object sender,GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Literal ltl = (Literal)e.Row.FindControl("ltlSum");
                string strSum = ltl.Text;
                if (!string.IsNullOrEmpty(strSum))
                    sum += Convert.ToDouble(strSum);
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[5].Text = string.Format("{0:C}",sum);
                ((LinkButton)e.Row.FindControl("lbtnClear")).Attributes.Add("onClick", "javascript:return confirm('确定清空购物车');");
            }
        }

        protected void lbtClear_Click(object sender,EventArgs e)
        {
            string str = ConfigurationManager.ConnectionStrings["SMDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(str))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("upClearCarByScid", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter p = new SqlParameter("@scID", Session["scID"]);
                cmd.Parameters.Add(p);
                cmd.ExecuteNonQuery();
            }
            Response.Redirect(Request.Path);
        }

        protected void grdGoods_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void lbtnSelectAll_Click(object sender, EventArgs e)
        {
            LinkButton lb = (LinkButton)sender;
            foreach (GridViewRow gvr in grdGoods.Rows)
            {
                CheckBox cb = (CheckBox)gvr.FindControl("chkSelect");
                if (cb.Checked == true)
                {
                    cb.Checked = false;
                }
                else
                {
                    cb.Checked = true;

                }
            }
            if (lb.Text.Equals("全选"))
                lb.Text = "取消全选";
            else
                lb.Text = "全选";
        }
    }
}