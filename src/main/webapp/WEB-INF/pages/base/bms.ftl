<#import "/base/base.ftl" as base>
<#import "/base/layout.ftl" as layout>

<#macro bmsheadcontent>
    <#assign bms_head_content>
        <#nested/>
    </#assign>
</#macro>
<#macro bmsheadjscontent>
    <#assign bms_head_js_content>
        <#nested/>
    </#assign>
</#macro>

<#macro bmsjscontent>
    <#assign bms_js_content>
        <#nested/>
    </#assign>
</#macro>

<#macro bmshtml bmsModel title>

<@base.headcontent>
	<!--icheck-->
	<link href="${ctx}/static/css/public/back.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/css/public/pace.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/css/public/common.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/js/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/js/assets/css/style.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/js/assets/css/style-responsive.css" rel="stylesheet" type="text/css"/>
	<link rel="shortcut icon" href="${ctx}/static/js/assets/img/favicon.ico"/>

	${bms_head_content!""}
</@base.headcontent>

<@base.headjscontent>
	${bms_head_js_content!""}
</@base.headjscontent>

<@base.jscontent>
	<script src="${ctx}/static/js/assets/plugins/respond.min.js"></script>
	<script src="${ctx}/static/js/assets/plugins/excanvas.min.js"></script>
	<script src="${ctx}/static/js/assets/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/assets/plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/assets/plugins/bootstrap-hover-dropdown/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/assets/plugins/jquery.blockui.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/assets/plugins/jquery.cokie.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/assets/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/js/assets/plugins/jquery-validation/dist/jquery.validate.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctx}/static/js/assets/plugins/select2/select2.min.js"></script>
	<script src="${ctx}/static/js/assets/scripts/app.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctx}/static/js/app/js/index.js"></script>

	${bms_js_content!""}
</@base.jscontent>

<@base.html title "page-header-fixed">
<script type="text/javascript">
    $(document).ready(function () {
        $("#clickUser").click(function () {

                 if($(".userDetails").css("display")=="block")
                 {
                     $(".userDetails").slideUp();
                 }
                 else
                 {
                     $(".userDetails").slideDown();
                     $(".messageShow").slideUp();
                 }
        })
        $("#clickMessage").click(function () {

            if($(".messageShow").css("display")=="block")
            {
                $(".messageShow").slideUp();
            }
            else
            {
                $(".messageShow").slideDown();
                $(".userDetails").slideUp();
            }
        })
        $("#menuClick").click(function () {
            $("#menuShow").css({"display":"none"});
        })

    })
</script>
<!--顶部导航栏     开始 -->
<header class="header navbar navbar-fixed-top" role="banner">
    <div class="container">

        <a class="navbar-brand" href="#">
            <strong>管理后台</strong>
            <i class="fa fa-bars" id="menuClick"></i>
        </a>
        <ul class="nav navbar-right" style="height:50px;">
            <li class="dropdown user" style="height:48px;" >
                <a class="dropdown-toggle" data-toggle="dropdown" id="clickUser">
                    <i class="fa fa-user"></i>
                        <span class="username">用戶中心</span>
                    <i class="icon-caret-down small"></i>
                </a>
                <ul class="dropdown-menu userDetails">
                    <li>
                        <a class="dlg-user-edit-info">
                            <i class="icon-user"></i> 基本资料
                        </a>
                    </li>
                    <li>
                        <a class="dlg-user-edit-pwd">
                            <i class="icon-pencil"></i> 修改密码
                        </a>
                    </li>
                    <li>
                        <a>
                            <i class="icon-tasks"></i> 任务列表
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="${ctx}/logout">
                            <i class="icon-key"></i> 退出
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
        <ul class="nav navbar-right"  style="height:50px;">
            <li class="dropdown user" style="height:48px;" >
                <a class="dropdown-toggle" data-toggle="dropdown"  id="clickMessage">
                    <i class="fa fa-bell"></i>
                    <span class="username">消息中心</span>
                    <i class="icon-caret-down small"></i>
                </a>
            </li>
            <ul class="dropdown-menu messageShow" style="margin-top: 2px!important;position: absolute!important;	float: left!important;	background-color: #fff!important;
                border: 1px solid #ccc!important;
                border: 1px solid rgba(0, 0, 0, 0.15)!important;
                -webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175)!important;
                -moz-box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175)!important;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175)!important;
                right: 100px;
                left: auto;
                display: none;">
                <li>
                    <a class="dlg-user-edit-info">
                        <i class="icon-user"></i> 新的订单
                    </a>
                </li>
                <li>
                    <a class="dlg-user-edit-pwd">
                        <i class="icon-pencil"></i> 订单反馈
                    </a>
                </li>

            </ul>
        </ul>
    </div>
