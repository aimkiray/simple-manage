<html>
<head>
    <title>新生</title>
</head>
<body>

<form id="add_customer_form">
    <div class="form-group">
        <label for="name">名称</label>
        <input type="text" class="form-control" id="name" name="name" placeholder="君の名は。" required>
    </div>
    <div class="form-group">
        <label for="site">地址</label>
        <input type="text" class="form-control" id="site" name="site" placeholder="地址" required>
    </div>
    <div class="form-group">
        <label for="phone">电话</label>
        <input type="text" class="form-control" id="phone" name="phone" placeholder="电话" required>
    </div>
    <div class="form-group">
        <label for="tax">税号</label>
        <input type="text" class="form-control" id="tax" name="tax" placeholder="税号" required>
    </div>

    <div class="form-group">
        <label for="email" class="control-label">注册邮箱</label>
        <input type="text" class="form-control" id="email" name="email"
                   placeholder="邮箱" required>
        <span id="email_info" style="color:red"></span>
    </div>

    <button type="submit" id="btn_add_customer" class="btn btn-primary">提交</button>
</form>
</body>
<script>

    var flag = {
        "email": false
    };

    $(document).ready(function () {

        // email验证
        $("#email").blur(function () {
            var email = $(this).val();

            var pattern = /\b([\w-_]+(?:\.[\w-_]+)*)@((?:[a-z0-9]+(?:-[a-zA-Z0-9]+)*)+\.[a-z]{2,6})\b/;
            if (!pattern.test(email)) {
                $("#email_info").html("格式不正确");
                flag.email = false;
            } else {
                $("#email_info").html("");
                flag.email = true;
            }
        });

        $("#add_customer_form").on("submit", function (event) {
            event.preventDefault();

            if (flag.email == false) {
                alert("请检查是否存在错误！");
                return false;
            } else {
                $.ajax({
                    url: "/api/customer",
                    cache: false, // 禁用缓存
                    async: false,
                    type: "POST",
                    dataType: "json",
                    data: $("#add_customer_form").serialize(),
                    success: function (data) {
                        if (data == 1) {
                            if (typeof customerTable === "function") {
                                customerTable().Init.ajax.reload()
                            }
                            $(".bootbox-close-button").click();
                        } else {
                            alert("添加失败，用户名已存在。");
                            $(".bootbox-close-button").click();
                        }
                    },
                    error: function () {
                        alert("通信失败！");
                        $(".bootbox-close-button").click();
                    }
                });
            }
        });
    });
</script>
</html>
