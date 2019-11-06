using System;
using System.Data;
using System.Globalization;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace UNEOPACS2.Study
{
    public partial class index : System.Web.UI.Page
    {
        CultureInfo uIE = new System.Globalization.CultureInfo("en-US");
        public static CConnect db;
        private string _mod;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                db = new CConnect();
            }
        }
        public string string2date(string dt)
        {
            string d, m, y;
            d = dt.Substring(0, 2);
            m = dt.Substring(3, 2);
            y = dt.Substring(6, 4);
            return y + m + d;
        }
        public string formatDate(string dd)
        {
            try
            {
                DateTime d = DateTime.ParseExact(dd, "yyyyMMdd", CultureInfo.InvariantCulture);
                return d.ToString("dd/MM/yyyy");
            }
            catch
            {
                return dd;
            }
        }
        public string formatTime(string tt)
        {
            try
            {
                if (tt.Length >= 6)
                    return (tt.Substring(0, 2) + ":" + tt.Substring(2, 2) + ":" + tt.Substring(4, 2));
                else
                    return tt;
            }
            catch
            {
                return tt;
            }

        }
        public string CalAge(string Dob, string stuDate)
        {
            try
            {
                DateTime bd = DateTime.ParseExact(Dob, "yyyyMMdd", CultureInfo.InvariantCulture);
                DateTime Now = DateTime.ParseExact(stuDate, "yyyyMMdd", CultureInfo.InvariantCulture);
                if (Now.Year >= bd.Year)
                {
                    int Years = new DateTime(Now.Subtract(bd).Ticks).Year - 1;
                    DateTime PastYearDate = bd.AddYears(Years);
                    int Months = 0;
                    for (int i = 1; i <= 12; i++)
                    {
                        if (PastYearDate.AddMonths(i) == Now)
                        {
                            Months = i;
                            break;
                        }
                        else if (PastYearDate.AddMonths(i) >= Now)
                        {
                            Months = i - 1;
                            break;
                        }
                    }

                    return String.Format("{0} [{1}.{2}y]", bd.ToString("dd/MM/yyyy"), Years, Months);

                }
                else
                {
                    return "-";
                }
            }
            catch
            {
                return "-";
            }
        }
        public string formatName(string n)
        {
            string[] tmp = n.Split('^');
            if (tmp.Length > 1)
            {
                if (!Properties.Settings.Default.SWAP_NAME)
                    return tmp[1] + " " + tmp[0];
                else
                    return tmp[0] + " " + tmp[1];
            }
            return n;
        }
        public string pacsLink(string md, string ln)
        {
            string url = Properties.Settings.Default.PACS_LINK;
            url += "?study=";
            if (md != "MD")
            {
                return url + ln;
            }
            return ln;
        }
        private string sqlPacs()
        {
            string sql = "";
            sql = "SELECT  DISTINCT dbo.Study.PatientId, dbo.Study.PatientsName,dbo.Study.StudyDate,dbo.Study.StudyTime, dbo.Study.AccessionNumber as vn,dbo.Study.PatientsBirthDate,dbo.Study.PatientsAge,";
            sql += "dbo.Study.StudyDescription,dbo.Study.ReferringPhysiciansName, dbo.Study.NumberOfStudyRelatedSeries,";
            sql += "dbo.Study.NumberOfStudyRelatedInstances, dbo.Series.Modality,dbo.Study.StudyInstanceUid,dbo.StudyReport.ondate,dbo.Study.StudyInstanceUid as urlview FROM  dbo.Study INNER JOIN";
            sql += " dbo.Series ON dbo.Study.GUID = dbo.Series.StudyGUID";
            sql += "  LEFT OUTER JOIN dbo.StudyReport ON dbo.Study.StudyInstanceUid = dbo.StudyReport.StudyInstanceUid";

            string where = "";
            if (!string.IsNullOrEmpty(txtID.Text))
            {
                where = !string.IsNullOrEmpty(where) ? " and " : " where ";
                sql += where;
                if (txtID.Text.IndexOf("/") < 0 && txtID.Text.Length < 9)
                {
                    sql += "PatientID like '%" + txtID.Text + "%'";
                }
                else if (txtID.Text.IndexOf("/") > 0)
                {
                    string hn, yy, pid;
                    int i = 0;
                    yy = txtID.Text.Substring(txtID.Text.IndexOf("/") + 1, 2);
                    hn = txtID.Text.Substring(0, txtID.Text.IndexOf("/"));
                    pid = hn;
                    for (i = hn.Length; i < 7; i++)
                    {
                        pid = "0" + pid;
                    }
                    hn = yy + pid;
                    // txtID.Text = hn;
                    sql += "(PatientID like '%" + txtID.Text + "%' or PatientID = '" + hn + "')";
                }
                else
                {
                    string hn, yy;
                    yy = txtID.Text.Substring(0, 2);
                    hn = int.Parse(txtID.Text.Substring(2, txtID.Text.Length - 2)).ToString();

                    sql += "(PatientID like '%" + hn + "/" + yy + "' or PatientID='" + txtID.Text + "')";
                }
            }
            if (!string.IsNullOrEmpty(txtName.Text))
            {
                where = !string.IsNullOrEmpty(where) ? " and " : " where ";
                sql += where;
                sql += "PatientsName like '%" + txtName.Text + "%'";
            }
            if (!string.IsNullOrEmpty(txtDesc.Text))
            {
                where = !string.IsNullOrEmpty(where) ? " and " : " where ";
                sql += where;
                sql += "StudyDescription like '%" + txtDesc.Text + "%'";
            }
            if (!string.IsNullOrEmpty(txtDt1.Text) || !string.IsNullOrEmpty(txtDt2.Text))
            {
                where = !string.IsNullOrEmpty(where) ? " and " : " where ";
                sql += where;
                sql += "StudyDate >= '" + string2date(txtDt1.Text) + "' and StudyDate <='" + string2date(txtDt2.Text) + "'";
            }
            if (!string.IsNullOrEmpty(txtDoc.Text))
            {
                where = !string.IsNullOrEmpty(where) ? " and " : " where ";
                sql += where;
                sql += "ReferringPhysiciansName like '%" + txtDoc.Text + "%'";
            }
            // modality
            _mod = "";
            foreach (ListItem li in cbMod.Items)
            {
                if (li.Selected)
                {
                    _mod += (string.IsNullOrEmpty(_mod) ? "" : ",") + "'" + li.Text + "'";
                }
            }
            if (!string.IsNullOrEmpty(_mod))
            {
                where = !string.IsNullOrEmpty(where) ? " and " : " where ";
                sql += where;
                sql += " Modality in (" + _mod + ")";
            }

            return sql;
        }
        protected void SqlQueryMD()
        {
            int mod = 0;
            string sql;
            sql = "SELECT      dbo.MediaStudyLevel.PatientID,dbo.MediaStudyLevel.StudyInstanceUid, dbo.MediaStudyLevel.StudyDate, dbo.MediaStudyLevel.StudyTime,";
            sql += "dbo.MediaStudyLevel.PatientsName, dbo.MediaStudyLevel.PatientsSex, dbo.MediaStudyLevel.AccessionNumber, dbo.MediaStudyLevel.Modality,";
            sql += "dbo.MediaStudyLevel.Media_Type, dbo.MediaStudyLevel.Path, dbo.MediaStudyLevel.NumberOfStudyRelatedSeries,";
            sql += "dbo.MediaStudyLevel.NumberOfStudyRelatedInstances, dbo.MediaStudyLevel.ReferringPhysiciansName,dbo.MediaStudyLevel.StudyDescription, dbo.StudyReport.ondate";
            sql += ",dbo.MediaStudyLevel.Path as urlview FROM dbo.MediaStudyLevel LEFT OUTER JOIN dbo.StudyReport ON ";
            sql += " dbo.MediaStudyLevel.StudyInstanceUid = dbo.StudyReport.StudyInstanceUid";

            if (txtID.Text.Length > 0)
            {
                if (mod == 0)
                    sql += " where ";
                else
                    sql += " and ";
                sql += "PatientID like '%" + txtID.Text + "%'";
                mod++;
            }
            if (txtName.Text.Length > 0)
            {
                if (mod == 0)
                    sql += " where ";
                else
                    sql += " and ";
                sql += "PatientsName like '%" + txtName.Text + "%'";
                mod++;
            }
            if (txtDesc.Text.Length > 0)
            {
                if (mod == 0)
                    sql += " where ";
                else
                    sql += " and ";
                sql += "StudyDescription like '%" + txtDesc.Text + "%'";
                mod++;
            }
            if (txtDoc.Text.Length > 0)
            {
                if (mod == 0)
                    sql += " where ";
                else
                    sql += " and ";
                sql += "ReferringPhysiciansName like '%" + txtDoc.Text + "%'";
                mod++;
            }
            if (txtDt1.Text.Length > 0 && txtDt2.Text.Length > 0)
            {
                if (mod == 0)
                    sql += " where ";
                else
                    sql += " and ";
                sql += "StudyDate >= '" + string2date(txtDt1.Text) + "' and StudyDate <= '" + string2date(txtDt2.Text) + "'";
                mod++;
            }
            if (db.ds.Tables["study"] != null)
            {
                sql += " order by StudyDate DESC";
                CConnect dba = new CConnect();
                dba.daFill(sql, "MD");
                foreach (DataRow r in dba.ds.Tables["MD"].Rows)
                {
                    DataRow dr = db.ds.Tables["study"].NewRow();
                    dr = db.ds.Tables["study"].NewRow();
                    dr["StudyInstanceUid"] = r["StudyInstanceUid"];
                    dr["StudyDate"] = r["StudyDate"];
                    dr["StudyTime"] = r["StudyTime"];
                    dr["PatientID"] = r["PatientID"];
                    dr["PatientsName"] = r["PatientsName"];
                    dr["PatientsBirthDate"] = "-";
                    dr["vn"] = r["AccessionNumber"];
                    dr["Modality"] = r["Modality"];
                    dr["NumberOfStudyRelatedSeries"] = r["NumberOfStudyRelatedSeries"];
                    dr["NumberOfStudyRelatedInstances"] = r["NumberOfStudyRelatedInstances"];
                    dr["ReferringPhysiciansName"] = r["ReferringPhysiciansName"];
                    dr["StudyDescription"] = r["StudyDescription"];
                    dr["ondate"] = r["ondate"];
                    dr["urlview"] = r["urlview"];
                    db.ds.Tables["study"].Rows.Add(dr);
                    db.ds.Tables["study"].AcceptChanges();
                    //db.connClose();
                }
                dba.connClose();
            }

        }

        protected void find()
        {
            db.daFill(sqlPacs(), "study");
            if (_mod.IndexOf("MD") > -1)
            {
                SqlQueryMD();
            }
        }

        protected void bnFind_Click(object sender, EventArgs e)
        {

            find();

        }

        protected void bnYesterday_Click(object sender, EventArgs e)
        {
            txtDt1.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy");
            txtDt2.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy");
            find();
        }

        protected void bnToday_Click(object sender, EventArgs e)
        {
            txtDt1.Text = DateTime.Now.ToString("dd/MM/yyyy");
            txtDt2.Text = DateTime.Now.ToString("dd/MM/yyyy");
            find();
        }


        [WebMethod]
        public static string getReport(string stuid=null)
        {
            //Send message
            var res = stuid;
            return res;
        }
    }
}