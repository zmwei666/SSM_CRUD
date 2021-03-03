<%--
  Created by IntelliJ IDEA.
  User: chen wei
  Date: 2021/2/23
  Time: 18:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--
        不以/开始的相对路径找资源，是以当前资源为路径为基准，经常容易出问题
        以/开始的相对路径找资源，是以服务器的路径为为基准的（http://localhost:3306）需要加上项目名才能正确找到
        http://localhost:3306/crud
    --%>
    <%--引入bootstrap的样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <%--引入jQuery--%>
    <script src="${APP_PATH}/static/js/jquery-1.9.1.min.js"></script>
    <%--引入bootstrap的js--%>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
<%--员工修改的模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">EmployeeName</label>
                        <div class="col-sm-9">
                            <%--<input type="text" class="form-control" id="empName_update_input" name="empName"
                                   placeholder="employeeName">
                            <span class="help-block"></span>--%>
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_update_input" class="col-sm-3 control-label">Email</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="email_update_input" name="email"
                                   placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Gender</label>
                        <div class="col-sm-9">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept_add_select" class="col-sm-3 control-label">DepartmentID</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-3 control-label">EmployeeName</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="empName_add_input" name="empName"
                                   placeholder="employeeName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-3 control-label">Email</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="email_add_input" name="email"
                                   placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Gender</label>
                        <div class="col-sm-9">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept_add_select" class="col-sm-3 control-label">DepartmentID</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--搭建页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="delete_all">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>departmentID</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area"></div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>

