using System;
using System.Collections.Generic;
using System.Linq;
using System.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UNEOPACS2
{
    public partial class login : System.Web.UI.Page
    {
        public enum MessageType { Success, Error, Info, Warning };
        CConnect db = new CConnect();
        protected void Page_Load(object sender, EventArgs e)
        {
            lbAbount.Text = "UNEO2.0 version : " + System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString() + " by GD4 ";
        }

        protected void bnSingin_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtUser.Text) || string.IsNullOrEmpty(txtPass.Text))
            {
                return;
            }
            if (!getLogin())
            {
                ShowMessage("ชื่อผู้ใช้หรือรหัสผ่านผิด!!", MessageType.Error);
            }
        }
        protected bool getLogin()
        {

            string sql;

            sql = "select * from userlogin where user_id=@user and user_pass=@pass";
            db.sqlCmdText(sql);
            db.sqlCmdAddParam("@user", txtUser.Text);
            db.sqlCmdAddParam("@pass", db.getMd5Hash(txtPass.Text));
            db.sqlReader();
            if (db.rsMoveNext())
            {
                if (int.Parse(db.Recordset("access").ToString()) > 0)
                {
                    updateIP();
                    createSession();
                    if (int.Parse(Session["usertype"].ToString()) == 1)
                    {
                        Response.Redirect("study/index.aspx");
                    }
                    if (int.Parse(Session["usertype"].ToString()) == 2)
                    {
                        Response.Redirect("study/index.aspx");
                        Response.Redirect("AdminDefault.aspx");
                    }
                }
                else
                {
                    ShowMessage("ท่านยังไม่ได้รับการอนุมัติการเข้าใช้งานจากเจ้าหน้าที่ระบบ PACS<br>กรุณาติดต่อเจ้าหน้าที่อีกครั้ง", MessageType.Warning);
                    return true;
                }
            }
            db.connClose();
            return false;
        }
        void createSession()
        {
            Session["login"] = txtUser.Text;
            Session["fullname"] = db.Recordset("fullname");
            Session["report"] = db.Recordset("report");
            Session["usertype"] = db.Recordset("access");
            Session.Timeout = int.Parse(db.Recordset("timeout").ToString());
            //Session.Timeout = 1;
            db.connClose();
        }
        void updateIP()
        {
            CConnect db2 = new CConnect();
            string sql;
            sql = "update userlogin set ipaddress=@ip,ondate=@ondate,logedin=@log where user_id=@user";
            db2.sqlCmdText(sql);
            db2.sqlCmdAddParam("@user", txtUser.Text);
            db2.sqlCmdAddParam("@ondate", DateTime.Now);
            db2.sqlCmdAddParam("@log", true);
            db2.sqlCmdAddParam("@ip", Request.UserHostAddress.ToString());
            db2.sqlCmd(sql);
            db2.connClose();
        }

        protected void ShowMessage(string Message, MessageType type)
        {
            string script = "window.onload=function(){ShowPopup('" + type + "', '" + Message + "');}";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }

        // Add new user
        protected void bncAdd_Click(object sender, EventArgs e)
        {
            createUser();
        }
        protected bool checkTxt()
        {
            if (string.IsNullOrEmpty(txtFullname.Text))
            {
                ShowMessage("กรุณากรอก ชื่อจริงผู้ใช้งาน", MessageType.Error);
                return false;
            }
            if (string.IsNullOrEmpty(txtcUser.Text))
            {
                ShowMessage("กรุณากรอก User name", MessageType.Error);
                return false;
            }
            if (string.IsNullOrEmpty(txtcPass.Text))
            {
                ShowMessage("กรุณากรอก Password", MessageType.Error);
                return false;
            }
            return true;
        }
        protected void createUser()
        {
            CConnect db = new CConnect();
            string sql;
            sql = "select count(*) from userlogin where user_id='" + txtcUser.Text + "'";
            if (checkTxt())
            {
                if (short.Parse(db.sqlCmdReturn(sql).ToString()) == 0)
                {
                    sql = "insert into userlogin(user_id,user_pass,fullname,report,timeout,access,logedin) values(";
                    sql += "@user,@pass,@fullname,@report,30,0,@log)";
                    db.sqlCmdText(sql);
                    db.sqlCmdAddParam("@user", txtcUser.Text);
                    db.sqlCmdAddParam("@pass", db.getMd5Hash(txtcPass.Text));
                    db.sqlCmdAddParam("@fullname", txtFullname.Text);
                    db.sqlCmdAddParam("@report", false);
                    db.sqlCmdAddParam("@log", false);
                    db.sqlCmd();
                    db.connClose();

                    txtcUser.Text = "";
                    txtcPass.Text = "";
                    txtFullname.Text = "";

                    ShowMessage("ผลการสมัครเรียบร้อย กรุณาแจ้งเจ้าหน้าที่ PACS เพื่อเปิดการใช้งาน", MessageType.Success);
                }
                else
                {
                    ShowMessage("User name : " + txtcUser.Text + " มีการใช้งานแล้ว กรุณาเปลี่ยนใหม่", MessageType.Error);
                }

            }
        }

        // change pass
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
                    sql = "update userlogin set user_pass=@pass where user_id=@user";
                    db.sqlCmdText(sql);
                    db.sqlCmdAddParam("@user", txtcpUser.Text);
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
            string sql;
            //Response.Write(txtPass.Text);

            sql = "select count(*) from userlogin where user_id='"+ txtcpUser.Text +"' and user_pass='"+ db.getMd5Hash(txtcpPass.Text) +"'";

            if (int.Parse(db.sqlCmdReturn(sql).ToString())>0)
            {
                return true;
            }
            return false;
        }  
        bool checkTxt2()
        {
            if (string.IsNullOrEmpty(txtcpUser.Text))
            {
                ShowMessage("กรุณากรอก User name", MessageType.Error);
                return false;
            }
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
    }
}