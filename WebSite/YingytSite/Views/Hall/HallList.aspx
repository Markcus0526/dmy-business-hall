<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header">
	<h1>
		营业厅管理
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
        <p class="alert alert-info">
	        <i class="ace-icon fa fa-exclamation-triangle"></i>
            温馨提示：如果把营业厅设置为冻结，该账号不能登录
        </p>
		<div>
            <p>
                <a class="btn btn-white btn-info btn-bold" href="<%= ViewData["rootUri"] %>Hall/AddHall">
	                <i class="ace-icon fa fa-plus bigger-120 blue"></i>添加营业厅
                </a>
                <a class="btn btn-white btn-warning btn-bold btnbatch" style="display:none;" id="btnbatchdel" onclick="processDel();">
                    <i class="ace-icon fa fa-trash-o bigger-120 orange"></i>批量删除
                </a>
                <a class="btn btn-white btn-warning btn-bold btnbatch" style="display:none;" id="btnbatchactivate" onclick="processShow();">
                    <i class="ace-icon fa fa-unlock bigger-120 orange"></i>批量解冻
                </a>
                <a class="btn btn-white btn-warning btn-bold btnbatch" style="display:none;" id="btnbatchblock" onclick="processHide();">
                    <i class="ace-icon fa fa-lock bigger-120 orange"></i>批量冻结
                </a>
            </p>
		</div>

		<div>
			<table id="tbldata" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="center">
							<label class="position-relative">
								<input type="checkbox" class="ace" />
								<span class="lbl"></span>
							</label>
						</th>
						<th>账号</th>
						<th>营业厅名称</th>
                        <th>代理名称</th>
						<th>地址</th>
						<th>手机</th>
						<th>邮箱</th>
						<th>状态</th>
						<th style="min-width:80px;">操作</th>
					</tr>
				</thead>
				<!--<tbody>
                    <tr>
			            <td class="center">
				            <label class="position-relative">
					            <input type="checkbox" class="ace" />
					            <span class="lbl"></span>
				            </label>
			            </td>

			            <td>yyt1</td>
			            <td>和平区营业厅1</td>
			            <td>辽宁 沈阳 和平区 293290 </td>
			            <td>1383456568， 293840293</td>
			            <td>yyt1@yidong.com</td>
			            <td class="hidden-480">
				            <span class="label label-inverse arrowed-in">冻结</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>解冻</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="<%= ViewData["rootUri"] %>Hall/LoginHall/1" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
						    </div>

                        </td>
                    </tr>
                    <tr>
			            <td class="center">
				            <label class="position-relative">
					            <input type="checkbox" class="ace" />
					            <span class="lbl"></span>
				            </label>
			            </td>

			            <td>yyt2</td>
			            <td>和平区营业厅1</td>
			            <td>辽宁 沈阳 和平区 293290 </td>
			            <td>1383456568， 293840293</td>
			            <td>yyt1@yidong.com</td>
			            <td class="hidden-480">
				            <span class="label label-success">启用</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>冻结</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="<%= ViewData["rootUri"] %>Hall/LoginHall/1" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
						    </div>

                        </td>
                    </tr>
				</tbody>-->
			</table>
		</div>
	</div>
