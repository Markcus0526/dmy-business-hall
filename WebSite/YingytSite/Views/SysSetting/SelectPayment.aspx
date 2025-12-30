<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="YingytSite.Models.Library" %>
<%@ Import Namespace="YingytSite.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header">
	<h1>
        选择支付方式
	</h1>
</div>

<div class="row">
	<div class="col-xs-12">
        <form action="#" id="form_agent" role="form" class="form-horizontal form-validate">
	        <div class="form-body">
		        <div class="form-group">
                    <table style="width:100%">
        <!--                     <tr> -->
        <!--                         <td style="padding: 0px 5px;"><img style="border:1px solid #eee; padding:2px" src="<%= ViewData["rootUri"] %>content/img/payment/weixin.png" /></td> -->
        <!--                         <td>微信支付</td> -->
        <!--                         <td> -->
        <!--                             微支付，支付就这么简单。 -->
        <!--                             <span style="color:red">微支付申请请进入您的微信公众平台，点击服务→服务中心→商户功能申请栏目</span> -->
        <!--                             <a href="#" style="color:blue" target="_blank">查看帮助</a> -->
        <!--                         </td> -->
        <!--                         <td> -->
        <!--                             <a href="http://localhost:41958/Merchants/AddPayment?paymode=<%= PAYMODE.WEIXIN %>" class="btn default btn-sm">添加支付</a> -->
        <!--                         </td> -->
        <!--                     </tr> -->
        <!--                     <tr> -->
        <!--                         <td style="padding-bottom:20px"></td> -->
        <!--                     </tr> -->
                        <tr>
                            <td style="padding: 0px 5px;"><img style="border:1px solid #eee; padding:2px" src="<%= ViewData["rootUri"] %>content/img/payment/alipay_direct_icon.gif" /></td>
                            <td>支付宝即时到账交易（手机网站支付）</td>
                            <td>
                                中国领先的在线支付平台，致力于为互联网用户和企业提供安全、便捷、专业的在线支付服务。
                                <a href="https://b.alipay.com/order/productDetail.htm?productId=2013080604609688" style="color:red" target="_blank">
							        <span class="red">立即申请</span>
						        </a>
                                <a href="http://stc.weimob.com/file/alipay.doc" style="color:red" target="_blank">
							        <span class="red">申请步骤</span>
						        </a>
                            </td>
                            <td>
                                <a href="<%= ViewData["rootUri"] %>SysSetting/AddPayment?paymode=<%= PAYMODE.ALIPAY %>" class="btn default btn-sm">添加支付</a>
                            </td>
                        </tr>
                    </table>
		        </div>
	        </div>
        </form>
    </div>
</div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageStyle" runat="server">

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="server">

	<script>
	    jQuery(document).ready(function () {
	    });

    </script>
</asp:Content>
