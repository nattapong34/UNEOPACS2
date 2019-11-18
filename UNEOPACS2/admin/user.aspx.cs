using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UNEOPACS2.admin
{
    public partial class user : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] == null)
            {
                Response.Redirect("~/login.aspx");
            }else
            {
                if (int.Parse(Session["usertype"].ToString()) < 2)
                {
                    Response.Redirect("~/study/index.aspx");
                }
            }

        }
    }
}