<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Lobby/Lobby.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<% var giftinfo = (tbl_gift)ViewData["giftinfo"]; %>
<div class="page-header">
	<h1>
		营销管理 -> 活动专区 -> 大转盘
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
        <p class="alert alert-info">
	        <i class="ace-icon fa fa-exclamation-triangle"></i>
            --温馨提示：大转盘使用方法<br />
            大转盘是在营业厅运行的一种活动方式。可以设置从一等奖到六等奖的奖品<br />
            用户试图大转盘来可以中奖（一等奖~六等奖）。当TA中奖的时候，分配给他个SN码。<br />
            领取的时候，输入营业厅设置的中奖兑换密码。<br />
            SN码状态是如下<br />
            <b>未领取</b>: 还未使用的状态<br />
            <b>已发放</b>: 已中奖分配的状态<br />
            <b>已消费</b>: 已领取中奖的奖品状态<br />
            点击启用的时候，自动生成所有奖品数量的SN码。SN码是16位文字串。<br />
        </p>
        <div>
		    <form class="form-horizontal" role="form" id="validation-form">
			    <div class="tabbable ">
				    <ul class="nav nav-tabs" id="myTab3">
					    <li class="active">
						    <a data-toggle="tab" href="#tab1">
							    <i class="pink ace-icon fa fa-briefcase bigger-110"></i>
							    活动奖品设置
						    </a>
					    </li>

					    <li>
						    <a data-toggle="tab" href="#tab2">
							    <i class="blue ace-icon fa fa-paperclip bigger-110"></i>
							    转盘SN码发放管理
						    </a>
					    </li>
				    </ul>

				    <div class="tab-content">
					    <div id="tab1" class="tab-pane in active">
			                <div class="form-group">
				                <label class="col-sm-3 control-label no-padding-right" for="status">启用转盘活动：</label>
				                <div class="col-sm-9" style="margin:4px 0px;">
                                    <div class="clearfix">
						                <label>
							                <input name="status" id="status" class="ace ace-switch ace-switch-3" type="checkbox" onchange="useBigWheel()" <% if (giftinfo != null && giftinfo.status == 1) { %>checked<% } %> />
							                <span class="lbl">
		                                        <!--[if IE]>启用<![endif]-->
                                            </span>
                                        </label>
                                    </div>
				                </div>
			                </div>
                            <div id="divbigwheel">
                                <div class="form-group">
				                    <label class="col-sm-3 control-label no-padding-right" for="agentname">一等奖奖品设置：</label>
				                    <div class="col-sm-9">
                                        <div class="clearfix">
					                    <input type="text" id="gift1name" name="gift1name" placeholder="请输入奖品名" class="col-xs-10 col-sm-5" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_1_name %>"<% } %>  />
                                        <span class="help-inline col-xs-12 col-sm-7">
											<span class="middle">请不要多于50字!</span>
										</span>
                                        </div>
				                    </div>
			                    </div>
                                <div class="form-group">
				                    <label class="col-sm-3 control-label no-padding-right" for="gift1cnt">一等奖奖品数量：</label>
				                    <div class="col-sm-9">
                                        <div class="clearfix">
					                    <input type="text" id="gift1cnt" name="tempcnt" placeholder="请输入有效数量" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_1_quantity %>"<% } %> <% if (giftinfo != null && giftinfo.status == 1) { %>disabled<% } %> />
					                    <input type="hidden" name="gift1cnt" placeholder="请输入有效数量" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_1_quantity %>"<% } %> />
                                        <span class="help-inline col-xs-12 col-sm-7">
											<span class="middle">小于1000 如果超过1000你可以在后SN码管理面板随时分批添加</span>
										</span>
                                        </div>
				                    </div>
			                    </div>
                                <div class="form-group">
				                    <label class="col-sm-3 control-label no-padding-right" for="agentname">二等奖奖品设置：</label>
				                    <div class="col-sm-9">
                                        <div class="clearfix">
					                    <input type="text" id="gift2name" name="gift2name" placeholder="请输入奖品名" class="col-xs-10 col-sm-5" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_2_name %>"<% } %>  />
                                        <span class="help-inline col-xs-12 col-sm-7">
											<span class="middle">请不要多于50字!</span>
										</span>
                                        </div>
				                    </div>
			                    </div>
                                <div class="form-group">
				                    <label class="col-sm-3 control-label no-padding-right" for="gift2cnt">二等奖奖品数量：</label>
				                    <div class="col-sm-9">
                                        <div class="clearfix">
					                    <input type="text" id="gift2cnt" name="tempcnt" placeholder="请输入有效数量" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_2_quantity %>"<% } %> <% if (giftinfo != null && giftinfo.status == 1) { %>disabled<% } %> />
					                    <input type="hidden" name="gift2cnt" placeholder="请输入有效数量" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_2_quantity %>"<% } %> />
                                        <span class="help-inline col-xs-12 col-sm-7">
											<span class="middle">小于1000 如果超过1000你可以在后SN码管理面板随时分批添加</span>
										</span>
                                        </div>
				                    </div>
			                    </div>
                                <div class="form-group">
				                    <label class="col-sm-3 control-label no-padding-right" for="agentname">三等奖奖品设置：</label>
				                    <div class="col-sm-9">
                                        <div class="clearfix">
					                    <input type="text" id="gift3name" name="gift3name" placeholder="请输入奖品名" class="col-xs-10 col-sm-5" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_3_name %>"<% } %> />
                                        <span class="help-inline col-xs-12 col-sm-7">
											<span class="middle">请不要多于50字!</span>
										</span>
                                        </div>
				                    </div>
			                    </div>
                                <div class="form-group">
				                    <label class="col-sm-3 control-label no-padding-right" for="gift3cnt">三等奖奖品数量：</label>
				                    <div class="col-sm-9">
                                        <div class="clearfix">
					                    <input type="text" id="gift3cnt" name="tempcnt" placeholder="请输入有效数量" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_3_quantity %>"<% } %> <% if (giftinfo != null && giftinfo.status == 1) { %>disabled<% } %> />
					                    <input type="hidden" name="gift3cnt" placeholder="请输入有效数量" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_3_quantity %>"<% } %> />
                                        <span class="help-inline col-xs-12 col-sm-7">
											<span class="middle">小于1000 如果超过1000你可以在后SN码管理面板随时分批添加</span>
										</span>
                                        </div>
				                    </div>
			                    </div>
                                <div class="form-group">
				                    <label class="col-sm-3 control-label no-padding-right" ></label>
				                    <div class="col-sm-9">
                                        <div class="clearfix">
                                            <a href="javascript:void(0);" onclick="toggleMoreGift();" type="button" class="btn btn-sm btn-info" data-toggle="button">显示更多奖项</a>
                                        </div>
				                    </div>
			                    </div>
                                <div id="moregift" style="display:none;">
                                    <div class="form-group">
				                        <label class="col-sm-3 control-label no-padding-right" for="agentname">四等奖奖品设置：</label>
				                        <div class="col-sm-9">
                                            <div class="clearfix">
					                        <input type="text" id="gift4name" name="gift4name" placeholder="请输入奖品名" class="col-xs-10 col-sm-5" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_4_name %>"<% } %> />
                                            <span class="help-inline col-xs-12 col-sm-7">
											    <span class="middle">请不要多于50字!</span>
										    </span>
                                            </div>
				                        </div>
			                        </div>
                                    <div class="form-group">
				                        <label class="col-sm-3 control-label no-padding-right" for="gift4cnt">四等奖奖品数量：</label>
				                        <div class="col-sm-9">
                                            <div class="clearfix">
    					                    <input type="text" id="gift4cnt" name="tempcnt" placeholder="请输入有效数量" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_4_quantity %>"<% } %> <% if (giftinfo != null && giftinfo.status == 1) { %>disabled<% } %> />
    					                    <input type="hidden" name="gift4cnt" placeholder="请输入有效数量" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_4_quantity %>"<% } %> />
                                            <span class="help-inline col-xs-12 col-sm-7">
											    <span class="middle">小于1000 如果超过1000你可以在后SN码管理面板随时分批添加</span>
										    </span>
                                            </div>
				                        </div>
			                        </div>
                                    <div class="form-group">
				                        <label class="col-sm-3 control-label no-padding-right" for="agentname">五等奖奖品设置：</label>
				                        <div class="col-sm-9">
                                            <div class="clearfix">
					                        <input type="text" id="gift5name" name="gift5name" placeholder="请输入奖品名" class="col-xs-10 col-sm-5" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_5_name %>"<% } %> />
                                            <span class="help-inline col-xs-12 col-sm-7">
											    <span class="middle">请不要多于50字!</span>
										    </span>
                                            </div>
				                        </div>
			                        </div>
                                    <div class="form-group">
				                        <label class="col-sm-3 control-label no-padding-right" for="gift5cnt">五等奖奖品数量：</label>
				                        <div class="col-sm-9">
                                            <div class="clearfix">
    					                    <input type="text" id="gift5cnt" name="tempcnt" placeholder="请输入有效数量" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_5_quantity %>"<% } %> <% if (giftinfo != null && giftinfo.status == 1) { %>disabled<% } %> />
    					                    <input type="hidden" name="gift5cnt" placeholder="请输入有效数量" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_5_quantity %>"<% } %> />
                                            <span class="help-inline col-xs-12 col-sm-7">
											    <span class="middle">小于1000 如果超过1000你可以在后SN码管理面板随时分批添加</span>
										    </span>
                                            </div>
				                        </div>
			                        </div>
                                    <div class="form-group">
				                        <label class="col-sm-3 control-label no-padding-right" for="agentname">六等奖奖品设置：</label>
				                        <div class="col-sm-9">
                                            <div class="clearfix">
					                        <input type="text" id="gift6name" name="gift6name" placeholder="请输入奖品名" class="col-xs-10 col-sm-5" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_6_name %>"<% } %> />
                                            <span class="help-inline col-xs-12 col-sm-7">
											    <span class="middle">请不要多于50字!</span>
										    </span>
                                            </div>
				                        </div>
			                        </div>
                                    <div class="form-group">
				                        <label class="col-sm-3 control-label no-padding-right" for="gift6cnt">六等奖奖品数量：</label>
				                        <div class="col-sm-9">
                                            <div class="clearfix">
    					                    <input type="text" id="gift6cnt" name="tempcnt" placeholder="请输入有效数量" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_6_quantity %>"<% } %> <% if (giftinfo != null && giftinfo.status == 1) { %>disabled<% } %> />
    					                    <input type="hidden" name="gift6cnt" placeholder="请输入有效数量" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.gift_6_quantity %>"<% } %> />
                                            <span class="help-inline col-xs-12 col-sm-7">
											    <span class="middle">小于1000 如果超过1000你可以在后SN码管理面板随时分批添加</span>
										    </span>
                                            </div>
				                        </div>
			                        </div>
                                </div><!-- MoreGift DIV END -->
                                <div class="form-group">
				                    <label class="col-sm-3 control-label no-padding-right" for="percent">概率（%）：</label>
				                    <div class="col-sm-9">
                                        <div class="clearfix">
    					                <input type="text" id="percent" name="percent" placeholder="请输入概率" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.probablity %>"<% } %>  />
                                        <span class="help-inline col-xs-12 col-sm-7">
											<span class="middle">即用户抽奖的中奖概率</span>
										</span>
                                        </div>
				                    </div>
			                    </div>
                                <div class="form-group">
				                    <label class="col-sm-3 control-label no-padding-right" for="agentname">兑奖代码：</label>
				                    <div class="col-sm-9">
                                        <div class="clearfix">
    					                <input type="text" id="password" name="password" placeholder="请输入代码" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.password %>"<% } %> />
                                        <span class="help-inline col-xs-12 col-sm-7">
											<span class="middle">消费确认密码长度小于15位 不设置密码,兑奖页面的密码输入框则不出现</span>
										</span>
                                        </div>
				                    </div>
			                    </div>
                                <div class="form-group">
				                    <label class="col-sm-3 control-label no-padding-right" for="wheelpass">转盘密码：</label>
				                    <div class="col-sm-9">
                                        <div class="clearfix">
    					                <input type="text" id="wheelpass" name="wheelpass" placeholder="请输入密码" class="col-xs-10 col-sm-2" <% if (giftinfo != null) { %>value="<%= giftinfo.wheelpass %>"<% } %> />
                                        <span class="help-inline col-xs-12 col-sm-7">
											<span class="middle">试一试转盘的时候弹出的密码长度小于4位。</span>
										</span>
                                        </div>
				                    </div>
			                    </div>
                            </div>
                            
			                <div class="clearfix form-actions">
				                <div class="col-md-offset-3 col-md-9">
                                    <button class="btn btn-sm btn-purple loading-btn" type="submit" data-loading-text="保存中...">
						                <i class="ace-icon fa fa-floppy-o bigger-125"></i>
						                保存
					                </button>
					                &nbsp; &nbsp; &nbsp;
					                <button class="btn btn-sm" type="reset">
						                <i class="ace-icon fa fa-undo bigger-110"></i>
						                重置
					                </button>
				                </div>
			                </div>

					    </div>

					    <div id="tab2" class="tab-pane">
                            <div class="row">
                                <div class="col-xs-12">
			                        <table id="tblsn" class="table table-striped table-bordered table-hover">
				                        <thead>
					                        <tr>
						                        <th>SN码</th>
						                        <th>中奖类型</th>
						                        <th>状态</th>
						                        <th>领取者手机号</th>
						                        <th>中奖时间</th>
						                        <th>使用时间</th>
						                        <th style="min-width:80px;">操作</th>
					                        </tr>
				                        </thead>
				                        <tbody>
                                        <!--<tr>
                                                <td>A201437298392</td>
                                                <td>一等奖</td>
                                                <td><span class="label label-success">未领取</span></td>
                                                <td>13927834444</td>
                                                <td>2014-05-11 09:23:55</td>
                                                <td>2014-05-11 10:50:55</td>
                                                <td>
										            <div class="btn-group">
											            <button data-toggle="dropdown" class="btn btn-primary btn-white dropdown-toggle">
												            操作<i class="ace-icon fa fa-angle-down icon-on-right"></i>
											            </button>
											            <ul class="dropdown-menu">
												            <li><a href="#">已经被抽中</a></li>
												            <li><a href="#">已经兑奖</a></li>
											            </ul>
										            </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>A201437298392</td>
                                                <td>一等奖</td>
                                                <td><span class="label label-success">未领取</span></td>
                                                <td>13927834444</td>
                                                <td>2014-05-11 09:23:55</td>
                                                <td>2014-05-11 10:50:55</td>
                                                <td>
										            <div class="btn-group">
											            <button data-toggle="dropdown" class="btn btn-primary btn-white dropdown-toggle">
												            操作<i class="ace-icon fa fa-angle-down icon-on-right"></i>
											            </button>
											            <ul class="dropdown-menu">
												            <li><a href="#">已经被抽中</a></li>
												            <li><a href="#">已经兑奖</a></li>
											            </ul>
										            </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>A201437298392</td>
                                                <td>一等奖</td>
                                                <td><span class="label label-warning">已发放</span></td>
                                                <td>13927834444</td>
                                                <td>2014-05-11 09:23:55</td>
                                                <td>2014-05-11 10:50:55</td>
                                                <td>
										            <div class="btn-group">
											            <button data-toggle="dropdown" class="btn btn-primary btn-white dropdown-toggle">
												            操作<i class="ace-icon fa fa-angle-down icon-on-right"></i>
											            </button>
											            <ul class="dropdown-menu">
												            <li><a href="#">已经被抽中</a></li>
												            <li><a href="#">已经兑奖</a></li>
											            </ul>
										            </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>A201437298392</td>
                                                <td>一等奖</td>
                                                <td><span class="label label-inverse arrowed-in">已消费</span></td>
                                                <td>13927834444</td>
                                                <td>2014-05-11 09:23:55</td>
                                                <td>2014-05-11 10:50:55</td>
                                                <td>
										            <div class="btn-group">
											            <button data-toggle="dropdown" class="btn btn-primary btn-white dropdown-toggle">
												            操作<i class="ace-icon fa fa-angle-down icon-on-right"></i>
											            </button>
											            <ul class="dropdown-menu">
												            <li><a href="#">已经被抽中</a></li>
												            <li><a href="#">已经兑奖</a></li>
											            </ul>
										            </div>
                                                </td>
                                            </tr>-->
				                        </tbody>
			                        </table>
                                </div>
                            </div>
					    </div>
				    </div>
			    </div>

            </form>

        </div>
	</div>
