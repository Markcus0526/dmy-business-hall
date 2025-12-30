<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Agent/Agent.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
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
            <a href="javascript:void(0);" class="btn blue" id="btn_upload"><i class="fa fa-plus"></i> 上传图片</a>&nbsp;&nbsp;
            <!--<a href="<%= ViewData["rootUri"] %>Lobby/LBrief/AddLImage" target="_blank" class="btn red"><i class="fa fa-plus"></i> 上传图片</a>&nbsp;&nbsp;-->
            <a class="btn blue"  href="#modal-table" role="button" data-toggle="modal" onclick="set_modalparam()"><i class="fa fa-plus"></i> 添加图片</a>&nbsp;&nbsp;
            <a href="javascript:void(0);" class="btn btn-primary loading-btn" data-loading-text="提交中..." onclick="submitform();"><i class="ace-icon fa fa-save align-top bigger-125"></i>保存</a>
	    </div>
		<div class="row">
            <div class="col-md-12">
                <div>
                <form name="form_upload" action="<%= ViewData["rootUri"] %>Upload/UploadMultipleImage" method="post" enctype="multipart/form-data">
                    <input type="file" id="uploadfile" name="uploadfile" onchange="SubmitUploadForm();" style="display:none;" multiple />
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
                                                <a style="display:inline-block" href="<%= ViewData["rootUri"] %><%= item.imgurl %>" target="_blank">
                                                    <img src="<%= ViewData["rootUri"] %><%= item.imgurl %>" style="max-width:150px; max-height:120px;" />
                                                </a>
                                            </td>
                                            <td>
                                                <div style="height:100%">
                                                    <table style="width:100%; height:100%;">
                                                        <tr >
                                                            <td>
                                                                <label>标题：</label>
                                                                <input type="text" style="width:400px; padding:3px 3px 3px;" name="title_<%= item.uid %>" value="<%= item.title %>" disabled />
                                                            </td>
                                                        </tr>
                                                        <tr >
                                                            <td>
                                                                <label>描述：</label>
                                                                <textarea style="width:400px; height:6em; padding:3px 3px 3px;" name="desc_<%= item.uid %>" disabled><%= item.description %></textarea>
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

                    <input type="hidden" name="id" id="androiddata_id" value="<% =ViewData["androiddata_id"] %>" />
                    <input type="hidden" name="delids" id="delids" value="" />

                </form>
            </div>
        </div>
    </div>
</div>

