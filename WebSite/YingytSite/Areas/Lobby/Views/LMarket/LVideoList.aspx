<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Lobby/Lobby.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header">
	<h1>
		营销管理 -> 演示视频
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
        <p class="alert alert-info">
	        <i class="ace-icon fa fa-exclamation-triangle"></i>
            温馨提示：状态说明<br />
            <b>强制播放</b>：在手机端播放代理选择的视频，而不是营业厅来设置的<br />
            <b>播放营业厅视频</b>：在手机端播放营业厅设置的视频<br />
            <b>默认</b>：默认状态。如果有营业厅设置的视频，播放那个视频。<br />
            <b>无视频</b>：不存在对应该手机型号的视频的情况，(在营业厅没设置视频，代理也没设置的状态。请抓紧设置视频。)
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
						<th>视频名称</th>
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

<div id="modal-table" class="modal fade" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header no-padding">
				<div class="table-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						<span class="white">&times;</span>
					</button>
					请选择视频
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
							<th>视频来源</th>
							<th>视频名称</th>
							<th>视频大小</th>
							<th>
								<i class="ace-icon fa fa-clock-o bigger-110"></i>
								播放时间
							</th>
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
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/css/select2.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.dataTables.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.dataTables.bootstrap.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/bootbox.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>  
	<script src="<%= ViewData["rootUri"] %>Content/js/select2.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/plugins/jwplayer/jwplayer.min.js"></script>
	<script type="text/javascript">
	    var selected_id = "";
	    var oTable, oVideoTable;
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
			    "sAjaxSource": rootUri + "Lobby/LMarket/RetrieveLVideoList",
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
				 	        var rst = o.aData[4];
				 	        if (rst.substring(0, 2) != "--")
				 	            rst += '&nbsp;&nbsp;<a href="javascript:(0);" onclick="showVideo(\'' + o.aData[7] + '\');"><i class="ace-icon fa fa-play"></i>播放</a>';

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
				 	                rst = '<span class="label label-inverse arrowed-in">无视频</span>';
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

				 	        rst += '<a class="red" href="<%= ViewData["rootUri"] %>Lobby/LBrief/AddLMarketVideo/' + o.aData[6] + '" ><i class="ace-icon fa fa-upload bigger-130"></i>上传视频</a>';				 	       

				 	        rst += '<a class="blue " href="#modal-table" role="button" data-toggle="modal" onclick="set_modalparam(' + o.aData[6] + ')"><i class="ace-icon fa fa-briefcase bigger-130"></i>选择视频</a>' +
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

	        oVideoTable =
				$('#tbldata_dlg')
				.dataTable({
				    "bServerSide": true,
				    "bProcessing": true,
				    "sAjaxSource": rootUri + "Agent/ABrief/RetrieveAVideoList",
				    "oLanguage": {
				        "sUrl": rootUri + "Content/i18n/dataTables.chinese.txt"
				    },
				    "aoColumns": [
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
				     				'<input type="radio" value="' + o.aData[0] + '" name="selcheckbox_dlg" class="ace" />' +
				     				'<span class="lbl"></span>' +
				     				'</label>';
				     	    },
				     	    sClass: 'center'
				     	},
				     	{
				     	    aTargets: [1],    // Column number which needs to be modified
				     	    fnRender: function (o, v) {   // o, v contains the object and value for the column
				     	        return o.aData[5];
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

	    function showVideo(filepath) {
	        var videobox = bootbox.dialog({
	            message: "<div id='player_div' style='height:400px; background:#eee;'>--해당 동영상파일을 jwplayer를 리용해서 play시킵니다.-- <br />播放该视频(调用jwplayer)。</div>",
	            buttons:
				{
				    "click":
					{
					    "label": "关闭",
					    "className": "btn-sm btn-primary",
					    "callback": function () {
					        //Example.show("Primary button");
					    }
					}
				}
	        });

	        videobox.on("shown.bs.modal", function () {
	            //alert(filepath);
	            jwplayer("player_div").setup({
	                flashplayer: rootUri + "Content/plugins/jwplayer/player.swf",
	                playlist: eval([{ "file": rootUri + filepath}]),
	                height: 400,
	                width: 560
	            });
	        });
	    }

	    function search_data() {
	        var brand_id = $("#brandlist").val();

	        oSettings = oTable.fnSettings();
	        oSettings.sAjaxSource = rootUri + "Lobby/LMarket/RetrieveLVideoList" + "?brand=" + brand_id;

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
