<%@ WebHandler Language="C#" Class="data" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using System.Collections.Generic;

public class data : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            var a = context.Request.Params["name"];
            var b = context.Request.Params["password"];
            string strsql = "SELECT CASE WHEN u.PassWord ='" + b + "' THEN 1 ELSE 0 END FROM T_Users u WHERE (LOWER(u.Name) = '" + a + "')";
            //to do
            //strsql = "select StartB,StartL,EndB,EndL,T_Tubulations_Space.Diameter,T_Tubulations_Space.type,Category  from T_Tubulations_Space,T_PipeLine where T_PipeLine.TubulationNo=T_Tubulations_Space.TubulationNo;";
            OperateDB myOperateDB = new OperateDB();
            DataSet mydataset = new DataSet();
            myOperateDB.ConectDB(strsql, ref mydataset);
            DataTable mydatatable = mydataset.Tables[0];
            string result = mydatatable.Rows[0][0].ToString();
            mydataset.Clear();
            mydatatable.Clear();
            if (result == "1")
            {
                strsql = "select StartB,StartL,EndB,EndL,T_Tubulations_Space.Diameter,T_Tubulations_Space.type,Category  from T_Tubulations_Space,T_PipeLine where T_PipeLine.TubulationNo=T_Tubulations_Space.TubulationNo;";
                //to do
                DataSet mydataset1 = new DataSet();
                myOperateDB.ConectDB(strsql, ref mydataset1);
                DataTable mydatatable1 = mydataset1.Tables[0];
                mydatatable1 = mydataset1.Tables[0];
                result = mydatatable1.Rows[0][0].ToString();
                List<piple> piplelist = new List<piple>();
                foreach (DataRow row in mydatatable1.Rows)
                {
                    piple mypiple = new piple();
                    mypiple.Startpointx = double.Parse(row[0].ToString());
                    mypiple.Startpointy = double.Parse(row[1].ToString());
                    mypiple.Endpointx = double.Parse(row[2].ToString());
                    mypiple.Endpointy = double.Parse(row[3].ToString());
                    mypiple.Width = double.Parse(row[4].ToString());
                    mypiple.Type = int.Parse(row[5].ToString());
                    mypiple.Catlog = int.Parse(row[6].ToString());
                    piplelist.Add(mypiple);
                }
                string strSerializeJSON = JsonConvert.SerializeObject(piplelist);
                context.Response.Write(strSerializeJSON);
            }
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
public class piple
{
   private double startpointx, startpointy, endpointx, endpointy;

    public double Endpointy
    {
        get { return endpointy; }
        set { endpointy = value; }
    }

    public double Endpointx
    {
        get { return endpointx; }
        set { endpointx = value; }
    }

    public double Startpointy
    {
        get { return startpointy; }
        set { startpointy = value; }
    }

    public double Startpointx
    {
        get { return startpointx; }
        set { startpointx = value; }
    }
    private double width;

    public double Width
    {
        get { return width; }
        set { width = value; }
    }
    private int type, catlog;

    public int Catlog
    {
        get { return catlog; }
        set { catlog = value; }
    }

    public int Type
    {
        get { return type; }
        set { type = value; }
    }

}
