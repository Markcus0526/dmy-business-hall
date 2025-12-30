<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Agent/Agent.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header">
	<h1>
		我的库 -> 手机库
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
							<div class="alert alert-info">
								<button class="close" data-dismiss="alert">
									<i class="ace-icon fa fa-times"></i>
								</button>

								<i class="ace-icon fa fa-hand-o-right"></i>
								重复的品牌将被过滤
							</div>

							<table id="grid-table"></table>

							<div id="grid-pager"></div>

							<script type="text/javascript">
							    var $path_base = ".."; //this will be used for editurl parameter
							</script>
	</div>
</div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageStyle" runat="server">
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/css/jquery-ui.min.css" />
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/css/datepicker.css" />
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/css/ui.jqgrid.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
	<script src="<%= ViewData["rootUri"] %>Content/js/date-time/bootstrap-datepicker.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/jqGrid/jquery.jqGrid.min.js"></script>
	<script src="<%= ViewData["rootUri"] %>Content/js/jqGrid/i18n/grid.locale-cn.js"></script>
	<script type="text/javascript">
		jQuery(function($) {
			var grid_selector = "#grid-table";
			var pager_selector = "#grid-pager";
				
			//resize to fit page size
			$(window).on('resize.jqGrid', function () {
				$(grid_selector).jqGrid( 'setGridWidth', $(".page-content").width() );
			})
			//resize on sidebar collapse/expand
			var parent_column = $(grid_selector).closest('[class*="col-"]');
			$(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
				if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
					$(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
				}
			})
			
			jQuery(grid_selector).jqGrid({
    			url: rootUri + "Agent/ABrief/GetBrandList",
                //height:400,
				subGrid : true,
				subGridOptions : {
					plusicon : "ace-icon fa fa-plus center bigger-110 blue",
					minusicon  : "ace-icon fa fa-minus center bigger-110 blue",
					openicon : "ace-icon fa fa-chevron-right center orange"
				},
				//for this example we are using local data
				subGridRowExpanded: function (subgridDivId, rowId) {
					var subgridTableId = subgridDivId + "_t";
    				var pager_id = "p_"+subgridTableId;
					$("#" + subgridDivId).html("<table id='" + subgridTableId + "'><div id='"+pager_id+"' class='scroll'></table>");
					$("#" + subgridTableId).jqGrid({
    					url:rootUri + "Agent/ABrief/GetSpecList?brandid=" + rowId,
						datatype: 'json',
						colNames: ['操作', '型号', '排序', '横分辨率', '纵分辨率', '来源'],
						colModel: [
					    {name:'myac2',index:'', width:80, fixed:true, sortable:false, resize:false, search:false,
						    formatter:'actions', 
						    formatoptions:{ 
							    keys:true,
								
							    delOptions:{recreateForm: true, beforeShowForm:beforeDeleteCallback},
							    //editformbutton:true, editOptions:{recreateForm: true, beforeShowForm:beforeEditCallback}
						    }
					    },
						{name:'specvalue',index:'specvalue', width:80, editable: true, editrules:{required:true}},
						{name:'specsortid',index:'specsortid',sorttype:"int", width:80, editable:true, search:false, editrules:{required:true, number:true}},
						{name:'scrwidth',index:'scrwidth', width:80, editable: true, editrules:{required:true, number:true}},
						{name:'scrheight',index:'scrheight', width:80, editable: true, editrules:{required:true, number:true}},
						{name:'username',index:'username', width:80, editable:false, search:false}
						],
					    rowNum:10,
					    pager: pager_id,
					    sortname: 'specsortid',
                        autowidth: true,
                        height: 500,
                        edit: true,
                        add: true,
                        del: true,
					    sortorder: "desc",
					    multiselect: true,
					    editurl: rootUri+"Agent/ABrief/EditSpec?brandid=" + rowId,
					    loadComplete : function() {
						    var table = this;
						    setTimeout(function(){
							    //styleCheckbox(table);
							
                                updatePagerIcons(table);
							    //updateActionIcons(table);
							    //updatePagerLevel2Icons(table);
    //							enableTooltips(table);
						    }, 0);
					    }
					});

				    jQuery("#"+subgridTableId).jqGrid('navGrid',"#"+pager_id,
			            { 	//navbar options
						    edit: true,
						    editicon : 'ui-icon ace-icon fa fa-pencil blue',
						    add: true,
						    addicon : 'ui-icon ace-icon fa fa-plus-circle purple',
						    del: true,
						    delicon : 'ui-icon ace-icon fa fa-trash-o red',
						    search: true,
						    searchicon : 'ui-icon ace-icon fa fa-search orange',
						    refresh: true,
						    refreshicon : 'ui-icon ace-icon fa fa-refresh green',
						    view: true,
						    viewicon : 'ui-icon ace-icon fa fa-search-plus grey',
			            },
				        {
					        //edit record form
					        //closeAfterEdit: true,
					        //width: 700,
					        recreateForm: true,
					        beforeShowForm : function(e) {
						        var form = $(e[0]);
						        form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
						        style_edit_form(form);
					        }
				        },
				        {
					        //new record form
					        //width: 700,
					        closeAfterAdd: true,
					        recreateForm: true,
					        viewPagerButtons: false,
					        beforeShowForm : function(e) {
						        var form = $(e[0]);
						        form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar')
						        .wrapInner('<div class="widget-header" />')
						        style_edit_form(form);
					        }
				        },
				        {
					        //delete record form
					        recreateForm: true,
					        beforeShowForm : function(e) {
						        var form = $(e[0]);
						        if(form.data('styled')) return false;
							
						        form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
						        style_delete_form(form);
							
						        form.data('styled', true);
					        },
					        onClick : function(e) {
						        alert(1);
					        }
				        },
				        {
					        //search form
					        recreateForm: true,
					        afterShowSearch: function(e){
						        var form = $(e[0]);
						        form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
						        style_search_form(form);
					        },
					        afterRedraw: function(){
						        style_search_filters($(this));
					        }
					        ,
					        multipleSearch: true,
					        /**
					        multipleGroup:true,
					        showQuery: true
					        */
				        },
				        {
					        //view record form
					        recreateForm: true,
					        beforeShowForm: function(e){
						        var form = $(e[0]);
						        form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
					        }
				        }
				    )

				},
					
				datatype: "json",
    			colNames:['操作','品牌','备注', '排序', '来源'],

				colModel:[
					{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false, search:false,
						formatter:'actions', 
						formatoptions:{ 
							keys:true,
							delOptions:{recreateForm: true, beforeShowForm:beforeDeleteCallback},
							//editformbutton:true, editOptions:{recreateForm: true, beforeShowForm:beforeEditCallback}
						}
					},
				    //{name:'uid',index:'uid', width:40, sorttype:"int", editable: false, key:true, search:false},
				    {name:'brandname',index:'brandname',width:90, editable:true, editrules:{required:true}},
				    {name:'note',index:'note',width:90, editable:true},
				    {name:'sortid',index:'sortid',sorttype:"int", width:90, editable:true, search:false , editrules:{required:true, number:true}},
				    {name:'username',index:'username', width:90, search:false, editable:false}
				], 
			
				viewrecords : true,
				rowNum:10,
				rowList:[10,20,30],
				pager : pager_selector,
				altRows: true,
				multiselect: true,
			    multiboxonly: true,
			
				loadComplete : function() {
					var table = this;
					setTimeout(function(){
						styleCheckbox(table);
							
						updateActionIcons(table);
						updatePagerIcons(table);
						enableTooltips(table);
					}, 0);
				},
			
				editurl: rootUri + "Agent/ABrief/EditBrand",
				caption: "手机品牌及具体型号",
				autowidth: true,
                height: "100%"
				/**
				,
				grouping:true, 
				groupingView : { 
						groupField : ['name'],
						groupDataSorted : true,
						plusicon : 'fa fa-chevron-down bigger-110',
						minusicon : 'fa fa-chevron-up bigger-110'
				},
				caption: "Grouping"
				*/
			
			});
			$(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size
				
				
			
			//enable search/filter toolbar
			//jQuery(grid_selector).jqGrid('filterToolbar',{defaultSearch:true,stringResult:true})
			//jQuery(grid_selector).filterToolbar({});
			
			
			//switch element when editing inline
			function aceSwitch( cellvalue, options, cell ) {
				setTimeout(function(){
					$(cell) .find('input[type=checkbox]')
						.addClass('ace ace-switch ace-switch-5')
						.after('<span class="lbl"></span>');
				}, 0);
			}
			//enable datepicker
			function pickDate( cellvalue, options, cell ) {
				setTimeout(function(){
					$(cell) .find('input[type=text]')
							.datepicker({format:'yyyy-mm-dd' , autoclose:true}); 
				}, 0);
			}
			
			
			//navButtons
			jQuery(grid_selector).jqGrid('navGrid',pager_selector,
				{ 	//navbar options
					edit: true,
					editicon : 'ace-icon fa fa-pencil blue',
					add: true,
					addicon : 'ace-icon fa fa-plus-circle purple',
					del: true,
					delicon : 'ace-icon fa fa-trash-o red',
					search: true,
					searchicon : 'ace-icon fa fa-search orange',
					refresh: true,
					refreshicon : 'ace-icon fa fa-refresh green',
					view: true,
					viewicon : 'ace-icon fa fa-search-plus grey',
				},
				{
					//edit record form
					//closeAfterEdit: true,
					//width: 700,
					recreateForm: true,
					beforeShowForm : function(e) {
						var form = $(e[0]);
						form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
						style_edit_form(form);
					}
				},
				{
					//new record form
					//width: 700,
					closeAfterAdd: true,
					recreateForm: true,
					viewPagerButtons: false,
					beforeShowForm : function(e) {
						var form = $(e[0]);
						form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar')
						.wrapInner('<div class="widget-header" />')
						style_edit_form(form);
					}
				},
				{
					//delete record form
					recreateForm: true,
					beforeShowForm : function(e) {
						var form = $(e[0]);
						if(form.data('styled')) return false;
							
						form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
						style_delete_form(form);
							
						form.data('styled', true);
					},
					onClick : function(e) {
						alert(1);
					}
				},
				{
					//search form
					recreateForm: true,
					afterShowSearch: function(e){
						var form = $(e[0]);
						form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
						style_search_form(form);
					},
					afterRedraw: function(){
						style_search_filters($(this));
					}
					,
					multipleSearch: true,
					/**
					multipleGroup:true,
					showQuery: true
					*/
				},
				{
					//view record form
					recreateForm: true,
					beforeShowForm: function(e){
						var form = $(e[0]);
						form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
					}
				}
			)
			
			
				
			function style_edit_form(form) {
				//enable datepicker on "sdate" field and switches for "stock" field
				form.find('input[name=sdate]').datepicker({format:'yyyy-mm-dd' , autoclose:true})
					.end().find('input[name=stock]')
						.addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
							//don't wrap inside a label element, the checkbox value won't be submitted (POST'ed)
							//.addClass('ace ace-switch ace-switch-5').wrap('<label class="inline" />').after('<span class="lbl"></span>');
			
				//update buttons classes
				var buttons = form.next().find('.EditButton .fm-button');
				buttons.addClass('btn btn-sm').find('[class*="-icon"]').hide();//ui-icon, s-icon
				buttons.eq(0).addClass('btn-primary').prepend('<i class="ace-icon fa fa-check"></i>');
				buttons.eq(1).prepend('<i class="ace-icon fa fa-times"></i>')
					
				buttons = form.next().find('.navButton a');
				buttons.find('.ui-icon').hide();
				buttons.eq(0).append('<i class="ace-icon fa fa-chevron-left"></i>');
				buttons.eq(1).append('<i class="ace-icon fa fa-chevron-right"></i>');		
			}
			
			function style_delete_form(form) {
				var buttons = form.next().find('.EditButton .fm-button');
				buttons.addClass('btn btn-sm btn-white btn-round').find('[class*="-icon"]').hide();//ui-icon, s-icon
				buttons.eq(0).addClass('btn-danger').prepend('<i class="ace-icon fa fa-trash-o"></i>');
				buttons.eq(1).addClass('btn-default').prepend('<i class="ace-icon fa fa-times"></i>')
			}
				
			function style_search_filters(form) {
				form.find('.delete-rule').val('X');
				form.find('.add-rule').addClass('btn btn-xs btn-primary');
				form.find('.add-group').addClass('btn btn-xs btn-success');
				form.find('.delete-group').addClass('btn btn-xs btn-danger');
			}
			function style_search_form(form) {
				var dialog = form.closest('.ui-jqdialog');
				var buttons = dialog.find('.EditTable')
				buttons.find('.EditButton a[id*="_reset"]').addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'ace-icon fa fa-retweet');
				buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'ace-icon fa fa-comment-o');
				buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').attr('class', 'ace-icon fa fa-search');
			}
				
			function beforeDeleteCallback(e) {
				var form = $(e[0]);
				if(form.data('styled')) return false;
					
				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
				style_delete_form(form);
					
				form.data('styled', true);
			}
				
			function beforeEditCallback(e) {
				var form = $(e[0]);
				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
				style_edit_form(form);
			}
			
			
			
			//it causes some flicker when reloading or navigating grid
			//it may be possible to have some custom formatter to do this as the grid is being created to prevent this
			//or go back to default browser checkbox styles for the grid
			function styleCheckbox(table) {
			/**
				$(table).find('input:checkbox').addClass('ace')
				.wrap('<label />')
				.after('<span class="lbl align-top" />')
			
			
				$('.ui-jqgrid-labels th[id*="_cb"]:first-child')
				.find('input.cbox[type=checkbox]').addClass('ace')
				.wrap('<label />').after('<span class="lbl align-top" />');
			*/
			}
				
			
			//unlike navButtons icons, action icons in rows seem to be hard-coded
			//you can change them like this in here if you want
			function updateActionIcons(table) {
				var replacement = 
				{
					'ui-ace-icon fa fa-pencil' : 'ace-icon fa fa-pencil blue',
					'ui-ace-icon fa fa-trash-o' : 'ace-icon fa fa-trash-o red',
					'ui-icon-disk' : 'ace-icon fa fa-check green',
					'ui-icon-cancel' : 'ace-icon fa fa-times red'
				};
				$(table).find('.ui-pg-div span.ui-icon').each(function(){
					var icon = $(this);
					var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
					if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
				})
			}
				
			//replace icons with FontAwesome icons like above
			function updatePagerIcons(table) {
				var replacement = 
				{
					'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
					'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
					'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
					'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
				};
				$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
					var icon = $(this);
					var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
						
					if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
				})
			}
			
			function enableTooltips(table) {
				$('.navtable .ui-pg-button').tooltip({container:'body'});
				$(table).find('.ui-pg-div').tooltip({container:'body'});
			}
			
			//var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');
			
			
		});
    </script>

</asp:Content>
