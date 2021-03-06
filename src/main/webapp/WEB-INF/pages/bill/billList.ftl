<#import "/base/base.ftl" as base>
<#import "/base/dict.ftl" as dict>

<@base.html "关键词优化">
<link href="${ctx}/static/css/public/bootstrap.min.css" rel="stylesheet">
<link href="${ctx}/static/css/public/bootstrap-table.css" rel="stylesheet">
<script src="${ctx}/static/js/public/jquery.js"></script>
<script src="${ctx}/static/js/public/bootstrap.min.js"></script>
<script src="${ctx}/static/js/public/bootstrap-table.js"></script>
<script src="${ctx}/static/js/public/bootstrap-table-zh-CN.js"></script>
<link href="${ctx}/static/css/bill/KeyWordsRanking.css" rel="stylesheet">
<script src="${ctx}/static/js/public/pace.js"></script>
<script src="${ctx}/static/js/bill/billList.js"></script>
<script src="${ctx}/static/js/bill/billListchangePrice.js"></script>
<script src="${ctx}/static/js/bill/billListsamePrice.js"></script>
<div class="Navs">
    <div class="nav_L left">
        <i class="fa fa-home">&nbsp;</i><span>优化管理</span> > <span>关键词排名</span>
    </div>
    <div class="nav_R right" id="divQx">

       <#if  bmsModel.user.hasRole("SUPER_ADMIN")||bmsModel.user.hasRole("ADMIN")||bmsModel.user.hasRole("COMMISSIONER")> <#--如果是优化方-->
        <div id="optimizationStart">
            <span>&nbsp;<i class="fa fa-play"></i>&nbsp;优化启动</span>
        </div>
        <div id="optimizationStop">
            <span>&nbsp;<i class="fa fa-stop"></i>&nbsp;合作停止</span>
        </div>
        <div id="billDelete">
            <span>&nbsp;<i class="fa fa-trash"></i>&nbsp;删除</span>
        </div>
           <div id="updatePrice">
               <span>&nbsp;<i class="fa fa-cny"></i>&nbsp;调价</span>
           </div>
       </#if>
        <#if  bmsModel.user.hasRole("DISTRIBUTOR")||bmsModel.user.hasRole("AGENT")>
            <div id="applyStopBill">
                <span>&nbsp;<i class="fa fa-trash"></i>&nbsp;申请停单</span>
            </div>
        </#if>
        <div class="search">
            <span>&nbsp;<i class="fa fa-search"></i>&nbsp;查询</span>
        </div>

    </div>
    <div class="cls">
    </div>
</div>
<div class="Navs2">
    <div class="nav_R2 right col-md-11" >
        <input type="hidden" name="type" value="${way}" id="way">
        <div>
            网址:
        </div>
        <input id="website" name="userName" class="form-control" value="" style="width: 150px;" type="text">
        <div>
            关键词:
        </div>
        <input id="keywords" name="keywords" class="form-control" value="" style="width: 150px;" type="text">
        <span style="font-size:13px;text-align:center;cursor:pointer;font-weight:bold;margin-left: 10px;">
        搜索引擎:
        </span>
        <select style="height: 35px;border: 1px solid #aaaaaa;" id="searchName">
                <@dict.showOptions dictKey="search" dictType="DICT" haveBlank="Y" />
        </select>
        <#if  bmsModel.user.hasRole("SUPER_ADMIN")||bmsModel.user.hasRole("ADMIN")||bmsModel.user.hasRole("COMMISSIONER")||bmsModel.user.hasRole("DISTRIBUTOR")||bmsModel.user.hasRole("AGENT")>
           <span style="font-size:13px;text-align:center;cursor:pointer;font-weight:bold;margin-left: 10px;">
        客户:
        </span>

           <select style="height: 35px;border: 1px solid #aaaaaa;" id="searchUserName">
               <option>--请选择--</option>
               <#list userList as user>
                   <option value="${user.id}">${user.userName}</option>
               </#list>
           </select>
    </#if>
        <span style="font-size:13px;text-align:center;cursor:pointer;font-weight:bold;margin-left: 10px;">
            今日达标:
        </span>
        <select style="height: 35px;border: 1px solid #aaaaaa;" id="searchStandard">
            <option>--请选择--</option>
            <option value="1">是</option>
            <option value="0">否</option>
        </select>
        <span style="font-size:13px;text-align:center;cursor:pointer;font-weight:bold;margin-left: 10px;" id="state">
            状态:
        </span>
        <select style="height: 35px;border: none;border: 1px solid #aaaaaa;"  id="searchState">
            <option  value="1">--请选择--</option>
            <option value="2">优化中</option>
            <option value="3">合作停</option>
        </select>
         <input type="hidden" value="2" id="searchStatechange">
        <span id="searchButton">查询</span>



    </div>
    <div class="cls">
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-primary" id="list-panel">
            <div class="panel-body">
                <div class="panel-nav">
                    <div class="Nav_Left">&nbsp;<i class="fa fa-paper-plane"></i>&nbsp;关键词排名</div>
                    <div class="Nav_Right">
                        <div id="continue">优化中</div>
                        <div id="stop">合作停</div>
                        <div id="all">全部</div>


                    </div>
                    <div class="cls"></div>
                </div>
                <table id="myTable" class="table table-striped  table-condensed table-responsive" style="width:100%;font-size: 13px;font-family: "微软雅黑">
                </table>
            </div>

        </div>
    </div>
