<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta charset="utf-8" />
	<title>
<% int syskind = int.Parse(ConfigurationManager.AppSettings["SystemKind"].ToString()); %>
    <% if (syskind == 1) {  //中国移动 %>
        中国移动-营业厅手机展示系统
        <% }
       else if (syskind == 2)   //联通
       { %>
        中国联通-营业厅手机展示系统
    <% }
       else if (syskind == 3)   //电信
       { %>
        中国电信-营业厅手机展示系统
    <% } %>
    </title>

	<meta name="description" content="User login page" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

	<!-- bootstrap & fontawesome -->
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>content/css/bootstrap.min.css" />
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>content/css/font-awesome.min.css" />

	<!-- ace styles -->
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>content/css/ace.min.css" />

	<!--[if lte IE 9]>
		<link rel="stylesheet" href="<%= ViewData["rootUri"] %>content/css/ace-part2.min.css" />
	<![endif]-->
	<link rel="stylesheet" href="<%= ViewData["rootUri"] %>content/css/ace-rtl.min.css" />

	<!--[if lte IE 9]>
		<link rel="stylesheet" href="<%= ViewData["rootUri"] %>content/css/ace-ie.min.css" />
	<![endif]-->

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

	<!--[if lt IE 9]>
	<script src="<%= ViewData["rootUri"] %>content/js/html5shiv.js"></script>
	<script src="<%= ViewData["rootUri"] %>content/js/respond.min.js"></script>
	<![endif]-->
</head>

	<body class="login-layout blur-login">
		<div class="main-container">
			<div class="main-content">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1">
						<div class="login-container">
							<div class="center">
                                <% 
                                    string llogourl = "";
                                    if (syskind == 1) {  //中国移动
                                        llogourl = "content/img/logobig.jpg";
                                    }
                                    else if (syskind == 2)   //联通
                                    { 
                                        llogourl = "content/img/logobig_lt.png";
                                    }
                                    else if (syskind == 3)   //电信
                                    { 
                                        llogourl = "content/img/logobig_dx.jpg";
                                    } 
                                %>
                                <img src="<%= ViewData["rootUri"] %><%= llogourl %>" style="max-height:130px;" />
								<h1>
									<span class="red">
                                    <% if (syskind == 1) {  //中国移动 %>
                                        中国移动
                                        <% }
                                       else if (syskind == 2)   //联通
                                       { %>
                                        中国联通
                                    <% }
                                       else if (syskind == 3)   //电信
                                       { %>
                                        中国电信
                                    <% } %>
                                    </span>
								</h1>
									<span class="grey" id="id-text2">营业厅手机展示系统</span>
							</div>

							<div class="space-6"></div>

							<div class="position-relative">
								<div id="login-box" class="login-box visible widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header blue lighter bigger">
												<i class="ace-icon fa fa-smile-o green"></i>
												欢迎来营业厅手机展示系统!
											</h4>

											<div class="space-6"></div>

											<form id="formlogon" autocomplete="off" method="post" action="<%= ViewData["rootUri"] %>Account/LogOn">
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" placeholder="用户名" id="username" name="username" />
															<i class="ace-icon fa fa-user"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" class="form-control" placeholder="密码" id="userpwd" name="userpwd" />
															<i class="ace-icon fa fa-lock"></i>
														</span>
													</label>

													<div class="space"></div>

													<div class="clearfix">
														<label class="inline">
															<input type="checkbox" class="ace" />
															<span class="lbl"> 记住账号</span>
														</label>

														<button type="submit" class="width-35 pull-right btn btn-sm btn-primary">
															<i class="ace-icon fa fa-key"></i>
															<span class="bigger-110">登录</span>
														</button>
													</div>

													<div class="space-4"></div>
												</fieldset>
											</form>

                                            <% if (!ViewData.ModelState.IsValid) { %>
			                                <div class="alert alert-danger aler-dismissable">
				                                <button class="close" data-dismiss="alert"></button>
				                                <span><%= Html.ValidationMessage("modelerror")%></span>
			                                </div>
                                            <% } %>
										</div><!-- /.widget-main -->

									</div><!-- /.widget-body -->
								</div><!-- /.login-box -->

							</div><!-- /.position-relative -->
						</div>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.main-content -->
		</div><!-- /.main-container -->

		<!-- basic scripts -->

		<!--[if !IE]> -->
		<script src="<%= ViewData["rootUri"] %>content/js/jquery.min.js"></script>

		<!-- <![endif]-->

		<!--[if IE]>
<script src="<%= ViewData["rootUri"] %>content/js/jquery.minie.js"></script>
<![endif]-->

		<!--[if !IE]> -->
		<script type="text/javascript">
		    window.jQuery || document.write("<script src='<%= ViewData["rootUri"] %>content/js/jquery.min.js'>" + "<" + "/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='<%= ViewData["rootUri"] %>content/js/jquery1x.min.js'>"+"<"+"/script>");
</script>
<![endif]-->
		<script type="text/javascript">
		    if ('ontouchstart' in document.documentElement) document.write("<script src='<%= ViewData["rootUri"] %>content/js/jquery.mobile.custom.min.js'>" + "<" + "/script>");
		</script>

		<!-- inline scripts related to this page -->
		<script type="text/javascript">
		    jQuery(function ($) {
		    });
		</script>
	</body>

</html>
