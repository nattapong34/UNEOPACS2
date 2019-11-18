using Ionic.Zip;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UNEOPACS2.Study
{
    public partial class download : System.Web.UI.Page
    {
        CultureInfo uIE = new System.Globalization.CultureInfo("en-US");
        CultureInfo uTH = new System.Globalization.CultureInfo("th-TH");
        public static CConnect db;
        protected void Page_Load(object sender, EventArgs e)
        {
            lbTitle.Text = Request["stuid"];
            lbInfo.Text = Request["hn"] + " " + Request["name"] + " " + Request["desc"] + " " + Request["dt"];

            List<string> filepath = GetFile(lbTitle.Text);
            if (filepath.Count > 0)
            {
                foreach (string f in filepath)
                {
                    FileInfo fi = new FileInfo(f);
                    lbFile.Text += fi.Name + "\n";
                }
            }
        }


        /// DCM
        /// 
        public string GetDCM(string stuid)
        {
            db = new CConnect();
            string sql;
            sql = "SELECT dbo.Study.StudyDate, dbo.Study.StudyTime, dbo.Study.StudyId, dbo.Filesystem.FilesystemPath, dbo.ServerPartition.PartitionFolder, dbo.FilesystemStudyStorage.StudyFolder, dbo.Study.StudyInstanceUid";
            sql += " FROM dbo.Study INNER JOIN  ";
            sql += " dbo.FilesystemStudyStorage ON dbo.Study.StudyStorageGUID = dbo.FilesystemStudyStorage.StudyStorageGUID INNER JOIN ";
            sql += " dbo.Filesystem ON dbo.FilesystemStudyStorage.FilesystemGUID = dbo.Filesystem.GUID INNER JOIN ";
            sql += " dbo.ServerPartition ON dbo.Study.ServerPartitionGUID = dbo.ServerPartition.GUID";
            sql += " where dbo.Study.StudyInstanceUid='" + stuid + "'";
            db.daFill(sql, "dcm");
            if (db.ds.Tables["dcm"].Rows.Count > 0)
            {
                DataRow dr = db.ds.Tables["dcm"].Rows[0];
                string tmp;
                tmp = dr["FilesystemPath"].ToString() + "\\" + @dr["PartitionFolder"].ToString() + "\\" + dr["StudyFolder"].ToString() + "\\" + dr["StudyInstanceUid"].ToString() + "\\";
                return tmp;//.Replace("\\", "/");
            }
            return "";
        }

        private List<string> GetFile(string stuid)
        {
            string filepath = @"" + (new Uri(GetDCM(stuid))).AbsolutePath;// "~\\" + GetDCM(stuid);
            List<string> tmp = new List<string>();
            string[] folders = Directory.GetDirectories(@filepath, "*", System.IO.SearchOption.AllDirectories);
            foreach (string fd in folders)
            {
                string[] files = Directory.GetFiles(fd);
                foreach (string f in files)
                {
                    FileInfo fi = new FileInfo(f);
                    tmp.Add(fi.FullName);
                }
            }
            return tmp;
        }
        public void DownloadFiles(string stuid)
        {
            List<string> filepath = GetFile(stuid);

            if (filepath.Count > 0)
            {
                using (ZipFile zip = new ZipFile())
                {
                    zip.AlternateEncodingUsage = ZipOption.AsNecessary;
                    zip.AddDirectoryByName("DCM");
                    foreach (string f in filepath)
                    {
                 
                        zip.AddFile(f, "DCM");
                    }
                    Response.Clear();
                    Response.BufferOutput = false;
                    string zipName = String.Format("DCM {0}.zip", Request["hn"] + "-"+ DateTime.Now.ToString("yyyy-MM-dd-HHmmss",uIE));
                    Response.ContentType = "application/zip";
                    Response.AddHeader("content-disposition", "attachment; filename=" + zipName);
                    zip.Save(Response.OutputStream);
                    Response.End();
                }
            }
        }

        protected void bnDownload_Click(object sender, EventArgs e)
        {
            // DownloadFiles(lbTitle.Text);
            DownloadFiles(lbTitle.Text);
        }
    }
}