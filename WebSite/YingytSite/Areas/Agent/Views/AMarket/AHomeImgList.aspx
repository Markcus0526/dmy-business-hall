<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Agent/Agent.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header">
	<h1>
		营销管理 -> 首页图片
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
        <p class="alert alert-info">
	        <i class="ace-icon fa fa-exclamation-triangle"></i>
            温馨提示：状态说明<br />
            <b>强制显示</b>：在手机端显示代理选择的视频，而不是营业厅来设置的<br />
            <b>显示营业厅图片</b>：在手机端显示营业厅设置的图片<br />
            <b>默认</b>：默认状态。如果有营业厅设置的图片，播放那个图片。<br />
            <b>无图片</b>：不存在对应该手机型号的图片的情况，(在营业厅没设置图片，代理也没设置的状态。请抓紧设置图片。)
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
                            <label for="form-field-select-3">营业厅:</label>
						    <select class="select2" id="lobbylist"  data-placeholder="Click to Choose...">
                                <option value="0">全部</option>
                                <% 
                                    List<tbl_user> lobbylist = (List<tbl_user>)ViewData["lobbylist"];
                                    if (lobbylist != null)
                                    {
                                        for (int i = 0; i < lobbylist.Count(); i++)
                                        {
                                            tbl_user item = lobbylist.ElementAt(i);
                                            %>
                                            <option value="<% =item.uid %>"><% =item.username %></option>
                                            <%
                                        }
                                    }
                                %>
				            </select>&nbsp;&nbsp;
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

                        <a class="btn btn-white btn-warning btn-bold btnbatch" style="display:none;" id="btnbatchactivate" onclick="processUnBlock();">
                            <i class="ace-icon fa fa-unlock bigger-120 orange"></i>批量解冻播放
                        </a>
                        <a class="btn btn-white btn-warning btn-bold btnbatch" style="display:none;" id="btnbatchblock" onclick="processBlock();">
                            <i class="ace-icon fa fa-lock bigger-120 orange"></i>批量强制播放
                        </a>

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
						<th>营业厅名称</th>
						<th>手机品牌</th>
						<th>手机型号</th>
						<th>图片</th>
						<th style="width:100px;">状态</th>
						<th style="width:180px;min-width:80px;">操作</th>
					</tr>
				</thead>
				<tbody>
                    <!--<tr>
			            <td class="center">
				            <label class="position-relative">
					            <input type="checkbox" value="1" class="ace" />
					            <span class="lbl"></span>
				            </label>
			            </td>

			            <td>和平区营业厅1</td>
			            <td>Lenovo</td>
			            <td>S930</td>
			            <td><a href="#" target="_blank"><img src="<%= ViewData["rootUri"] %>content/img/f1.jpg" style="max-height:100px;" /></a></td>
			            <td class="hidden-480">
				            <span class="label label-warning">强制显示</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
                                <a class="orange" href="javascript:void(0);" onclick="processUnBlock(1);"><i class="ace-icon fa fa-unlock bigger-130"></i>解冻显示</a>
							    <a class="blue " href="#modal-table" role="button" data-toggle="modal"><i class="ace-icon fa fa-briefcase bigger-130"></i>选择图片</a>
						    </div>
                        </td>
                    </tr>
                    <tr>
			            <td class="center">
				            <label class="position-relative">
					            <input type="checkbox" value="2" class="ace" />
					            <span class="lbl"></span>
				            </label>
			            </td>

			            <td>和平区营业厅1</td>
			            <td>华为</td>
			            <td>STW300</td>
			            <td><a href="#" target="_blank"><img src="<%= ViewData["rootUri"] %>content/img/f1.jpg" style="max-height:100px;" /></a></td>
			            <td class="hidden-480">
				            <span class="label label-success">显示营业厅图片</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
                                <a class="orange" href="javascript:void(0);" onclick="processBlock(2);"><i class="ace-icon fa fa-lock bigger-130"></i>强制显示</a>
							    <a class="blue " href="#modal-table" role="button" data-toggle="modal"><i class="ace-icon fa fa-briefcase bigger-130"></i>选择图片</a>
						    </div>
                        </td>
                    </tr>
                    <tr>
			            <td class="center">
				            <label class="position-relative">
					            <input type="checkbox" value="3" class="ace" />
					            <span class="lbl"></span>
				            </label>
			            </td>

			            <td>和平区营业厅1</td>
			            <td>中兴</td>
			            <td>T95</td>
			            <td><a href="#" target="_blank"><img src="<%= ViewData["rootUri"] %>content/img/f1.jpg" style="max-height:100px;" /></a></td>
			            <td class="hidden-480">
				            <span class="label label-info arrowed arrowed-righ">默认</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
                                <a class="orange" href="javascript:void(0);" onclick="processBlock(3);"><i class="ace-icon fa fa-lock bigger-130"></i>强制显示</a>
							    <a class="blue " href="#modal-table" role="button" data-toggle="modal"><i class="ace-icon fa fa-briefcase bigger-130"></i>选择图片</a>
						    </div>
                        </td>
                    </tr>
                    <tr>
			            <td class="center">
				            <label class="position-relative">
					            <input type="checkbox" value="4" class="ace" />
					            <span class="lbl"></span>
				            </label>
			            </td>

			            <td>和平区营业厅1</td>
			            <td>Lenovo</td>
			            <td>S930</td>
			            <td><a href="#" target="_blank"><img src="<%= ViewData["rootUri"] %>content/img/default-image_100.gif" style="max-height:100px;" /></a></td>
			            <td class="hidden-480">
				            <span class="label label-inverse arrowed-in">无视频</span>
			            </td>
                        <td>
						    <div class="hidden-sm hidden-xs action-buttons">
                                <a class="red" target="_blank" href="<%= ViewData["rootUri"] %>Agent/AVideo/AMyVideoList" ><i class="ace-icon fa fa-upload bigger-130"></i>上传图片</a>
							    <a class="blue " href="#modal-table" role="button" data-toggle="modal"><i class="ace-icon fa fa-briefcase bigger-130"></i>选择图片</a>
						    </div>
                        </td>
                    </tr>-->
				</tbody>
			</table>
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
					请选择图片(Ajax DataTable)
				</div>
			</div>

			<div class="modal-body no-padding">
				<table id="tbldata_dlg" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
					<thead>
						<tr>
						    <th class="center">
							    <label class="position-relative">
								    <input type="radio" class="ace" id="selcheckbox_dlg" name="selcheckbox_dlg" value="" />
								    <span class="lbl"></span>
							    </label>
						    </th>
							<th>图片来源</th>
							<th>图片</th>
							<th>图片大小</th>
						</tr>
					</thead>
					<tbody>
						<!--<tr>
							<td>
								营业厅图片
							</td>
							<td><a><img src="<%= ViewData["rootUri"] %>content/img/f1.jpg" style="max-height:60px;" /></a></td>
							<td>8MB</td>
						</tr>
						<tr>
							<td>
								我的图片
							</td>
							<td><a><img src="<%= ViewData["rootUri"] %>content/img/f1.jpg" style="max-height:60px;" /></a></td>
							<td>8MB</td>
						</tr>
						<tr>
							<td>
								营业厅图片
							</td>
							<td><a><img src="<%= ViewData["rootUri"] %>content/img/f1.jpg" style="max-height:60px;" /></a></td>
							<td>8MB</td>
						</tr>
						<tr>
							<td>
								营业厅图片
							</td>
							<td><a><img src="<%= ViewData["rootUri"] %>content/img/f1.jpg" style="max-height:60px;" /></a></td>
							<td>8MB</td>
						</tr>
						<tr>
							<td>
								营业厅图片
							</td>
							<td><a><img src="<%= ViewData["rootUri"] %>content/img/f1.jpg" style="max-height:60px;" /></a></td>
							<td>8MB</td>
						</tr>
						<tr>
							<td>
								营业厅图片
							</td>
							<td><a><img src="<%= ViewData["rootUri"] %>content/img/f1.jpg" style="max-height:60px;" /></a></td>
							<td>8MB</td>
						</tr>
						<tr>
							<td>
								营业厅图片
							</td>
							<td><a><img src="<%= ViewData["rootUri"] %>content/img/f1.jpg" style="max-height:60px;" /></a></td>
							<td>8MB</td>
						</tr>
						<tr>
							<td>
								营业厅图片
							</td>
							<td><a><img src="<%= ViewData["rootUri"] %>content/img/f1.jpg" style="max-height:60px;" /></a></td>
							<td>8MB</td>
						</tr>
						<tr>
							<td>
								营业厅图片
							</td>
							<td><a><img src="<%= ViewData["rootUri"] %>content/img/f1.jpg" style="max-height:60px;" /></a></td>
							<td>8MB</td>
						</tr>-->
					</tbody>
				</table>
			</div>

			<div class="modal-footer no-margin-top">
				<button class="btn btn-sm btn-danger pull-left" data-dismiss="modal" onclick="submit_dataitem();">
					<i class="ace-icon fa fa-save"></i>
					确认
				</button>

				<!--<ul class="pagination pull-right no-margin">
					<li class="prev disabled">
						<a href="#">
							<i class="ace-icon fa fa-angle-double-left"></i>
						</a>
					</li>

					<li class="active">
						<a href="#">1</a>
					</li>

					<li>
						<a href="#">2</a>
					</li>

					<li>
						<a href="#">3</a>
					</li>

					<li class="next">
						<a href="#">
							<i class="ace-icon fa fa-angle-double-right"></i>
						</a>
					</li>
				</ul>-->

            <input type="hidden" id="dataid" value=""/>

			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- PAGE CONTENT ENDS -->


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
			    "sAjaxSource": rootUri + "Agent/AMarket/RetrieveAHomeImgList",
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
				 	    aTargets: [4],    // Column number which needs to be modified
				 	    fnRender: function (o, v) {   // o, v contains the object and value for the column
				 	        var rst = '';
				 	        if (('' + o.aData[4]).substring(0, 2) == "--")
				 	            rst += '<img src="<%= ViewData["rootUri"] %>content/img/default-image_100.gif" style="max-height:100px;" />';
				 	        else
				 	            rst += '<a href="<%= ViewData["rootUri"] %>' + o.aData[4] + '" target="_blank"><img src="<%= ViewData["rootUri"] %>' + o.aData[4] + '" style="width:74px;height:100px;max-height:100px;" /></a>';

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

				 	        rst += '<a class="red" target="_blank" href="<%= ViewData["rootUri"] %>Agent/ABrief/AddAMarketImage/' + o.aData[6] + '" ><i class="ace-icon fa fa-upload bigger-130"></i>上传图片</a>';

				 	        switch (parseInt(o.aData[7], 10)) {				 	        
				 	            case 1:
				 	                rst += '<a class="orange" href="javascript:void(0);" onclick="processUnBlock(' + o.aData[6] + ');"><i class="ace-icon fa fa-unlock bigger-130"></i>解冻播放</a>';
				 	                break;
				 	            case 2:
				 	                rst += '<a class="orange" href="javascript:void(0);" onclick="processBlock(' + o.aData[6] + ');"><i class="ace-icon fa fa-lock bigger-130"></i>强制播放</a>';
				 	                break;
				 	        }

				 	        rst += '<a class="blue " href="#modal-table" role="button" data-toggle="modal" onclick="set_modalparam(' + o.aData[6] + ')"><i class="ace-icon fa fa-briefcase bigger-130"></i>选择图片</a>' +
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
				    "bFilter": false,
				    "aoColumnDefs": [
				     	{
				     	    aTargets: [0],    // Column number which needs to be modified
				     	    fnRender: function (o, v) {   // o, v contains the object and value for the column
				     	        return '<label class="position-relative">' +
				     				'<input type="radio" value="' + o.aData[0] + '" name="selcheckbox_dlg" class="ace" />' +
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
				        showBatchBtn();
				    }

				});
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
	                message: "您确定要强制播放吗？",
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
	                            $.ajax({
	                                url: rootUri + "Agent/AMarket/BlockAVideo",
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
	                                        toastr["success"]("强制播放成功！", "恭喜您");
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

	    function processUnBlock(sel_id) {
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
	                message: "您确定要解冻强制播放吗？",
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
	                            $.ajax({
	                                url: rootUri + "Agent/AMarket/UnblockAVideo",
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
	                                        toastr["success"]("解冻强制播放成功！", "恭喜您");
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

	    function search_data() {
	        var lobby_id = $("#lobbylist").val();
	        var brand_id = $("#brandlist").val();

	        oSettings = oTable.fnSettings();
	        oSettings.sAjaxSource = rootUri + "Agent/AMarket/RetrieveAHomeImgList" + "?lobby=" + lobby_id + "&brand=" + brand_id;

	        oTable.dataTable().fnDraw();
	    }

	    function set_modalparam(id) {
	        $("#dataid").val(id);
	        $('#selcheckbox_dlg').click();
	    }

	    function submit_dataitem() {
	        var id = $("#dataid").val();
	        var selected_id = "";
	        $(':radio:checked').each(function () {
	            if ($(this).attr('name') == 'selcheckbox_dlg')
	                selected_id += $(this).attr('value') + ",";
	        });
            
	        if (selected_id.length < 2)
	            return;

	        $.ajax({
	            url: rootUri + "Agent/AMarket/SelectAVideo",
	            data: {
	                "id": id,
	                "selids": selected_id
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
	                    toastr["success"]("操作成功！", "恭喜您");
	                }
	            }
	        });
	    }

    </script>
</asp:Content>
