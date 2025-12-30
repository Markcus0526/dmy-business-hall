<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<% var noticeinfo = (SysEditInfo)ViewData["noticeinfo"]; %>
<div class="page-header">
	<h1>
		通知管理
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
            通知
		</small>
        <a class="btn btn-white btn-default btn-round" onclick="window.location='<%= ViewData["rootUri"] %>System/SysNoticeList'" style="float:right">
		    <i class="ace-icon fa fa-times red2"></i>
		    返回
	    </a>
	</h1>
</div>

<div class="row">
	<div class="col-xs-12">
		<form class="form-horizontal" role="form" id="validation-form">
			<div class="form-group" <% if (ViewData["uid"] != null) { %>style="display:none"<% } %>>
				<label class="col-sm-3 control-label no-padding-right" for="title">题目<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="title" name="title" placeholder="请输入题目" class="col-xs-10 col-sm-5" <% if (noticeinfo != null) { %>value="<%= noticeinfo.title %>"<% } %> />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="cateid">分类<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
						<select class="" id="cateid" name="cateid" onchange = "proc_change_type();" <% if (noticeinfo != null) { %>value="<%= noticeinfo.cateid %>"<% } %>>
                            <option value="1" <% if (noticeinfo != null && noticeinfo.cateid == 1) {%>selected<% } %>>全部</option>
                            <option value="2" <% if (noticeinfo != null && noticeinfo.cateid == 2) {%>selected<% } %>>代理通知</option>
                            <option value="3" <% if (noticeinfo != null && noticeinfo.cateid == 3) {%>selected<% } %>>营业厅通知</option>
				        </select>
                    </div>
				</div>
			</div>
			<div class="form-group" id="categorypart">
				<label class="col-sm-3 control-label no-padding-right" for="company">通知范围：</label>
                
				<div class="col-sm-2">
                    <select class="" id="ecatetype" name="ecatetype" onchange = "proc_change_etype();" >
                            
				    </select>    
                    
				</div>
                <div class="col-sm-2">
                    <div class="clearfix" id="categorylistpart">
					    <select id="categorylist" name="categorylist" style="width:300px" multiple class = "form-control" >
				        </select>
                    </div>
                </div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="company">通知内容：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<textarea class="form-control" id="contents" name="contents" style="height:420px; width:640px;"></textarea>
                    
                    </div>
				</div>
			</div>

            <input type="hidden" id="uid" name="uid" value="<% if (ViewData["uid"] != null) { %><%= ViewData["uid"] %><% } else { %>0<% } %>" />
            <input type="hidden" id="r_contents" name="r_contents" value = "" />
			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-info loading-btn" type="submit" data-loading-text="提交中...">
						<i class="ace-icon fa fa-check bigger-110"></i>
						提交
					</button>

					&nbsp; &nbsp; &nbsp;
					<button class="btn" type="button" onclick="window.location='<%= ViewData["rootUri"] %>System/<% if (ViewData["uid"] != null) { %>EditSysNotice/<%= ViewData["uid"] %> <% } else { %>AddSysNotice <% } %> '">
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
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/css/select2.css" />
    <link href="<%= ViewData["rootUri"] %>Content/plugins/select2/select2_metro.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
	<script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>  
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.validate.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/validate.messages_zh.js"></script>
    <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/plugins/kindeditor-4.1.7/kindeditor-min.js"></script>
	<script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/plugins/kindeditor-4.1.7/lang/zh_CN.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/plugins/select2/select2.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/plugins/select2/select2_locale_zh-CN.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/app.js"></script>

	<script type="text/javascript">
	    var editor;
	    function redirectToListPage(status) {
	        if (status.indexOf("error") != -1) {
	            $('.loading-btn').button('reset');
	        } else {
	            window.location = rootUri + "System/SysNoticeList";
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
	    });
        var smSelect;
        function init_page()
        {
            var sysnew_range;
            smSelect = $('#categorylist').select2({
                placeholder: "请选择范围",
                allowClear: true
            });
            <% if (ViewData["categorylist"] != null) { %>
                sysnew_range = "<%=ViewData["categorylist"] %>";
                if(sysnew_range == "0")
                {
                    $("#ecatetype").val(0);
                }
                else
                {
                    $("#ecatetype").val(1);
                    smSelect.val(sysnew_range.split(","), true);
                    $("#categorylistpart").show();
                }
            <% } %>

            var content_data;
            <% if (ViewData["contents"] != null) { %>
                content_data= unescape("<%= ViewData["contents"]%>");
            <% } %>
            $("#contents").html(content_data);
        }

        
	    jQuery(function ($) {
            proc_change_type();
            init_page();    //for edit.

	        $('.loading-btn')
		      .click(function () {
		          var btn = $(this)
		          btn.button('loading')
		      });

	        $(".select2").css('width', '250px').select2({ allowClear: true })
			.on('change', function () {
			    $(this).closest('form').validate().element($(this));
			});

//	        $.validator.messages.required = "必须要填写";
//            $.validator.messages.number = "必须要填写数字";
//            $.validator.messages.uniquename = "必须要填写有一";
//            $.validator.messages.email = "必须要填写邮箱";
//	        $.validator.messages.minlength = jQuery.validator.format("必须由至少{0}个字符组成.");
//	        $.validator.messages.maxlength = jQuery.validator.format("必须由最多{0}个字符组成");
//	        $.validator.messages.equalTo = jQuery.validator.format("密码不一致.");
	        $('#validation-form').validate({
	            errorElement: 'span',
	            errorClass: 'help-block',
	            //focusInvalid: false,
	            rules: {
	                title: {
	                    required: true
	                },
                    categorylist: {
                        required: true
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
            $("#r_contents").attr("value", escape($("#contents").val()));
	        $.ajax({
	            type: "POST",
	            url: rootUri + "System/SubmitSysNotice",
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
	                if (data == true) {
	                    retval = true;
	                } else {
	                    retval = false;
	                }
	            }
	        });

	        return retval;
	    }
        function return_function() {
            redirectToListPage("back");
        }
        function proc_change_type()
        {
            if($("#cateid").val() == 2)
            {
                var ehtml = "";
                ehtml += '<option value ="0" >全部代理</option>';
                ehtml += '<option value ="1" >个别代理</option>';
                $("#ecatetype").html(ehtml);
                $("#categorypart").show();
                $("#categorylistpart").hide();
                var html = "";
                <% 
                    List<tbl_user> users = (List<tbl_user>)ViewData["agents"];
                    if (users != null)
                    {
                        for (int i = 0; i < users.Count; i++)
                        {
                            tbl_user item = users.ElementAt(i);
                            %>
                            html += '<option value="<% =item.uid %>"><% =item.username%></option>'
                            <%
                        }
                    }
                %>
                $("#categorylist").html(html);
            }
            else if($("#cateid").val() == 3)
            {
                var ehtml = "";
                ehtml += '<option value ="0" >全部营业厅</option>';
                ehtml += '<option value ="1" >个别营业厅</option>';
                $("#ecatetype").show();
                $("#ecatetype").html(ehtml);

                $("#categorypart").show();
                $("#categorylistpart").hide();
                var html = "";
                <% 
                    List<HallInfo> halls = (List<HallInfo>)ViewData["halls"];
                    if (halls != null)
                    {
                        for (int i = 0; i < halls.Count; i++)
                        {
                            HallInfo item = halls.ElementAt(i);
                            %>
                            html += '<option value="<% =item.uid %>"><% =item.nickname%></option>'
                            <%
                        }
                    }
                %>
                $("#categorylist").html(html);
            }
            else
            {
                $("#categorylist").html("");
                $("#categorypart").hide();
            }
        }
        function proc_change_etype()
        {
            if($("#ecatetype").val() == 0)
            {
                $("#categorylistpart").hide();
            }
            else
            {
                $("#categorylistpart").show();
            }
        }
        
    </script>
</asp:Content>