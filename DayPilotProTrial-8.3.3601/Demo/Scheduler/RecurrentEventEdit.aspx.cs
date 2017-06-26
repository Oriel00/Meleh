using System;
using System.Data;
using DayPilot.Web.Ui.Recurrence;

public partial class Scheduler_RecurrentEventEdit : System.Web.UI.Page
{
    private DataTable table;
    private RecurrenceRule _rule = RecurrenceRule.NoRepeat;



    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetNoStore();

        string data = Request.QueryString["hash"];
        if (Session[data] == null)
        {
            throw new Exception("The session data expired.");
        }
        table = (DataTable)Session[data];

        DataRow row = table.Rows.Find(Request.QueryString["id"]);
        DataRow master = table.Rows.Find(Request.QueryString["master"]);

        if (!IsPostBack)
        {
            switch (Mode)
            {
                case EventMode.Master:
                    _rule = RecurrenceRule.Decode((string)master["recurrence"]);
                    TextBoxStart.Text = ((DateTime)master["start"]).ToString();
                    TextBoxEnd.Text = ((DateTime)master["end"]).ToString();
                    TextBoxName.Text = (string)master["name"];
                    break;
                case EventMode.NewException:
                    _rule = RecurrenceRule.Exception;
                    DateTime start = Occurrence;
                    TimeSpan duration = (DateTime)master["end"] - (DateTime)master["start"];
                    DateTime end = start + duration;
                    TextBoxStart.Text = start.ToString();
                    TextBoxEnd.Text = end.ToString();
                    TextBoxName.Text = (string)master["name"];
                    break;
                case EventMode.Exception:
                    _rule = RecurrenceRule.Exception;
                    TextBoxStart.Text = ((DateTime)row["start"]).ToString();
                    TextBoxEnd.Text = ((DateTime)row["end"]).ToString();
                    TextBoxName.Text = (string)row["name"];
                    break;
                case EventMode.Regular:
                    _rule = RecurrenceRule.NoRepeat;
                    TextBoxStart.Text = ((DateTime)row["start"]).ToString();
                    TextBoxEnd.Text = ((DateTime)row["end"]).ToString();
                    TextBoxName.Text = (string)row["name"];
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }
    }

    private EventMode Mode
    {
        get
        {
            if (!String.IsNullOrEmpty(Request.QueryString["master"])) 
            {
                if (!String.IsNullOrEmpty(Request.QueryString["start"]))
                {
                    return EventMode.NewException;
                }
                if (!String.IsNullOrEmpty(Request.QueryString["id"])) {
                    return EventMode.Exception;
                }
                return EventMode.Master;
            }

            return EventMode.Regular;
        }
        
    }

    enum EventMode
    {
        Master,
        NewException,
        Exception,
        Regular
    }

    private DateTime Occurrence
    {
        get
        {
            return Convert.ToDateTime(Request.QueryString["start"]);
        }
    }

    protected string RecurrenceJson
    {
        get
        {
            return _rule.ToJson();
        }
    }
    protected void ButtonSave_Click(object sender, EventArgs e)
    {
        string id = Request.QueryString["id"];
        string masterId = Request.QueryString["master"];

        DataRow master = table.Rows.Find(masterId);
        DataRow row = table.Rows.Find(id);

        switch (Mode)
        {
            case EventMode.Master:
                RecurrenceRule rule = RecurrenceRule.FromJson(masterId, (DateTime)master["start"], Recurrence.Value);
                master["name"] = TextBoxName.Text;
                master["start"] = Convert.ToDateTime(TextBoxStart.Text);
                master["end"] = Convert.ToDateTime(TextBoxEnd.Text);
                master["recurrence"] = rule.Encode();
                table.AcceptChanges();
                break;
            case EventMode.NewException:
                DataRow r = table.NewRow();
                r["id"] = Guid.NewGuid().ToString();
                r["name"] = TextBoxName.Text;
                r["start"] = Convert.ToDateTime(TextBoxStart.Text);
                r["end"] = Convert.ToDateTime(TextBoxEnd.Text);
                r["recurrence"] = RecurrenceRule.EncodeExceptionModified(masterId, Occurrence);
                table.Rows.Add(r);
                table.AcceptChanges();
                break;
            case EventMode.Exception:
                row["name"] = TextBoxName.Text;
                row["start"] = Convert.ToDateTime(TextBoxStart.Text);
                row["end"] = Convert.ToDateTime(TextBoxEnd.Text);
                table.AcceptChanges();
                break;
            case EventMode.Regular:
                row["name"] = TextBoxName.Text;
                row["start"] = Convert.ToDateTime(TextBoxStart.Text);
                row["end"] = Convert.ToDateTime(TextBoxEnd.Text);
                row["recurrence"] = RecurrenceRule.FromJson(id, (DateTime)row["start"], Recurrence.Value).Encode();
                table.AcceptChanges();
                break;
            default:
                throw new ArgumentOutOfRangeException();
        }

        Modal.Close(this, "OK");
    }
    protected void ButtonCancel_Click(object sender, EventArgs e)
    {
        Modal.Close(this);
    }
}
