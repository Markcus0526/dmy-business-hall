<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Lobby/Lobby.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<% var videoinfo = (tbl_video)ViewData["videoinfo"]; %>
<div class="page-header">
	<h1>
		视频库
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
            我的视频
		</small>
        <a class="btn btn-white btn-default btn-round" onclick="window.history.go(-1);" style="float:right">
		    <i class="ace-icon fa fa-times red2"></i>
		    返回
	    </a>
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
		<form class="form-horizontal" role="form" id="validation-form">
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">视频名称<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="videoname" name="videoname" placeholder="请输入视频名" class="col-xs-10 col-sm-5" value="<% if (videoinfo != null) { %><%= videoinfo.title %><% } %>" />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="company">视频<span class="red">*</span>：</label>
				<div class="col-sm-4">
                    <div class="clearfix">                        
                        <input class="" type="file" id="input_videofile" /><label id="filename1"><% if (videoinfo != null) { %><%= videoinfo.filename %><% } %></label>
                        <input type="hidden" id="filename" name="filename" value="<% if (videoinfo != null) { %><%= videoinfo.filename %><% } %>" />
                        <input type="hidden" id="path" name="path" value="<% if (videoinfo != null) { %><%= videoinfo.path %><% } %>" />
                        <input type="hidden" id="filesize" name="filesize" value="<% if (videoinfo != null) { %><%= videoinfo.filesize %><% } %>" />
                    </div>

                    <span id="alert_convert" class="alert alert-info help-block" style="display:none;">现在改变文件格式到MP4中。。。</span>
				</div>
			</div>

            <input type="hidden" id="uid" name="uid" value="<% if (ViewData["uid"] != null) { %><%= ViewData["uid"] %><% } else { %>0<% } %>" />
            <input type="hidden" id="dataid" name="dataid" value="<% if (ViewData["dataid"] != null) { %><%= ViewData["dataid"] %><% } else { %>0<% } %>" />

			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-info loading-btn" type="submit" data-loading-text="提交中...">
						<i class="ace-icon fa fa-check bigger-110"></i>
						提交
					</button>

					&nbsp; &nbsp; &nbsp;
					<button class="btn" type="button" onclick="window.location='<%= ViewData["rootUri"] %>Lobby/LBrief/<% if (ViewData["uid"] != null) { %>EditLVideo/<%= ViewData["uid"] %> <% } else { %>AddLVideo <% } %>'">
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
	<link rel="stylesheet" type="text/css" href="<%= ViewData["rootUri"] %>Content/plugins/uploadify/uploadify.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
	<script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>  
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.validate.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/validate.messages_zh.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/plugins/uploadify/jquery.uploadify.min.js"></script>  

	<script type="text/javascript">
	    function redirectToListPage(status) {
	        if (status.indexOf("error") != -1) {
	            $('.loading-btn').button('reset');
	        } else {
                window.history.go(-1);
	            //window.location = rootUri + "Lobby/LBrief/LVideoList";
	        }
	    }
	    jQuery(function ($) {
	        $('.loading-btn')
		      .click(function () {
		          var btn = $(this)
		          btn.button('loading')
		      });

	        $('#input_videofile').uploadify({
	            'buttonText': '请选择上传视频',
	            //'queueSizeLimit': 1,  //设置上传队列中同时允许的上传文件数量，默认为999
                'multi': false,
	            'uploadLimit': 0,   //设置允许上传的文件数量，默认为999
	            'swf': rootUri + 'Content/plugins/uploadify/uploadify.swf',

	            'fileTypeExts': '*.flv;*.mp4;*.mpeg;*.avi;',
	            'fileTypeDesc': 'Video Files (.flv,.mp4,.mpeg,.avi)',
	            'fileSizeLimit': '20MB',

	            'uploader': rootUri + 'Upload/UploadVideo',
	            'onUploadComplete': function (file) {   //单个文件上传完成时触发事件
	                //alert('The file ' + file.name + ' finished processing.');
	            },
	            'onQueueComplete': function (queueData) {   //队列中全部文件上传完成时触发事件
	                //alert(queueData.uploadsSuccessful + ' files were successfully uploaded.');
	            },
	            'onUploadSuccess': function (file, data, response) {    //单个文件上传成功后触发事件
	                //alert(data);                    
	                //alert('文件 ' + file.name + ' 已经上传成功，并返回 ' + response + ' 保存文件名称为 ' + data.SaveName + "|" + data.FileSize + "|" + response.SaveName);
	                $("#filename").val(file.name);
	                $("#path").val(data);
	                $("#filesize").val(file.size);
	                $("#filename1").html(file.name);
	            }
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
	                videoname: {
	                    required: true,
	                    uniquename: true
	                },
	                filename: {
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
	                if ($("#filename").val() == null || $("#filename").val().length == 0) {
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

	                    toastr["error"]("请选择上传视频", "温馨敬告");
	                    return false;
	                }

	                submitform();
	                return false;
	            },
	            invalidHandler: function (form) {
	                $('.loading-btn').button('reset');
	            }
	        });
	        $.validator.addMethod("uniquename", function (value, element) {
	            return checkVideoName();
	        }, "视频名已存在");
	    });

	    function submitform() {
            var s= "" + $("#filename").val(); 
            if(s.substring(s.length-4, s.length).toLowerCase() != ".mp4")
                $("#alert_convert").show();

	        $.ajax({
	            type: "POST",
	            url: rootUri + "Agent/ABrief/SubmitAVideo",
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

                        $("#alert_convert").hide();
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

                        $("#alert_convert").hide();
	                }
	            },
	            error: function (data) {
	                alert("Error: " + data.status);
	                $('.loading-btn').button('reset');

                    $("#alert_convert").hide();
	            }
	        });
	    }

	    function checkVideoName() {
	        var videoname = $("#videoname").val();
	        var retval = false;
            var videoid = '<%=ViewData["uid"]%>';
            if ( videoid == '' )
                videoid = '0';

	        $.ajax({
	            async: false,
	            type: "GET",
	            url: rootUri + "Agent/ABrief/CheckUniqueVideoname",
	            dataType: "json",
	            data: {
                    vid: videoid,
	                videoname: videoname
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

	    function reset_form() {
            <% 
            var videoinfo = (tbl_video)ViewData["videoinfo"];
            if (videoinfo != null) { %>
                $("#filename").val("<%= videoinfo.filename %>");
                $("#path").val("<%= videoinfo.path %>");
                $("#filesize").val("<%= videoinfo.filesize * 1048576 %>");
            <% } else { %>
                $("#filename").val("");
                $("#path").val("");
                $("#filesize").val("");
            <% } %>

	        $("#filename1").html($("#filename").val())
        }

    </script>
</asp:Content>