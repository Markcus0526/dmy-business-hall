<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Agent/Agent.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<% var hallinfo = (HallInfo)ViewData["hallinfo"]; %>
<div class="page-header">
	<h1>
		营业厅
		<small>
			<i class="ace-icon fa fa-angle-double-right"></i>
            <% if (ViewData["uid"] == null)
               { %>
			添加
            <% }
               else
               { %>
               详细
            <% } %>
            营业厅
		</small>
        <a class="btn btn-white btn-default btn-round" onclick="window.location='<%= ViewData["rootUri"] %>Agent/AHall/AHallList'" style="float:right">
		    <i class="ace-icon fa fa-times red2"></i>
		    返回
	    </a>
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
		<form class="form-horizontal" role="form" id="validation-form">
			<div class="form-group" <% if (ViewData["uid"] != null) { %>style="display:none"<% } %>>
				<label class="col-sm-3 control-label no-padding-right" for="hallname">营业厅账号<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" readonly id="hallname" name="hallname" placeholder="请输入用户名" class="col-xs-10 col-sm-5" <% if (hallinfo != null) { %>value="<%= hallinfo.hallname %>"<% } %> />
                    </div>
				</div>
			</div>
            <div class="form-group" <% if (hallinfo != null) { %>style="display:none;"<% } %>>
				<label class="col-sm-3 control-label no-padding-right" for="hallpwd">密码<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="password" readonly id="hallpwd" name="hallpwd" placeholder="请输入密码" class="col-xs-10 col-sm-5" <% if (hallinfo != null) { %>value="<%= hallinfo.password %>"<% } %> />
                    </div>
				</div>
			</div>
            <div class="form-group" <% if (hallinfo != null) { %>style="display:none;"<% } %>>
				<label class="col-sm-3 control-label no-padding-right" for="confirmpwd">确认密码：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="password" readonly id="confirmpwd" name="confirmpwd" placeholder="请确认密码" class="col-xs-10 col-sm-5" <% if (hallinfo != null) { %>value="<%= hallinfo.password %>"<% } %>/>
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="nickname">营业厅名称<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" readonly id="nickname" name="nickname" placeholder="请输入代理名称" class="col-xs-10 col-sm-5"  <% if (hallinfo != null) { %>value="<%= hallinfo.nickname %>"<% } %>/>
                    </div>
				</div>
			</div>
			
			
			<!--<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="company">公司名称：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="company" name="company" placeholder="请输入公司名称" class="col-xs-10 col-sm-5" <% if (hallinfo != null) { %>value="<%= hallinfo.company %>"<% } %>/>
                    </div>
				</div>
			</div>-->
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="addrdetail">详细地址<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix" style="margin-bottom:10px;">
                        <select class="col-xs-10 col-sm-2" disabled id="province" name="province" onchange="ChangeProvince();">
						    <% 
                                List<tbl_ecsregion> provinces = (List<tbl_ecsregion>)ViewData["provinces"];
                                if (provinces != null)
                                {
                                    for (int i = 0; i < provinces.Count; i++)
                                    {
                                        tbl_ecsregion item = provinces.ElementAt(i);
                                        if (ViewData["hallprovince"] != null && item.uid == (long)ViewData["hallprovince"])
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
                        <!--<select class="col-xs-10 col-sm-2" id="province" name="province">
						    <option value="">请选择省份</option>
						    <option value="AL">北京</option>
						    <option value="AL">辽宁</option>
						    <option value="AK">吉林</option>
						    <option value="AZ">黑龙江</option>
					    </select>-->
                        <span style="float:left;">&nbsp;&nbsp;</span>
                        <select class="col-xs-10 col-sm-2" disabled id="city" name="city" onchange="ChangeCity();">
						    <% 
                                List<tbl_ecsregion> cities = (List<tbl_ecsregion>)ViewData["cities"];
                                if (cities != null)
                                {
                                    for (int i = 0; i < cities.Count; i++)
                                    {
                                        tbl_ecsregion item = cities.ElementAt(i);
                                        if (ViewData["hallcity"] != null && item.uid == (long)ViewData["hallcity"])
                                        {
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
                        <span style="float:left;">&nbsp;&nbsp;</span>
                        <select class="col-xs-10 col-sm-2" disabled id="district" name="district">
                            <% 
                                List<tbl_ecsregion> districts = (List<tbl_ecsregion>)ViewData["districts"];
                                if (districts != null)
                                {
                                    for (int i = 0; i < districts.Count; i++)
                                    {
                                        tbl_ecsregion item = districts.ElementAt(i);
                                        if(hallinfo != null && item.uid == hallinfo.addrid) {
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
					<input type="text" readonly id="addrdetail" name="addrdetail" placeholder="请输入详细地址" class="col-xs-10 col-sm-5" <% if (hallinfo != null) { %>value="<%= hallinfo.addr %>"<% } %>/>
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="company">所属代理<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
						<select class="select2" id="categorylist" name="categorylist" data-placeholder="Click to Choose..." disabled>
                            <% 
                                List<tbl_user> users = (List<tbl_user>)ViewData["agents"];
                                if (users != null)
                                {
                                    for (int i = 0; i < users.Count; i++)
                                    {
                                        tbl_user item = users.ElementAt(i);
                                        %>
                                        <option value="<% =item.uid %>" <% if(hallinfo != null && item.uid == hallinfo.parentid) { %> selected <% } %>><% =item.username%></option>
                                        
                                        <%
                                    }
                                }
                            %>
				        </select>
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="company">电话<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" readonly id="phone" name="phone" placeholder="请输入公司名称" class="col-xs-10 col-sm-5" <% if (hallinfo != null) { %>value="<%= hallinfo.phonenum %>"<% } %>/>
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="company">邮箱<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" readonly id="email" name="email" placeholder="请输入公司名称" class="col-xs-10 col-sm-5" <% if (hallinfo != null) { %>value="<%= hallinfo.mail %>"<% } %>/>
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="company">QQ<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" readonly id="qqnumber" name="qqnumber" placeholder="请输入公司名称" class="col-xs-10 col-sm-5" <% if (hallinfo != null) { %>value="<%= hallinfo.qqnum %>"<% } %>/>
                    </div>
				</div>
			</div>

            <input type="hidden" id="uid" name="uid" value="<% if (ViewData["uid"] != null) { %><%= ViewData["uid"] %><% } else { %>0<% } %>" />

			<%--<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-info loading-btn" type="submit" data-loading-text="提交中...">
						<i class="ace-icon fa fa-check bigger-110"></i>
						提交
					</button>

					&nbsp; &nbsp; &nbsp;
					<button class="btn" type="button" onclick = "window.location='<%= ViewData["rootUri"] %>Agent/AHall/<% if (ViewData["uid"] != null) { %>EditAHall/<%= ViewData["uid"] %> <% } else { %>AddAHall <% } %> '">
						<i class="ace-icon fa fa-undo bigger-110"></i>
						重置
					</button>
				</div>
			</div>--%>
        </form>
	</div>
</div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageStyle" runat="server">
	<link rel="stylesheet" type="text/css" href="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.min.css" />
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/css/select2.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
	<script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>  
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.validate.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/validate.messages_zh.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/select2.min.js"></script>

	<script type="text/javascript">
	    function redirectToListPage(status) {
	        if (status.indexOf("error") != -1) {
	            $('.loading-btn').button('reset');
	        } else {
	            window.location = rootUri + "Agent/AHall/AHallList";
	        }
	    }
	    jQuery(function ($) {
	        //for edit//
            
            ////////////
	        $('.loading-btn')
		      .click(function () {
		          var btn = $(this)
		          btn.button('loading')
		      });

	        $(".select2").css('width', '250px').select2({ allowClear: true })
			.on('change', function () {
			    $(this).closest('form').validate().element($(this));
			});

//			$.validator.messages.required = "必须要填写";
//			$.validator.messages.number = "必须要填写数字";
//			$.validator.messages.uniquename = "必须要填写有一";
//			$.validator.messages.email = "必须要填写邮箱";
//			$.validator.messages.minlength = jQuery.validator.format("必须由至少{0}个字符组成.");
//			$.validator.messages.maxlength = jQuery.validator.format("必须由最多{0}个字符组成");
//			$.validator.messages.equalTo = jQuery.validator.format("密码不一致.");
	        $('#validation-form').validate({
	            errorElement: 'span',
	            errorClass: 'help-block',
	            //focusInvalid: false,
	            rules: {
	                hallname: {
	                    required: true,
	                    uniquename: true
	                },
	                nickname: {
	                    required: true
	                },
	                hallpwd: {
	                    required: true
	                },
	                confirmpwd: {
                        required: true,
                        equalTo: "#hallpwd"
	                },
                    company: {
	                    required: true
	                },
	                addrdetail: {
                        required: true
                    },
                    phone: {
	                    required: true,
                        number: true
	                },
                    email: {
                        required: true,
                        email:true
                    },
                    qqnumber: {
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
	            return checkHallName();
	        }, "用户名已存在");
	    });

	    function submitform() {
	        $.ajax({
	            type: "POST",
	            url: rootUri + "Hall/SubmitHall",
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

	    function checkHallName() {
	        var hallname = $("#hallname").val();
	        var retval = false;

	        $.ajax({
	            async: false,
	            type: "GET",
	            url: rootUri + "Hall/CheckUniqueHallname",
	            dataType: "json",
	            data: {
	                hallname: hallname
	            },
	            success: function (data) {
	                if (data == "noexist") {
	                    retval = true;
	                } else {
	                    retval = false;
	                }
	            }
	        });

	        return retval;
	    }
	    function process_back() {
	        redirectToListPage("back");
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
	        ChangeCity();
	    }
	    function ChangeCity() {
	        var city = $("#city").val();
	        $.ajax({
	            async: false,
	            type: "GET",
	            url: rootUri + "Region/GetDistrictListFull",
	            dataType: "json",
	            data: {
	                city: city
	            },
	            success: function (data) {
	                if (data != null) {
	                    var districts = [];
	                    districts = data.district;
	                    var htmlStr = "";
	                    for (var i = 0; i < districts.length; i++) {
	                        htmlStr += '<option value="' + districts[i].uid + '">' + districts[i].regionname + '</option>';
	                    }
	                    $("#district").html(htmlStr);
	                } else {
	                    $("#district").html("");
	                }
	            }
	        });
	    }
    </script>
</asp:Content>