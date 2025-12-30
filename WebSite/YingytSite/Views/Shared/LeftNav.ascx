<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<ul class="nav nav-list">
	<li class="<% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "Home") { %>active <% } %>">
		<a href="<%= ViewData["rootUri"] %>">
			<i class="menu-icon fa fa-tachometer"></i>
			<span class="menu-text"> 首页 </span>
		</a>

		<b class="arrow"></b>
	</li>

    <% 
        if (ViewData["userrole"] != null && ((string)ViewData["userrole"]).Contains("Agent"))
        {
        %>
	<li class="<% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "Agent") { %>active open hsub <% } %>">
		<a href="#" class="dropdown-toggle">
			<i class="menu-icon fa fa-credit-card"></i>
			<span class="menu-text"> 代理管理 </span>

			<b class="arrow fa fa-angle-down"></b>
		</a>

		<b class="arrow"></b>

		<ul class="submenu">
			<li class="<% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "AgentList") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>Agt/AgentList">
					<i class="menu-icon fa fa-caret-right"></i>
					城市代理列表
				</a>

				<b class="arrow"></b>
			</li>
		</ul>
	</li>
    <%
        }
        %>
    <% 
        if (ViewData["userrole"] != null && ((string)ViewData["userrole"]).Contains("Lobby"))
        {
        %>
	<li class="<% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "Hall") { %>active open hsub <% } %>">
		<a href="#" class="dropdown-toggle">
			<i class="menu-icon fa fa-credit-card"></i>
			<span class="menu-text"> 营业厅管理 </span>

			<b class="arrow fa fa-angle-down"></b>
		</a>

		<b class="arrow"></b>

		<ul class="submenu">
			<li class="<% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "HallList") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>Hall/HallList">
					<i class="menu-icon fa fa-caret-right"></i>
					营业厅列表
				</a>

				<b class="arrow"></b>
			</li>
		</ul>
	</li>
    
    <%
        }
        %>
    <% 
        if (ViewData["userrole"] != null && ((string)ViewData["userrole"]).Contains("User"))
        {
        %>
	<li class="<% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "User") { %>active open hsub <% } %>">
		<a href="#" class="dropdown-toggle">
			<i class="menu-icon fa fa-user"></i>
			<span class="menu-text"> 管理员 </span>
			<b class="arrow fa fa-angle-down"></b>
		</a>

		<b class="arrow"></b>

		<ul class="submenu">
			<li class="<% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "UserList") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>User/Userlist">
					<i class="menu-icon fa fa-caret-right"></i>
					管理员列表
				</a>

				<b class="arrow"></b>
			</li>
<!-- 			<li class="<% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "UserLog") { %>active <% } %>"> -->
<!-- 				<a href="tables.html"> -->
<!-- 					<i class="menu-icon fa fa-caret-right"></i> -->
<!-- 					操作日志 -->
<!-- 				</a> -->
<!--  -->
<!-- 				<b class="arrow"></b> -->
<!-- 			</li> -->
			<li class="<% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "RoleList") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>User/RoleList">
					<i class="menu-icon fa fa-caret-right"></i>
					角色管理
				</a>

				<b class="arrow"></b>
			</li>
		</ul>
	</li>
    
    <%
        }
        %>
    <% 
        if (ViewData["userrole"] != null && ((string)ViewData["userrole"]).Contains("SysNotice"))
        {
        %>
	<li class="<% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "System") { %>active open hsub <% } %>">
		<a href="#" class="dropdown-toggle">
			<i class="menu-icon fa fa-gears"></i>
			<span class="menu-text"> 系统设置 </span>

			<b class="arrow fa fa-angle-down"></b>
		</a>

		<b class="arrow"></b>

		<ul class="submenu">
            <li class="<% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "SysNoticeList") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>System/SysNoticeList">
					<i class="menu-icon fa fa-caret-right"></i>
					系统通知
				</a>

				<b class="arrow"></b>
			</li>
		</ul>
	</li>    
    <%
        }
        %>
</ul>