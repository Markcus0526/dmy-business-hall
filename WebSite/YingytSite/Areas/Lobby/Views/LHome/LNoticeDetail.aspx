<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Lobby/Lobby.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<% var noticeinfo = (tbl_sysnew)ViewData["noticeinfo"]; %>
<div class="page-header">
	<h1>
		<%= noticeinfo.title %>
	</h1>
</div>
<div class="row">
	<div class="col-xs-12">
        <div>
        <script type="text/javascript">
            document.write(unescape("<%= noticeinfo.contents %>"));
        </script>
        </div>
    </div>
</div><!-- #dialog-specdata -->

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageStyle" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">
</asp:Content>