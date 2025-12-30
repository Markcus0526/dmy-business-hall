<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header">
	<h1>
        支付方式		
	</h1>
</div>

<div class="row">
	<div class="col-xs-12">
		<div>
            <p>
                <a class="btn btn-white btn-info btn-bold" href="<%= ViewData["rootUri"] %>SysSetting/SelectPayment">
	                <i class="ace-icon fa fa-plus bigger-120 blue"></i>添加支付
                </a>
            </p>
		</div>

		<div>
			<table id="tbldata" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
				        <th>名称</th>
				        <th>支付方式</th>
				        <th>排行</th>
				        <th>操作</th>
			        </tr>
				</thead>
				<tbody>
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

	<script>
	    var dtInst;
	    var handleDataTable = function () {
	        if (!jQuery().dataTable) {
	            return;
	        }

	        // begin first table
	        dtInst = $('#tbldata').dataTable({
	            "bServerSide": true,
	            "bProcessing": true,
	            "sAjaxSource": rootUri + "SysSetting/RetrievePaymentList",
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
	            // set the initial value
	            "iDisplayLength": 10,
	            "bFilter": false,
	            "aoColumnDefs": [
				    {
				        aTargets: [3],    // Column number which needs to be modified
				        fnRender: function (o, v) {   // o, v contains the object and value for the column
				            var rhtml = '<a href="' + rootUri + 'SysSetting/EditPayment/' + o.aData[3] + "?paymode=" + o.aData[1] + '" class="btn default btn-xs default"><i class="fa fa-edit"></i> 编辑</a>&nbsp;&nbsp;' +
                                        '<a href="javascript:void(0);" class="btn default btn-xs default" onclick="return deletePayment(' + o.aData[3] + ');"><i class="fa fa-trash-o"></i> 删除</a>';

				            return rhtml;
				        },
				        sClass: 'tableCell'    // Optional - class to be applied to this table cell
				    }
                ]
	        });
	    }
	    jQuery(document).ready(function () {
	        handleDataTable();
	    });

	    function deletePayment(id) {
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
	                            url: rootUri + "SysSetting/DeletePayment",
	                            data: {
	                                "id": id
	                            },
	                            type: "post",
	                            success: function (message) {
	                                if (message == true) {
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
	                                    toastr["success"]("删除成功！", "恭喜您");
	                                }
	                            }
	                        });
	                    }
	                }
	            }
	        });
	    }

	    function redirectToListPage(status) {
	        if (status.indexOf("error") != -1) {
	        } else {
	            refreshTable();
	        }
	    }
	    function refreshTable() {
	        oSettings = dtInst.fnSettings();

	        dtInst.dataTable().fnDraw();
	    }

    </script>
</asp:Content>
