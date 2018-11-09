using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OketllManualTask : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void dvTaskOktell_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        gvOktellTasks.DataBind();
    }


    protected void dvTaskOktell_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {

      
    }
}