<div id="modal-table" class="modal fade" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header no-padding">
				<div class="table-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						<span class="white">&times;</span>
					</button>
					请选择图片
				</div>
			</div>

			<div class="modal-body no-padding">
				<table id="tbldata_dlg" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
					<thead>
						<tr>                            
						    <th class="center">
							    <label class="position-relative">
								    <input type="checkbox" class="ace" />
								    <span class="lbl"></span>
							    </label>
						    </th>
							<th>图片来源</th>
							<th>图片</th>
							<th>图片大小</th>
						</tr>
					</thead>

					<tbody>						
					</tbody>
				</table>
			</div>

			<div class="modal-footer no-margin-top">
				<button class="btn btn-sm btn-danger pull-left" data-dismiss="modal" onclick="submit_dataitem();">
					<i class="ace-icon fa fa-save"></i>
					确认
				</button>				
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- PAGE CONTENT ENDS -->

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
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.dataTables.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.dataTables.bootstrap.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/bootbox.min.js"></script>

    <script type="text/javascript">

        var dialog_selids = ",";

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
                        $.ajax({
                            url: rootUri + "Agent/AMarket/InsertAndGetNestableImgInfo",
                            data: {
                                "data": xhr.responseText
                            },
                            type: "post",
                            success: function (datalist) {
                                if (datalist != null && datalist != "") {
                                    for (var i = 0; i < datalist.length; i++) {
                                        var data = datalist[i];
                                        var newhtml =
						    '<li class="dd-item dd2-item" data-id="new_' + data.uid + '">' +
							    '<div class="dd-handle dd2-handle">' +
                                    '<i class="normal-icon ace-icon fa fa-bars blue bigger-130"></i>' +
                                    '<i class="drag-icon ace-icon fa fa-arrows bigger-125"></i>' +
                                '</div>' +
							    '<div class="dd2-content">' +
                                    '<table style="width:100%; height:100%;">' +
                                        '<tr><td><a style="display:inline-block" href="' + rootUri + data.imgurl + '">' +
                                                    '<img src="' + rootUri + data.imgurl + '" style="max-width:150px; max-height:120px;" /></a>' +
                                            '</td>' +
                                            '<td><div style="height:100%">' +
                                                    '<table style="width:100%; height:100%;">' +
                                                        '<tr ><td><label>标题：</label>' +
                                                                '<input type="text" style="width:400px; padding:3px 3px 3px;" name="title_' + data.uid + '" value="' + data.title + '" disabled />' +
                                                            '</td></tr>' +
                                                        '<tr ><td>' +
                                                        '<label>描述：</label><textarea style="width:400px; height:6em; padding:3px 3px 3px;" name="desc_' + data.uid + '" disabled>' + data.description + '</textarea>' +
                                                        '</td></tr>' +
                                                    '</table>' +
                                                '</div></td>' +
                                            '<td style="width: 10%; text-align:right;" valign="top"><a href="#" class="btn default" onclick="removeItem(\'new_' + data.uid + '\');"><i class="fa fa-trash-o"></i></a></td>' +
                                        '</tr></table>' +
                                '</div></li>';
                                        $("#dd-list").append(newhtml);
                                    }

                                    $('#photolist').nestable().on('change', updateOutput);
                                    updateOutput($('#photolist').data('output', $('#idsortlist')));
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

                                    toastr["error"]("图片已经存在", "温馨敬告");
                                }
                            }
                        });
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

        function removeItem(id)  {
            bootbox.dialog({
                message: "您确定要删除吗？",
                backdrop: true,
                buttons: {
                    danger: {
                        label: "取消",
                        className: "btn-danger",
                        callback: function () {
                            return true;
                        }
                    },
                    main: {
                        label: "确定",
                        className: "btn-primary",
                        callback: function () {
                            if (!isNaN(id)) {
                                var delids = $("#delids").val();
                                $("#delids").val(delids + id + ",");
                            }

                            $("li[data-id='" + id + "']").remove();
                            $('#photolist').nestable().on('change', updateOutput);
                            updateOutput($('#photolist').data('output', $('#idsortlist')));
                        }
                    }
                }
            });

//            if (confirm("您确定要删除吗？")) {
//                if (id.length > 5 && id.substring(0, 4) == "new_") {
//                    $("li[data-id='" + id + "']").remove();
//	                $('#photolist').nestable().on('change', updateOutput);
//	                updateOutput($('#photolist').data('output', $('#idsortlist')));

//                    return true;
//                }
//                $.ajax({
//                    async: false,
//                    type: "POST",
//                    url: rootUri + "Agent/AMarket/DelBriSpotImgItem/1",
//                    dataType: "json",
//                    data: {                        
//                        delid: id
//                    },
//                    success: function (data) {
//                        if (data == true) {
//                            $("li[data-id=" + id + "]").remove();
//	                        $('#photolist').nestable().on('change', updateOutput);
//	                        updateOutput($('#photolist').data('output', $('#idsortlist')));                                
//                        } else {
//                        }
//                    },
//                    error: function(data){
//                        alert("delete Error: " + data.status);
//                    }
//                });
//            }
        }

        function submitform() {
            //alert($("#idsortlist").val() + "|" + $('#form_content').serialize());

            $.ajax({
                type: "POST",
                url: rootUri + "Agent/AMarket/SaveBrightSpotItemList",
                dataType: "json",
                data: $('#form_content').serialize(),
                success: function (data) {
                    if (data == true) {
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

                        toastr["error"](data.error, "温馨敬告");
                    }
                },
                error: function(data){
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

            oImageTable =
				$('#tbldata_dlg')
				.dataTable({
				    "bServerSide": true,
				    "bProcessing": true,
				    "sAjaxSource": rootUri + "Agent/ABrief/RetrieveAImageList",
				    "oLanguage": {
				        "sUrl": rootUri + "Content/i18n/dataTables.chinese.txt"
				    },
				    "aoColumns": [
					  { "bSortable": false },
					  { "bSortable": false },
					  { "bSortable": false },
					  { "bSortable": false }
					],
				    "aLengthMenu": [
                        [10, 20, 50, -1],
                        [10, 20, 50, "All"] // change per page values here
                    ],
				    "iDisplayLength": 10,
				    "aoColumnDefs": [
				     	{
				     	    aTargets: [0],    // Column number which needs to be modified
				     	    fnRender: function (o, v) {   // o, v contains the object and value for the column
				     	        return '<label class="position-relative">' +
				     				'<input type="checkbox" value="' + o.aData[0] + '" name="selcheckbox_dlg" class="ace" onchange="onChangeChecked_dlg(this)"' +
                                    (IsIdChecked_dlg(o.aData[0]) ? 'checked' : '') + ' />' +
				     				'<span class="lbl"></span>' +
				     				'</label>';
				     	    },
				     	    sClass: 'center'
				     	},
				     	{
				     	    aTargets: [1],    // Column number which needs to be modified
				     	    fnRender: function (o, v) {   // o, v contains the object and value for the column
				     	        return o.aData[4];
				     	    },
				     	    sClass: 'left'
				     	},
				 	    {
				 	        aTargets: [2],    // Column number which needs to be modified
				 	        fnRender: function (o, v) {   // o, v contains the object and value for the column
				 	            var rst = '<img src="<%= ViewData["rootUri"] %>' + o.aData[6] + '" style="max-height:100px;" />';

				 	            return rst;
				 	        },
				 	        sClass: 'left'
				 	    }
				    ],
				    "fnDrawCallback": function (oSettings) {
				        //showBatchBtn();
				    }

				});

            $(document).on('click', 'th input:checkbox', function () {
                var that = this;
                $(this).closest('table').find('tr > td:first-child input:checkbox')
					.each(function () {
					    this.checked = that.checked;
					    $(this).closest('tr').toggleClass('selected');

					    onChangeChecked_dlg(this);
					});
            });
        });

	    function redirectToListPage(status) {
	        if (status.indexOf("error") != -1) {
	            $('.loading-btn').button('reset');
	        } else {
	            window.location = rootUri + "Agent/AMarket/ABrightSpotList";
	        }
	    }

	    function set_modalparam(id) {
	        $(':checkbox:checked').removeAttr('checked');
	        dialog_selids = ",";
	    }

	    function submit_dataitem() {
	        var selected_id = "";
//	        $(':checkbox:checked').each(function () {
//	            if ($(this).attr('name') == 'selcheckbox_dlg')
//	                selected_id += $(this).attr('value') + ",";
//	        });

	        selected_id = dialog_selids.substring(1, dialog_selids.length);

	        if (selected_id.length < 2)
	            return;


	        var ids = selected_id.split(",");
	        for (var i = 0; i < ids.length - 1; i++) {
	            if ($("li[data-id='new_" + ids[i] + "']").html() != undefined) {
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

	                toastr["error"]("图片已经存在", "温馨敬告");

	                return;
	            }
	        }

	        $.ajax({
	            url: rootUri + "Agent/AMarket/GetNestableImgInfo",
	            data: {
	                "id": $("#androiddata_id").val(),
	                "selids": selected_id
	            },
	            type: "post",
	            success: function (datalist) {
	                if (datalist != null && datalist != "") {
	                    for (var i = 0; i < datalist.length; i++) {
	                        var data = datalist[i];
	                        var newhtml =
						    '<li class="dd-item dd2-item" data-id="new_' + data.uid + '">' +
							    '<div class="dd-handle dd2-handle">' +
                                    '<i class="normal-icon ace-icon fa fa-bars blue bigger-130"></i>' +
                                    '<i class="drag-icon ace-icon fa fa-arrows bigger-125"></i>' +
                                '</div>' +
							    '<div class="dd2-content">' +
                                    '<table style="width:100%; height:100%;">' +
                                        '<tr><td><a style="display:inline-block" href="' + rootUri + data.imgurl + '">' +
                                                    '<img src="' + rootUri + data.imgurl + '" style="max-width:150px; max-height:120px;" /></a>' +
                                            '</td>' +
                                            '<td><div style="height:100%">' +
                                                    '<table style="width:100%; height:100%;">' +
                                                        '<tr ><td><label>标题：</label>' +
                                                                '<input type="text" style="width:400px; padding:3px 3px 3px;" name="title_' + data.uid + '" value="' + data.title + '" disabled />' +
                                                            '</td></tr>' +
                                                        '<tr ><td>' +
                                                        '<label>描述：</label><textarea style="width:400px; height:6em; padding:3px 3px 3px;" name="desc_' + data.uid + '" disabled>' + data.description + '</textarea>' +
                                                        '</td></tr>' +
                                                    '</table>' +
                                                '</div></td>' +
                                            '<td style="width: 10%; text-align:right;" valign="top"><a href="#" class="btn default" onclick="removeItem(\'new_' + data.uid + '\');"><i class="fa fa-trash-o"></i></a></td>' +
                                        '</tr></table>' +
                                '</div></li>';
	                        $("#dd-list").append(newhtml);
	                    }

	                    $('#photolist').nestable().on('change', updateOutput);
	                    updateOutput($('#photolist').data('output', $('#idsortlist')));
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

	                    toastr["error"]("图片已经存在", "温馨敬告");
	                }
	            }
	        });
	    }

	    function IsIdChecked_dlg(id) {
	        if (dialog_selids.indexOf("," + id + ",", 0) >= 0)
	            return true;
	        else
	            return false;
	    }

	    function RemoveId_dlg(id) {
	        dialog_selids = dialog_selids.replace(new RegExp("," + id + ","), ",");
	    }

	    function AddId_dlg(id) {
	        if (dialog_selids.indexOf("," + id + ",", 0) < 0)
	            dialog_selids += id + ",";
	    }

	    function onChangeChecked_dlg(element) {
	        if (element.checked)
	            AddId_dlg($(element).val());
	        else
	            RemoveId_dlg($(element).val());
        }
    
    </script>
</asp:Content>
