<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Lobby/Lobby.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header">
	<h1>
		演示模板
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
        <div class="divtemplate">
        <ul class="cateradio unstyled">
        <%
            List<tbl_template> templatelist = (List<tbl_template>)ViewData["templates"];
            if (templatelist != null)
            {
                for (int i = 0; i < templatelist.Count(); i++)
                {
                    tbl_template item = templatelist.ElementAt(i);
             %>
                <li class="free <% if (item.uid == (long)ViewData["tid"]) { %>active<% } %>" name="catehome">
                    <div class="mbtip"><% =item.description %></div>
                    <label>
                        <img src="<%= ViewData["rootUri"] %><% =item.imgpath %>" alt="<% =item.description %>" title="<% =item.title %>">
		                <label>
			                <input name="form-field-radio" type="radio" class="ace" <% if (item.uid == (long)ViewData["tid"]) { %>checked<% } %> onclick="SetTemplate(<% =item.uid %>)" />
			                <span class="lbl"><% =item.title %></span>
		                </label>
                    </label>
                </li>
            <%
                }
            }
            %>
            <!--<li class="free active" name="catehome">
                <div class="mbtip">TOP1</div>
                <label>
                    <img src="<%= ViewData["rootUri"] %>Content/phonetemplate/temp1.png" alt="TOP1" title="TOP1">
		            <label>
			            <input name="form-field-radio" type="radio" class="ace" />
			            <span class="lbl"> 模板1</span>
		            </label>
                </label>
            </li>
            <li class="free" name="catehome">
                <div class="mbtip">图标式模板，背景在微官网的首页幻灯片里添加，建议尺寸为960*640或近似等比例图；分类图标请选择系统图标。</div>
                <label>
                    <img src="<%= ViewData["rootUri"] %>Content/phonetemplate/temp2.png" alt="TOP2" title="TOP2">
		            <label>
			            <input name="form-field-radio" type="radio" class="ace" />
			            <span class="lbl"> 模板2</span>
		            </label>
                </label>
            </li>
            <li class="free" name="catehome">
                <div class="mbtip">图标式模板，背景在微官网的首页幻灯片里添加，建议尺寸为960*640或近似等比例图；分类图标请选择系统图标。</div>
                <label>
                    <img src="<%= ViewData["rootUri"] %>Content/phonetemplate/temp2.png" alt="TOP2" title="TOP2">
		            <label>
			            <input name="form-field-radio" type="radio" class="ace" />
			            <span class="lbl"> 模板2</span>
		            </label>
                </label>
            </li>
            <li class="" name="catehome">
                <div class="mbtip">图标式模板，背景在微官网的首页幻灯片里添加，建议尺寸为960*640或近似等比例图；分类图标请选择系统图标。</div>
                <label>
                    <img src="<%= ViewData["rootUri"] %>Content/phonetemplate/temp2.png" alt="TOP2" title="TOP2">
		            <label>
			            <input name="form-field-radio" type="radio" class="ace" />
			            <span class="lbl"> 模板2</span>
		            </label>
                </label>
            </li>
            <li class="" name="catehome">
                <div class="mbtip">图标式模板，背景在微官网的首页幻灯片里添加，建议尺寸为960*640或近似等比例图；分类图标请选择系统图标。</div>
                <label>
                    <img src="<%= ViewData["rootUri"] %>Content/phonetemplate/temp2.png" alt="TOP2" title="TOP2">
		            <label>
			            <input name="form-field-radio" type="radio" class="ace" />
			            <span class="lbl"> 模板2</span>
		            </label>
                </label>
            </li>
            <li class="" name="catehome">
                <div class="mbtip">图标式模板，背景在微官网的首页幻灯片里添加，建议尺寸为960*640或近似等比例图；分类图标请选择系统图标。</div>
                <label>
                    <img src="<%= ViewData["rootUri"] %>Content/phonetemplate/temp2.png" alt="TOP2" title="TOP2">
		            <label>
			            <input name="form-field-radio" type="radio" class="ace" />
			            <span class="lbl"> 模板2</span>
		            </label>
                </label>
            </li>
            <li class="" name="catehome">
                <div class="mbtip">图标式模板，背景在微官网的首页幻灯片里添加，建议尺寸为960*640或近似等比例图；分类图标请选择系统图标。</div>
                <label>
                    <img src="<%= ViewData["rootUri"] %>Content/phonetemplate/temp2.png" alt="TOP2" title="TOP2">
		            <label>
			            <input name="form-field-radio" type="radio" class="ace" />
			            <span class="lbl"> 模板2</span>
		            </label>
                </label>
            </li>
            <li class="new" name="catehome">
                <div class="mbtip">图标式模板，背景在微官网的首页幻灯片里添加，建议尺寸为960*640或近似等比例图；分类图标请选择系统图标。</div>
                <label>
                    <img src="<%= ViewData["rootUri"] %>Content/phonetemplate/temp2.png" alt="TOP2" title="TOP2">
		            <label>
			            <input name="form-field-radio" type="radio" class="ace" />
			            <span class="lbl"> 模板2</span>
		            </label>
                </label>
            </li>
            <li class="new" name="catehome">
                <div class="mbtip">图标式模板，背景在微官网的首页幻灯片里添加，建议尺寸为960*640或近似等比例图；分类图标请选择系统图标。</div>
                <label>
                    <img src="<%= ViewData["rootUri"] %>Content/phonetemplate/temp3.png" alt="TOP2" title="TOP2">
		            <label>
			            <input name="form-field-radio" type="radio" class="ace" />
			            <span class="lbl"> 模板2</span>
		            </label>
                </label>
            </li>-->
        </ul>
        </div>

    </div>
</div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageStyle" runat="server">
	<link rel="stylesheet" type="text/css" href="<%= ViewData["rootUri"] %>Content/css/official.css" />
    <link rel="stylesheet" type="text/css" href="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.min.css" /> 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
    <script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>  
    <script type="text/javascript">
        $(function () {
            $("div.divtemplate input[type='radio']").click(function () {
                var $this = $(this), $key = $this.attr("name"), $value = $this.val();
                var _pli = $this.parents("li");

                _pli.siblings().removeClass("active");
                
                _pli.addClass("active");
            })
        })

        function SetTemplate(sel_id) {
            $.ajax({
                url: rootUri + "Lobby/LTemplate/SetTemplate",
                data: {
                    "id": sel_id
                },
                type: "post",
                success: function (message) {
                    if (message == true) {
                        toastr.options = {
                            "closeButton": false,
                            "debug": true,
                            "positionClass": "toast-bottom-right",
                            "onclick": null,
                            "showDuration": "3",
                            "hideDuration": "3",
                            "timeOut": "1500",
                            "extendedTimeOut": "1000",
                            "showEasing": "swing",
                            "hideEasing": "linear",
                            "showMethod": "fadeIn",
                            "hideMethod": "fadeOut"
                        };
                        toastr["success"]("操作成功！", "恭喜您");
                    }
                }
            });
        }

    </script>
</asp:Content>
