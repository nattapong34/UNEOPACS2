using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Security.Cryptography;
using System.Text;

/// <summary>
/// Summary description for CConnect
/// </summary>
/// 
namespace UNEOPACS2
{
    public class CConnect
    {
        public String mycon;
        private SqlConnection conn;
        private SqlCommand cmd;
        private SqlDataReader dr;
        private SqlDataAdapter da;
        public DataSet ds;
        private SqlCommandBuilder builder;
        public string ip;
        public CConnect()
        {         
            if (WebConfigurationManager.ConnectionStrings["PACS"] != null)
            {
                mycon = WebConfigurationManager.ConnectionStrings["PACS"].ToString();
            }
            conn = new SqlConnection(mycon);
            //connOpen()
            cmd = new SqlCommand();
            cmd = new SqlCommand("SET NAMES tis620", conn);
            cmd.Connection = conn;
            //cmd.ExecuteNonQuery();
            da = new SqlDataAdapter();
            ds = new DataSet();
        }

        public void connOpen()
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Open();
        }
        public bool checkConn()
        {
            if (conn.State == ConnectionState.Open)
                return true;
            else
                return false;
        }
        public void connClose()
        {
            conn.Close();
        }
        public void drClose()
        {
            dr.Close();
        }
        public void sqlCmd(string sql)
        {
            try
            {
                connOpen();
                cmd.CommandText = sql;
                cmd.ExecuteNonQuery();
            }
            catch
            {
                // err.Message;
            }
            finally
            {
                connClose();
            }
        }
        public int sqlCmdCheck(string sql)
        {
            try
            {
                connOpen();
                cmd.CommandText = sql;
                return cmd.ExecuteNonQuery();
            }
            catch
            {
                // err.Message;
            }
            finally
            {
                connClose();
            }
            return 0;
        }
        public void sqlCmd()
        {
            try
            {
                connOpen();
                cmd.ExecuteNonQuery();
            }
            catch
            {
                // err.Message;
            }
            finally
            {
                connClose();
            }
        }
        public void sqlCmdText(string sql)
        {
            cmd.CommandText = sql;
        }
        public void sqlCmdAddParam(string pm, object txt)
        {
            cmd.Parameters.AddWithValue(pm, txt);
        }
        public object sqlCmdReturn(string sql)
        {
            object exc=null;
            try
            {
                connOpen();
                cmd.CommandText = sql;
                exc= cmd.ExecuteScalar();
            }
            catch
            {
                // err.Message;
            }
            finally
            {
                connClose();
            }
            return exc;
        }
        public void sqlReader(string sql)
        {  
                connOpen();
                cmd.CommandText = sql;
                dr = cmd.ExecuteReader();
        }
        public void sqlReader()
        {
                connOpen();
                dr = cmd.ExecuteReader();

        }
        public bool rsMoveNext()
        {
            return dr.Read();
        }
        public object Recordset(string field)
        {
            return dr[field];
        }
        public object Recordset(int field)
        {
            return dr[field];
        }
        public int daFill(string sql, string tb)
        {
            int st = 0;
            try
            {
                connOpen();
                cmd.CommandText = sql;
                da.SelectCommand = cmd;
                if (ds.Tables[tb] != null)
                    ds.Tables[tb].Clear();
                st = da.Fill(ds, tb);
            }
            catch
            {
                // err.Message;
            }
            finally
            {
                connClose();
            }
            return st;
        }
        public void daDeleteCmd(string sql)
        {
            try
            {
                connOpen();
                cmd.CommandText = sql;
                da.DeleteCommand = cmd;
            }
            catch
            {
                // err.Message;
            }
            finally
            {
                connClose();
            }
        }
        public int daFill(string sql, DataSet dts)
        {
            int st=0;
            try
            {
                connOpen();
                cmd.CommandText = sql;
                da.SelectCommand = cmd;
                if (ds.Tables["tmp"] != null)
                    ds.Tables["tmp"].Clear();
                st= da.Fill(dts, "tmp");
            }
            catch
            {
                // err.Message;
            }
            finally
            {
                connClose();
            }
            return st;
        }
        public void daUpdate(DataTable dt)
        {
            builder = new SqlCommandBuilder(da);
            da.Update(dt);
        }
        public int daUpdate()
        {
            builder = new SqlCommandBuilder(da);
            return da.Update(ds);
        }
        public int daUpdate(string table)
        {
            builder = new SqlCommandBuilder(da);
            return da.Update(ds, table);
        }
        public int daUpdate(short table_id)
        {
            builder = new SqlCommandBuilder(da);
            return da.Update(ds.Tables[table_id]);
        }

        public string getMd5Hash(string input)
        {
            // Create a new instance of the MD5CryptoServiceProvider object.
            MD5 md5Hasher = MD5.Create();

            // Convert the input string to a byte array and compute the hash.
            byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(input));

            // Create a new Stringbuilder to collect the bytes
            // and create a string.
            StringBuilder sBuilder = new StringBuilder();

            // Loop through each byte of the hashed data 
            // and format each one as a hexadecimal string.
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }

            // Return the hexadecimal string.
            return sBuilder.ToString();
        }

        // Verify a hash against a string.
        public bool verifyMd5Hash(string input, string hash)
        {
            // Hash the input.
            string hashOfInput = getMd5Hash(input);

            // Create a StringComparer an compare the hashes.
            StringComparer comparer = StringComparer.OrdinalIgnoreCase;

            if (0 == comparer.Compare(hashOfInput, hash))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}