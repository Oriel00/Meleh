<script language="c#" runat="server">
public void Page_Load(object sender, EventArgs e)
{
   Response.Status = "301 Moved Permanently";
   Response.AddHeader("Location","ScaleYears.aspx");
}
</script>