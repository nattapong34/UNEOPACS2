using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Globalization;
using Newtonsoft.Json;

namespace UNEOPACS2.service
{
    /// <summary>
    /// Summary description for report
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class report : System.Web.Services.WebService
    {
        CultureInfo uIE = new System.Globalization.CultureInfo("en-US");
        public static CConnect db;

        [WebMethod]
        public string HelloWorld(string txt)
        {
            return "resturn:"+txt;
        }


        [WebMethod]
        public string getReport(string stuid)
        {
            db = new CConnect();
            string sql;
            string res = "";
            sql = "select * from StudyReport where StudyInstanceUid='" + stuid + "'";
            db.daFill(sql, "report");
            string JSONresult;
            JSONresult = JsonConvert.SerializeObject(db.ds.Tables["report"]);
            return JSONresult ?? "";

        }

        [WebMethod]
        public bool addReport(string comment,string stuid,bool normal=true,string doctor=null)
        {
            string sql;

            try
            {
                sql = "select count(*) from studyreport where studyinstanceuid='" + stuid + "'";

                if (int.Parse(db.sqlCmdReturn(sql).ToString()) > 0)
                {
                    sql = "update studyreport";
                    sql += " set normal=@normal,comment=@comment,ondate=@ondate,doctor=@doctor)";
                    sql += " where studyinstanceuid = '" + stuid + "'";
                    db.sqlCmdText(sql);
                }
                else
                { 

                    sql = "insert into studyreport(studyinstanceuid,normal,comment,ondate,doctor)";
                    sql += " values(@stuid,@normal,@comment,@ondate,@doctor)";
                    db.sqlCmdText(sql);
                    db.sqlCmdAddParam("@stuid", stuid);
                }  
                db.sqlCmdAddParam("@comment", comment);
                db.sqlCmdAddParam("@ondate", DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss", uIE));
                db.sqlCmdAddParam("@normal", normal);
                db.sqlCmdAddParam("@doctor", doctor);
                db.sqlCmd();
                db.connClose();
            }
            catch
            {
                return false;
            }
            return true;
        }
    }
}
