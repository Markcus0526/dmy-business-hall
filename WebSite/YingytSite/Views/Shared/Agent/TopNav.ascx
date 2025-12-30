<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<ul class="nav nav-list">
	<li class="hover <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "Home") { %>active <% } %>">
		<a href="<%= ViewData["rootUri"] %>Agent/AHome/AgentHome">
			<i class="menu-icon fa fa-home"></i>
			<span class="menu-text"> 首页 </span>
		</a>
		<b class="arrow"></b>
	</li>

	<li class="hover <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "Hall") { %>active <% } %>">
		<a href="<%= ViewData["rootUri"] %>Agent/AHall/AHallList">
			<i class="menu-icon fa fa-sitemap"></i>
			<span class="menu-text"> 营业厅 </span>
		</a>

		<b class="arrow"></b>
	</li>
	<li class="hover <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "Market") { %>active open <% } %>">
		<a href="#" class="dropdown-toggle">
			<i class="menu-icon fa fa-list"></i>
			<span class="menu-text"> 营销管理 </span>

			<b class="arrow fa fa-angle-down"></b>
		</a>
		<b class="arrow"></b>
		<ul class="submenu">
			<li class="hover <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "VideoList") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>Agent/AMarket/AVideoList">
					<i class="menu-icon fa fa-video-camera"></i>
					演示视频
				</a>

				<b class="arrow"></b>
			</li>

			<li class="hover <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "SplashList") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>Agent/AMarket/ASplashList">
					<i class="menu-icon fa fa-caret-right"></i><i class="menu-icon fa fa-photo"></i>
					SPLASH广告图片
				</a>

				<b class="arrow"></b>
			</li>
			<li class="hover <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "HomeImgList") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>Agent/AMarket/AHomeImgList">
					<i class="menu-icon fa fa-home"></i>
					首页图片
				</a>
				<b class="arrow"></b>
			</li>
			<li class="hover <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "BrightSpotList") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>Agent/AMarket/ABrightSpotList">
					<i class="menu-icon fa fa-lightbulb-o"></i>
					手机亮点
				</a>
				<b class="arrow"></b>
			</li>
			<li class="hover <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "BuySetList") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>Agent/AMarket/ABuySetList">
					<i class="menu-icon fa fa-tasks"></i>
					购机套餐
				</a>
				<b class="arrow"></b>
			</li>
		</ul>
	</li>

	<li class="hover <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "BriefCase") { %>active open  <% } %>">
		<a href="#" class="dropdown-toggle">
			<i class="menu-icon fa fa-briefcase"></i>
			<span class="menu-text">  我的公文包
				<span class="badge badge-transparent tooltip-error" title="有两个新型手机">
					<i class="ace-icon fa fa-exclamation-triangle red bigger-130"></i>
				</span>
            </span>

			<b class="arrow fa fa-angle-down"></b>
		</a>

		<b class="arrow"></b>

		<ul class="submenu">
			<li class="hover <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "PhoneList") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>Agent/ABrief/APhoneList">
					<i class="menu-icon fa fa-android"></i>
					智能手机库
				</a>
                <b class="arrow"></b>
			</li>
			<li class="hover <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "MyVideoList") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>Agent/ABrief/AVideoList">
					<i class="menu-icon fa fa-video-camera"></i>
					视频库
				</a>
                <b class="arrow"></b>
			</li>
			<li class="hover <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "ImageList") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>Agent/ABrief/AImageList">
					<i class="menu-icon fa fa-file-image-o"></i>
					图片库
				</a>
                <b class="arrow"></b>
			</li>
		</ul>
	</li>

	<li class="hover <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "System") { %>active open  <% } %>">
		<a href="#" class="dropdown-toggle">
			<i class="menu-icon fa fa-cog"></i>
			<span class="menu-text"> 系统设置</span>

			<b class="arrow fa fa-angle-down"></b>
		</a>

		<b class="arrow"></b>

		<ul class="submenu">
			<li class="hover <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "Profile") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>Agent/ASystem/Profile">
					<i class="menu-icon fa fa-user"></i>
					个人信息
				</a>

				<b class="arrow"></b>
			</li>
			<li class="hover <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "NoticeList") { %>active <% } %>">
				<a href="<%= ViewData["rootUri"] %>Agent/ASystem/NoticeList">
					<i class="menu-icon fa fa-envelope"></i>
					营业厅通知
				</a>

				<b class="arrow"></b>
			</li>
		</ul>
	</li>

	<li class="hover <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "Statistics") { %>active <% } %>">
		<a href="<%= ViewData["rootUri"] %>Agent/AStatistics/AStatistics">
			<i class="menu-icon fa fa-bar-chart-o"></i>
			<span class="menu-text"> 统计 </span>
		</a>

		<b class="arrow"></b>
	</li>
</ul><!-- /.nav-list -->
