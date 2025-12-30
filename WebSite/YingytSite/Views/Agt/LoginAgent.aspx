<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>登录中,请稍等。。。</title>
	<link rel="shortcut icon" href="<%= ViewData["rootUri"] %>Content/icon/favicon.ico" />
</head>
<body>
    <form id="formlogin" method="post" action="<%= ViewData["loginurl"] %>">
		<input type="hidden" name="username" id="username" value="<%= ViewData["username"] %>" />
		<input type="hidden" name="userpwd" id="userpwd" value="<%= ViewData["password"] %>" />
    </form>
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

    <script type="text/javascript">
        jQuery(document).ready(function () {
            $("#formlogin").submit();
        });
    </script>
</body>
</html>