</header>
	<div class="clearfix">
	</div>
	<div class="page-container">
		<div class="page-sidebar-wrapper" id="menuShow">
			<div class="page-sidebar navbar-collapse collapse" style="border-right:1px solid #eee; " >
				<ul class="page-sidebar-menu" id="page-sidebar-menu">
					<li class="sidebar-toggler-wrapper">
						<div class="sidebar-toggler hidden-phone">
						</div>
					</li>
					<li class="start active" style="border-bottom: 1px solid #eee;">
						<a href="javascript:;"  >
							<i class="fa fa-home"></i><span class="title"> 首页 </span><span class="selected"></span>
						</a>
					</li>
					<#if bmsModel.user.hasRole("SUPER_ADMIN") ||bmsModel.user.hasRole("ADMIN")||bmsModel.user.hasRole("COMMISSIONER")>
					<li class="current" style="border-bottom: 1px solid #eee;">
						<a href="javascript:;">
							<i class="fa fa-star-o"></i><span class="title"> 优化管理 </span><span class="arrow "></span>
						</a>
						<ul class="sub-menu" style="background: #eee;">
                            <li>
                                <a href="${ctx}/bill/list?way=2">
                                    关键词排名
                                </a>
                            </li>

						<#if bmsModel.user.hasRole("SUPER_ADMIN") ||bmsModel.user.hasRole("COMMISSIONER")>
     				  		 <li>
                                <a href="${ctx}/bill/billOptimization">
                                    关键词优化
                                </a>
                            </li>
						</#if>
							<#if bmsModel.user.hasRole("SUPER_ADMIN") ||bmsModel.user.hasRole("ADMIN")>
                                <li>
                                    <a href="${ctx}/bill/pendingAudit">
                                        待审核订单
                                    </a>
                                </li>
							</#if>
						</ul>
						</li>
					</#if>
					<#if bmsModel.user.hasRole("DISTRIBUTOR")>
                        <li class="" style="border-bottom: 1px solid #eee;">
                            <a href="javascript:;">
                                <i class="fa fa-star-o"></i><span class="title"> 优化方管理 </span><span class="arrow "></span>
                            </a>
                            <ul class="sub-menu" style="background: #eee;">
                                <li>
                                    <a href="${ctx}/bill/list?way=1">
                                        关键词排名
                                    </a>
                                </li>
                            </ul>
                        </li>
					</#if>
					<#if bmsModel.user.hasRole("DISTRIBUTOR")>
                    <li class="" style="border-bottom: 1px solid #eee;">
                        <a href="javascript:;">
                            <i class="fa fa-star-o"></i><span class="title"> 代理商管理 </span><span class="arrow "></span>
                        </a>
                        <ul class="sub-menu" style="background: #eee;">
                            <li>
                                <a href="${ctx}/bill/list?way=2">
                                    关键词排名
                                </a>
                            </li>
                            <li>
                                <a href="${ctx}/bill/pendingAudit">
                                    订单审核
                                </a>
                            </li>
                        </ul>
                    </li>
				</#if>
					<#if bmsModel.user.hasRole("DISTRIBUTOR")>
                        <li class="" style="border-bottom: 1px solid #eee;">
                            <a href="javascript:;">
                                <i class="fa fa-star-o"></i><span class="title"> 客户管理 </span><span class="arrow "></span>
                            </a>
                            <ul class="sub-menu" style="background: #eee;">
                                <li>
                                    <a href="${ctx}/bill/billCustomer">
                                        关键词排名
                                    </a>
                                </li>
                                <li>
                                    <a href="${ctx}/bill/pendingAuditView">
                                        待审核订单
                                    </a>
                                </li>
                            </ul>
                        </li>
					</#if>
					<#if bmsModel.user.hasRole("AGENT")>
                        <li class="" style="border-bottom: 1px solid #eee;">
                            <a href="javascript:;">
                                <i class="fa fa-star-o"></i><span class="title"> 渠道商管理 </span><span class="arrow "></span>
                            </a>
                            <ul class="sub-menu" style="background: #eee;">
                                <li>
                                    <a href="${ctx}/bill/list?way=1">
                                        关键词排名
                                    </a>
                                </li>
                            </ul>
                        </li>
					</#if>
					<#if bmsModel.user.hasRole("AGENT")>
                        <li class="" style="border-bottom: 1px solid #eee;">
                            <a href="javascript:;">
                                <i class="fa fa-star-o"></i><span class="title"> 客户管理 </span><span class="arrow "></span>
                            </a>
                            <ul class="sub-menu" style="background: #eee;">
                                <li>
                                    <a href="${ctx}/bill/billCustomer">
                                        关键词排名
                                    </a>
                                </li>
                                <li>
                                    <a href="${ctx}/bill/pendingAuditView">
                                        待审核订单
                                    </a>
                                </li>
                            </ul>
                        </li>
					</#if>
					<#if bmsModel.user.hasRole("CUSTOMER")>
                        <li class="" style="border-bottom: 1px solid #eee;">
                            <a href="javascript:;">
                                <i class="fa fa-star-o"></i><span class="title"> 优化管理 </span><span class="arrow "></span>
                            </a>
                            <ul class="sub-menu"  style="background: #eee;">
                                <li>
                                    <a href="${ctx}/bill/list?way=1">
                                        关键词排名
                                    </a>
                                </li>
                            </ul>
                        </li>
					</#if>

					<#if bmsModel.user.hasRole("SUPER_ADMIN") >
					<li class="" style="border-bottom: 1px solid #eee;">
						<a href="javascript:;">
							<i class="fa fa-paperclip"></i><span class="title"> 操作员管理 </span><span class="arrow "></span>
						</a>
						<ul class="sub-menu"  style="background: #eee;">
							<li>
								<a href="${ctx}/operator/list">
									操作员列表
								</a>
							</li>

						</ul>
					</li>
		    		</#if>

		<#if bmsModel.user.hasRole("SUPER_ADMIN")||bmsModel.user.hasRole("COMMISSIONER")||bmsModel.user.hasRole("DISTRIBUTOR")||bmsModel.user.hasRole("AGENT")>
       			 <li class="" style="border-bottom: 1px solid #eee;">
						<a href="javascript:;">
							<i class="fa fa-magic"></i><span class="title"> 资金管理 </span><span class="arrow "></span>
						</a>
						<ul class="sub-menu"  style="background: #eee;">
							<li>
                                <a href="${ctx}/customer/customerList">
									客户列表
								</a>
							</li>
							<li>
                                <a href="${ctx}/customer/fundAccount">
									资金明细
								</a>
							</li>
						<#if bmsModel.user.hasRole("SUPER_ADMIN")>
                            <li>
                                <a href="${ctx}/customer/customerReviewList">
                                    客户审核
                                </a>
                            </li>
  						</#if>
						</ul>
					</li>
			</#if>
				<#if bmsModel.user.hasRole("COMMISSIONER") >
                    <li class="" style="border-bottom: 1px solid #eee;">
                        <a href="javascript:;">
                            <i class="fa fa-line-chart"></i><span class="title"> 业绩管理 </span><span class="arrow "></span>
                        </a>
                        <ul class="sub-menu"  style="background: #eee;">
                            <li>
                                <a href="${ctx}/achievement/achievementList">
                                    业绩详情
                                </a>
                            </li>

                        </ul>
                    </li>
                 </#if>
					<li class="" style="border-bottom: 1px solid #eee;">
						<a href="javascript:;">
							<i class="fa fa-magnet"></i><span class="title"> 个人中心 </span><span class="arrow "></span>
						</a>
						<ul class="sub-menu"  style="background: #eee;">
							<li>
								<a href="javascript:;">
									信息修改
								</a>
							</li>
							<li>
								<a href="javascript:;">
									密码修改
								</a>
							</li>

						</ul>
					</li>
				</ul>
			</div>
		</div>
		<div class="page-content-wrapper">
			<div class="page-content">
				<#nested />
			</div>
		</div>
	</div>
	<div class="footer">
		<div class="footer-inner">
			2017 &copy; 鱼在我这里。
		</div>
		<div class="footer-tools">
			<span class="go-top"><i class="fa fa-angle-up"></i></span>
		</div>
	</div>
</@base.html>

</#macro>


