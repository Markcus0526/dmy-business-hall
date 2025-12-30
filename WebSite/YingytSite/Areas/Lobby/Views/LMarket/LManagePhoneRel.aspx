<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Lobby/Lobby.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<% var detrelinfo = (tbl_androiddetrel)ViewData["detrelinfo"]; %>
<div class="page-header">
	<h1>
		编辑手机类型范围
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
				<label class="col-sm-3 control-label no-padding-right" for="videoname">最小价格<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="minprice" name="minprice" placeholder="请输入最小价格" class="col-xs-5 col-sm-2" value="<% if (detrelinfo != null) { %><%= detrelinfo.minprice %><% } %>" />&nbsp;&nbsp;&nbsp;
                    <label class="col-sm-3 control-label no-padding-right" for="videoname">最大价格<span class="red">*</span>：</label>
					<input type="text" id="maxprice" name="maxprice" placeholder="请输入最大价格" class="col-xs-5 col-sm-2" value="<% if (detrelinfo != null) { %><%= detrelinfo.maxprice %><% } %>" />
                    </div>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">最小屏幕大小<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="minscrsize" name="minscrsize" placeholder="请输入最小屏幕大小" class="col-xs-5 col-sm-2" value="<% if (detrelinfo != null) { %><%= detrelinfo.minscrsize %><% } %>" />&nbsp;&nbsp;&nbsp;
                    <label class="col-sm-3 control-label no-padding-right" for="videoname">最大屏幕大小<span class="red">*</span>：</label>
					<input type="text" id="maxscrsize" name="maxscrsize" placeholder="请输入最大屏幕大小" class="col-xs-5 col-sm-2" value="<% if (detrelinfo != null) { %><%= detrelinfo.maxscrsize %><% } %>" />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">最小内存大小<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="minmemsize" name="minmemsize" placeholder="请输入最小内存大小" class="col-xs-5 col-sm-2" value="<% if (detrelinfo != null) { %><%= detrelinfo.minmemsize %><% } %>" />&nbsp;&nbsp;&nbsp;
                    <label class="col-sm-3 control-label no-padding-right" for="videoname">最大内存大小<span class="red">*</span>：</label>
					<input type="text" id="maxmemsize" name="maxmemsize" placeholder="请输入最大内存大小" class="col-xs-5 col-sm-2" value="<% if (detrelinfo != null) { %><%= detrelinfo.maxmemsize %><% } %>" />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">最小像素数<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="minpixcnt" name="minpixcnt" placeholder="请输入最小像素数" class="col-xs-5 col-sm-2" value="<% if (detrelinfo != null) { %><%= detrelinfo.minpixcnt %><% } %>" />&nbsp;&nbsp;&nbsp;
                    <label class="col-sm-3 control-label no-padding-right" for="videoname">最大像素数<span class="red">*</span>：</label>
					<input type="text" id="maxpixcnt" name="maxpixcnt" placeholder="请输入最大像素数" class="col-xs-5 col-sm-2" value="<% if (detrelinfo != null) { %><%= detrelinfo.maxpixcnt %><% } %>" />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">最小版本<span class="red">*</span>：</label>
				<div class="col-sm-9">
                    <div class="clearfix">
					<input type="text" id="minosver" name="minosver" placeholder="请输入最小版本" class="col-xs-5 col-sm-2" value="<% if (detrelinfo != null) { %><%= detrelinfo.minosver %><% } %>" />&nbsp;&nbsp;&nbsp;
                    <label class="col-sm-3 control-label no-padding-right" for="videoname">最大版本<span class="red">*</span>：</label>
					<input type="text" id="maxosver" name="maxosver" placeholder="请输入最大版本" class="col-xs-5 col-sm-2" value="<% if (detrelinfo != null) { %><%= detrelinfo.maxosver %><% } %>" />
                    </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="videoname">手动添加同类型手机：<span class="red">*</span>：</label>
				<div class="col-sm-9" id="divdetaillist">
                    <div class="clearfix">
                        <a href="#modal-table" data-toggle="modal" class="btn btn-sm" id="image" onclick="showPhoneList();">添加同类型手机</a>
                    </div>
                <%
                    var reldetaillist = (List<RelDetailInfo>)ViewData["reldetaillist"];
                    if (reldetaillist != null)
                    {
                        for (int i = 0; i < reldetaillist.Count(); i++)
                        {
                            RelDetailInfo item = reldetaillist.ElementAt(i);
                            if (item.imgurl == null || item.imgurl == "")
                                item.imgurl = "content/img/huawei_tmp.jpg";
                     %>
                        <div style="margin:10px 0px;">
                            <input type="hidden" class="divimglist" value="<% =item.uid %>" />
                            <div style='float:left; padding:5px;'>
                            <img src='<%= ViewData["rootUri"] %><% =item.imgurl %>' style="border:1px solid #ccc;" width='100px' height='100px' onmouseover='over_img(this)' onmouseout='out_img(this)' >
                            <a href='javascript:(0);'><img src='<%= ViewData["rootUri"] %>content/img/imgdel.png' class='close_btn' onclick="removeMe(this, 'fname')" onmouseover='over_close(this)' style='visibility:hidden; margin-top:-100px; margin-left:-10px; width:20px; height:20px;' onmouseout='out_close(this)'></a>
                            </div>
                        </div>
                <% 
                        }
                    }
                     %>

                <!--<div style="margin:10px 0px;" id="div1">
                    <div style='float:left; padding:5px;'>
                    <img src='/content/img/huawei_tmp.jpg' style="border:1px solid #ccc;" width='100px' height='100px' onmouseover='over_img(this)' onmouseout='out_img(this)' >
                    <a href='javascript:(0);'><img src='<%= ViewData["rootUri"] %>content/img/imgdel.png' class='close_btn' onclick="removeMe(this, 'fname')" onmouseover='over_close(this)' style='visibility:hidden; margin-top:-100px; margin-left:-10px; width:20px; height:20px;' onmouseout='out_close(this)'></a>
                    </div>
                </div>
                <div style="margin:10px 0px;" id="div2">
                    <div style='float:left; padding:5px;'>
                    <img src='/content/img/huawei_tmp.jpg' style="border:1px solid #ccc;" width='100px' height='100px' onmouseover='over_img(this)' onmouseout='out_img(this)' >
                    <a href='javascript:(0);'><img src='<%= ViewData["rootUri"] %>content/img/imgdel.png' class='close_btn' onclick="removeMe(this, 'fname')" onmouseover='over_close(this)' style='visibility:hidden; margin-top:-100px; margin-left:-10px; width:20px; height:20px;' onmouseout='out_close(this)'></a>
                    </div>
                </div>
                <div style="margin:10px 0px;" id="div3">
                    <div style='float:left; padding:5px;'>
                    <img src='/content/img/huawei_tmp.jpg' style="border:1px solid #ccc;" width='100px' height='100px' onmouseover='over_img(this)' onmouseout='out_img(this)' >
                    <a href='javascript:(0);'><img src='<%= ViewData["rootUri"] %>content/img/imgdel.png' class='close_btn' onclick="removeMe(this, 'fname')" onmouseover='over_close(this)' style='visibility:hidden; margin-top:-100px; margin-left:-10px; width:20px; height:20px;' onmouseout='out_close(this)'></a>
                    </div>
                </div>
                <div style="margin:10px 0px;" id="div4">
                    <div style='float:left; padding:5px;'>
                    <img src='/content/img/huawei_tmp.jpg' style="border:1px solid #ccc;" width='100px' height='100px' onmouseover='over_img(this)' onmouseout='out_img(this)' >
                    <a href='javascript:(0);'><img src='<%= ViewData["rootUri"] %>content/img/imgdel.png' class='close_btn' onclick="removeMe(this, 'fname')" onmouseover='over_close(this)' style='visibility:hidden; margin-top:-100px; margin-left:-10px; width:20px; height:20px;' onmouseout='out_close(this)'></a>
                    </div>
                </div>-->
				</div>


			</div>
            
            <input type="hidden" id="reldetailids" name="reldetailids" value="<% if (detrelinfo != null) { %><%= detrelinfo.reldetailids %><% } %>" />
            <input type="hidden" id="uid" name="uid" value="<% if (ViewData["uid"] != null) { %><%= ViewData["uid"] %><% } else { %>0<% } %>" />

			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-info loading-btn" type="submit" data-loading-text="提交中...">
						<i class="ace-icon fa fa-check bigger-110"></i>
						提交
					</button>

					&nbsp; &nbsp; &nbsp;
					<button class="btn" type="button" onclick="window.location='<%= ViewData["rootUri"] %>Lobby/LMarket/LManagePhoneRel/<% if (ViewData["androiddetail_id"] != null) { %><%= ViewData["androiddetail_id"] %> <% } else { %>0 <% } %>'">
						<i class="ace-icon fa fa-undo bigger-110"></i>
						重置
					</button>
				</div>
			</div>
        </form>
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
					请选择手机
				</div>
			</div>

			<div class="modal-body no-padding">
				<table id="tbldetaildata" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
					<thead>
						<tr>
						    <th class="center">
							    <label class="position-relative">
								    <input type="checkbox" class="ace" id="selcheckbox_dlg"  value="" />
								    <span class="lbl"></span>
							    </label>
						    </th>
							<th>品牌，型号</th>
							<th>图片</th>
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

            <input type="hidden" id="dataid" value=""/>

		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- PAGE CONTENT ENDS -->

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageStyle" runat="server">
	<link rel="stylesheet" type="text/css" href="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.min.css" />
    <link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/css/jquery-ui.custom.min.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
	<script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>  
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.validate.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/validate.messages_zh.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery-ui.custom.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.ui.touch-punch.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.dataTables.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.dataTables.bootstrap.js"></script>

	<script type="text/javascript">

	    var dialog_selids = ",";
	    var dialog_imgurl = {};

	    function redirectToListPage(status) {
	        if (status.indexOf("error") != -1) {
	            $('.loading-btn').button('reset');
	        } else {
	            window.history.go(-1);
	            //window.location = rootUri + "Lobby/LBrief/LVideoList";
	        }
	    }

	    var oDetailTable;
	    jQuery(function ($) {
	        $('.loading-btn')
		      .click(function () {
		          var btn = $(this)
		          btn.button('loading')
		      });

		    oDetailTable =
			$('#tbldetaildata')
			.dataTable({
			    "bServerSide": true,
			    "bProcessing": true,
			    "sAjaxSource": rootUri + "Lobby/LMarket/RetrieveLPhoneDetail2",
			    "oLanguage": {
			        "sUrl": rootUri + "Content/i18n/dataTables.chinese.txt"
			    },
			    "aoColumns": [
					{ "bSortable": false },
					null,
					{ "bSortable": false }
				],
			    "aLengthMenu": [
                    [10, 20, 50, -1],
                    [10, 20, 50, "All"] // change per page values here
                ],
			    "iDisplayLength": 10,
			    "bFilter": false,
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
				 	    aTargets: [2],    // Column number which needs to be modified
				 	    fnRender: function (o, v) {   // o, v contains the object and value for the column
				 	        var rst = '';
				 	        if (('' + o.aData[2]).substring(0, 2) == "--")
				 	            rst += '<img src="<%= ViewData["rootUri"] %>content/img/default-image_100.gif" style="max-height:100px;" />';
				 	        else
				 	            rst += '<a href="<%= ViewData["rootUri"] %>' + o.aData[2] + '" target="_blank"><img src="<%= ViewData["rootUri"] %>' + o.aData[2] + '" style="width:74px;height:100px;max-height:100px;" /></a>';
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

			    showBatchBtn();
			});

	        $('#validation-form').validate({
	            errorElement: 'span',
	            errorClass: 'help-block',
	            //focusInvalid: false,
	            rules: {
	                minprice: {
	                    required: true,
                        number: true
                    },
                    maxprice: {
                        required: true,
                        number: true
                    },
                    minscrsize: {
                        required: true,
                        number: true
                    },
                    maxscrsize: {
                        required: true,
                        number: true
                    },
                    minmemsize: {
                        required: true,
                        number: true
                    },
                    maxmemsize: {
                        required: true,
                        number: true
                    },
                    minpixcnt: {
                        required: true,
                        number: true
                    },
                    maxpixcnt: {
                        required: true,
                        number: true
                    },
                    minosver: {
                        required: true,
                        number: true
                    },
                    maxosver: {
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
	        var selected_id = "";

	        $('input.divimglist').each(function () {
	            if ($(this).attr('class') == 'divimglist')
	                selected_id += $(this).attr('value') + ",";
	        });

	        $("#reldetailids").val(selected_id);
            
	        $.ajax({
	            type: "POST",
	            url: rootUri + "Lobby/LMarket/SubmitAndroidDetrel",
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

	    function showPhoneList() {
	        $(':checkbox:checked').removeAttr('checked');
	        dialog_selids = ",";
	        //$("#dataid").val(id);
	        //$('#selcheckbox_dlg').click();
	    }

	    function removeMe(obj, f_name) {
	        var pic_div = obj.parentNode.parentNode.parentNode;
	        //             var url;
	        //             url = rootUri + "goods_add/remove_photo3";    
	        //             $.ajax({
	        //                 url: url,
	        //                 data: "file_name=" + f_name,
	        //                 type: "post",
	        //                 success: function(message) {
	        $(pic_div).remove();
	        /*var img_name_ary = $('#imglisturl').val().split(',');
	        var img_name_data = "";
	        for (var i = 0; i < img_name_ary.length; i++) {
	            if (img_name_ary[i] == f_name)
	                continue;
	            else
	                img_name_data += img_name_ary[i] + ",";
	        }
	        img_name_data = img_name_data.substr(0, img_name_data.length - 1);
	        $('#imglisturl').val(img_name_data);*/
	        //                 }
	        //             });
	    }
	    function over_img(obj) {
	        clearTimeout(timeoutID);
	        timer_flag = false;
	        if (img_parent_div)
	            $(img_parent_div).find(".close_btn").css('visibility', 'hidden');
	        var obj_parent = $(obj).parent();
	        //$(obj_parent).find(".close_btn").show(); 
	        $(obj_parent).find(".close_btn").css('visibility', 'visible');
	    }
	    var img_parent_div = null;
	    var timeoutID;
	    function out_img(obj) {
	        img_parent_div = $(obj).parent();
	        timeoutID = setTimeout("timerProc( )", 500);
	        timer_flag = true;
	    }
	    var timer_flag = false;
	    var close_flag = false;
	    function timerProc() {
	        if (!close_flag) {
	            $(img_parent_div).find(".close_btn").css('visibility', 'hidden');
	        }
	        timer_flag = false;
	    }
	    function over_close(obj) {
	        close_flag = true;
	    }
	    function out_close(obj) {
	        close_flag = false;

	        if (!timer_flag)
	            $(obj).css('visibility', 'hidden');
	    }

	    function submit_dataitem() {
	        var selected_id = "";
//	        $(':checkbox:checked').each(function () {
//	            if ($(this).attr('name') == 'selcheckbox_dlg') {
//	                selected_id += $(this).attr('value') + ",";

//	                var detail_id = $(this).attr('value');
//	                //alert($("input[value='" + detail_id + "'].divimglist").val());
//	                if ($("input[value='" + detail_id + "'].divimglist").val() != undefined) {
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

//	                    toastr["error"]("手机已经存在", "温馨敬告");

//	                    return;
//	                }

//	                imgurl = $(this).parent().parent().parent().find('img').eq(0).attr("src");
//	                //alert(imgurl);

//	                var htmlstr = '<div style="margin:10px 0px;">' +
//                            '<input type="hidden" class="divimglist" value="' + detail_id + '" />' +
//                            '<div style="float:left; padding:5px;">' +
//                            '<img src="' + imgurl + '" style="border:1px solid #ccc;" width="100px" height="100px" onmouseover="over_img(this)" onmouseout="out_img(this)" >' +
//                            '<a href="javascript:(0);"><img src="<%= ViewData["rootUri"] %>content/img/imgdel.png" class="close_btn" onclick="removeMe(this, \'fname\')" onmouseover="over_close(this)" style="visibility:hidden; margin-top:-100px; margin-left:-10px; width:20px; height:20px;" onmouseout="out_close(this)"></a>' +
//                            '</div>'
//	                '</div>';

//	                $("#divdetaillist").append(htmlstr)
//	            }
//	        });

	        selected_id = dialog_selids.substring(1, dialog_selids.length);

	        if (selected_id.length < 2)
	            return;

	        var ids = selected_id.split(",");
	        for (var i = 0; i < ids.length - 1; i++) {
	            var detail_id = ids[i];
	            if ($("input[value='" + detail_id + "'].divimglist").val() != undefined) {
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

	            	toastr["error"]("手机已经存在", "温馨敬告");

	            	return;
	            }

	            imgurl = dialog_imgurl[detail_id]; //$(this).parent().parent().parent().find('img').eq(0).attr("src");
	            //alert(imgurl);

	            var htmlstr = '<div style="margin:10px 0px;">' +
	                    '<input type="hidden" class="divimglist" value="' + detail_id + '" />' +
	                    '<div style="float:left; padding:5px;">' +
	                    '<img src="' + imgurl + '" style="border:1px solid #ccc;" width="100px" height="100px" onmouseover="over_img(this)" onmouseout="out_img(this)" >' +
	                    '<a href="javascript:(0);"><img src="<%= ViewData["rootUri"] %>content/img/imgdel.png" class="close_btn" onclick="removeMe(this, \'fname\')" onmouseover="over_close(this)" style="visibility:hidden; margin-top:-100px; margin-left:-10px; width:20px; height:20px;" onmouseout="out_close(this)"></a>' +
	                    '</div>'
	            '</div>';

	            $("#divdetaillist").append(htmlstr)
	        }

//	        alert(selected_id);
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

	        dialog_imgurl[$(element).val()] = $(element).parent().parent().parent().find('img').eq(0).attr("src");
	    }

    </script>
</asp:Content>