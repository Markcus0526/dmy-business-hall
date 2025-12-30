<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Lobby/Lobby.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<% var detailinfo = (tbl_androiddetail)ViewData["detailinfo"]; %>
<div class="page-header">
	<h1>
		编辑手机详细信息
        <a class="btn btn-white btn-default btn-round" onclick="window.history.go(-1);" style="float:right">
		    <i class="ace-icon fa fa-times red2"></i>
		    返回
	    </a>
	</h1>
</div>

                <form name="form_upload" action="<%= ViewData["rootUri"] %>Upload/UploadImage" method="post" enctype="multipart/form-data">
                    <input type="file" id="uploadfile" name="Filedata" onchange="SubmitUploadForm();" style="display:none;" />
                    <span class="help-block" id="uploadstatus" style="display:none;"></span>
                </form>

<div class="row">
	<div class="col-xs-12">
		<form class="form-horizontal" role="form" id="validation-form">
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">手机题目<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="title" name="title" placeholder="请输入手机题目" class="col-xs-10 col-sm-5" value="<% if (detailinfo != null) { %><%= detailinfo.title %><% } %>" />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">默认图片<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
                        <img id="previewimg1" src="<% if (detailinfo != null && detailinfo.imgurl1 != null && detailinfo.imgurl1 != "") { %><%= ViewData["rootUri"] %><%= detailinfo.imgurl1 %><% } else { %><%= ViewData["rootUri"] %>Content/img/default-image_100.gif<% } %>" style="max-height:80px;" />
                        <input type="hidden" id="imgurl1" name="imgurl1" value="<% if (detailinfo != null) { %><%= detailinfo.imgurl1 %><% } %>" />
                        <input type="button" class="btn btn-sm" id="imagebutton1" value="选择图片" />
                    </div>
                    <span class="help-inline col-xs-12 col-sm-7">
						<span class="middle">建议大小(宽60高50)</span>
					</span>
				</div>

				<label class="col-sm-3 control-label no-padding-right" for="videoname">图片2<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
                        <img id="previewimg2" src="<% if (detailinfo != null && detailinfo.imgurl2 != null && detailinfo.imgurl2 != "") { %><%= ViewData["rootUri"] %><%= detailinfo.imgurl2 %><% } else { %><%= ViewData["rootUri"] %>Content/img/default-image_100.gif<% } %>" style="max-height:80px;" />
                        <input type="hidden" id="imgurl2" name="imgurl2" value="<% if (detailinfo != null) { %><%= detailinfo.imgurl2 %><% } %>" />
                        <input type="button" class="btn btn-sm" id="imagebutton2" value="选择图片" />
                    </div>
                    <span class="help-inline col-xs-12 col-sm-7">
						<span class="middle">建议大小(宽60高50)</span>
					</span>
				</div>

				<label class="col-sm-3 control-label no-padding-right" for="videoname">图片3<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
                        <img id="previewimg3" src="<% if (detailinfo != null && detailinfo.imgurl3 != null && detailinfo.imgurl3 != "") { %><%= ViewData["rootUri"] %><%= detailinfo.imgurl3 %><% } else { %><%= ViewData["rootUri"] %>Content/img/default-image_100.gif<% } %>" style="max-height:80px;" />
                        <input type="hidden" id="imgurl3" name="imgurl3" value="<% if (detailinfo != null) { %><%= detailinfo.imgurl3 %><% } %>" />
                        <input type="button" class="btn btn-sm" id="imagebutton3" value="选择图片" />
                    </div>
                    <span class="help-inline col-xs-12 col-sm-7">
						<span class="middle">建议大小(宽60高50)</span>
					</span>
				</div>
				<label class="col-sm-3 control-label no-padding-right" for="videoname">图片4<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
                        <img id="previewimg4" src="<% if (detailinfo != null && detailinfo.imgurl4 != null && detailinfo.imgurl4 != "") { %><%= ViewData["rootUri"] %><%= detailinfo.imgurl4 %><% } else { %><%= ViewData["rootUri"] %>Content/img/default-image_100.gif<% } %>" style="max-height:80px;" />
                        <input type="hidden" id="imgurl4" name="imgurl4" value="<% if (detailinfo != null) { %><%= detailinfo.imgurl4 %><% } %>" />
                        <input type="button" class="btn btn-sm" id="imagebutton4" value="选择图片" />
                    </div>
                    <span class="help-inline col-xs-12 col-sm-7">
						<span class="middle">建议大小(宽60高50)</span>
					</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">详细说明<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<textarea type="text" id="description" name="description" placeholder="请输入说明" class="col-xs-10 col-sm-5"><% if (detailinfo != null) { %><%= detailinfo.description %><% } %></textarea>
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">推荐价格（参考价格）<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="recommprice" name="recommprice" placeholder="请输入数字" class="col-xs-10 col-sm-5" value="<% if (detailinfo != null) { %><%= detailinfo.recommprice %><% } %>" />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">实际价格<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="realprice" name="realprice" placeholder="请输入数字" class="col-xs-10 col-sm-5" value="<% if (detailinfo != null) { %><%= detailinfo.realprice %><% } %>" />
                    </div>
				</div>
			</div>            
            <%--<table>
            <tr>
            <td>
                <div class="form-group">
				    <label class="col-sm-3 control-label no-padding-right" for="videoname">屏幕大小（展示用）<span class="red">*</span>：</label>
				    <div class="col-sm-9">
                        <div class="clearfix">
					    <input type="text" id="screenshowsize" name="screenshowsize" placeholder="请输入文字" class="col-xs-5 col-sm-2" value="<% if (detailinfo != null) { %><%= detailinfo.screenshowsize %><% } %>" />&nbsp;&nbsp;&nbsp;
                        </div>
				    </div>
			    </div>
            </td>
            <td>            
                <div class="form-group">
				    <label class="col-sm-3 control-label no-padding-right" for="videoname">屏幕大小（实际）<span class="red">*</span>：</label>
				    <div class="col-sm-9">
                        <div class="clearfix">					    
					    <input type="text" id="screensize" name="screensize" placeholder="请输入数字" class="col-xs-5 col-sm-2" value="<% if (detailinfo != null) { %><%= detailinfo.screensize %><% } %>" />
                        </div>
				    </div>
			    </div>
            </td>
            </tr>
            </table>--%>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">屏幕大小（展示用）<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="screenshowsize" name="screenshowsize" placeholder="请输入文字" class="col-xs-5 col-sm-2" value="<% if (detailinfo != null) { %><%= detailinfo.screenshowsize %><% } %>" />&nbsp;&nbsp;&nbsp;
                    <label class="col-sm-3 control-label no-padding-right" for="videoname">屏幕大小（实际）<span class="red">*</span>：</label>
					<input type="text" id="screensize" name="screensize" placeholder="请输入数字" class="col-xs-5 col-sm-2" value="<% if (detailinfo != null) { %><%= detailinfo.screensize %><% } %>" />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">CPU（展示用）<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="showcpu" name="showcpu" placeholder="请输入文字" class="col-xs-5 col-sm-2" value="<% if (detailinfo != null) { %><%= detailinfo.showcpu %><% } %>" />&nbsp;&nbsp;&nbsp;
                    <label class="col-sm-3 control-label no-padding-right" for="videoname">CPU（实际）<span class="red">*</span>：</label>
					<input type="text" id="cpu" name="cpu" placeholder="请输入数字" class="col-xs-5 col-sm-2" value="<% if (detailinfo != null) { %><%= detailinfo.cpu %><% } %>" />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">RAM（展示用）<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="memshowsize" name="memshowsize" placeholder="请输入文字" class="col-xs-5 col-sm-2" value="<% if (detailinfo != null) { %><%= detailinfo.memshowsize %><% } %>" />&nbsp;&nbsp;&nbsp;
                    <label class="col-sm-3 control-label no-padding-right" for="videoname">RAM（实际）<span class="red">*</span>：</label>
					<input type="text" id="memsize" name="memsize" placeholder="请输入数字" class="col-xs-5 col-sm-2" value="<% if (detailinfo != null) { %><%= detailinfo.memsize %><% } %>" />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">相机像素数（展示用）<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="pixshowcnt" name="pixshowcnt" placeholder="请输入文字" class="col-xs-5 col-sm-2" value="<% if (detailinfo != null) { %><%= detailinfo.pixshowcnt %><% } %>" />&nbsp;&nbsp;&nbsp;
                    <label class="col-sm-3 control-label no-padding-right" for="videoname">相机像素数（实际）<span class="red">*</span>：</label>
					<input type="text" id="pixcnt" name="pixcnt" placeholder="请输入数字" class="col-xs-5 col-sm-2" value="<% if (detailinfo != null) { %><%= detailinfo.pixcnt %><% } %>" />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">系统版本（展示用）<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="osshowver" name="osshowver" placeholder="请输入文字" class="col-xs-5 col-sm-2" value="<% if (detailinfo != null) { %><%= detailinfo.osshowver %><% } %>" />&nbsp;&nbsp;&nbsp;
                    <label class="col-sm-3 control-label no-padding-right" for="videoname">系统版本（实际）<span class="red">*</span>：</label>
					<input type="text" id="osver" name="osver" placeholder="请输入数字" class="col-xs-5 col-sm-2" value="<% if (detailinfo != null) { %><%= detailinfo.osver %><% } %>" />
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
					<button class="btn" type="button" onclick="window.location='<%= ViewData["rootUri"] %>Lobby/LMarket/LManagePhoneDetail/<% if (ViewData["uid"] != null) { %><%= ViewData["uid"] %><% } else { %>0<% } %>'">
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
    <script src="<%= ViewData["rootUri"] %>Content/plugins/upload/jquery.form.js"></script>
    <script src="<%= ViewData["rootUri"] %>Content/js/ajaxupload.js"></script>

	<script type="text/javascript">
	    function redirectToListPage(status) {
	        if (status.indexOf("error") != -1) {
	            $('.loading-btn').button('reset');
	        } else {
                window.history.go(-1);
	            //window.location = rootUri + "Lobby/LBrief/LVideoList";
	        }
        }

        var initFormUpload = function () {
            var bar = $('.bar');
            var percent = $('.percent');
            var status = $('#status');

            $('form[name=form_upload]').ajaxForm({
                dataType: 'json',
                beforeSend: function () {
                    status.empty();
                    $(".progress").css("display", "block");
                    $('#uploadstatus').html("正在上传图片...");
                    $("#uploadstatus").css("display", "block");
                    var percentVal = '0%';
                    bar.width(percentVal);
                    percent.html(percentVal);
                },
                uploadProgress: function (event, position, total, percentComplete) {
                    var percentVal = percentComplete + '%';
                    bar.width(percentVal);
                    percent.html(percentVal);
                },
                success: function () {
                    var percentVal = '100%';
                    bar.width(percentVal);
                    percent.html(percentVal);
                },
                complete: function (xhr, status) {
                    $(".progress").css("display", "none");
                    $("#uploadstatus").css("display", "none");

                    if (status == "success") {
                        //alert(xhr.responseText);
                        var filepath = xhr.responseText.substring(1, xhr.responseText.length - 1);
                        $("#previewimg" + imageindex).attr("src", rootUri + filepath);
                        $("#imgurl" + imageindex).val(filepath);
                    }
                }
            });
        };

        function SubmitUploadForm() {
            var ext = $('#uploadfile').val().split('.').pop().toLowerCase();
            if ($.inArray(ext, ['png', 'jpg', 'jpeg']) == -1) {
                alert("请选择图片格式文件");
            } else {
                $("form[name=form_upload]").submit();
            }
        }

        var imageindex = 0;
        jQuery(function ($) {
            $('.loading-btn')
		      .click(function () {
		          var btn = $(this)
		          btn.button('loading')
		      });

            $("#imagebutton1").click(function () {
                $('#uploadfile').trigger("click");
                imageindex = 1;
            });
            $("#imagebutton2").click(function () {
                $('#uploadfile').trigger("click");
                imageindex = 2;
            });
            $("#imagebutton3").click(function () {
                $('#uploadfile').trigger("click");
                imageindex = 3;
            });
            $("#imagebutton4").click(function () {
                $('#uploadfile').trigger("click");
                imageindex = 4;
            });
            initFormUpload();

            $('#validation-form').validate({
                errorElement: 'span',
                errorClass: 'help-block',
                //focusInvalid: false,
                rules: {
                    title: {
                        required: true
                    },
                    description: {
                        required: true
                    },
                    recommprice: {
                        required: true,
                        number: true
                    },
                    realprice: {
                        required: true,
                        number: true
                    },
                    screensize: {
                        required: true,
                        number: true
                    },
                    screenshowsize: {
                        required: true
                    },
                    cpu: {
                        required: true
                    },
                    showcpu: {
                        required: true
                    },
                    memsize: {
                        required: true,
                        number: true
                    },
                    memshowsize: {
                        required: true
                    },
                    pixcnt: {
                        required: true,
                        number: true
                    },
                    pixshowcnt: {
                        required: true
                    },
                    osver: {
                        required: true,
                        number: true
                    },
                    osshowver: {
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
                    //	                if ($("#filename").val() == null || $("#filename").val().length == 0) {
                    //	                    toastr.options = {
                    //	                        "closeButton": false,
                    //	                        "debug": true,
                    //	                        "positionClass": "toast-bottom-right",
                    //	                        "onclick": null,
                    //	                        "showDuration": "3",
                    //	                        "hideDuration": "3",
                    //	                        "timeOut": "1500",
                    //	                        "extendedTimeOut": "1000",
                    //	                        "showEasing": "swing",
                    //	                        "hideEasing": "linear",
                    //	                        "showMethod": "fadeIn",
                    //	                        "hideMethod": "fadeOut"
                    //	                    };

                    //	                    toastr["error"]("请选择上传视频", "温馨敬告");
                    //	                    return false;
                    //	                }

                    submitform();
                    return false;
                },
                invalidHandler: function (form) {
                    $('.loading-btn').button('reset');
                }
            });
            //	        $.validator.addMethod("uniquename", function (value, element) {
            //	            return checkVideoName();
            //	        }, "视频名已存在");
        });

	    function submitform() {
	        $.ajax({
	            type: "POST",
	            url: rootUri + "Lobby/LMarket/SubmitAndroidDetail",
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

    </script>
</asp:Content>