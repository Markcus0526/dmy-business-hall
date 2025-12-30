<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header">
	<h1>
		城市代理账号
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
        <p class="alert alert-info">
	        <i class="ace-icon fa fa-exclamation-triangle"></i>
            温馨提示：如果把代理设置为冻结，代理用他的账号不能登录<br />
            点击操作栏的登录按钮，替该代理的权限可以进去
        </p>
		<div>
            <p>
                <a class="btn btn-white btn-info btn-bold" href="<%= ViewData["rootUri"] %>Agt/AddAgent">
	                <i class="ace-icon fa fa-plus bigger-120 blue"></i>添加代理
                </a>
                <a class="btn btn-white btn-warning btn-bold btnbatch" style="display:none;" id="btnbatchdel" onclick="processDel();">
                    <i class="ace-icon fa fa-trash-o bigger-120 orange"></i>批量删除
                </a>
                <a class="btn btn-white btn-warning btn-bold btnbatch" style="display:none;" id="btnbatchactivate" onclick="processActivate();">
                    <i class="ace-icon fa fa-unlock bigger-120 orange"></i>批量解冻
                </a>
                <a class="btn btn-white btn-warning btn-bold btnbatch" style="display:none;" id="btnbatchblock" onclick="processBlock();">
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
						<th>代理名称</th>
						<th>公司名称</th>
						<th>联系人</th>
						<th>电话</th>
						<th style="width:60px;">状态</th>
						<th style="min-width:80px;">操作</th>
					</tr>
				</thead>
				<tbody>
                    <!--<tr>
			            <td class="center">
				            <label class="position-relative">
					            <input type="checkbox" class="ace" />
					            <span class="lbl"></span>
				            </label>
			            </td>

			            <td>sydl1</td>
			            <td>沈阳代理1</td>
			            <td>沈阳营业厅管理公司1 </td>
			            <td>张三</td>
			            <td>138392834323</td>
			            <td class="hidden-480">
				            <span class="label label-inverse arrowed-in">冻结</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>解冻</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="<%= ViewData["rootUri"] %>Agt/LoginAgent/1" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
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

			            <td>sydl2</td>
			            <td>沈阳代理2</td>
			            <td>沈阳营业厅管理公司2</td>
			            <td>王老</td>
			            <td>138392834323</td>
			            <td class="hidden-480">
				            <span class="label label-success">启用</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>冻结</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="<%= ViewData["rootUri"] %>Agt/LoginAgent/1" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
						    </div>
                        </td>
                    </tr>-->
				</tbody>
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
		        oTable =
				$('#tbldata')
				.dataTable({
				    "bServerSide": true,
				    "bProcessing": true,
				    "sAjaxSource": rootUri + "Agt/RetrieveAgentList",
				    "oLanguage": {
				        "sUrl": rootUri + "Content/i18n/dataTables.chinese.txt"
				    },
				    //bAutoWidth: false,
				    "aoColumns": [
					  { "bSortable": false },
                      null,
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
                            aTargets: [6],    // Column number which needs to be modified
                            fnRender: function (o, v) {   // o, v contains the object and value for the column
                                var rst = "";
                                switch (parseInt(o.aData[6], 10)) {
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
 				            aTargets: [7],    // Column number which needs to be modified
 				            fnRender: function (o, v) {   // o, v contains the object and value for the column
 				                var rst = '<div class="hidden-sm hidden-xs action-buttons">' +
							        '<a class="green" href="' + rootUri + 'Agt/EditAgent/' + o.aData[7] + '"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>';

 				                switch (parseInt(o.aData[8], 10)) {
 				                    case 0:
 				                        rst += '<a class="orange" href="#" onclick="processActivate(' + o.aData[7] + ')"><i class="ace-icon fa fa-unlock bigger-130"></i>解冻</a>';
 				                        break;
 				                    case 1:
 				                        rst += '<a class="orange" href="#" onclick="processBlock(' + o.aData[7] + ')"><i class="ace-icon fa fa-lock bigger-130"></i>冻结</a>';
 				                        break;
 				                }

 				                rst += '<a class="red" href="#" onclick="processDel(' + o.aData[7] + ')"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>' +
                                    '<a class="dark" href="' + rootUri + 'Agt/EditAPass/' + o.aData[7] + '"><i class="ace-icon fa fa-key bigger-130"></i>修改密码</a>' +
							        '<a class="blue " href="' + rootUri + 'Agt/LoginAgent/' + o.aData[7] + '" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>' +
						        '</div>';

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
		                                url: rootUri + "Agt/DeleteAgent",
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

		    function processBlock(sel_id) {
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
		                message: "您确定要冻结吗？",
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
		                                url: rootUri + "Agt/BlockAgent",
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
		                                        toastr["success"]("批量冻结成功！", "恭喜您");
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

		    function processActivate(sel_id) {
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
		                                url: rootUri + "Agt/ActivateAgent",
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
