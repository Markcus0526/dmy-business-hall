<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Lobby/Lobby.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header">
	<h1>
		统计
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
        <p class="alert alert-info">
	        <i class="ace-icon fa fa-exclamation-triangle"></i>
            APP点击量概况
        </p>
        <div class="widget-box">
			<div class="widget-header">
				<h4 class="smaller">
					查询
					<small>请选择查询条件（手机品牌、手机类型，等等）</small>
				</h4>
			</div>

			<div class="widget-body">
				<div class="widget-main">
                    <div class="searchbar">
                        <div>
                            <table style="width:100%">
                            <tr>
                            <td>
                            <label for="form-field-select-3">手机品牌:</label>
                            </td>
                            <td style="padding-top:20px;">
						    <select class="form-control select2" id="brandlist" data-placeholder="Click to Choose..." onchange="changeBrand();" style="width:200px;">
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
				            </select>&nbsp;&nbsp;
                            </td>
                            <td>
                            <label for="form-field-select-3">手机类型:</label>
                            </td>
                            <td style="padding-top:20px;">
						    <select class="form-control select2" id="speclist" data-placeholder="Click to Choose..." style="width:200px;" disabled>
                                <option value="0">全部</option>
                               <%-- <% 
                                    List<tbl_androidspec> speclist = (List<tbl_androidspec>)ViewData["speclist"];
                                    if (speclist != null)
                                    {
                                        for (int i = 0; i < speclist.Count(); i++)
                                        {
                                            tbl_androidspec item = speclist.ElementAt(i);
                                            %>
                                            <option value="<% =item.uid %>"><% =item.specvalue %></option>
                                            <%
                                        }
                                    }
                                %>--%>
				            </select>&nbsp;&nbsp;
                            </td>
                            <td>
                            <label for="form-field-select-3">统计类型:</label>
                            </td>
                            <td>
						    <select class="form-control select2" id="stat_type" data-placeholder="Click to Choose..." style="width:200px;">
                                <option value="0" selected>月</option>
                                <option value="1">日</option>
				            </select>   
                            </td>                                       
                            </tr>
                            </table>

                            <span>时间范围：</span>
		                    <div id="date_range" class="btn white">
			                    <i class="fa fa-calendar"></i>
			                    &nbsp;<span><%--<% =ViewData["startdate"] %>~<% =ViewData["enddate"] %>--%></span>
			                    <b class="fa fa-angle-down"></b>
		                    </div>
                        </div>
                    </div>

					<hr />

					<p>
						<span class="btn btn-sm btn-info" onclick="search_data();" ><i class="fa fa-search"></i> 查询</span>               

					</p>
        
				</div>
			</div>
		</div>
		<div>
			<div class="portlet-body" id="statisticsgraph">
				<div id="site_statistics_loading">
					<img src="<%= ViewData["rootUri"] %>Content/img/loading.gif" alt="loading"/>
				</div>
				<div id="site_statistics_content" class="display-none">
					<div id="site_statistics_daily" class="chart" style="width:100%;height:300px;display:none;"></div>
					<div id="site_statistics_monthly" class="chart" style="width:100%;height:300px;"></div>
				</div>

			</div>
		</div>
	</div>
</div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageStyle" runat="server">
	<link rel="stylesheet" type="text/css" href="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.min.css" />
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/css/select2.css" />
	<link rel="stylesheet" type="text/css" href="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.dataTables.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/jquery.dataTables.bootstrap.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/bootbox.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>  
	<script src="<%= ViewData["rootUri"] %>Content/js/select2.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-daterangepicker/moment.min.js" type="text/javascript"></script>
	<script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script> 
	<script src="<%= ViewData["rootUri"] %>Content/js/app1.js" type="text/javascript"></script>
    
