<%@ WebHandler Language="C#" Class="locationlogin" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Data;

public class locationlogin : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        try
        {
            var a = context.Request.Params["name"];
            var b = context.Request.Params["password"];
            string strsql = "SELECT CASE WHEN u.PassWord ='" + b + "' THEN 1 ELSE 0 END FROM T_Users u WHERE (LOWER(u.Name) = '" +a + "')";
            //to do
            
            OperateDB myOperateDB = new OperateDB();
            DataSet mydataset = new DataSet();
            myOperateDB.ConectDB(strsql, ref mydataset);
            DataTable mydatatable = mydataset.Tables[0];
            string result = mydatatable.Rows[0][0].ToString();
            context.Response.Write(result);
        }
        catch { 
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}
public class OperateDB
{
    string my_strIP, my_strUID, my_strPassWord, my_strDB;
    public OperateDB()
    {
        my_strIP = "202.118.16.50,4035";
        my_strUID = "ob";
        my_strPassWord = "123456";
        my_strDB = "PIPLE";
    }
    public OperateDB(string strIP, string strUID, string strPassWord, string strDB)
    {
        my_strIP = strIP;
        my_strUID = strUID;
        my_strPassWord = strPassWord;
        my_strDB = strDB;
    }
    public void ConectDB(string strSQL, ref DataSet dataset)
    {
        string connection = "server=" + my_strIP + ";uid=" + my_strUID + ";pwd=" + my_strPassWord + ";database=" + my_strDB;
        using (SqlConnection con = new SqlConnection(connection))
        {
            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(strSQL, con);
            adapter.Fill(dataset);
            adapter.Dispose();
            con.Close(); con.Dispose();
        }
    }
}