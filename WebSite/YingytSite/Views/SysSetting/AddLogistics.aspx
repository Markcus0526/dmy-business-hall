<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<% 
    var logiinfo = (tbl_wshoplogistic)ViewData["logiinfo"];
    var deflogilist = (List<LOGISTICS_INFO>)ViewData["deflogilist"]; 
   %>
<div class="page-header">
	<h1>
		物流公司
		<small>
			<i class="ace-icon fa fa-angle-double-right"></i>
            <% if (ViewData["uid"] == null)
               { %>
			添加
            <% }
               else
               { %>
               编辑
            <% } %>
		</small>
        <a class="btn btn-white btn-default btn-round" onclick="window.history.go(-1)" style="float:right">
		    <i class="ace-icon fa fa-times red2"></i>
		    返回
	    </a>
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
		<form class="form-horizontal" role="form" id="validation-form">

        <% if (deflogilist != null)
           { %>
            <div class="form-group" >
				<label class="col-sm-3 control-label no-padding-right" for="name">常用物流公司：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<select name="deflist" id="deflist" onchange="setDefLogistics()">
                        <option value="-1">请选择</option>
                    <% for (int i = 0; i < deflogilist.Count; i++)
                       {
                           var item = deflogilist[i]; 
                    %>
                        <option value="<%= i %>"><%= item.name %></option>
                    <% } %>
                    </select>
                    </div>
				</div>
			</div>
        <% } %>

			<div class="form-group" >
				<label class="col-sm-3 control-label no-padding-right" for="name">物流公司名称：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="name" name="name" placeholder="请输入物流公司名称" class="input-large form-control" <% if (logiinfo != null) { %>value="<%= logiinfo.name %>"<% } %> />
                    </div>
				</div>
			</div>
            <div class="form-group" >
				<label class="col-sm-3 control-label no-padding-right" for="url">物流公司网址：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="url" name="url" placeholder="请输入物流公司网址" class="input-large form-control" <% if (logiinfo != null) { %>value="<%= logiinfo.url %>"<% } %> />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="sortid">排序：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="sortid" name="sortid" placeholder="请输入数字" class="input-large form-control col-xs-10 col-sm-5" <% if (logiinfo != null) { %>value="<%= logiinfo.sortid %>"<% } else { %>value="1"<% } %>  />
                    <span class="help-inline col-xs-12 col-sm-7">
						<span class="middle">数字越小越靠前</span>
					</span>
                    </div>
				</div>
			</div>

            <input type="hidden" id="uid" name="uid" value="<% if (ViewData["uid"] != null) { %><%= ViewData["uid"] %><% } else { %>0<% } %>" />

			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
                    <button class="btn btn-sm btn-purple loading-btn" type="submit" data-loading-text="提交中...">
						<i class="ace-icon fa fa-floppy-o bigger-125"></i>
						提交
					</button>
					&nbsp; &nbsp; &nbsp;
					<button class="btn btn-sm" type="reset">
						<i class="ace-icon fa fa-undo bigger-110"></i>
						重置
					</button>
				</div>
			</div>
        </form>
	</div>
</div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageStyle" runat="server">
	<link rel="stylesheet" type="text/css" href="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.min.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
	<script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>  
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.validate.min.js"></script>
	<script type="text/javascript">
	    function redirectToListPage(status) {
	        if (status.indexOf("error") != -1) {
	            $('.loading-btn').button('reset');
	        } else {
	            window.location = rootUri + "SysSetting/LogisticsList";
	        }
	    }
	    jQuery(function ($) {
	        $('.loading-btn')
		      .click(function () {
		          var btn = $(this)
		          btn.button('loading')
		      });

	        $.validator.messages.required = "必须要填写";
	        $.validator.messages.number = jQuery.validator.format("请输入一个有效的数字.");
	        $.validator.messages.minlength = jQuery.validator.format("必须由至少{0}个字符组成.");
	        $.validator.messages.maxlength = jQuery.validator.format("必须由最多{0}个字符组成");
	        $('#validation-form').validate({
	            errorElement: 'span',
	            errorClass: 'help-block',
	            //focusInvalid: false,
	            rules: {
	                name: {
	                    required: true,
	                    uniquename: true
	                },
	                url: {
	                    required: true
	                },
	                sortid: {
	                    required: true,
	                    number: true
	                }
	            },
	            highlight: function (e) {
	                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
	            },

	            success: function (e) {
	                $(e).closest('.form-group').removeClass('has-error'); //.addClass('has-info');
	                $(e).remove();
	            },

	            errorPlacement: function (error, element) {
	                if (element.is(':checkbox') || element.is(':radio')) {
	                    var controls = element.closest('div[class*="col-"]');
	                    if (controls.find(':checkbox,:radio').length > 1) controls.append(error);
	                    else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
	                }
	                else if (element.is('.select2')) {
	                    error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
	                }
	                else if (element.is('.chosen-select')) {
	                    error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
	                }
	                else error.insertAfter(element.parent());
	            },

	            submitHandler: function (form) {
	                submitform();
	                return false;
	            },
	            invalidHandler: function (form) {
	                $('.loading-btn').button('reset');
	            }
	        });
	        $.validator.addMethod("uniquename", function (value, element) {
	            return checkTagName();
	        }, "公司名已存在");
	    });

	    function submitform() {
	        $.ajax({
	            type: "POST",
	            url: rootUri + "SysSetting/SubmitLogistics",
	            dataType: "json",
	            data: $('#validation-form').serialize(),
	            success: function (data) {
	                if (data == "") {
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

	                    toastr["success"]("操作成功!", "恭喜您");
	                } else {
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

	                    toastr["error"](data, "温馨敬告");

	                }
	            },
	            error: function (data) {
	                alert("Error: " + data.status);
	                $('.loading-btn').button('reset');
	            }
	        });
	    }

	    function checkTagName() {
	        var name = $("#name").val();
	        var retval = false;

	        $.ajax({
	            async: false,
	            type: "GET",
	            url: rootUri + "SysSetting/CheckUniqueLogisticsName",
	            dataType: "json",
	            data: {
	                name: name,
	                uid: $("#uid").val()
	            },
	            success: function (data) {
	                if (data == true) {
	                    retval = true;
	                } else {
	                    retval = false;
	                }
	            }
	        });

	        return retval;
	    }

	    function setDefLogistics() {
	        var selId = $("#deflist").val();
	        if (selId < 0) {
	            return false;
	        }
            var deflogilist = <%= new JavaScriptSerializer().Serialize(ViewData["deflogilist"]) %>;
	        var selItem = deflogilist[selId];
	        $("#name").val(selItem.name);
            $("#url").val(selItem.url);
        }
    </script>
</asp:Content>