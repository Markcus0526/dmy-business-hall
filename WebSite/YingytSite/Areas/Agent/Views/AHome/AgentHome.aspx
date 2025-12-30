<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Agent/Agent.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
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
				<div class="widget-box transparent" id="recent-box">
					<div class="widget-header">
						<h4 class="widget-title lighter smaller">
							<i class="ace-icon fa fa-rss orange"></i>系统通知
						</h4>
						<div class="widget-toolbar no-border">
								<a href="#" class="btn btn-sm btn-white btn-info" onclick="toggleMoreNews();">
									&nbsp;查看所有通知 
									<i class="ace-icon fa fa-arrow-right"></i>
								</a>

						</div>

					</div>

					<div class="widget-body">
						<div class="widget-main padding-4">
							<div class="comments">
                            <% if (ViewData["noticelist"] != null)
                                {
                                    int i = 1;
                                    foreach(var item in (List<NewsTipInfo>)ViewData["noticelist"]) { %>
								        <div class="itemdiv commentdiv <% if(i > 7) { %> morenews <% } %>" <% if(i > 7) { %> style="display:none;" <% } %>>
									        <div class="body">
										        <div class="name">
											        <a href="<%= ViewData["rootUri"] %>Agent/AHome/NoticeDetail/<%= item.uid %>"><%= item.title %></a>
										        </div>

										        <div class="time">
											        <i class="ace-icon fa fa-clock-o"></i>
                                                    <% string tcolor = "red";
                                                        if (i == 1)
                                                        {
                                                            tcolor = "green";
                                                        }
                                                        else if (i == 2)
                                                        {
                                                            tcolor = "blue";
                                                        }
                                                        else if (i == 3)
                                                        {
                                                            tcolor = "orange";
                                                        }
                                                        else if (i == 4)
                                                        {
                                                            tcolor = "red";
                                                        }
                                                        %>
											        <span class="<%= tcolor %>"><%= item.beforetime %></span>
										        </div>

										        <div class="text">
											        <i class="ace-icon fa fa-quote-left"></i>
											        <!--<%= item.description%>--> 
                                                    <script type="text/javascript">
                                                        document.write(unescape("<%= item.description%>"))
                                                    </script>
										        </div>
									        </div>
								        </div>                                                           
                                    <% 
                                        i++;
                                                           
                                    }
                                } %>
							</div>
						</div><!-- /.widget-main -->
					</div><!-- /.widget-body -->
				</div><!-- /.widget-box -->
            </div>

			<div class="col-sm-5">
				<div class="widget-box transparent">
					<div class="widget-header widget-header-flat">
						<h4 class="widget-title lighter">
							<i class="ace-icon fa fa-star orange"></i>
							访问量 BEST5
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
											<i class="ace-icon fa fa-caret-right blue"></i>营业厅名称
										</th>

										<th>
											<i class="ace-icon fa fa-caret-right blue"></i>地址
										</th>

										<th class="hidden-480">
											<i class="ace-icon fa fa-caret-right blue"></i>访问量
										</th>
									</tr>
								</thead>

								<tbody>
                                <%
                                    List<VisitInfo> visitlist = (List<VisitInfo>)ViewData["visitlist"];
                                    if (visitlist != null)
                                    {
                                        for(int i = 0; i < visitlist.Count(); i ++)
                                        {
                                            VisitInfo item = visitlist.ElementAt(i);                                     
                                     %>
                                        <tr>
										    <td><% =item.hallname %></td>

										    <td>
                                                <% =item.address %>
										    </td>

										    <td class="hidden-480">
											    <% =String.Format("{0:0,000}", item.visitcount) %>
										    </td>
									    </tr>
                                    <%
                                        } 
                                    }
                                     %>

									<!--<tr>
										<td>和平区营业厅1</td>

										<td>
                                            辽宁 沈阳市 和平区长白桥2938903
										</td>

										<td class="hidden-480">
											29,380,923
										</td>
									</tr>
									<tr>
										<td>和平区营业厅2</td>
										<td>辽宁 沈阳市 和平区长刷卡机杜蕾斯</td>
										<td class="hidden-480">
											29,380,923
										</td>
									</tr>
									<tr>
										<td>和平区营业厅3</td>
										<td>辽宁 沈阳市 和平区长白桥2938903</td>
										<td class="hidden-480">
											29,380,923
										</td>
									</tr>
									<tr>
										<td>和平区营业厅4</td>
										<td>辽宁 沈阳市 和平区长白桥2938903</td>
										<td class="hidden-480">
											29,380,923
										</td>
									</tr>
									<tr>
										<td>和平区营业厅5</td>
										<td>辽宁 沈阳市 和平区长白桥2938903</td>
										<td class="hidden-480">
											29,380,923
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

        jQuery(function ($) {
            $('.shopinfo,.comments').ace_scroll({
                size: 500
            });
        });

        function toggleMoreNews() {
            $(".morenews").toggle();        
        }
        
    </script>
<!--     <script type="text/javascript"> -->
<!--         $(document).ready(function () { -->
<!--             $('#digiclock').jdigiclock(); -->
<!--         }); -->
<!--     </script> -->
</asp:Content>
