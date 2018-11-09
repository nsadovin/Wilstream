using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Сводное описание для EmailTemplate
/// </summary>
public    class EmailTemplate
{
    string _template = "";
    public EmailTemplate(string template)
    {
        _template = template;
    }

    Dictionary<string, string> _params = new Dictionary<string, string>();

    public void AddParam(string place, string value)
    {
        if (!_params.ContainsKey(place))
            _params.Add(place, value);
        else
            _params[place] = value;
    }
    public void AddParam(string value)
    {
        _params.Add(value, value);
    }

    public string GetFullBody()
    {
        var body = _template;
        foreach (KeyValuePair<string, string> item in _params)
        {
            body = body.Replace("[" + item.Key + "]", item.Value);
        }
        return body;
    }

}
