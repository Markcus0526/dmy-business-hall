<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Agent/Agent.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header">
	<h1>
		系统设置 -> 通知列表
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
        <p class="alert alert-info">
	        <i class="ace-icon fa fa-exclamation-triangle"></i>
            温馨提示：向营业厅发布通知<br />
            
        </p>
		<div>
            <p>
                <a class="btn btn-white btn-info btn-bold" href="<%= ViewData["rootUri"] %>Agent/ASystem/AddNotice">
	                <i class="ace-icon fa fa-plus bigger-120 blue"></i>添加通知
                </a>
                <a class="btn btn-white btn-warning btn-bold" style="display:none;" id="btnbatchdel" onclick="processDel();">
                    <i class="ace-icon fa fa-trash-o bigger-120 orange"></i>批量删除
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
						<th>题目</th>
						<th>通知范围</th>
						<th>通知时间</th>
						<th>是否显示</th>
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

			            <td>新功能上线啦~~~！</td>
			            <td>沈阳代理1，沈阳代理2</td>
			            <td>2014年05月24日 11:33：23</td>
			            <td class="hidden-480">
				            <span class="label label-inverse arrowed-in">不显示</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>显示</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="#" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
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

			            <td>营业厅管理方法阿加莎领导咳嗽发生的减肥</td>
			            <td>沈阳代理2</td>
			            <td>2014年05月24日 11:33：23</td>
			            <td class="hidden-480">
				            <span class="label label-success">启用</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>不显示</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="#" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
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

			            <td>营业厅管理方法阿加莎领导咳嗽发生的减肥</td>
			            <td>沈阳代理2</td>
			            <td>2014年05月24日 11:33：23</td>
			            <td class="hidden-480">
				            <span class="label label-success">启用</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>不显示</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="#" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
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

			            <td>营业厅管理方法阿加莎领导咳嗽发生的减肥</td>
			            <td>沈阳代理2</td>
			            <td>2014年05月24日 11:33：23</td>
			            <td class="hidden-480">
				            <span class="label label-success">启用</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>不显示</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="#" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
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

			            <td>营业厅管理方法阿加莎领导咳嗽发生的减肥</td>
			            <td>沈阳代理2</td>
			            <td>2014年05月24日 11:33：23</td>
			            <td class="hidden-480">
				            <span class="label label-success">启用</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>不显示</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="#" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
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

			            <td>营业厅管理方法阿加莎领导咳嗽发生的减肥</td>
			            <td>沈阳代理2</td>
			            <td>2014年05月24日 11:33：23</td>
			            <td class="hidden-480">
				            <span class="label label-success">启用</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>不显示</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="#" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
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

			            <td>营业厅管理方法阿加莎领导咳嗽发生的减肥</td>
			            <td>沈阳代理2</td>
			            <td>2014年05月24日 11:33：23</td>
			            <td class="hidden-480">
				            <span class="label label-success">启用</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>不显示</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="#" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
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

			            <td>营业厅管理方法阿加莎领导咳嗽发生的减肥</td>
			            <td>沈阳代理2</td>
			            <td>2014年05月24日 11:33：23</td>
			            <td class="hidden-480">
				            <span class="label label-success">启用</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>不显示</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="#" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
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

			            <td>营业厅管理方法阿加莎领导咳嗽发生的减肥</td>
			            <td>沈阳代理2</td>
			            <td>2014年05月24日 11:33：23</td>
			            <td class="hidden-480">
				            <span class="label label-success">启用</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>不显示</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="#" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
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

			            <td>营业厅管理方法阿加莎领导咳嗽发生的减肥</td>
			            <td>沈阳代理2</td>
			            <td>2014年05月24日 11:33：23</td>
			            <td class="hidden-480">
				            <span class="label label-success">启用</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>不显示</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="#" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
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

			            <td>营业厅管理方法阿加莎领导咳嗽发生的减肥</td>
			            <td>沈阳代理2</td>
			            <td>2014年05月24日 11:33：23</td>
			            <td class="hidden-480">
				            <span class="label label-success">启用</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
							    <a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
                                <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>不显示</a>
                                <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
							    <a class="blue " href="#" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>
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
		        oTable =
				$('#tbldata')
				.dataTable({
				    "bServerSide": true,
				    "bProcessing": true,
				    "sAjaxSource": rootUri + "Agent/ASystem/RetrieveANoticeList",
				    "oLanguage": {
				        "sUrl": rootUri + "Content/i18n/dataTables.chinese.txt"
				    },
				    "aoColumns": [
					  { "bSortable": false },
					  null,
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
                            aTargets: [4],    // Column number which needs to be modified
                            fnRender: function (o, v) {   // o, v contains the object and value for the column
                                var rst = "";
                                switch (parseInt(o.aData[4], 10)) {
                                    case 0:
                                        rst = '<span class="label label-inverse arrowed-in">不显示</span>';
                                        break;
                                    case 1:
                                        rst = '<span class="label label-success">显示</span>';
                                        break;
                                }

                                return rst;
                            },
                            sClass: 'center'
                        },
				     	{
				     	    aTargets: [5],    // Column number which needs to be modified
				     	    /*<a class="green" href="#"><i class="ace-icon fa fa-pencil bigger-130"></i>编辑</a>
				     	    <a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>不显示</a>
				     	    <a class="red" href="#"><i class="ace-icon fa fa-trash-o bigger-130"></i>删除</a>
				     	    <a class="blue " href="#" ><i class="ace-icon fa fa-sign-in bigger-130"></i>管理</a>*/

				     	    fnRender: function (o, v) {   // o, v contains the object and value for the column

				     	        var rst = '<div class="hidden-sm hidden-xs action-buttons" style="width:200px">';
				     	        rst += '<a class="green" href="' + rootUri + 'Agent/ASystem/EditNotice/' + o.aData[5] + '">' +
				     				        '<i class="ace-icon fa fa-pencil bigger-130"></i>编辑' +
				     				        '</a>';
				     	        switch (parseInt(o.aData[6], 10)) {
				     	            case 0:
				     	                rst += '<a class="orange" href="#" onclick="processShow(' + o.aData[5] + ')"><i class="ace-icon fa fa-unlock bigger-130"></i>显示</a>';
				     	                break;
				     	            case 1:
				     	                rst += '<a class="orange" href="#" onclick="processHide(' + o.aData[5] + ')"><i class="ace-icon fa fa-lock bigger-130"></i>不显示</a>';
				     	                break;
				     	        }
				     	        //rst += '<a class="orange" href="#"><i class="ace-icon fa fa-unlock bigger-130"></i>不显示</a>';
				     	        rst += '<a class="red" href="#" onclick="processDel(' + o.aData[5] + ')">' +
				     				        '<i class="ace-icon fa fa-trash-o bigger-130"></i>删除' +
				     				        '</a>';
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
		            //$("#btnbatchdel").css("display", "normal");
		            $("#btnbatchdel").show();
		        } else {
		            //$("#btnbatchdel").css("display", "none");
		            $("#btnbatchdel").hide();
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
		                                url: rootUri + "System/DeleteSysNotice",
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
		                                        toastr["success"]("删除成功！", "恭喜您");
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
		                message: "您确定要显示吗？",
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
		                                url: rootUri + "System/showSysNotice",
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
		                                        toastr["success"]("显示成功！", "恭喜您");
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
		                message: "您确定要不显示吗？",
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
		                                url: rootUri + "System/hideSysNotice",
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
		                                        toastr["success"]("不显示成功！", "恭喜您");
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
