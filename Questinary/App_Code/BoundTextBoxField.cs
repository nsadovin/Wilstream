using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace CustomBoundField
{

    /// <summary>
    /// Summary description for BoundTextBoxField
    /// </summary>
    public class BoundTextBoxField : System.Web.UI.WebControls.BoundField
    {

        public TextBoxMode TextMode
        {
            get
            {
                TextBoxMode _tm = TextBoxMode.SingleLine;
                if (this.ViewState["TextMode"] != null)
                    _tm = (TextBoxMode)this.ViewState["TextMode"];
                return _tm;
            }
            set { this.ViewState["TextMode"] = value; }
        }

        public int Columns
        {
            get
            {
                int i = 0;
                if (this.ViewState["Columns"] != null)
                    i = (int)this.ViewState["Columns"];
                return i;
            }
            set { this.ViewState["Columns"] = value; }
        }

        public int Rows
        {
            get
            {
                int i = 0;
                if (this.ViewState["Rows"] != null)
                    i = (int)this.ViewState["Rows"];
                return i;
            }
            set { this.ViewState["Rows"] = value; }
        }

        public bool Wrap
        {
            get
            {
                bool b = true;
                if (this.ViewState["Wrap"] != null)
                    b = (bool)this.ViewState["Wrap"];
                return b;
            }
            set { this.ViewState["Wrap"] = value; }
        }

        protected override void OnDataBindField(object sender, EventArgs e)
        {
            base.OnDataBindField(sender, e);
            Control c = (Control)sender;
            if (c is TextBox)
            {
                TextBox txt = (TextBox)c;
                txt.TextMode = this.TextMode;
                txt.Columns = this.Columns;
                txt.Rows = this.Rows;
                txt.Wrap = this.Wrap;
            }
        }

    }

}