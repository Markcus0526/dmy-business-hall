<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Lobby/Lobby.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header">
	<h1>
		选择手机亮点图片
        <a class="btn btn-white btn-default btn-round" onclick="window.history.go(-1)" style="float:right">
		    <i class="ace-icon fa fa-times red2"></i>
		    返回
	    </a>
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
	    <div class="table-toolbar">
            <a href="javascript:void(0);" class="btn blue" id="btn_upload"><i class="fa fa-plus"></i> 添加图片</a>&nbsp;&nbsp;
            <a href="javascript:void(0);" class="btn btn-primary loading-btn" data-loading-text="提交中..." onclick="submitform();"><i class="ace-icon fa fa-save align-top bigger-125"></i>保存</a>
	    </div>
		<div class="row">
            <div class="col-md-12">
                <div>
                <form name="form_upload" action="<%= ViewData["rootUri"] %>Upload/UploadImage" method="post" enctype="multipart/form-data">
                    <input type="file" id="uploadfile" name="uploadfile" onchange="SubmitUploadForm();" style="display:none;" />
                    <span class="help-block" id="uploadstatus" style="display:none;"></span>
                </form>
                </div>
                <div class="progress" style="display:none;">
                    <div class="bar" style="width: 0%;"></div>
                    <div class="percent">100%</div>
                </div>

                <form name="form_content" id="form_content" action="">
			        <textarea id="idsortlist" name="idsortlist" class="form-control col-md-12 margin-bottom-10" style="display:none;"></textarea>
                    <div class="dd dd-draghandle" id="photolist">
					    <ol class="dd-list" id="dd-list">
                            <% foreach (NestableImgInfo item in (List<NestableImgInfo>)ViewData["items"])
                               { %>
						    <li class="dd-item dd2-item" data-id="<%= item.uid %>">
                                <div class="dd-handle dd2-handle">
									<i class="normal-icon ace-icon fa fa-bars blue bigger-130"></i>
									<i class="drag-icon ace-icon fa fa-arrows bigger-125"></i>
								</div>
							    <div class="dd2-content">
                                    <table style="width:100%; height:100%;">
                                        <tr>
                                            <td>
                                                <a style="display:inline-block" href="<%= ViewData["rootUri"] %><%= item.imgurl %>">
                                                    <img src="<%= ViewData["rootUri"] %><%= item.imgurl %>" style="max-width:150px; max-height:120px;" />
                                                </a>
                                            </td>
                                            <td>
                                                <div style="height:100%">
                                                    <table style="width:100%; height:100%;">
                                                        <tr >
                                                            <td>
                                                                <label>标题：</label>
                                                                <input type="text" style="width:400px; padding:3px 3px 3px;" name="title_<%= item.uid %>" value="<%= item.title %>" />
                                                            </td>
                                                        </tr>
                                                        <tr >
                                                            <td>
                                                                <label>描述：</label>
                                                                <textarea style="width:400px; height:6em; padding:3px 3px 3px;" name="desc_<%= item.uid %>"><%= item.description %></textarea>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                            <td style="width: 10%; text-align:right;" valign="top"><a href="#" class="btn default" onclick="removeItem('<%= item.uid %>');"><i class="fa fa-trash-o"></i></a></td>
                                        </tr>
                                    </table>
                                </div>
						    </li>
                            <% } %>
					    </ol>
				    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageStyle" runat="server">
	<link rel="stylesheet" type="text/css" href="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.min.css" />
    <style>
        .progress { position:relative; width:100%; border: 1px solid #ddd; padding: 1px; border-radius: 3px; }
        .bar { background-color: #438eEE; width:0%; height:20px; border-radius: 3px; }
        .percent { position:absolute; display:inline-block; top:3px; left:48%; }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
	<script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>  
    <script src="<%= ViewData["rootUri"] %>Content/plugins/upload/jquery.form.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.nestable.min.js"></script>
    <script src="<%= ViewData["rootUri"] %>Content/js/ajaxupload.js"></script>

    <script type="text/javascript">
        var updateOutput = function (e) {
            var list = e.length ? e : $(e.target),
            output = list.data('output');
            if (window.JSON) {
                output.val(window.JSON.stringify(list.nestable('serialize'))); //, null, 2));
            } else {
                output.val('JSON browser support required for this demo.');
            }
        }

        var initFormUpload = function () {
            var bar = $('.bar');
            var percent = $('.percent');
            var status = $('#status');

            $('form[name=form_upload]').ajaxForm({
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
                complete: function (xhr) {
                    $(".progress").css("display", "none");
                    $("#uploadstatus").css("display", "none");
                    var newhtml =
						'<li class="dd-item dd3-item" data-id="new_' + xhr.responseText + '">' +
							'<div class="dd-handle dd3-handle"></div>' +
							'<div class="dd3-content">' +
                                '<table style="width:100%; height:100%;">' +
                                    '<tr><td><a style="display:inline-block" href="' + rootUri + xhr.responseText + '">' +
                                                '<img src="' + rootUri + xhr.responseText + '" style="max-width:150px; max-height:120px;" /></a>' +
                                        '</td>' +
                                        '<td><div style="height:100%">' +
                                                '<table style="width:100%; height:100%;">' +
                                                    '<tr ><td><label>标题：</label>' +
                                                            '<input type="text" style="width:400px; padding:3px 3px 3px;" name="title_' + xhr.responseText + '" value="" />' +
                                                        '</td></tr>' +
                                                    '<tr ><td>' +
                                                    '<label>描述：</label><textarea style="width:400px; height:6em; padding:3px 3px 3px;" name="desc_' + xhr.responseText + '"></textarea>' +
                                                    '</td></tr>' +
                                                '</table>' +
                                            '</div></td>' +
                                        '<td style="width: 10%; text-align:right;" valign="top"><a href="#" class="btn default" onclick="removeItem(\'new_' + xhr.responseText + '\');"><i class="fa fa-trash-o"></i></a></td>' +
                                    '</tr></table>' +
                            '</div></li>';
                    $("#dd-list").append(newhtml);
                    $('#photolist').nestable().on('change', updateOutput);
                    updateOutput($('#photolist').data('output', $('#idsortlist')));
                }
            });
        };

        function SubmitUploadForm() {
            var ext = $('#uploadfile').val().split('.').pop().toLowerCase();
            if ($.inArray(ext, ['bmp', 'png', 'jpg', 'jpeg']) == -1) {
                alert("请选择图片格式文件");
            } else {
                $("form[name=form_upload]").submit();
            }
        }

        function removeItem(id) {
            if (confirm("您确定要删除吗？")) {
                if (id.length > 5 && id.substring(0, 4) == "new_") {
                    $("li[data-id='" + id + "']").remove();
                    $('#photolist').nestable().on('change', updateOutput);
                    updateOutput($('#photolist').data('output', $('#idsortlist')));
                    return true;
                }
                $.ajax({
                    async: false,
                    type: "POST",
                    url: rootUri + "Lobby/LMarket/DelBriSpotImgItem/1",
                    dataType: "json",
                    data: {
                        delid: id
                    },
                    success: function (data) {
                        if (data == true) {
                            $("li[data-id=" + id + "]").remove();
                            $('#photolist').nestable().on('change', updateOutput);
                            updateOutput($('#photolist').data('output', $('#idsortlist')));
                        } else {
                        }
                    },
                    error: function (data) {
                        alert("delete Error: " + data.status);
                    }
                });
            }
        }

        function submitform() {
            $.ajax({
                type: "POST",
                url: rootUri + "Lobby/LMarket/SaveBrightSpotItemList/1",
                dataType: "json",
                data: $('#form_content').serialize(),
                success: function (data) {
                    if (data == true) {
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

                        toastr["error"](data.error, "温馨敬告");
                    }
                },
                error: function (data) {
                    alert("Error: " + data.status);
                    $('.loading-btn').button('reset');
                }
            });
        }

        jQuery(document).ready(function () {
            $('.loading-btn')
		      .click(function () {
		          var btn = $(this)
		          btn.button('loading')
		      });

            $('#photolist').nestable().on('change', updateOutput);
            updateOutput($('#photolist').data('output', $('#idsortlist')));

            $("#btn_upload").click(function () {
                $("input[name=uploadfile]").trigger("click");
            });
            initFormUpload();
        });

        function redirectToListPage(status) {
            if (status.indexOf("error") != -1) {
                $('.loading-btn').button('reset');
            } else {
                window.location = rootUri + "Agt/AgentList";
            }
        }
    
    </script>
</asp:Content>