<%--    <script src="<%= ViewData["rootUri"] %>Content/plugins/flot/jquery.js" type="text/javascript"></script>--%>
    <script src="<%= ViewData["rootUri"] %>Content/plugins/flot/jquery.flot.js" type="text/javascript"></script>
	<script src="<%= ViewData["rootUri"] %>Content/plugins/flot/jquery.flot.navigate.js" type="text/javascript"></script>
	<script src="<%= ViewData["rootUri"] %>Content/plugins/flot/jquery.flot.resize.js" type="text/javascript"></script>
    <script src="<%= ViewData["rootUri"] %>Content/plugins/flot/jquery.flot.time.js" type="text/javascript"></script>

	<script type="text/javascript">

        var enddate = moment();
	    var startdate = moment().subtract('days', parseInt('<% =ViewData["daydiff"]%>', 10));

	    var handleDateRangePickers = function () {
	        if (!jQuery().daterangepicker) {
	            return;
	        }

//	        enddate = parseInt('<% =ViewData["enddatereal"]%>', 10);
//	        startdate = parseInt('<% =ViewData["startdatereal"]%>', 10);
                       
	        $('#date_range').daterangepicker({
	            opens: (App.isRTL() ? 'left' : 'right'),
	            startDate: startdate,
	            endDate: enddate,
	            minDate: '01/01/2012',
	            maxDate: '12/31/2020',
	            /*dateLimit: {
	                days: 60
	            },*/
	            showDropdowns: true,
	            showWeekNumbers: true,
	            timePicker: false,
	            timePickerIncrement: 1,
	            timePicker12Hour: true,
	            ranges: {
	                '今天': [moment(), moment()],
	                '昨天': [moment().subtract('days', 1), moment().subtract('days', 1)],
	                '最后7天': [moment().subtract('days', 6), moment()],
	                '最后30天': [moment().subtract('days', 29), moment()],
	                '本月': [moment().startOf('month'), moment().endOf('month')],
	                '上个月': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
	            },
	            buttonClasses: ['btn'],
	            applyClass: 'green',
	            cancelClass: 'default',
	            format: 'MM/DD/YYYY',
	            separator: ' to ',
	            locale: {
	                applyLabel: '确定',
	                cancelLabel: '取消',
	                fromLabel: '从',
	                toLabel: '到',
	                customRangeLabel: '自定义范围',
	                daysOfWeek: ['日', '一', '二', '三', '四', '五', '六'],
	                monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
	                firstDay: 1
	            }
	        },
                function (start, end) {
                    //console.log("Callback has been called!");
                    $('#date_range span').html(start.format('YYYY-MM-DD') + ' ~ ' + end.format('YYYY-MM-DD'));
                    startdate = start;
                    enddate = end;
                }
            );
	        //Set the initial state of the picker label
	        $('#date_range span').html(startdate.format('YYYY-MM-DD') + ' ~ ' + enddate.format('YYYY-MM-DD'));
	    }

        function showTooltip(title, x, y, contents) {
	        $('<div id="tooltip" class="chart-tooltip"><div class="date">' + title + '<\/div><div class="label label-success">' + contents + '<\/div><\/div>').css({
	            position: 'absolute',
	            display: 'none',
	            top: y - 100,
	            width: 120,
	            left: x - 40,
	            border: '0px solid #ccc',
	            padding: '2px 6px',
	            'background-color': '#fff',
	        }).appendTo("body").fadeIn(200);
	    }

        var plot_statistics_daily, plot_statistics_monthly;	  
	    var dayInc = (new Date(1970, 0, 2)) - (new Date(1970, 0, 1));
        var initCharts = function () {
            if (!jQuery.plot) {
                return;
            }        
            
            //if ($('#site_statistics').size() != 0) {
                $('#site_statistics_loading').hide();
                $('#site_statistics_content').show();
                   
                plot_statistics_daily = $.plot($("#site_statistics_daily"), [{
                    data: [[0, 1], [1, 1], [2, 1], [5, 0.5]],
                    label: "手机游览"
                }
                ], {
                    series: {
                        lines: {
                            show: true,
                            lineWidth: 2,
                            fill: true,
                            fillColor: {
                                colors: [{
                                    opacity: 0.05
                                }, {
                                    opacity: 0.01
                                }
                                ]
                            }
                        },
                        points: {
                            show: true
                        },
                        shadowSize: 2
                    },
                    grid: {
                        hoverable: true,
                        clickable: true,
                        tickColor: "#eee",
                        borderWidth: 0
                    },
                    colors: ["#d12610", "#37b7f3", "#52e136"],
                    xaxis: {
                        mode: "time",
                        minTickSize: [1, "day"],
                        min: startdate, //enddate-30*dayInc,
                        max: enddate,
                        timeformat: "%Y-%m-%d",
                        ticks: 30,
                        tickDecimals: 0,
                        labelAngle: -45,
                        //panRange: [startdate, enddate]
                    },
                    yaxis: {
                        min: 0,
                        max: 100,
                        ticks: 11,
                        tickDecimals: 0,
                        //panRange: [0, 1]
                    },
			        zoom: {
				        interactive: false
			        },
			        pan: {
				        interactive: true
			        }
                });

                plot_statistics_monthly = $.plot($("#site_statistics_monthly"), [{
                    data: [[0, 1], [1, 1], [2, 1], [5, 0.5]],
                    label: "手机游览"
                }
                ], {
                    series: {
                        lines: {
                            show: true,
                            lineWidth: 2,
                            fill: true,
                            fillColor: {
                                colors: [{
                                    opacity: 0.05
                                }, {
                                    opacity: 0.01
                                }
                                ]
                            }
                        },
                        points: {
                            show: true
                        },
                        shadowSize: 2
                    },
                    grid: {
                        hoverable: true,
                        clickable: true,
                        tickColor: "#eee",
                        borderWidth: 0
                    },
                    colors: ["#d12610", "#37b7f3", "#52e136"],
                    xaxis: {
                        mode: "time",
                        minTickSize: [1, "month"],
                        min: startdate, //enddate-30*dayInc,
                        max: enddate,
                        timeformat: "%Y-%m",
                        ticks: 30,
                        tickDecimals: 0,
                        labelAngle: -45,
                        //panRange: [startdate, enddate]
                    },
                    yaxis: {
                        min: 0,
                        max: 100,
                        ticks: 11,
                        tickDecimals: 0,
                        //panRange: [0, 1000]
                    },
			        zoom: {
				        interactive: false
			        },
			        pan: {
				        interactive: true
			        }
                });

                //alert(plot_statistics_monthly.getAxes);
                
                var previousPoint = null;
                $("#site_statistics_daily").bind("plothover", function (event, pos, item) {
                    $("#x").text(pos.x.toFixed(2));
                    $("#y").text(pos.y.toFixed(2));
                    if (item) {
                        if (previousPoint != item.dataIndex) {
                            previousPoint = item.dataIndex;
                            //alert(item + "  / " + item.dataIndex);

                            $("#tooltip").remove();
                            var x = item.datapoint[0].toFixed(2),
                                y = item.datapoint[1].toFixed(2);

                            var date = new Date(item.series.data[item.dataIndex][0]);
                            showTooltip(date.getFullYear()+"年"+(date.getMonth()+1)+"月"+(date.getDate())+"号", item.pageX, item.pageY, item.series.label + ": " + item.series.data[item.dataIndex][1]);
                        }
                    } else {
                        $("#tooltip").remove();
                        previousPoint = null;
                    }
                });
                $("#site_statistics_monthly").bind("plothover", function (event, pos, item) {
                    $("#x").text(pos.x.toFixed(2));
                    $("#y").text(pos.y.toFixed(2));
                    if (item) {
                        if (previousPoint != item.dataIndex) {
                            previousPoint = item.dataIndex;
                            //alert(item + "  / " + item.dataIndex);

                            $("#tooltip").remove();
                            var x = item.datapoint[0].toFixed(2),
                                y = item.datapoint[1].toFixed(2);

                            var date = new Date(item.series.data[item.dataIndex][0]);
                            showTooltip(date.getFullYear()+"年"+(date.getMonth()+1)+"月", item.pageX, item.pageY, item.series.label + ": " + item.series.data[item.dataIndex][1]);
                        }
                    } else {
                        $("#tooltip").remove();
                        previousPoint = null;
                    }
                });
            //}
        }

        //var specselect;
        jQuery(function ($) {
//		    $(".select2").css('width', '250px').select2({ allowClear: true })
//			.on('change', function () {
//			    //$(this).closest('form').validate().element($(this));
//			});

            //specselect = $("#speclist").select2({ allowClear: true });
	        handleDateRangePickers();
            initCharts();
            search_data();
		});
                
		function redirectToListPage(status) {
		    if (status.indexOf("error") != -1) {
		    } else {

		    }
		}

		function changeBrand() {
		    var brand_id = $("#brandlist").val();
		    if (brand_id == null)
		        return;
		    if (brand_id == 0) {
		        $("#speclist").val(0);
		        $("#speclist").attr("disabled", "disabled");
		        return;
		    }
		    $("#speclist").removeAttr("disabled");
		    $.ajax({
		        url: rootUri + "Agent/AStatistics/GetSpecList",
		        data: {
		            "brand_id": brand_id
		        },
		        type: "GET",
		        success: function (data) {
		            if (data != null && data != "") {
		                var speclist = [];
		                speclist = speclist.concat(data);
		                var options = '<option value="0" selected>全部</option>';
		                for (var i = 0; i < speclist.length; i++) {
		                    options += "<option value='" + speclist[i].uid + "'>" + speclist[i].specvalue + "</option>";
		                }
                        $("#speclist").html(options);
		            }
		        }
		    });
		}

		function search_data() {
		    var brand_id = $("#brandlist").val();
		    var spec_id = $("#speclist").val();
		    var stat_type = $("#stat_type").val();
		    var start_date = startdate.format('YYYY-MM-DD');
		    var end_date = enddate.format('YYYY-MM-DD');
            		    
            $.ajax({
                type: "GET",
                url: rootUri + "Agent/AStatistics/RetriveStatisticsList",
                dataType: 'json',
                data: { 
                    brand_id: brand_id, 
                    spec_id: spec_id, 
                    type: stat_type, 
                    startdate: start_date, 
                    enddate: end_date, 
                },
                success: function (data) {
                    if(data != null && data != "") {
                        var maxcount = 0;
                                         
                        var list = [];
                        for (var i = 0; i < data.length; i++) {                            
                            list = ([[data[i].date, data[i].count]]).concat(list);
                            if(data[i].count > maxcount)
                                maxcount = data[i].count;
                        }   
                        maxcount ++;
                        if(maxcount < 10)
                            maxcount = 10;

                        if(stat_type == 0) {
                            $("#site_statistics_daily").hide();
                            $("#site_statistics_monthly").show();
                            
                            plot_statistics_monthly = $.plot($("#site_statistics_monthly"), [{
                                data: list,
                                label: "手机游览"
                            }
                            ], {
                                series: {
                                    lines: {
                                        show: true,
                                        lineWidth: 2,
                                        fill: true,
                                        fillColor: {
                                            colors: [{
                                                opacity: 0.05
                                            }, {
                                                opacity: 0.01
                                            }
                                            ]
                                        }
                                    },
                                    points: {
                                        show: true
                                    },
                                    shadowSize: 2
                                },
                                grid: {
                                    hoverable: true,
                                    clickable: true,
                                    tickColor: "#eee",
                                    borderWidth: 0
                                },
                                colors: ["#d12610", "#37b7f3", "#52e136"],
                                xaxis: {
                                    mode: "time",
                                    minTickSize: [1, "month"],
                                    min: startdate-30*dayInc, //enddate-30*dayInc,
                                    max: enddate+30*dayInc,
                                    timeformat: "%Y-%m",
                                    ticks: 30,
                                    tickDecimals: 0,
                                    labelAngle: -45,
                                    //panRange: [startdate, enddate]
                                },
                                yaxis: {
                                    min: 0,
                                    max: maxcount,
                                    ticks: 11,
                                    tickDecimals: 0,
                                    //panRange: [0, 1000]
                                },
			                    zoom: {
				                    interactive: false
			                    },
			                    pan: {
				                    interactive: true
			                    }
                            });

//                            plot_statistics_monthly.setData([{
//                                data: list,
//                                label: "手机游览"
//                            }
//                            ]);
//                            plot_statistics_monthly.pan({ left: 0, top: 0 });
                        } else {
                            $("#site_statistics_daily").show();
                            $("#site_statistics_monthly").hide();                       
                            
                            plot_statistics_daily = $.plot($("#site_statistics_daily"), [{
                                    data: list,
                                    label: "手机游览"
                                }
                                ], {
                                    series: {
                                        lines: {
                                            show: true,
                                            lineWidth: 2,
                                            fill: true,
                                            fillColor: {
                                                colors: [{
                                                    opacity: 0.05
                                                }, {
                                                    opacity: 0.01
                                                }
                                                ]
                                            }
                                        },
                                        points: {
                                            show: true
                                        },
                                        shadowSize: 2
                                    },
                                    grid: {
                                        hoverable: true,
                                        clickable: true,
                                        tickColor: "#eee",
                                        borderWidth: 0
                                    },
                                    colors: ["#d12610", "#37b7f3", "#52e136"],
                                    xaxis: {
                                        mode: "time",
                                        minTickSize: [1, "day"],
                                        min: startdate, //enddate-30*dayInc,
                                        max: enddate,
                                        timeformat: "%Y-%m-%d",
                                        ticks: 30,
                                        tickDecimals: 0,
                                        labelAngle: -45,
                                        //panRange: [startdate, enddate]
                                    },
                                    yaxis: {
                                        min: 0,
                                        max: maxcount,
                                        ticks: 11,
                                        tickDecimals: 0,
                                        //panRange: [0, 1]
                                    },
			                        zoom: {
				                        interactive: false
			                        },
			                        pan: {
				                        interactive: true
			                        }
                                });

//                            plot_statistics_daily.setData([{
//                                data: list,
//                                label: "手机游览"
//                            }
//                            ]);
//                            plot_statistics_daily.pan({ left: 0, top: 0 });
                        }
                    }
                }
            });
		}	    

    </script>
</asp:Content>
