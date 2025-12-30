<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Lobby/Lobby.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header">
	<h1>
		营销管理 -> 购机套餐
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
        <p class="alert alert-info">
	        <i class="ace-icon fa fa-exclamation-triangle"></i>
            温馨提示：三张以下航的图片显示（外X张）<br />
        </p>
        <div class="widget-box">
			<div class="widget-header">
				<h4 class="smaller">
					搜索
					<small>请选择搜索条件（营业厅、手机品牌、等等）</small>
				</h4>
			</div>

			<div class="widget-body">
				<div class="widget-main">
                    <div class="searchbar">
                        <div>
                            <label for="form-field-select-3">手机品牌:</label>
						    <select class="select2" id="brandlist" data-placeholder="Click to Choose...">
                                <option value="0">全部</option>
                                <% 
                                    List<tbl_androidbrand> brandlist = (List<tbl_androidbrand>)ViewData["brandlist"];
                                    if (brandlist != null)
                                    {
                                        for (int i = 0; i < brandlist.Count(); i++)
                                        {
                                            tbl_androidbrand item = brandlist.ElementAt(i);
                                            %>
                                            <option value="<% =item.uid %>"><% =item.brandname %></option>
                                            <%
                                        }
                                    }
                                %>
				            </select>
                        </div>
                    </div>

					<hr />

					<p>
						<span class="btn btn-sm btn-info" onclick="search_data();" ><i class="fa fa-search"></i> 搜索</span>

					</p>
				</div>
			</div>
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
						<th style="display:none;">营业厅名称</th>
						<th>手机品牌</th>
						<th>手机型号</th>
						<th style="width:350px;">套餐图片</th>
						<th style="width:100px;">状态</th>
						<th style="width:180px;min-width:80px;">操作</th>
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
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/css/select2.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.dataTables.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.dataTables.bootstrap.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/bootbox.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>  
	<script src="<%= ViewData["rootUri"] %>Content/js/select2.min.js"></script>
	<script type="text/javascript">
	    var selected_id = "";
	    var oTable;
	    jQuery(function ($) {

	        $(".select2").css('width', '250px').select2({ allowClear: true })
			.on('change', function () {
			    $(this).closest('form').validate().element($(this));
			});
	        oTable =
			$('#tbldata')
			.dataTable({
			    "bServerSide": true,
			    "bProcessing": true,
			    "sAjaxSource": rootUri + "Lobby/LMarket/RetrieveLBuySetList",
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
				 				'<input type="checkbox" value="' + o.aData[0] + '" name="selcheckbox" class="ace" onclick="showBatchBtn()" />' +
				 				'<span class="lbl"></span>' +
				 				'</label>';
			     	    },
			     	    sClass: 'center'
			     	},
				 	{
				 	    aTargets: [1],    // Column number which needs to be modified
				 	    sClass: 'hidden'
				 	},
				 	{
				 	    aTargets: [4],    // Column number which needs to be modified
				 	    fnRender: function (o, v) {   // o, v contains the object and value for the column
				 	        var rst = '';
				 	        if (('' + o.aData[4]).substring(0, 2) == "--")
				 	            rst += '<img src="<%= ViewData["rootUri"] %>content/img/default-image_100.gif" style="max-height:100px;" />';
				 	        else {
				 	            var pathlist = o.aData[4].toString().split(",");
				 	            //alert(o.aData[4] + "|" + o.aData[8] + "|" + pathlist.length);
				 	            for (var i = 0; i < pathlist.length - 1; i++) {
				 	                rst += '<a href="<%= ViewData["rootUri"] %>' + pathlist[i] + '" target="_blank"><img src="<%= ViewData["rootUri"] %>' + pathlist[i] + '" style="width:74px;height:100px;max-height:100px;" /></a>&nbsp;';
				 	            }
				 	            var imgcount = parseInt(o.aData[8], 10) - 3;
				 	            if (imgcount > 0)
				 	                rst += '（外' + imgcount + '张）';
				 	        }

				 	        return rst;
				 	    },
				 	    sClass: 'left'
				 	},
				 	{
				 	    aTargets: [5],    // Column number which needs to be modified
				 	    fnRender: function (o, v) {   // o, v contains the object and value for the column
				 	        var rst = "";
				 	        switch (parseInt(o.aData[5], 10)) {
				 	            case 0:
				 	                rst = '<span class="label label-inverse arrowed-in">无图片</span>';
				 	                break;
				 	            case 1:
				 	                rst = '<span class="label label-warning">强制播放</span>';
				 	                break;
				 	            case 2:
				 	                rst = '<span class="label label-success">播放营业厅视频</span>';
				 	                break;
				 	        }

				 	        return rst;
				 	    },
				 	    sClass: 'center'
				 	},
				 	{
				 	    aTargets: [6],    // Column number which needs to be modified
				 	    fnRender: function (o, v) {   // o, v contains the object and value for the column
				 	        var rst = '<div class="hidden-sm hidden-xs action-buttons">';

				 	        rst += '<a class="blue " href="<%= ViewData["rootUri"] %>Lobby/LMarket/LManageBuySet/' + o.aData[6] + '"><i class="ace-icon fa fa-briefcase bigger-130"></i>选择图片</a>' +
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
	            $(".btnbatch").show();
	        } else {
	            $(".btnbatch").hide();
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

	    function search_data() {
	        var brand_id = $("#brandlist").val();

	        oSettings = oTable.fnSettings();
	        oSettings.sAjaxSource = rootUri + "Lobby/LMarket/RetrieveLBuySetList" + "?brand=" + brand_id;

	        oTable.dataTable().fnDraw();
	    }

    </script>
</asp:Content>
