/* Copyright © 2005 - 2011 Annpoint, s.r.o.
   Use of this software is subject to license terms. 
   http://www.daypilot.org/

   If you have purchased a DayPilot Pro license, you are allowed to use this 
   code under the conditions of DayPilot Pro License Agreement:

   http://www.daypilot.org/files/LicenseAgreement.pdf

   Otherwise, you are allowed to use it for evaluation purposes only under 
   the conditions of DayPilot Pro Trial License Agreement:
   
   http://www.daypilot.org/files/LicenseAgreementTrial.pdf
   
*/

using System;
using System.Data;
using System.Web.UI;

public partial class Edit : Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            DataRow ev = loadEvent(Request.QueryString["id"]);

            TextBoxStart.Text = Convert.ToDateTime(ev["start"]).ToString();
            TextBoxEnd.Text = Convert.ToDateTime(ev["end"]).ToString();
            TextBoxName.Text = Convert.ToString(ev["name"]);

            //TextBoxName.Focus();
        }
    }
    protected void ButtonOK_Click(object sender, EventArgs e)
    {
        DateTime start = Convert.ToDateTime(TextBoxStart.Text);
        DateTime end = Convert.ToDateTime(TextBoxEnd.Text);
        string name = TextBoxName.Text;

        dbUpdateEvent(Request.QueryString["id"], start, end, name, null);
        Modal.Close(this, "OK");
    }

    private string dbUpdateEvent(string id, DateTime start, DateTime end, string name, string resource)
    {
        initData();

        #region Simulation of database update

        DataRow dr = loadEvent(id);
        dr["start"] = start;
        dr["end"] = end;
        dr["id"] = id;
        dr["name"] = name;
        dr["column"] = resource;

        //table.Rows.Add(dr);
        table.AcceptChanges();
        #endregion

        return id;
    }

    protected void ButtonCancel_Click(object sender, EventArgs e)
    {
        Modal.Close(this);
    }

    private void initData()
    {
        string id = "AllFeatures";

        if (Session[id] == null)
        {
            Session[id] = DataGeneratorCalendar.GetData();
        }
        table = (DataTable)Session[id];
    }

    private DataRow loadEvent(string id)
    {
        initData();

        return table.Rows.Find(id);

    }

}