</div>



<!--调价-->
<div class="bootbox modal in changepriceDiv" tabindex="-1" role="dialog" style="display: none;" aria-hidden="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="bootbox-close-button close">×</button>
                <h4 class="modal-title">调价</h4>
            </div>
            <div class="modal-body" style="max-height: 374px;">
                <div class="bootbox-body">
                    <style type="text/css">
                        .modal-dialog {
                            width: 400px;
                        }
                    </style>
                    <form class="form-horizontal row-border" id="edt-form" action="#" novalidate="novalidate">
                        <div class="form-group">
                            <table class="table table-striped table-bordered">
                                <tbody>
                                <tr>
                                    <th>
                                        前<span class="red">N</span>名
                                    </th>
                                    <th>
                                        收费<span class="red">(元/天)</span>
                                    </th>
                                </tr>
                                <tr>
                                    <td>
                                        <input name="changerankend" class="form-control input-width-small" type="text">
                                    </td>
                                    <td>
                                        <input name="changeprice" class="form-control input-width-small" type="text">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input name="changerankend1" class="form-control input-width-small" type="text">
                                    </td>
                                    <td>
                                        <input name="changeprice1" class="form-control input-width-small" type="text">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input name="changerankend2" class="form-control input-width-small" type="text">
                                    </td>
                                    <td>
                                        <input name="changeprice2" class="form-control input-width-small" type="text">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input name="changerankend3" class="form-control input-width-small" type="text">
                                    </td>
                                    <td>
                                        <input name="changeprice3" class="form-control input-width-small" type="text">
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <input name="tids" value="" type="hidden">
                        <input name="op" value="cp" type="hidden">
                    </form>

                </div>
            </div>
            <div class="modal-footer">
                <button data-bb-handler="success" type="button" class="btn wzgj-blue changeprice">确定</button>
                <button data-bb-handler="cancel" type="button" class="btn wzgj-btn cancel">取消</button>
            </div>
        </div>
    </div>
</div>
<!--调价end-->
<!--详情-->

    <div class="modal-backdrop in" style="display: none">
    </div>
    <div class="bootbox modal in" tabindex="-1" role="dialog" style="display: none;" aria-hidden="false" id="billCostDetail">
        <div class="modal-dialog listdetails">
            <div class="modal-content">
                <div class="modal-body" style="max-height: 374px;">
                    <button type="button" class="bootbox-close-button close" style="margin-top: -10px;">×</button>
                    <div class="bootbox-body">
                        <style type="text/css">
                            .listdetails {
                                width: 800px;
                            }
                        </style>
                        <div class="row" style="margin-top: -5px;">
                            <div class="col-md-12">
                                <label>价格配置</label>
                                    <table class="table table-hover table-striped table-bordered" >
                                        <thead>
                                        <tr>
                                            <th style="width: 100px;">达标位置
                                            </th>
                                            <th>收费标准<span>(元/天)</span>
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody id="detailTable">


                                        </tbody>
                                    </table>

                                <label>任务消费记录</label>
                                <div class="widget box">
                                    <div class="widget-header">

                                    </div>
                                    <div class="widget-content">
                                        <table id="pricetable"  class="table table-striped  table-condensed table-responsive" >
                                        </table>
                                        <div class="row">
                                            <div class="table-footer">
                                                <div class="col-md-6">
                                                    <div class="dataTables_paginate paging_bootstrap" style="float:left;">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="dataTables_paginate paging_bootstrap">

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input name="Bid" value="" type="hidden">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button data-bb-handler="cancel" type="button" class="btn wzgj-blue cancel">关闭</button>
                </div>
            </div>
        </div>
    </div>
<div class="pload" style="position:absolute;top:45%;left: 50%; z-index:2200;background:url('${ctx}/static/img/load3.gif') top center no-repeat;width:40px;height:40px;margin:auto auto;display: none;"></div>
    <#if  bmsModel.user.hasRole("SUPER_ADMIN")>
<form id= "uploadForm" enctype="multipart/form-data">
    <p >上传文件： <input type="file" name="file"/></ p>
    <input type="button" value="上传" onclick="doUpload()" />
</form>
<script>
    function doUpload() {
        var formData = new FormData($( "#uploadForm" )[0]);
        $.ajax({
            url:CTX+ '/order/uploadPrice' ,
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            beforeSend: function () {
                $(".pload").show();

                $(".modal-backdrop").show();
            },
            success: function (result) {
                $(".pload").hide();
                $(".modal-backdrop").hide();
                alert(result.message);

            }
        });
    }
</script>
</#if>
<!--详情end-->
</@base.html>