</div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageStyle" runat="server">
	<link rel="stylesheet" type="text/css" href="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.min.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.dataTables.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.dataTables.bootstrap.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/bootbox.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>  
		<script type="text/javascript">
		    var selected_id = "";
		    var oTable;
		    jQuery(function ($) {
		        oTable = $('#tbldata')
				.dataTable({
				    "bServerSide": /*true*/true,
				    "bProcessing": true,
				    "sAjaxSource": rootUri + "Hall/RetrieveHallList",
				    "oLanguage": {
				        "sUrl": rootUri + "Content/i18n/dataTables.chinese.txt"
				    },
				    "aoColumns": [
					  { "bSortable": false },
					  null,
					  { "bSortable": false },
                      { "bSortable": false },
					  { "bSortable": false },
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
 								    '<input type="checkbox" value="' + o.aData[0] + '" name="selcheckbox" class="ace" onclick="showBatchBtn()" />' +
 								    '<span class="lbl"></span>' +
 							        '</label>';
 				            },
 				            sClass: 'center'
 				        },
                        {
                            aTargets: [7],    // Column number which needs to be modified
                            fnRender: function (o, v) {   // o, v contains the object and value for the column
                                var rst = "";
                                switch (parseInt(o.aData[7], 10)) {
                                    case 0:
                                        rst = '<span class="label label-inverse arrowed-in">冻结</span>';
                                        break;
                                    case 1:
                                        rst = '<span class="label label-success">启用</span>';
                                        break;
                                }

                                return rst;
                            },
                            sClass: 'center'
                        },
 				        {
 				            aTargets: [8],    // Column number which needs to be modified
 				            fnRender: function (o, v) {   // o, v contains the object and value for the column
 				                var rst = '<div class="hidden-sm hidden-xs action-buttons" style="width:200px">';
 				                rst += '<a class="green" href="' + rootUri + 'Hall/EditHall/' + o.aData[8] + '">' +
				     				        '<i class="ace-icon fa fa-pencil bigger-130"></i>编辑' +
				     				        '</a>';
 				                switch (parseInt(o.aData[9], 10)) {
 				                    case 0:
 				                        rst += '<a class="orange" href="#" onclick="processShow(' + o.aData[8] + ')"><i class="ace-icon fa fa-unlock bigger-130"></i>解冻</a>';
 				                        break;
 				                    case 1:
 				                        rst += '<a class="orange" href="#" onclick="processHide(' + o.aData[8] + ')"><i class="ace-icon fa fa-lock bigger-130"></i>冻结</a>';
 				                        break;
 				                }
 				                rst += '<a class="red" href="#" onclick="processDel(' + o.aData[8] + ')"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>' +
                                    '<a class="dark" href="' + rootUri + 'Hall/EditLPass/' + o.aData[8] + '"><i class="ace-icon fa fa-key bigger-130"></i>修改密码</a>';
 				                rst += '<a class="blue" href="' + rootUri + 'Hall/LoginHall/' + o.aData[8] +'" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>';
 				                rst += '</div>';
 				                return rst;
 				            },
 				            sClass: 'center'
 				        }
                     ],
				    "fnDrawCallback": function (oSettings) {
				        showBatchBtn();
				    }

				});

		        $(document).on('click', 'th input:checkbox', function () {
		            var that = this;
		            $(this).closest('table').find('tr > td:first-child input:checkbox')
					.each(function () {
					    this.checked = that.checked;
					    $(this).closest('tr').toggleClass('selected');
					});

		            showBatchBtn();
		        });

		        $('[data-rel="tooltip"]').tooltip({ placement: tooltip_placement });
		        function tooltip_placement(context, source) {
		            var $source = $(source);
		            var $parent = $source.closest('table')
		            var off1 = $parent.offset();
		            var w1 = $parent.width();

		            var off2 = $source.offset();
		            //var w2 = $source.width();

		            if (parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2)) return 'right';
		            return 'left';
		        }

		    });

		    function showBatchBtn() {
		        selected_id = "";

		        $(':checkbox:checked').each(function () {
		            if ($(this).attr('name') == 'selcheckbox')
		                selected_id += $(this).attr('value') + ",";
		        });

		        if (selected_id != "") {
		            //$(".btnbatch").css("display", "normal");
		            $(".btnbatch").show();
		            //$("#btnbatchdel").css("display", "normal");
		        } else {
		            $(".btnbatch").hide();
		            //$(".btnbatch").css("display", "none");
		            //$("#btnbatchdel").css("display", "none");
		        }
		    }

		    function refreshTable() {
		        oSettings = oTable.fnSettings();
		        oTable.dataTable().fnDraw();
		    }
		    function redirectToListPage(status) {
		        if (status.indexOf("error") != -1) {
		        } else {
		            refreshTable();
		        }
		    }

		    function processDel(sel_id) {
		        var selected_id = "";

		        if (sel_id != null && sel_id.length != "") {
		            selected_id = sel_id;
		        } else {
		            $(':checkbox:checked').each(function () {
		                if ($(this).attr('name') == 'selcheckbox')
		                    selected_id += $(this).attr('value') + ",";
		            });
		        }

		        if (selected_id != "") {
		            bootbox.dialog({
		                message: "您确定要删除吗？",
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
		                            $.ajax({
		                                url: rootUri + "Hall/DeleteHall",
		                                data: {
		                                    "delids": selected_id
		                                },
		                                type: "post",
		                                success: function (message) {
		                                    if (message == true) {
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
		                                        toastr["success"]("批量删除成功！", "恭喜您");
		                                    }
		                                }
		                            });
		                        }
		                    }
		                }
		            });
		        }
		        else {
		            //
		        }
		        return false;
		    }

		    function processShow(sel_id) {
		        var selected_id = "";

		        if (sel_id != null && sel_id.length != "") {
		            selected_id = sel_id;
		        } else {
		            $(':checkbox:checked').each(function () {
		                if ($(this).attr('name') == 'selcheckbox')
		                    selected_id += $(this).attr('value') + ",";
		            });
		        }

		        if (selected_id != "") {
		            bootbox.dialog({
		                message: "您确定要解冻吗？",
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
		                            $.ajax({
		                                url: rootUri + "Hall/showHall",
		                                data: {
		                                    "updateids": selected_id
		                                },
		                                type: "post",
		                                success: function (message) {
		                                    if (message == true) {
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
		                                        toastr["success"]("批量解冻成功！", "恭喜您");
		                                    }
		                                }
		                            });
		                        }
		                    }
		                }
		            });
		        }
		        else {
		            //
		        }
		        return false;
		    }
		    function processHide(sel_id) {
		        var selected_id = "";

		        if (sel_id != null && sel_id.length != "") {
		            selected_id = sel_id;
		        } else {
		            $(':checkbox:checked').each(function () {
		                if ($(this).attr('name') == 'selcheckbox')
		                    selected_id += $(this).attr('value') + ",";
		            });
		        }

		        if (selected_id != "") {
		            bootbox.dialog({
		                message: "您确定要解冻吗？",
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
		                            $.ajax({
		                                url: rootUri + "Hall/hideHall",
		                                data: {
		                                    "updateids": selected_id
		                                },
		                                type: "post",
		                                success: function (message) {
		                                    if (message == true) {
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
		                                        toastr["success"]("批量解冻成功！", "恭喜您");
		                                    }
		                                }
		                            });
		                        }
		                    }
		                }
		            });
		        }
		        else {
		            //
		        }
		        return false;
		    }
		    
        </script>
</asp:Content>
