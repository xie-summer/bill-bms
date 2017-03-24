
/**
 * Created by Administrator on 2017/3/16.
 */

var userName=false;
var password=false;

//用户名
$("input[name='userName']").blur(function () {

    if ($("#userName1").val() != "")
    {
        if (/^[A-Za-z]\w{5,12}$/.test($("#userName1").val())) {


            $.ajax({
                type: "get",
                data:{userName:$("#userName1").val()},
                url:CTX+"/user/register/validUserName",
                dataType:"json",
                success:function (result) {
                    if (result.code==200){ //返回结果code==200代表正确
                        //验证可以使用,
                        userName=true;
                    }else{
                        //验证为已注册,不能使用,
                        $(".pdlogid").css({ "color": "#ff0000" }).text("用户名已存在！");
                        userName = false;
                    }

                }

            })

        }
        else {
            //格式不对
            userName = false;
            $(".pdlogid").css({ "color": "#ff0000" }).text("用户名格式不正确！");
        }

    }
});
//密码
$("input[name='password']").blur(function () {

    if ($("input[name='password']").val()!= "")
    {
        if (/^\w{6,12}$/.test($(this).val())) {
            password = true;

        }
        else {
            //格式不对
            password = false;
            $(".pdpwd").css({ "color": "#ff0000" }).text("密码格式不正确！");
        }
    }
});
$("input[name='userName']").focus(function () {
    $(".pdlogid").css({ "color": "#ff0000" }).text("");
    userName = false;

});
$(".addOperatorcmt").click(function () {
    if(userName&&password)
    {
        $.ajax({
            type: "post",
            data:{userName:$("#userName1").val(),password:$("input[name='password']").val()},
            url:CTX+"/operator/list",
            dataType:"json",
            success:function (result) {

                  if(result.code==200)
                  {
                      alert(result.message);
                      $(".addOperatorDiv").slideUp();
                      $(".modal-backdrop").hide();
                      $('#myTable').bootstrapTable('refresh');
                  }
                  else
                  {
                      alert(result.Message);
                  }

            }

        })
    }

})



//添加操作员
    $("#addOperator").click(function () {

        $(".modal-backdrop").show();
        $(".addOperatorDiv").slideDown();


    })
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
            url: CTX+'/operator/getOperator',         //请求后台的URL（*）
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
                    field: 'customerId',
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
                    title: '操作员',

                },
                {
                    field: 'realName',
                    align: 'center',
                    valign: 'middle',
                    sortable: true,
                    title: '真实姓名'
                }, {
                    field: 'contact',
                    align: 'center',
                    valign: 'middle',
                    title: '联系人',

                }, {
                    field: 'qq',
                    align: 'center',
                    sortable: true,
                    valign: 'middle',
                    title: 'qq'
                },
                {
                    field: 'phone',
                    align: 'center',
                    valign: 'middle',
                    sortable: true,
                    title: '电话'
                },

                {
                    field: 'createTime',
                    align: 'center',
                    valign: 'middle',
                    title: '注册时间',

                },

                {
                    field: 'lastLoginTime',
                    align: 'center',
                    valign: 'middle',
                    sortable: true,
                    title: '最新登录',

                },

                {
                    field: "loginCount",
                    align: 'center',
                    valign: 'middle',
                    title: '登录次数',



                },
                {
                    field: "status",
                    align: 'center',
                    valign: 'middle',
                    title: '状态',
                    formatter:function (value,row,index) {
                        var a="";
                        if(value==1)
                        {
                            a="<span style='color:#94b86e;'>正常</span>";
                        }
                        else
                        {
                            a="<span>冻结中</span>";
                        }
                        return a;
                    }



                },
                {
                    field: 'operate',
                    title: '操作',
                    align: 'center',
                    valign: 'middle',
                    formatter:function (value,row,index) {
                        var a="<span style='color:#4382CF;cursor:pointer;' id='operate'>☸</span>";

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



