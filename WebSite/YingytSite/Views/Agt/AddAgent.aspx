<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<% var agentinfo = (tbl_user)ViewData["agentinfo"]; %>
<div class="page-header">
	<h1>
		城市代理
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
            代理
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
			<div class="form-group" <% if (ViewData["uid"] != null) { %>style="display:none"<% } %>>
				<label class="col-sm-3 control-label no-padding-right" for="agentname">代理账号<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="userid" name="userid" placeholder="请输入用户名" class="col-xs-10 col-sm-5" <% if (agentinfo != null) { %>value="<%= agentinfo.userid %>"<% } %> />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="nickname">代理名称<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="username" name="username" placeholder="请输入代理名称" class="col-xs-10 col-sm-5" <% if (agentinfo != null) { %>value="<%= agentinfo.username %>"<% } %> />
                    </div>
				</div>
			</div>
			<div class="form-group" <% if (agentinfo != null) { %>style="display:none;"<% } %>>
				<label class="col-sm-3 control-label no-padding-right" for="agentpwd">密码<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="password" id="agentpwd" name="agentpwd" placeholder="请输入密码" class="col-xs-10 col-sm-5" />
                    </div>
				</div>
			</div>
			<div class="form-group" <% if (agentinfo != null) { %>style="display:none;"<% } %>>
				<label class="col-sm-3 control-label no-padding-right" for="confirmpwd">确认密码：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="password" id="confirmpwd" name="confirmpwd" placeholder="请输入确认密码" class="col-xs-10 col-sm-5" />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="company">公司名称<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="agentname" name="agentname" placeholder="请输入公司名称" class="col-xs-10 col-sm-5" <% if (agentinfo != null) { %>value="<%= agentinfo.agentname %>"<% } %> />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="addrdetail">详细地址<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix" style="margin-bottom:10px;">
                        <select class="col-xs-10 col-sm-2" id="province" onchange="ChangeProvince();">
						    <% 
                                List<tbl_ecsregion> provinces = (List<tbl_ecsregion>)ViewData["provinces"];
                                if (provinces != null)
                                {
                                    for (int i = 0; i < provinces.Count; i++)
                                    {
                                        tbl_ecsregion item = provinces.ElementAt(i);
                                        if (ViewData["agentprovince"] != null && item.uid == (long)ViewData["agentprovince"])
                                        {
                                        %>
                                        <option value="<% =item.uid %>" selected><% =item.regionname%></option>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <option value="<% =item.uid %>"><% =item.regionname%></option>
                                        <%
                                        }
                                    }
                                }
                            %>
					    </select>
                        <span style="float:left;">&nbsp;&nbsp;</span>
                        <select class="col-xs-10 col-sm-2" id="city" name="city">
						    <% 
                                List<tbl_ecsregion> cities = (List<tbl_ecsregion>)ViewData["cities"];
                                if (cities != null)
                                {
                                    for (int i = 0; i < cities.Count; i++)
                                    {
                                        tbl_ecsregion item = cities.ElementAt(i);
                                        if(agentinfo != null && item.uid == agentinfo.addrid) {
                                        %>
                                        <option value="<% =item.uid %>" selected><% =item.regionname %></option>
                                        <%
                                        } else {
                                        %>
                                        <option value="<% =item.uid %>"><% =item.regionname %></option>
                                        <%
                                        }
                                    }
                                }
                            %>
					    </select>
                    </div>
                    <div class="clearfix">
					<input type="text" id="addr" name="addr" placeholder="请输入详细地址" class="col-xs-10 col-sm-5" <% if (agentinfo != null) { %>value="<%= agentinfo.addr %>"<% } %> />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="company">联系人<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="connector" name="connector" placeholder="请输入联系人" class="col-xs-10 col-sm-5" <% if (agentinfo != null) { %>value="<%= agentinfo.connector %>"<% } %> />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="company">电话<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="phonenum" name="phonenum" placeholder="请输入电话" class="col-xs-10 col-sm-5" <% if (agentinfo != null) { %>value="<%= agentinfo.phonenum %>"<% } %> />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="company">邮箱<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="mailaddr" name="mailaddr" placeholder="请输入邮箱" class="col-xs-10 col-sm-5" <% if (agentinfo != null) { %>value="<%= agentinfo.mailaddr %>"<% } %> />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="qqnum">QQ：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
                        <span class="input-icon input-icon-right">
					        <input type="text" id="qqnum" name="qqnum" placeholder="请输入QQ" <% if (agentinfo != null) { %>value="<%= agentinfo.qqnum %>"<% } %> />
							<i class="ace-icon fa fa-qq"></i>
						</span>
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="status">状态<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
						<label>
							<input id="status" name="status" class="ace ace-switch ace-switch-3" type="checkbox" <% if (agentinfo != null) { if(agentinfo.status == 1) { %>checked<% } } else { %>checked<% } %>/>
							<span class="lbl">
		                        <!--[if IE]>启用<![endif]-->
                            </span>
                        </label>
                    </div>
				</div>
			</div>

            <input type="hidden" id="uid" name="uid" value="<% if (ViewData["uid"] != null) { %><%= ViewData["uid"] %><% } else { %>0<% } %>" />

			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-info loading-btn" type="submit" data-loading-text="提交中...">
						<i class="ace-icon fa fa-check bigger-110"></i>
						提交
					</button>

					&nbsp; &nbsp; &nbsp;
					<button class="btn" type="reset" onclick="window.location = '<% if(ViewData["uid"] == null) { %><% =ViewData["rootUri"] %>Agt/AddAgent<% } else { %> <% =ViewData["rootUri"] %>Agt/EditAgent/<% =ViewData["uid"] %><% } %>'">
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
	<script src="<%= ViewData["rootUri"] %>Content/js/validate.messages_zh.js"></script>
	<script type="text/javascript">
	    function redirectToListPage(status) {
	        if (status.indexOf("error") != -1) {
	            $('.loading-btn').button('reset');
	        } else {
	            window.location = rootUri + "Agt/AgentList";
	        }
	    }
	    jQuery(function ($) {
	        $('.loading-btn')
		      .click(function () {
		          var btn = $(this)
		          btn.button('loading')
		      });

	        /*$.validator.messages.required = "必须要填写";
	        $.validator.messages.minlength = jQuery.validator.format("必须由至少{0}个字符组成.");
	        $.validator.messages.maxlength = jQuery.validator.format("必须由最多{0}个字符组成");
	        $.validator.messages.equalTo = jQuery.validator.format("密码不一致.");*/
	        $('#validation-form').validate({
	            errorElement: 'span',
	            errorClass: 'help-block',
	            //focusInvalid: false,
	            rules: {
	                userid: {
	                    required: true,
                        uniquename: true
	                },
	                username: {
	                    required: true
	                },
	                agentpwd: {
	                    required: true
	                },
	                confirmpwd: {
	                    required: true,
                        equalTo: "#agentpwd"
	                },
	                agentname: {
	                    required: true
	                },
	                city: {
	                    required: true
	                },
	                addr: {
	                    required: true
	                },
	                connector: {
	                    required: true
	                },
	                phonenum: {
	                    required: true,
                        number: true                        
	                },
	                mailaddr: {
	                    required: true,
                        email: true
	                },
	                qqnum: {
	                    //required: true,
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
	            return checkAgentName();
	        }, "用户名已存在");
	    });

	    function submitform() {
	        $.ajax({
	            type: "POST",
	            url: rootUri + "Agt/SubmitAgent",
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

	    function checkAgentName() {
	        var agentid = $("#userid").val();
	        var retval = false;

	        $.ajax({
	            async: false,
	            type: "GET",
	            url: rootUri + "Agt/CheckUniqueAgentname",
	            dataType: "json",
	            data: {
	                agentid: agentid
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

	    function ChangeProvince() {
	        var provin = $("#province").val();
	        $.ajax({
	            async: false,
	            type: "GET",
	            url: rootUri + "Region/GetCityListFull",
	            dataType: "json",
	            data: {
	                provin: provin
	            },
	            success: function (data) {
	                if (data != null) {
	                    var cities = [];
	                    cities = data.city;
	                    var htmlStr = "";
	                    for (var i = 0; i < cities.length; i++) {
	                        htmlStr += '<option value="' + cities[i].uid + '">' + cities[i].regionname + '</option>';
	                    }
	                    $("#city").html(htmlStr);
	                } else {
	                    $("#city").html("");
	                }
	            }
	        });
	    }

    </script>
</asp:Content>