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

public partial class New : Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bool time = Request.QueryString["time"] == "yes";

            if (time)
            {
                TextBoxStart.Text = Convert.ToDateTime(Request.QueryString["start"]).ToString();
                TextBoxEnd.Text = Convert.ToDateTime(Request.QueryString["end"]).ToString();
            }
            else
            {
                TextBoxStart.Text = Convert.ToDateTime(Request.QueryString["start"]).ToShortDateString();
                TextBoxEnd.Text = Convert.ToDateTime(Request.QueryString["end"]).ToShortDateString();
            }

            //TextBoxName.Focus();

            DropDownList1.SelectedValue = Request.QueryString["r"];
        }
    }
    protected void ButtonOK_Click(object sender, EventArgs e)
    {
        DateTime start = Convert.ToDateTime(TextBoxStart.Text);
        DateTime end = Convert.ToDateTime(TextBoxEnd.Text);
        string name = TextBoxName.Text;
        string resource = DropDownList1.SelectedValue;

        dbInsertEvent(start, end, name, resource);
        Modal.Close(this, "OK");
    }

    private string dbInsertEvent(DateTime start, DateTime end, string name, string resource)
    {
        initData();

        string id = Guid.NewGuid().ToString();

        #region Simulation of database update

        DataRow dr = table.NewRow();
        dr["start"] = start;
        dr["end"] = end;
        dr["id"] = id;
        dr["name"] = name;
        dr["column"] = resource;

        table.Rows.Add(dr);
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
        string id = Request.QueryString["hash"];

        if (Session[id] == null)
        {
            Session[id] = DataGeneratorScheduler.GetData();
        }
        table = (DataTable)Session[id];
    }

    protected void DropDownList1_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        TextBoxName.Text = DropDownList1.SelectedValue;
    }
}
