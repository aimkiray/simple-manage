<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户管理</title>

    <#--bootstrap-->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <#--awesome-->
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <#--datatables-->
    <link href="https://cdn.bootcss.com/datatables/1.10.16/css/dataTables.bootstrap.min.css" rel="stylesheet">

</head>

<body>

<div class="panel-body">

    <div id="toolbar" class="btn-group">
        <button id="btn_add" type="button" class="btn btn-default">
            <span class="fa fa-plus" aria-hidden="true"></span>新增
        </button>
    </div>

    <table id="customer_list" class="table table-striped table-bordered">
        <thead>
        <tr>
            <th><input type="checkbox"></th>
            <th>名称</th>
            <th>地址</th>
            <th>电话</th>
            <th>邮箱</th>
            <th>税号</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody></tbody>
        <!-- tbody是必须的 -->
    </table>
</div>
</body>
<#--jquery-->
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<#--bootstrap-->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<#--bootbox-->
<script src="https://cdn.bootcss.com/bootbox.js/4.4.0/bootbox.min.js"></script>
<#--dataTables-->
<script src="https://cdn.bootcss.com/datatables/1.10.16/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.bootcss.com/datatables/1.10.16/js/dataTables.bootstrap.min.js"></script>

<script>

    $(document).ready(function () {
        // 初始化Table
        customerTable();

        // 初始化Button的点击事件
        buttonInit();

        // 丢掉datatables报错信息（官方方案之一）
        $.fn.dataTable.ext.errMode = 'throw';

    });

    //提示信息
    var lang = {
        "sProcessing": "处理中...",
        "sLengthMenu": "每页 _MENU_ 项",
        "sZeroRecords": "没有匹配结果",
        "sInfo": "当前显示第 _START_ 至 _END_ 项，共 _TOTAL_ 项。",
        "sInfoEmpty": "当前显示第 0 至 0 项，共 0 项",
        "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
        "sInfoPostFix": "",
        "sSearch": "搜索:",
        "sUrl": "",
        "sEmptyTable": "表中数据为空",
        "sLoadingRecords": "载入中...",
        "sInfoThousands": ",",
        "oPaginate": {
            "sFirst": "首页",
            "sPrevious": "上页",
            "sNext": "下页",
            "sLast": "末页",
            "sJump": "跳转"
        },
        "oAria": {
            "sSortAscending": ": 以升序排列此列",
            "sSortDescending": ": 以降序排列此列"
        }
    };

    //初始化表格
    var customerTable = function () {
        var tableParam = {};
        tableParam.Init = $("#customer_list").dataTable({
            destroy: true, //创建表格前先删除旧表格
            // dom: "<'row'<'col-sm-6'<'toolbar'>><'col-sm-6'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-2'l><'col-sm-3'i><'col-sm-7'p>>",
            dom: "<'row'<'col-sm-6'><'col-sm-6'>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-2'l><'col-sm-3'i><'col-sm-7'p>>",
            language: lang,  //提示信息
            autoWidth: false,  //禁用自动调整列宽
            stripeClasses: ["odd", "even"],  //为奇偶行加上样式，兼容不支持CSS伪类的场合
            processing: true,  //隐藏加载提示,自行处理
            serverSide: true,  //启用服务器端分页
            lengthMenu: [[5,25,50,100,-1],[5,25,50,100,"All"]],
            pageLength: 5,
            pagingType: "full_numbers",  //分页样式：simple,simple_numbers,full,full_numbers
            searching: false,  //禁用原生搜索
            orderMulti: false,  //启用多列排序
            order: [],  //取消默认排序查询,否则复选框一列会出现小箭头
            renderer: "bootstrap",  //渲染样式：Bootstrap和jquery-ui
            columnDefs: [{
                "targets": 'nosort',  //列的样式名
                "orderable": false    //包含上样式名‘nosort’的禁止排序
            }],
            ajax: {
                url: '/api/customer',
                type: 'GET',
                dataType: "json"
            },
            //列表表头字段
            columns: [
                {data : "id", "orderable": false, "width": "2%", "render": function(data,type,row,meta){ return '<input type="checkbox" name="'+data+'">'; } },
                {data : "name"},
                {data : "site"},
                {data : "phone"},
                {data : "email"},
                {data : "tax"},
                {
                    data : "id",
                    render: function (data, type, row) {
                        return '<button class="btn btn-info btn-sm" onclick="updateCustomer('+data+')"><i class="fa fa-pencil"></i>修改</button>' +
                            '&nbsp;&nbsp;' +
                            '<button class="btn btn-danger btn-sm" onclick="delCustomer('+data+')"><i class="fa fa-remove"></i>删除</button>';
                    }
                }
            ]
        }).api();
//此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象

        return tableParam;
    }

    function updateCustomer(id) {
        $.ajax({
            url: "/customer/" + id,
            type: "GET",
            dataType: "text",
            success: function (data) {
                bootbox.dialog({
                    message: data,
                    title: "修改信息"
                })
            },
            error: function () {
                alert("通信失败");
            }
        });
    }

    function delCustomer(id) {
        bootbox.confirm({
            message: "确认删除？",
            buttons: {
                confirm: {
                    label: '确认',
                    className: 'btn-success'
                },
                cancel: {
                    label: '取消',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if (result) {
                    $.ajax({
                        url: "/api/customer/" + id,
                        type: "DELETE",
                        dataType: "text",
                        success: function () {
                            customerTable().Init.ajax.reload();
                            $(".bootbox-close-button").click();
                        },
                        error: function () {
                            alert("删除失败！");
                            $(".bootbox-close-button").click();
                        }
                    });
                }
            }
        });
    }


    function buttonInit() {

        // 初始化页面上面的按钮事件

        $("#btn_add").click(function () {
            $.ajax({
                url: "/customer/add",
                type: "GET",
                dataType: "text",
                success: function (data) {
                    bootbox.dialog({
                        message: data,
                        title: "添加用户"
                    })
                },
                error: function () {
                    alert("通信失败");
                }
            });
        });

        // 刷新列表
        $("#btn_query").click(function () {
            customerTable().Init.ajax.reload()
        });
    }
</script>
</html>
