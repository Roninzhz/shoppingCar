using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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

        protected void grdGoods_RowDataBound(object sender, GridViewRowEventArgs e)
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
                e.Row.Cells[5].Text = string.Format("{0:C}", sum);
                ((LinkButton)e.Row.FindControl("lbtnClear")).Attributes.Add("onClick", "javascript:return confirm('确定清空购物车');");
            }
        }

        protected void lbtClear_Click(object sender, EventArgs e)
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
            Summ();
            Cchecked();
        }

        private void Summ()
        {
            decimal sum = 0M;
            for (int i = 0; i < this.grdGoods.Rows.Count; i++)
            {
                CheckBox ckb = (CheckBox)this.grdGoods.Rows[i].Cells[0].FindControl("chkSelect");
                if (ckb.Checked)
                {
                    Literal lt1 = (Literal)this.grdGoods.Rows[i].FindControl("ltlSum");
                    if (grdGoods.Rows[i].RowType == DataControlRowType.DataRow)
                    {
                        sum += decimal.Parse(lt1.Text);
                    }
                }
            }
            Literal ltsum = (Literal)this.grdGoods.FooterRow.FindControl("ltlSum1");
            ltsum.Text = sum.ToString();
        }

        protected void lbtnSelectAll_Click(object sender, EventArgs e)
        {
            bool flag = true;
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
                    flag = false;
                    cb.Checked = true;

                }
            }
            if (!flag)
            {
                lb.Text = "取消全选";
                Summ();
            }
            else
            {
                lb.Text = "全选";
                Literal ltsum = (Literal)this.grdGoods.FooterRow.FindControl("ltlSum1");
                ltsum.Text = "0";
            }
        }

        protected void Cchecked()
        {
            bool flag = true;
            LinkButton lt = (LinkButton)this.grdGoods.FooterRow.FindControl("lbtnSelectAll");
            for (int i = 0; i < this.grdGoods.Rows.Count; i++)
            {
                CheckBox ckb = (CheckBox)this.grdGoods.Rows[i].Cells[0].FindControl("chkSelect");
                if (!ckb.Checked)
                {
                    flag = false;
                }
                if (flag)
                {
                    lt.Text = "取消全选";
                }
                else
                {
                    lt.Text = "全选";
                }
            }
        }
    }
}