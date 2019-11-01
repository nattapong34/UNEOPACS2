using System;
using System.Collections.Generic;
using System.Linq;
using System.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UNEOPACS2
{
    public partial class uneo : System.Web.UI.MasterPage
    {
       public static string ins;
        public enum MessageType { Success, Error, Info, Warning };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"]==null)
            {
                Response.Redirect("/login.aspx");
            }

           ins= Properties.Settings.Default.HOSPITAL_NAME;
            //d
        }

        protected void lbLogoff_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("/login.aspx");
        }
        protected void bncpAdd_Click(object sender, EventArgs e)
        {
            changePass();
        }
        protected void changePass()
        {
            string sql;
            if (checkTxt2())
            {
                if (checkUser())
                {
                    CConnect db = new CConnect();
                    sql = "update userlogin set user_pass=@pass where user_id=@user";
                    db.sqlCmdText(sql);
                    db.sqlCmdAddParam("@user", Session["login"].ToString());
                    db.sqlCmdAddParam("@pass", db.getMd5Hash(txtcpNewpass.Text));
                    db.sqlCmd();
                    db.connClose();
                    ShowMessage("เปลี่ยนรหัสผ่านเรียบร้อย", MessageType.Success);
                }
                else
                {
                    ShowMessage("รหัสผ่านเก่าไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง", MessageType.Error);
                }

            }
        }
        bool checkUser()
        {
            if (Session["login"] == null)
                return false;
            CConnect db = new CConnect();
            string sql = "select count(*) from userlogin where user_id='" + Session["login"].ToString() + "' and user_pass='" + db.getMd5Hash(txtcpPass.Text) + "'";

            if (int.Parse(db.sqlCmdReturn(sql).ToString()) > 0)
            {
                return true;
            }
            return false;
        }
        bool checkTxt2()
        {
            if (string.IsNullOrEmpty(txtcpPass.Text))
            {
                ShowMessage("กรุณากรอก password เก่า", MessageType.Error);
                return false;
            }
            if (string.IsNullOrEmpty(txtcpNewpass.Text))
            {
                ShowMessage("กรุณากรอก password ใหม่", MessageType.Error);
                return false;
            }
            return true;
        }
        protected void ShowMessage(string Message, MessageType type)
        {
            string script = "window.onload=function(){ShowPopup('" + type + "', '" + Message + "');}";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }
    }
}