<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="row">
	<div class="col-xs-12">
		<div class="alert alert-block alert-success">
			<button type="button" class="close" data-dismiss="alert">
				<i class="ace-icon fa fa-times"></i>
			</button>

			<i class="ace-icon fa fa-check green"></i>
			欢迎光临<strong class="green"> 营业厅手机展示系统<small>(v1.0)</small>
			</strong>，祝您工作愉快！
		</div>

		<div class="row">
			<div class="col-sm-7 ">
                <div class="widget-box transparent ">
				    <div class="widget-header widget-header-flat">
					    <h4 class="widget-title lighter">
						    <i class="ace-icon fa fa-bullhorn "></i>
						    运行概况
					    </h4>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main no-padding">
                        <div class="col-xs-12 infobox-container" style="margin-top:15px;">
				            <div class="space-6"></div>

				            <div class="infobox infobox-green infobox-small infobox-dark">
					            <div class="infobox-chart">
						            <span class="sparkline" data-values="3,4,2,3,4,4,2,2"></span>
					            </div>

					            <div class="infobox-data">
						            <div class="infobox-content">总市代理</div>
						            <div class="infobox-content"><% =String.Format("{0:0,000}", ViewData["totalagent"]) %></div>
					            </div>
				            </div>

				            <div class="infobox infobox-blue infobox-small infobox-dark">
					            <div class="infobox-chart">
						            <span class="sparkline" data-values="3,4,2,3,4,4,2,2"></span>
					            </div>

					            <div class="infobox-data">
						            <div class="infobox-content">总营业厅</div>
						            <div class="infobox-content"><% =String.Format("{0:0,000}", ViewData["totalhall"]) %></div>
					            </div>
				            </div>

				            <div class="infobox infobox-grey infobox-small infobox-dark">
					            <div class="infobox-icon">
						            <i class="ace-icon fa fa-download"></i>
					            </div>

					            <div class="infobox-data">
						            <div class="infobox-content">总访问</div>
						            <div class="infobox-content"><% =String.Format("{0:0,000}", ViewData["totalvisit"]) %></div>
					            </div>
				            </div>
                        </div>

                        </div>
                    </div>
			    </div>
            </div>

			<div class="col-sm-5">
				<div class="widget-box transparent">
					<div class="widget-header widget-header-flat">
						<h4 class="widget-title lighter">
							<i class="ace-icon fa fa-star orange"></i>
							城市代理排行 BESTT5
						</h4>

						<div class="widget-toolbar">
							<a href="#" data-action="collapse">
								<i class="ace-icon fa fa-chevron-up"></i>
							</a>
						</div>
					</div>

					<div class="widget-body">
						<div class="widget-main no-padding" style="margin-top:15px;">
							<table class="table table-bordered table-striped">
								<thead class="thin-border-bottom">
									<tr>
										<th>
											<i class="ace-icon fa fa-caret-right blue"></i>代理名称
										</th>

										<th>
											<i class="ace-icon fa fa-caret-right blue"></i>所属营业厅数
										</th>

										<th class="hidden-480">
											<i class="ace-icon fa fa-caret-right blue"></i>开通账号日期
										</th>
									</tr>
								</thead>

								<tbody>
                                <%
                                    List<HavehallInfo> agentlist = (List<HavehallInfo>)ViewData["best5"];
                                    if (agentlist != null)
                                    {
                                        for (int i = 0; i < agentlist.Count(); i++)
                                        {
                                            HavehallInfo item = agentlist.ElementAt(i);
                                     %>
									        <tr>
										        <td><% =item.agentname %></td>

										        <td>
											        <b class="green"><% =item.hallcount %></b>
										        </td>

										        <td class="hidden-480">
											        <% =item.regtime %>
										        </td>
									        </tr>
                                    <%
                                        }
                                    }
                                     %>
									<!--<tr>
										<td>沈阳代理0</td>

										<td>
											<b class="green">349</b>
										</td>

										<td class="hidden-480">
											2014年06月05日 12:32:53
										</td>
									</tr>
									<tr>
										<td>沈阳代理2</td>

										<td>
											<b class="green">349</b>
										</td>

										<td class="hidden-480">
											2014年06月05日 12:32:53
										</td>
									</tr>
									<tr>
										<td>沈阳代理3</td>

										<td>
											<b class="green">349</b>
										</td>

										<td class="hidden-480">
											2014年06月05日 12:32:53
										</td>
									</tr>
									<tr>
										<td>沈阳代理4</td>

										<td>
											<b class="green">349</b>
										</td>

										<td class="hidden-480">
											2014年06月05日 12:32:53
										</td>
									</tr>-->

								</tbody>
							</table>
						</div><!-- /.widget-main -->
					</div><!-- /.widget-body -->
				</div><!-- /.widget-box -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div>
</div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageStyle" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
	<!--[if lte IE 8]>
		<script src="<%= ViewData["rootUri"] %>Content/js/excanvas.min.js"></script>
	<![endif]-->
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.sparkline.min.js"></script>
    <script type="text/javascript">
        $('.sparkline').each(function () {
            var $box = $(this).closest('.infobox');
            var barColor = !$box.hasClass('infobox-dark') ? $box.css('color') : '#FFF';
            $(this).sparkline('html',
									 {
									     tagValuesAttribute: 'data-values',
									     type: 'bar',
									     barColor: barColor,
									     chartRangeMin: $(this).data('min') || 0
									 });
        });

		jQuery(function($) {
		    $('.shopinfo,.comments').ace_scroll({
				size: 300
			});
		});
        
    </script>
<!--     <script type="text/javascript"> -->
<!--         $(document).ready(function () { -->
<!--             $('#digiclock').jdigiclock(); -->
<!--         }); -->
<!--     </script> -->
</asp:Content>
