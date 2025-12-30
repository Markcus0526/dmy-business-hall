<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="WeiShopSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<% var deliveryinfo = (tbl_wshopdelivery)ViewData["deliveryinfo"]; %>
<div class="page-header">
	<h1>
		配送方式
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
            方式
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
			<div class="form-group" >
				<label class="col-sm-3 control-label no-padding-right" for="name">配送方式名称：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="name" name="name" placeholder="请输入标签名称" class="input-large form-control" <% if (deliveryinfo != null) { %>value="<%= deliveryinfo.name %>"<% } %> />
                    </div>
				</div>
			</div>
            <div class="form-group" >
				<label class="col-sm-3 control-label no-padding-right" for="deliverytype">配送类型：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<select name="deliverytype" id="deliverytype">
                        <option value="0">先付款后发货</option>
                        <option value="1">货到付款</option>
                    </select>
                    </div>
				</div>
			</div>
            <div class="form-group" >
				<label class="col-sm-3 control-label no-padding-right" for="logistics">默认物流公司：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<select name="logistics" id="logistics">
                        <option value="">请选择</option>
                        <% foreach (var item in (List<tbl_wshoplogistic>)ViewData["logilist"]) { %>
                            <option <% if (deliveryinfo != null && deliveryinfo.logisticsid == item.uid) { %>selected<% } %>
                            value="<%= item.uid %>" ><%= item.name %></option>    
                        <% } %>
                    </select>
                    </div>
				</div>
			</div>

            <div class="form-group" >
				<label class="col-sm-3 control-label no-padding-right" for="name">配送费用：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
                        <div>
                            <table border="0" cellspacing="0" cellpadding="0" style="width:auto; display: inline;">
                            	<tr>
                                    <td class="form-group">
                                        首重重量
                                    </td>
                            		<td class="form-group">
                                        <div>
                                        <select name="fstweight" id="fstweight">
                                        <% foreach (var item in (List<DeliveryWeight>)DeliveryModel.GetDefDeliveryWeight()) { %>
                                            <option <% if (deliveryinfo != null && deliveryinfo.fstweight == item.weight) { %>selected<% } %>
                                            value="<%= item.weight %>"><%= item.name %></option>
                                        <% } %>
                                        </select>
                                        </div>
                                    </td>
                                    <td>* 续重重量</td>
                                    <td class="form-group">
                                        <div>
                                        <select name="contunits" id="contunits">
                                        <% foreach (var item in (List<DeliveryWeight>)DeliveryModel.GetDefDeliveryWeight()) { %>
                                            <option <% if (deliveryinfo != null && deliveryinfo.contunits == item.weight) { %>selected<% } %>
                                            value="<%= item.weight %>"><%= item.name %></option>
                                        <% } %>
                                        </select>
                                        </div>
                                    </td>
                                    <td>*</td>
                            	</tr>
                            </table>
                        </div>
                    </div>
				</div>
			</div>

            <div class="form-group" >
				<label class="col-sm-3 control-label no-padding-right" for="name">配送费用：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
                        <div>
                            <table border="0" cellspacing="0" cellpadding="0" style="width:auto; display: inline;">
                            	<tr>
                                    <td class="form-group">
                                        首重价格
                                    </td>
                            		<td class="form-group">
                                        <div>
                                        <input type="text" name="fstprice" id="fstprice" class="form-control input-small" style=""  
                                        <% if (deliveryinfo != null) { %> value="<%= deliveryinfo.fstprice %>" <% } %> />
                                        </div>
                                    </td>
                                    <td>* 续重价格</td>
                                    <td class="form-group">
                                    <div>
                                        <input type="text" name="contprice" id="contprice" class="form-control input-small has-error" style="width:auto; display: inline"  
                                        <% if (deliveryinfo != null) { %> value="<%= deliveryinfo.contprice %>" <% } %> />
                                        </div>
                                    </td>
                                    <td>*</td>
                            	</tr>
                            </table>
                        </div>
                        <div>
                            根据重量来计算运费，当物品不足《首重重量》时，按照《首重费用》计算，超过部分按照《续重重量》和《续重费用》乘积来计算
                        </div>

                    </div>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="sortid">排序：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="sortid" name="sortid" placeholder="请输入数字" class="input-large form-control col-xs-10 col-sm-5" <% if (deliveryinfo != null) { %>value="<%= deliveryinfo.sortid %>"<% } else { %>value="1"<% } %>  />
                    <span class="help-inline col-xs-12 col-sm-7">
						<span class="middle">数字越小越靠前</span>
					</span>
                    </div>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="contents">品牌介绍：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
                        <textarea class="form-control" id="contents" name="contents" style="height:300px; width:780px;"><% if (deliveryinfo != null && deliveryinfo.contents != null) { %><%= deliveryinfo.contents%><% } %></textarea>
                    </div>
				</div>
			</div>

            <input type="hidden" id="uid" name="uid" value="<% if (ViewData["uid"] != null) { %><%= ViewData["uid"] %><% } else { %>0<% } %>" />
            <input type="hidden" id="esccontent" name="esccontent" <% if (deliveryinfo != null && deliveryinfo.contents != null) { %>value="<%= deliveryinfo.contents %>" <% } else { %> value=""<% } %> />

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
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/plugins/kindeditor-4.1.7/themes/default/default.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
	<script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>  
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.validate.min.js"></script>
    <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/plugins/kindeditor-4.1.7/kindeditor-min.js"></script>
	<script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/plugins/kindeditor-4.1.7/lang/zh_CN.js"></script>

	<script type="text/javascript">
	    var editor;
	    function redirectToListPage(status) {
	        if (status.indexOf("error") != -1) {
	            $('.loading-btn').button('reset');
	        } else {
	            window.location = rootUri + "SysSetting/DeliveryList";
	        }
	    }

	    KindEditor.ready(function (K) {
	        editor = K.create('textarea[name="contents"]', {
                uploadJson: "<%= ViewData["rootUri"] %>Upload/UploadKindEditorImage",
                fileManagerJson: "<%= ViewData["rootUri"] %>Upload/ProcessKindEditorRequest",
                allowFileManager: true,
                allowUpload: true,
                resizeType:1,
                afterChange:function(){
                    if (editor != null)
                    {
                        editor.sync();
                    }
                }
	        });

			var imgeditor = K.editor({
				allowFileManager : true,
                uploadJson: "<%= ViewData["rootUri"] %>Upload/UploadKindEditorImage",
                fileManagerJson: "<%= ViewData["rootUri"] %>Upload/ProcessKindEditorRequest",
			});
			K('#image1').click(function() {
				imgeditor.loadPlugin('image', function() {
					imgeditor.plugin.imageDialog({
						imageUrl : K('#imgpath').val(),
						clickFn : function(url, title, width, height, border, align) {
                            $("#Img1").attr("src", url);
							K('#imgpath1').val(url);
							imgeditor.hideDialog();
						}
					});
				});
			});
	    });

	    jQuery(function ($) {
	        $('.loading-btn')
		      .click(function () {
		          var btn = $(this)
		          btn.button('loading')
		      });

            var recvcontents = "<%= ViewData["contents"] %>";
            var conthtml = unescape(recvcontents);
            $("#contents").html(conthtml);
            if (editor != undefined) {
                editor.html(conthtml);
                editor.sync();
            }

	        $.validator.messages.required = "必须要填写";
	        $.validator.messages.number = jQuery.validator.format("请输入一个有效的数字.");
	        $.validator.messages.url = jQuery.validator.format("请输入有效的地址");
	        $('#validation-form').validate({
	            errorElement: 'span',
	            errorClass: 'help-block',
	            //focusInvalid: false,
	            rules: {
	                name: {
	                    required: true,
	                    uniquename: true
	                },
	                logistics: {
	                    required: true
	                },
                    fstprice: {
	                    required: true,
                        number: true
	                },
                    contprice: {
	                    required: true,
                        number: true
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
	            return checkBrandName();
	        }, "用户名已存在");
	    });

	    function submitform() {
            $("#esccontent").attr("value", escape($("#contents").val()));

	        $.ajax({
	            type: "POST",
	            url: rootUri + "SysSetting/SubmitDelivery",
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

	    function checkBrandName() {
	        var brandname = $("#brandname").val();
	        var retval = false;

	        $.ajax({
	            async: false,
	            type: "GET",
	            url: rootUri + "SysSetting/CheckUniqueDeliveryName",
	            dataType: "json",
	            data: {
	                brandname: brandname,
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
    </script>
</asp:Content>