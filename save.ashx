<%@ WebHandler Language="C#" Class="save" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Data;

public class save : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        try
        {
            var date = context.Request.Params["date"];
            var lon = context.Request.Params["lon"];
            var lat = context.Request.Params["lat"];
            var temperature = context.Request.Params["temperature"];
            string strsql = "INSERT into T_infraredequipmentdate(Date,Lat,Lon,tem) VALUES('" + date + "',"+lat+","+lon+","+temperature+");" ;
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
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}