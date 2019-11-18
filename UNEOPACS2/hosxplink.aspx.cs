using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UNEOPACS2
{
    public partial class hosxplink : System.Web.UI.Page
    {
        CConnect db = new CConnect();
        void createSession()
        {
            Session["login"] = "doctor";
            Session["fullname"] = "Viewer XRAY";
            Session["report"] = false;
            Session["usertype"] = 1;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string sql, xn, stuid, url, link, MOD;
            url = Properties.Settings.Default.PACS_LINK;
            url += "?study=";
            if (Request.QueryString["xn"] != null)
            {
                xn = Request.QueryString["xn"];
                if (xn != null)
                {

                    sql = "select StudyInstanceUid from study where AccessionNumber='" + xn + "'";
                    //Response.Write(sql);
                    stuid = db.sqlCmdReturn(sql).ToString();

                    sql = "select dbo.Series.Modality from series inner join study on dbo.Study.GUID = dbo.Series.StudyGUID";
                    sql += " where study.StudyinstanceUid='" + stuid + "'";
                    MOD = db.sqlCmdReturn(sql).ToString();
                    if (stuid != null)
                    {                                              

                            link = url + stuid;
                            //Response.Write(link);
                            Response.Redirect(link);
                    }
                    else
                    {
                        Response.Write("ไม่พบภาพ XRAY ของผู้ป่วยรายนี้");
                    }
                }
                else
                {
                    Response.Write("ไม่พบภาพ XRAY ของผู้ป่วยรายนี้");
                }
                db.connClose();
            }
            else if (Request.QueryString["hn"] != null)
            {
                string getHN;

                getHN = Request.QueryString["hn"];

                createSession();
                Session["findHN"] = getHN;
                Response.Redirect("/Study/index.aspx");
            }
            else
            {
                Response.Write("ไม่พบภาพ XRAY ของผู้ป่วยรายนี้");
            }
        }
    }
}