<script type="text/javascript">
    // 全局变量，记录总记录数
    var totalRecord;
    // 记录当前页码
    var currentPage;

    // 1. 页面加载完成以后，直接去发送一个ajax请求，要到分页数据
    $(function () {
        // 去首页
        to_page(1);
    });

    // 发送到去第几页的ajax请求
    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "get",
            success: function (data) {
                console.log(data);
                // 1. 解析并显示员工数据
                build_emps_table(data);
                // 2. 解析并显示分页信息
                build_page_info(data);
                // 3. 解析并显示分页条
                build_page_nav(data);

            }
        });

        // 清除delete_all的选中状态
        $("#delete_all").prop("checked",false);


    }

    // 1. 解析并显示员工数据
    function build_emps_table(data) {
        // 清空table表格
        $("#emps_table tbody").empty();
        // 所有的员工数据
        var emps = data.extend.pageInfo.list;
        // index 为当前的索引，item表示当前的对象
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td></td>").append($("<input type='checkbox' class='delete_item'></input>"));
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var gender = item.gender == "M" ? "男" : "女";
            var genderTd = $("<td></td>").append(item.gender);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            // 为编辑按钮添加一个自定义的属性，用来表示当前的员工的id
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            // 为删除按钮添加一个自定义的属性，用来表示当前员工的id
            delBtn.attr("delete-id",item.empId)
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            // append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");
        });
    }

    // 2. 解析并显示分页信息
    function build_page_info(data) {
        // 清空分页信息
        $("#page_info_area").empty();

        $("#page_info_area").append("当前第" + data.extend.pageInfo.pageNum + "页，总共" + data.extend.pageInfo.pages + "页，总共" + data.extend.pageInfo.total + "条记录")

        totalRecord = data.extend.pageInfo.total;
        currentPage = data.extend.pageInfo.pageNum;
    }

    // 3. 解析并显示分页条
    function build_page_nav(data) {
        // 清空分页条
        $("#page_nav_area").empty();

        var ul = $("<ui></ui>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
        var prePageLli = $("<li></li>").append($("<a></a>").append("&laquo;"));

        // 如果没有首页和前一页，则不能点击按钮
        if (data.extend.pageInfo.hasPreviousPage == false) {
            // 添加不能点击的样式，并且移除单击事件
            firstPageLi.addClass("disabled")/*.unbind("click")*/;
            prePageLli.addClass("disabled")/*.unbind("click")*/;
        } else {
            // 给首页和上一页添加单击事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLli.click(function () {
                to_page(data.extend.pageInfo.prePage);
            });
        }

        var nextPageLli = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));


        // 如果没有末页和下一页，则不能点击按钮
        if (data.extend.pageInfo.hasNextPage == false) {
            // 添加不能点击的样式，并且移除单击事件
            nextPageLli.addClass("disabled")/*.unbind("click")*/;
            lastPageLi.addClass("disabled")/*.unbind("click")*/;
        } else {
            // 给末页和下一页添加单击事件
            nextPageLli.click(function () {
                to_page(data.extend.pageInfo.nextPage);
            });
            lastPageLi.click(function () {
                to_page(data.extend.pageInfo.pages);
            });
        }

        // 添加首页和前一页
        ul.append(firstPageLi).append(prePageLli);

        // 遍历页码，并放入ul中
        $.each(data.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            // 判断当前页是活动页的话加上标识
            if (data.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });

        // 添加下一页和末页
        ul.append(nextPageLli).append(lastPageLi);

        // 将ul添加到nav中
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    // 清空表单样式及内容、表单重置的方法
    function reset_form(ele) {
        // 重置表单内容
        $(ele)[0].reset();
        // 清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        // 清空提示信息
        $(ele).find(".help-block").text("");
    }

    // 点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        // 清楚表单数据（表单重置）
        // $("#empAddModal form")[0].reset();
        reset_form("#empAddModal form");

        // 发送ajax请求，查出部门信息，显示在下拉列表
        getDepts("#dept_add_select");

        // 弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    // 查出所有的部门信息并显示在下拉列表中
    function getDepts(ele) {
        // 清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (data) {
                console.log(data);

                // 显示部门信息在下拉列表中
                $.each(data.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    // 校验表单数据
    function validata_add_from() {
        // 拿到要校验的数据，使用正则表达式

        // 校验empName
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]+$)/;
        if (!regName.test(empName)) {
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者是6-16位英文和数字的组合");
            // alert("用户名可以是2-5位中文或者是6-16位英文和数字的组合")
            // $("#empName_add_input").parent().addClass("has-error");
            // $("#empName_add_input").next("span").text("用户名可以是2-5位中文或者是6-16位英文和数字的组合");
            return false;
        } else if ($("#emp_save_btn").attr("ajax-va")=="success"){
            // 通过前端验证and后端验证才会来到这个if里
            show_validate_msg("#empName_add_input", "success", "用户名可用");
            // 校验成功的话，输入框变绿
            // $("#empName_add_input").parent().addClass("has-success");
            // 清空提示框中的内容
            // $("#empName_add_input").next("span").text("");
        }
        // 校验邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            // alert("邮箱格式不正确");
            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "邮箱格式正确");
            // $("#email_add_input").parent().addClass("has-success");
            // $("#email_add_input").next("span").text("");
        }

        return true;
    }

    // 抽取校验结果的提升信息
    function show_validate_msg(ele, status, msg) {
        // 移除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");

        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }

    }

    // 校验用户名是否可用
    $("#empName_add_input").change(function () {
        // 发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkUser",
            data: "empName=" + empName,
            type: "POST",
            success: function (data) {
                if (data.code == 100) {
                    show_validate_msg("#empName_add_input", "success", data.extend.va_msg)
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else if (data.code == 200) {
                    show_validate_msg("#empName_add_input", "error", data.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });
    });

    // 保存员工
    $("#emp_save_btn").click(function () {
        //模态框中填写的表单数据提交给服务器进行保存

        // 先对要提交给服务器的数据进行校验
        if (!validata_add_from()) {
            return false;
        }

        // 判断之前的ajax用户校验是否成功，如果校验成功在走下面的步骤
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }

        // 发送ajax请求保存员工
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (data) {
                // alert(data.msg);
                if (data.code == 100) {
                    // 员工保存成功
                    // 关闭模态框
                    $("#empAddModal").modal('hide');
                    // 来到最后一页，显示刚才保存的数据
                    // 发送ajax请求显示最后一页数据
                    to_page(totalRecord);

                } else if (data.code == 200) {
                    // 显式失败信息
                    // console.log(data);
                    // 有那个字段的错误信息就显示那个字段的
                    if (data.extend.errorField.email != undefined) {
                        // 显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", data.extend.errorField.email);
                    }
                    if (data.extend.errorField.empName != undefined) {
                        // 显示员工名字的错误信息
                        show_validate_msg("#empName_add_input", "error", data.extend.errorField.empName);
                    }
                }
            }
        });
    });


    // ==============编辑的逻辑==============

    /*
    给编辑按钮绑定单击事件，因为我们是在按钮创建之前就绑定了单击事件（先加载页面，再发送请求给服务器拿数据，填充到表格里），所以就会绑不上
        两种解决办法
        1. 在创建按钮的时候绑定，
        2. 绑定点击.live()  jQuery新版本中没有live方法，可以用on代替
    */
    $(document).on("click",".edit_btn",function () {
        // alert("edit");

        // 清空表单遗留样式，以及提示
        reset_form("#empUpdateModal form")
        // 查出部门信息，并显示部门列表
        getDepts("#empUpdateModal select");
        // 查出员工信息，并显示员工信息
        getEmp($(this).attr("edit-id"));
        // 把员工id传递到模态框的更新按钮上
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));

        // 弹出模态框
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (data) {
                // console.log(data);

                // 回显表单
                var empData = data.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    // 点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        // 验证邮箱是否合法
        // 校验邮箱信息
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }

        // 发送ajax请求保存员工更新的数据
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (data) {
                // console.log(data);
                // 1. 关闭对话框
                $("#empUpdateModal").modal("hide");
                // 2. 回到本页面
                to_page(currentPage);
            }
        });
    });

    //==================删除的逻辑=============
    // 单个删除
    $(document).on("click",".delete_btn",function () {
        // 弹出是佛确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("delete-id");
        if (confirm("确定删除【"+empName+"】吗？")) {
            // 确认，发送ajax请求
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (data) {
                    alert(data.msg);
                    // 回到本页
                    to_page(currentPage);
                }
            });
        }
    });

    // 全选、全不选
    $("#delete_all").click(function () {
        // attr获取checked是undefined，改用prop
        $(".delete_item").prop("checked",$(this).prop("checked"));
    });

    // delete_item 单选框
    $(document).on("click",".delete_item",function () {
        // 判断当前选中的元素是5个
        var flag = $(".delete_item:checked").length == $(".delete_item").length;
        $("#delete_all").prop("checked",flag);
    });

    // 点击全部删除，就批量删除
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
        $.each($(".delete_item:checked"),function () {
            empNames+=$(this).parents("tr").find("td:eq(2)").text()+"、";
            // 组装员工id的字符串
            del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        // 去除empName多余的顿号
        empNames=empNames.substring(0,empNames.length-1);
        // 去除多余的-
        del_idstr=del_idstr.substring(0,del_idstr.length-1);
        if (confirm("确认删除【"+empNames+"】吗？")) {
            // 发送ajax请求删除员工
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (data) {
                    alert(data.msg);

                    //回到当前页面
                    to_page(currentPage);
                }
            });
        }
    });

</script>
</body>
</html>
