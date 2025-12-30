<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models.Library" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header">
	<h1>
        <span class="glyphicon glyphicon-edit"></span>
        <% if (ViewData["uid"] != null)
            { %> 
            编辑文章
        <% }
            else
            { %>
    		添加文章
        <% } %>
	</h1>
</div>

<% var payinfo = (tbl_wshoppayment)ViewData["payinfo"];
   if (payinfo != null)
   {
       ViewData["receiver"] = payinfo.receiver;
       ViewData["alipay_account"] = payinfo.alipay_account;
       ViewData["alipay_key"] = payinfo.alipay_key;
       ViewData["alipay_id"] = payinfo.alipay_partnerid;
       ViewData["fee"] = payinfo.fee;
       ViewData["sortid"] = payinfo.sortid;
       ViewData["status"] = payinfo.status;
   }
    %>
<div class="portlet-body form">
	<form action="#" id="form_agent" class="form-horizontal form-validate">
		<div class="form-body">
            <div class="alert alert-info">
	            <strong>提示：</strong> 尊敬的商户您好，为了确保您企业现金流的顺畅性，此处支付宝的类型为即时到帐，个人支付宝账号将不支持。
			</div>
			<div class="form-group">
				<label class="control-label col-md-2" for="paymode">交易类型<span class="required">*</span></label>
				<div class="col-md-3">
                    <label class="control-label">支付宝即时到账交易</label>
					<input type="hidden" name="paymode" id="paymode" data-required="1" value="<%= PAYMODE.ALIPAY %>" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-2" for="receiver">收款方名称：<span class="required">*</span></label>
				<div class="col-md-3">
                    <input type="text" class="form-control" id="receiver" name="receiver" value="<% if (ViewData["receiver"] != null) { %><%= ViewData["receiver"]%><% } %>" />
				</div>
			</div>			
			<div class="form-group">
				<label class="control-label col-md-2" for="alipay_account">支付宝收款账户：<span class="required">*</span></label>
				<div class="col-md-3">
                    <input type="text" class="form-control" id="alipay_account" name="alipay_account" value="<% if (ViewData["alipay_account"] != null) { %><%= ViewData["alipay_account"]%><% } else { %><% } %>" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-2" for="alipay_key">Key：<span class="required">*</span></label>
				<div class="col-md-3">
                    <input type="text" class="form-control" id="alipay_key" name="alipay_key" value="<% if (ViewData["alipay_key"] != null) { %><%= ViewData["alipay_key"]%><% } %>" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-2" for="alipay_id">Pid：<span class="required">*</span></label>
				<div class="col-md-3">
                    <input type="text" class="form-control" id="alipay_id" name="alipay_id" value="<% if (ViewData["alipay_id"] != null) { %><%= ViewData["alipay_id"]%><% } %>" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-2" for="fee">支付手续费：<span class="required">*</span></label>
				<div class="col-md-2">
                    <input type="text" class="form-control" id="fee" name="fee" value="<% if (ViewData["fee"] != null) { %><%= ViewData["fee"]%><% } else { %>0.000<% } %>" />
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-md-2" for="sortid">显示顺序<span class="required">*</span></label>
				<div class="col-md-2">
					<input type="text" name="sortid" id="sortid" data-required="1" class="form-control" <% if (ViewData["sortid"] != null) { %> value="<%= ViewData["sortid"] %>" <% } else { %>value="1"<% } %>/>
				</div>
				<span class="help-block">数字越小越靠前</span>
			</div>
		</div>
		<input type="hidden" id="uid" name="uid" <% if (ViewData["uid"] != null) { %> value="<%= ViewData["uid"] %>" <% } %> />
		<div class="form-actions fluid">
			<div class="col-md-offset-3 col-md-9">
                <button type="submit" data-loading-text="提交中..." class="loading-btn btn btn-primary">
				保存
				</button>
				<button type="button" class="btn default" onclick="window.history.go(-1);">取消</button>                              
			</div>
		</div>
	</form>
</div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageStyle" runat="server">
    <link rel="stylesheet" type="text/css" href="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.min.css" />
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/plugins/kindeditor-4.1.7/themes/default/default.css" />
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/css/select2.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
    <script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>  
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.validate.min.js"></script>
    <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/plugins/kindeditor-4.1.7/kindeditor-min.js"></script>
	<script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/plugins/kindeditor-4.1.7/lang/zh_CN.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/select2.min.js"></script>


	<script>
	    var handleValidation1 = function () {

	        var form1 = $('#form_agent');

	        $.validator.messages.required = "必须要填写";
	        $.validator.messages.number = jQuery.validator.format("请输入一个有效的数字.");
	        $.validator.messages.url = jQuery.validator.format("请输入有效的地址");

	        form1.validate({
	            errorElement: 'span', //default input error message container
	            errorClass: 'help-block error', // default input error message class
	            focusInvalid: false, // do not focus the last invalid input
	            ignore: "",
	            rules: {
	                receiver: {
	                    required: true
	                },
	                alipay_account: {
	                    required: true
	                },
	                alipay_id: {
	                    required: true
	                },
	                alipay_key: {
	                    required: true
	                },
	                fee: {
	                    number: true
	                },
	                sortid: {
	                    required: true,
	                    number: true
	                }
	            },

	            invalidHandler: function (event, validator) { //display error alert on form submit
	                $('.loading-btn').button('reset');
	            },

	            highlight: function (element) { // hightlight error inputs
	                $(element)
                            .closest('.form-group').addClass('has-error'); // set error class to the control group
	            },

	            unhighlight: function (element) { // revert the change done by hightlight
	                $(element)
                            .closest('.form-group').removeClass('has-error'); // set error class to the control group
	            },

	            success: function (label) {
	                label.closest('.form-group').removeClass('has-error'); // set success class to the control group
	            },

	            submitHandler: function (form) {
	                submitform();
	                return false;
	            }
	        });
	    }
	    jQuery(document).ready(function () {
	        handleValidation1();

	        $('.loading-btn')
		      .click(function () {
		          var btn = $(this)
		          btn.button('loading')
		      });

	    });

	    function redirectToListPage(status) {
	        if (status.indexOf("error") != -1) {
	            $('.alert-success').hide();
	            $('.loading-btn').button('reset');
	        } else {
	            window.location = rootUri + "SysSetting/Payment";
	        }
	    }

	    function submitform() {

	        $.ajax({
	            type: "POST",
	            url: rootUri + "SysSetting/SubmitPayment",
	            dataType: "json",
	            data: $('#form_agent').serialize(),
	            success: function (data) {
	                if (data == "") {
	                    toastr.options = {
	                        "closeButton": false,
	                        "debug": true,
	                        "positionClass": "toast-top-center",
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
	                        "positionClass": "toast-top-center",
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

    </script>
</asp:Content>
