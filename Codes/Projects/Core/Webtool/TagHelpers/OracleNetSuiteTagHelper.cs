using Microsoft.AspNetCore.Razor.TagHelpers;

namespace Webtool.TagHelpers
{
    // You may need to install the Microsoft.AspNetCore.Razor.Runtime package into your project
    [HtmlTargetElement("Oracle-NetSuite")]
    public class OracleNetsuiteTagHelper : TagHelper
    {
        public override void Process(TagHelperContext context, TagHelperOutput output)
        {
            output.Content.SetHtmlContent("NSPOS Webtool");
            output.TagName = "font color = \"#ff0000\"";
        }
    }
}
