using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace ShoppingCar
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected int getUserIdByName(string uName, string uPwd)
        {
            int uID = 0;
            string connstr = ConfigurationManager.ConnectionStrings["SMDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("upGetUidByName", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] ps = new SqlParameter[]
                {
                    new SqlParameter("@uName",txtUName.Text),
                    new SqlParameter("@uPwd",txtUPwd.Text)
                };
                cmd.Parameters.AddRange(ps);
                uID = (int)cmd.ExecuteScalar();
            }
            return uID;
        }

        protected int getCarIdByUid(int uID)
        {
            int scID = 0;
            string connstr = ConfigurationManager.ConnectionStrings["SMDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("upGetScidByUid", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter ps = new SqlParameter("@uID", uID);
                cmd.Parameters.Add(ps);
                scID = (int)cmd.ExecuteScalar();
            }
            return scID;
        }
        protected void submit_Click(object sender, EventArgs e)
        {
            string uName = txtUName.Text.Trim();
            string uPwd = txtUPwd.Text.Trim();
            int uID = getUserIdByName(uName, uPwd);
            if (uID != 0)
            {
                Session["uName"] = uName;
                Session["uID"] = uID;
                Session["scID"] = getCarIdByUid(uID);
                ClientScript.RegisterStartupScript(GetType(), "", "<script>alert('登陆成功！');location.href='GoodList.aspx';</script>");
            }
            else
            {
                ClientScript.RegisterStartupScript(GetType(), "", "<script>alert('用户名或密码不正确！');location.href='GoodList.aspx;'</script>");
            }
        }
    }

}