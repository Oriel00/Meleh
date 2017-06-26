using System;
using System.Data;
using System.IO;
using System.Reflection;
using DayPilot.Web.Ui;

public partial class Demo : System.Web.UI.MasterPage
{
    //private string root;

    protected void Page_Load(object sender, EventArgs e)
    {
	// prevent invalid ViewState errors in Firefox
        if (Request.Browser.Browser == "Firefox") Response.Cache.SetNoStore();

        if (!IsPostBack)
        {
            Repeater1.DataBind();
            Repeater2.DataBind();
            DemoInfo.DataBind();
            SandboxInfo.DataBind();
        }
    }

    protected bool MenuVisible
    {
        get
        {
            return root != ResolveUrl("~/");
        }
    }

    private string root
    {
        get
        {
            return Request.FilePath.Substring(0, Request.FilePath.LastIndexOf('/')) + "/";
        }
    }
    private DataTable tabs = null;
    protected DataTable Tabs
    {
        get
        {
            if (tabs == null)
            {
                DataSet ds = new DataSet();
                ds.ReadXml(Server.MapPath("~/Navigation.config"));
                DataTable dt = ds.Tables["Item"];

                foreach (DataRow r in dt.Rows)
                {
                    string url = r["url"] as string;

                    if (url == null)
                        continue;

                    r["url"] = ResolveUrl("~" + url);

                    if (root == ResolveUrl("~" + url))
                    {
                        r["class"] = "tab selected";
                    }
                    else
                    {
                        r["class"] = "tab";
                    }

                    //r["url"] = normalized;
                }
                tabs = dt;
            }

            return tabs;

        }
    }

    protected string Description
    {
        get
        {
            DataTable dt = LocalNavigation.Tables["Description"];
            if (dt == null || dt.Rows.Count == 0)
            {
                return String.Empty;
            }
            return dt.Rows[0]["text"] as string;
        }
        
    }

    private DataSet localNavigation;
    private DataSet LocalNavigation
    {
        get
        {
            if (localNavigation == null)
            {
                localNavigation = new DataSet();
                localNavigation.ReadXml(Server.MapPath("Navigation.config"));
            }
            return localNavigation;
        }
    }

    protected DataTable Items
    {
        get
        {
            DataTable dt = LocalNavigation.Tables["Item"].Copy();

            foreach (DataRow r in dt.Rows)
            {
                string url = r["url"] as string;

                if (url == null)
                    continue;

                if (Request.Path.ToUpper().IndexOf("/" + url.ToUpper()) != -1)
                {
                    r["url"] = ResolveUrl(root + url);
                    r["class"] += " selected";
                }
                else
                {
                    r["url"] = ResolveUrl(root + url);
                    //r["class"] = "";
                }
            }
            return dt;

        }
    }

    protected string GetLastUpdate()
    {
        Version v = Assembly.GetAssembly(typeof (DayPilotCalendar)).GetName().Version;
//        DateTime update = File.GetCreationTime(Server.MapPath("~/updated.config"));
        DateTime update = File.GetLastWriteTime(Server.MapPath("~/bin/DayPilot.dll"));
        int hoursAgo = Convert.ToInt32(Math.Round((DateTime.Now - update).TotalHours));
        string ago;

        switch (hoursAgo)
        {
            case 0:
                ago = "right now";
                break;
            case 1:
                ago = "1 hour ago";
                break;
            default:
                ago = String.Format("{0} hours ago", hoursAgo);
                break;
        }

        return String.Format("DayPilot Pro {0} (built {1} UTC; {2})", v, update, ago); 
    }

    protected string GetDownloadLink()
    {
        return String.Format("<a href='{0}'>{1}</a>", GetDownloadUrl(), GetDownloadName());
    }

    protected string GetDownloadUrl()
    {
        if (IsSandbox)
        {
            return ResolveUrl(String.Format("~/{0}", GetDownloadName()));
        }
        if (IsDemo)
        {
            return String.Format("/files/trial/{0}", GetDownloadName());
        }
        return GetDownloadName();
    }

    protected string GetDownloadName()
    {
        Version v = Assembly.GetAssembly(typeof(DayPilotCalendar)).GetName().Version;
        return String.Format("DayPilotProTrial-{0}.{1}.{2}.zip", v.Major, v.Minor, v.Build);
    }

    protected bool IsSandbox
    {
        get
        {
            return Request.Path.ToLower().Contains("sandbox");
        }
    }

    protected bool IsDemo
    {
        get
        {
            return Request.Path.ToLower().Contains("demo");
        }
    }

}