</div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageStyle" runat="server">
	<link rel="stylesheet" type="text/css" href="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.min.css" />
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/css/select2.css" />
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/css/chosen.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.dataTables.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.dataTables.bootstrap.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/bootbox.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>  
	<script src="<%= ViewData["rootUri"] %>Content/js/select2.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/chosen.jquery.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.validate.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/validate.messages_zh.js"></script>

	<script type="text/javascript">
    
	    var oTable;
	    jQuery(function ($) {
	        $('.loading-btn')
		      .click(function () {
		          var btn = $(this)
		          btn.button('loading')
		      });

	        $(".select2").css('width', '250px').select2({ allowClear: true })
			.on('change', function () {
			    $(this).closest('form').validate().element($(this));
			});

	        $('#validation-form').validate({
	            errorElement: 'span',
	            errorClass: 'help-block',
	            //focusInvalid: false,
	            rules: {
	                gift1name: {
	                    maxlength: 50
	                },
	                gift2name: {
	                    maxlength: 50
	                },
	                gift3name: {
	                    maxlength: 50
	                },
	                gift4name: {
	                    maxlength: 50
	                },
	                gift5name: {
	                    maxlength: 50
	                },
	                gift6name: {
	                    maxlength: 50
	                },
//	                gift1cnt: {
//	                    number: true,
//	                    max: 1000,
//	                    min: 1
//	                },
//	                gift2cnt: {
//	                    number: true,
//	                    max: 1000,
//	                    min: 1
//	                },
//	                gift31cnt: {
//	                    number: true,
//	                    max: 1000,
//	                    min: 1
//	                },
//	                gift4cnt: {
//	                    number: true,
//	                    max: 1000,
//	                    min: 1
//	                },
//	                gift5cnt: {
//	                    number: true,
//	                    max: 1000,
//	                    min: 1
//	                },
//	                gift6cnt: {
//	                    number: true,
//	                    max: 1000,
//	                    min: 1
//	                },
	                tempcnt: {
	                    number: true,
	                    max: 1000,
	                    min: 1
	                },
	                percent: {
	                    required: true,
	                    number: true,
	                    max: 100,
	                    min: 0
	                },
	                password: {
	                    required: true,
	                    maxlength: 15
	                },
	                wheelpass: {
	                    maxlength: 4
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
	                submitform();
	                return false;
	            },
	            invalidHandler: function (form) {
	                $('.loading-btn').button('reset');
	            }
	        });

	        oTable =
				$('#tblsn')
				.dataTable({
				    "bServerSide": true,
				    "bProcessing": true,
				    "sAjaxSource": rootUri + "Lobby/LMarket/RetrieveLSNNumberList",
				    "oLanguage": {
				        "sUrl": rootUri + "Content/i18n/dataTables.chinese.txt"
				    },
				    "aoColumns": [
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
				     	    aTargets: [1],    // Column number which needs to be modified
				     	    fnRender: function (o, v) {   // o, v contains the object and value for the column
				     	        var order = parseInt(o.aData[1], 10);
				     	        var hanyuorders = ["一等奖", "二等奖", "三等奖", "四等奖", "五等奖", "六等奖"];

				     	        return hanyuorders[order];
				     	    },
				     	    sClass: 'center'
				     	},
				     	{
				     	    aTargets: [2],    // Column number which needs to be modified
				     	    fnRender: function (o, v) {   // o, v contains the object and value for the column
				     	        var rst = "";
				     	        switch (parseInt(o.aData[2], 10)) {
				     	            case 0:
				     	                rst = '<span class="label label-success">未领取</span>';
				     	                break;
				     	            case 1:
				     	                rst = '<span class="label label-warning">已发放</span>';
				     	                break;
				     	            case 2:
				     	                rst = '<span class="label label-inverse arrowed-in">已消费</span>';
				     	                break;
				     	        }

				     	        return rst;
				     	    },
				     	    sClass: 'center'
				     	},
				     	{
				     	    aTargets: [6],    // Column number which needs to be modified
				     	    fnRender: function (o, v) {   // o, v contains the object and value for the column
				     	        var rst = '<div class="btn-group">' +
											    '<button data-toggle="dropdown" class="btn btn-primary btn-white dropdown-toggle">' +
												    '操作<i class="ace-icon fa fa-angle-down icon-on-right"></i>' +
											    '</button>' +
											    '<ul class="dropdown-menu">' +
												    '<li><a href="#" onclick="processChouzhong(' + o.aData[6] + ')">已经被抽中</a></li>' +
												    '<li><a href="#" onclick="processDuijiang(' + o.aData[6] + ')">已经兑奖</a></li>' +
											    '</ul>'
				     	        '</div>'

				     	        return rst;
				     	    },
				     	    sClass: 'center'
				     	}
				        ],
				    "fnDrawCallback": function (oSettings) {
				    }

				});
	    });

	    function refreshTable() {
	        oSettings = oTable.fnSettings();

	        oTable.dataTable().fnDraw();
	    }

	    function redirectToListPage(status) {
	        $('.loading-btn').button('reset');

	        if (status.indexOf("error") != -1) {
	        } else {
	            refreshTable();
	        }
	    }

	    function useBigWheel() {
	        var status = $("#status").is(":checked");

	        if (status == true) {
	            if (($("#gift1name").val().length > 0 && $("#gift1cnt").val().length == 0) || ($("#gift1name").val().length == 0 && $("#gift1cnt").val().length > 0) ||
                    ($("#gift2name").val().length > 0 && $("#gift2cnt").val().length == 0) || ($("#gift2name").val().length == 0 && $("#gift2cnt").val().length > 0) ||
                    ($("#gift3name").val().length > 0 && $("#gift3cnt").val().length == 0) || ($("#gift3name").val().length == 0 && $("#gift3cnt").val().length > 0) ||
                    ($("#gift4name").val().length > 0 && $("#gift4cnt").val().length == 0) || ($("#gift4name").val().length == 0 && $("#gift4cnt").val().length > 0) ||
                    ($("#gift5name").val().length > 0 && $("#gift5cnt").val().length == 0) || ($("#gift5name").val().length == 0 && $("#gift5cnt").val().length > 0) ||
                    ($("#gift6name").val().length > 0 && $("#gift6cnt").val().length == 0) || ($("#gift6name").val().length == 0 && $("#gift6cnt").val().length > 0) ||
                        ($("#gift1name").val().length == 0 && //$("#gift1cnt").val().length == 0 &&
                        $("#gift2name").val().length == 0 && //$("#gift2cnt").val().length == 0 &&
                        $("#gift3name").val().length == 0 && //$("#gift3cnt").val().length == 0 &&
                        $("#gift4name").val().length == 0 && //$("#gift4cnt").val().length == 0 &&
                        $("#gift5name").val().length == 0 && //$("#gift5cnt").val().length == 0 &&
                        $("#gift6name").val().length == 0 //&& $("#gift6cnt").val().length == 0
                        )) {

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

	                toastr["error"]("活动奖品设置错误", "温馨敬告");

	                $("#status")[0].checked = false;

	                return;
	            }


                bootbox.dialog({
		                message: "您确定要启动转盘活动码？",
		                buttons: {
		                    danger: {
		                        label: "取消",
		                        className: "btn-danger",
		                        callback: function () {
		                            $("#status")[0].checked = false;
		                        }
		                    },
		                    main: {
		                        label: "确定",
		                        className: "btn-primary",
		                        callback: function () {
                                    $("#gift1cnt").attr("disabled", "disabled");
	                                $("#gift2cnt").attr("disabled", "disabled");
	                                $("#gift3cnt").attr("disabled", "disabled");
	                                $("#gift4cnt").attr("disabled", "disabled");
	                                $("#gift5cnt").attr("disabled", "disabled");
	                                $("#gift6cnt").attr("disabled", "disabled");

                                    //submitform();
		                        }
		                    }
		                }
		            });
	        } else {
	                $("#gift1name").removeAttr("disabled");
	                $("#gift2name").removeAttr("disabled");
	                $("#gift3name").removeAttr("disabled");
	                $("#gift4name").removeAttr("disabled");
	                $("#gift5name").removeAttr("disabled");
	                $("#gift6name").removeAttr("disabled");

	            $("#gift1cnt").removeAttr("disabled");
	            $("#gift2cnt").removeAttr("disabled");
	            $("#gift3cnt").removeAttr("disabled");
	            $("#gift4cnt").removeAttr("disabled");
	            $("#gift5cnt").removeAttr("disabled");
	            $("#gift6cnt").removeAttr("disabled");

	            $("#percent").removeAttr("disabled");
	            $("#passowrd").removeAttr("disabled");
	        }
	    }

	    function submitform() {
	        if ($('#validation-form').valid()) {
	            $('.alert-danger').hide();

	            $("input[name='gift1cnt']").val($("#gift1cnt").val());
	            $("input[name='gift2cnt']").val($("#gift2cnt").val());
	            $("input[name='gift3cnt']").val($("#gift3cnt").val());
	            $("input[name='gift4cnt']").val($("#gift4cnt").val());
	            $("input[name='gift5cnt']").val($("#gift5cnt").val());
	            $("input[name='gift6cnt']").val($("#gift6cnt").val());

	            $.ajax({
	                type: "POST",
	                url: rootUri + "Lobby/LMarket/SubmitGifts",
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
	    }

	    function toggleMoreGift() {
	        $("#moregift").toggle();
	    }

	    function processChouzhong(sel_id) {
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
	                message: "您确定要已经被抽中吗？",
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
	                                url: rootUri + "Lobby/LMarket/ChouzhongGift",
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
	                                        toastr["success"]("操作成功！", "恭喜您");
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

	    function processDuijiang(sel_id) {
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
	                message: "您确定要已经兑奖吗？",
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
	                                url: rootUri + "Lobby/LMarket/DuijiangGift",
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
	                                        toastr["success"]("操作成功！", "恭喜您");
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
