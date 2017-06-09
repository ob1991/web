<%@ WebHandler Language="C#" Class="save" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Data;

public class save : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            var date = context.Request.Params["date"];
            var lon = context.Request.Params["lon"];
            var lat = context.Request.Params["lat"];
            var temperature = context.Request.Params["temperature"];
            string strsql = "INSERT into T_infraredequipmentdate(Date,Lat,Lon,tem) VALUES('" + date + "'," + lat + "," + lon + "," + temperature + ");";
            //to do
            //strsql = "select StartB,StartL,EndB,EndL,T_Tubulations_Space.Diameter,T_Tubulations_Space.type,Category  from T_Tubulations_Space,T_PipeLine where T_PipeLine.TubulationNo=T_Tubulations_Space.TubulationNo;";
            OperateDB myOperateDB = new OperateDB();
            DataSet mydataset = new DataSet();
            myOperateDB.ConectDB(strsql, ref mydataset);
            mydataset.Clear();
            context.Response.Write("1");
        }
        catch
        {

        }
    }

    public bool IsReusable
    {
        get
        {
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