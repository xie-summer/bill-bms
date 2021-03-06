
/**
 * Created by Administrator on 2017/3/16.
 */

$(".close").click(function () {
    $(".addOperatorDiv").slideUp();
    $(".modal-backdrop").hide();

})
$(".cancel").click(function () {
    $(".addOperatorDiv").slideUp();
    $(".modal-backdrop").hide();
})

$(function () {

    //1.初始化Table
    var oTable = new TableInit();
    oTable.Init();




});
var TableInit = function () {
    var oTableInit = new Object();
    //初始化Table
    oTableInit.Init = function () {
        $('#myTable').bootstrapTable({
            url: CTX+'/achievement/getOperator',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，
            pagination: true,                   //是否显示分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 20,                       //每页的记录行数（*）
            pageList: [20, 50, 100],        //可供选择的每页的行数（*）
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            queryParams: oTableInit.queryParams,//传递参数（*）
            queryParamsType: "",
            showColumns: true,                  //是否显示所有的列
            showRefresh: true,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            height: 700,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "Id",                     //每一行的唯一标识，一般为主键列
            showToggle: true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            showExport: true,                     //是否显示导出
            exportDataType: "basic",
            rowStyle: function (row, index) {
                //这里有5个取值代表5中颜色['active', 'success', 'info', 'warning', 'danger'];
                var strclass = "";
                if ((row.id)%2==0){
                    strclass = '';
                }
                else {
                    strclass = 'active';
                }
                return { classes: strclass }
            },
            columns: [
                {
                    checkbox: true
                },{
                    field: 'id',
                    sortable: true,
                    align: 'center',
                    valign: 'middle',
                    title: '序号',

                },
                {
                    field: 'customerCount',
                    sortable: true,
                    align: 'center',
                    valign: 'middle',
                    title: '数据库编号',
                    visible:false

                },
                {
                    field: 'userName',
                    sortable: true,
                    align: 'center',
                    valign: 'middle',
                    title: 'xxx',
                    formatter:function (value,row,index) {
                        var a="";

                        a="<span style='color:#4382CF;cursor:pointer;' id='details'>"+value+"</span>";


                        return a;
                    }

                },
                {
                    field: 'realName',
                    align: 'center',
                    valign: 'middle',
                    sortable: true,
                    title: 'xx'
                }, {
                    field: 'contact',
                    align: 'center',
                    valign: 'middle',
                    title: '客户数',

                }, {
                    field: 'qq',
                    align: 'center',
                    sortable: true,
                    valign: 'middle',
                    title: '本月总消费'
                },
                {
                    field: 'phone',
                    align: 'center',
                    valign: 'middle',
                    sortable: true,
                    title: '累计任务数'
                },

                {
                    field: 'createTime',
                    align: 'center',
                    valign: 'middle',
                    title: '当前任务数',

                },

                {
                    field: 'lastLoginTime',
                    align: 'center',
                    valign: 'middle',
                    sortable: true,
                    title: '今日消费',

                },

                {
                    field: "loginCount",
                    align: 'center',
                    valign: 'middle',
                    title: '今日达标任务',



                },

                {
                    field: 'operate',
                    title: '操作',
                    align: 'center',
                    valign: 'middle',
                    formatter:function (value,row,index) {
                        var a="<span style='color:#4382CF;cursor:pointer;' id='details'>资料</span>   " +
                            "<span style='color:#4382CF;cursor:pointer;' id='details'>改密</span>   "

                        return a;
                    },
                    events:operateEvents


                },


            ],

        });
    };

    //得到查询的参数
    oTableInit.queryParams = function (params) {
        var temp = {
            limit: params.pageSize,   //页面大小
            offset: params.pageNumber,  //页码
            sortOrder: params.sortOrder,
            sortName: params.sortName,

        };
        return temp;
    }
    window.operateEvents = {
        'click #operate': function (e, value, row, index) {

            if(confirm("是否冻结此账户？"))
            {

                $.ajax({
                    type:'post',
                    url:CTX+"/operator/updateUserState",
                    data:{userId:row.customerId},
                    success:function (result) {
                        if(result.code==200)
                        {
                            alert(result.message);
                            $('#myTable').bootstrapTable('refresh');
                        }
                        else
                        {
                            alert(result.message);
                        }
                    }
                })
            }
        }
    }


    return oTableInit;
};

$(function () {
    $("#queren").click(function () {

        $('#myTable').bootstrapTable('refresh');
    });

});



