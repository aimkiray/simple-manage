<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sign up</title>
    <link href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        body {
            padding-top: 40px;
            padding-bottom: 40px;
            background-color: #eee;
        }

        .form-signup {
            max-width: 330px;
            padding: 15px;
            margin: 0 auto;
        }

        .text-signup {
            max-width: 330px;
            padding: 15px;
            margin: 0 auto;
        }
    </style>
<body>

<div class="container">

    <form id="signUpForm" class="form-signup" action="/signup" method="post">

        <div class="form-group">
            <label for="userName" class="control-label">用户名</label>
            <div>
                <input type="text" class="form-control" id="userName" name="userName"
                       placeholder="请输入用户名" required>
                <span id="username_info" style="color:red"></span>
            </div>
        </div>

        <div class="form-group">
            <label for="userPassword" class="control-label">密码</label>
            <div>
                <input type="password" class="form-control" id="userPassword"
                       placeholder="请输入密码" required>
                <span id="userPassword_info" style="color:red"></span>
            </div>
        </div>

        <div class="form-group">
            <label for="rePassword" class="control-label">重复密码</label>
            <div>
                <input type="password" class="form-control" name="userPassword" id="rePassword"
                       placeholder="请再次输入密码" required>
                <span id="rePassword_info" style="color:red"></span>
            </div>
        </div>

        <div class="form-group">
            <label for="email" class="control-label">注册邮箱</label>
            <div>
                <input type="text" class="form-control" id="email" name="email"
                       placeholder="请输入注册邮箱" required>
                <span id="email_info" style="color:red"></span>
            </div>
        </div>

        <div class="form-group">
            <div>
                <button type="submit" class="btn btn-lg btn-primary btn-block">注册</button>
            </div>
        </div>
    </form>

    <div class="text-signup">
        <span>已有账户？>> <a href="/signin">登陆</a></span>
        <br>
        <span style="color: aqua">数据库：H2内存模式</span>
        <br>
        <span style="color: aqua">连接池：Spring Data JPA</span>
        <br>
        <span style="color: aqua">数据库管理：/console</span>
    </div>

</div>

</body>

<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>

<script type="text/javascript">
    var flag = {
        "email": false,
        "username": false,
        "password": false
    };

    $(document).ready(function () {
        // email验证
        $("#email").blur(function () {
            var email = $(this).val();

            var pattern = /\b(^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$)\b/;
            if (!pattern.test(email)) {
                $("#email_info").html("格式不正确");
            } else {
                $("#email_info").html("");
                flag.email = true;
            }
        });

        $("#userName").blur(function () {
            // 用户名校验
            var username = $(this).val();

            // 校验规则
            var pattern = /\b(^['A-Za-z0-9]{4,20}$)\b/;
            if (!pattern.test(username)) {
                $("#username_info").html("用户名不合法");
            } else {
                $("#username_info").html("");
                flag.username = true;
            }
        });

        // 密码校验
        $("#userPassword").blur(function () {
            var password = $(this).val();

            var pattern = /\b(^['A-Za-z0-9]{4,20}$)\b/;
            if (!pattern.test(password)) {
                $("#userPassword_info").html("密码格式不正确");
            } else {
                $("#userPassword_info").html("");
                //flag.password=true;
            }
        });


        // 密码重复校验
        $("#rePassword").blur(function () {
            var rePassword = $(this).val();

            if (rePassword != $("#userPassword").val()) {
                $("#rePassword_info").html("两次输入不一致");
                return;
            } else {
                $("#rePassword_info").html("");
                flag.password = true;
            }
        });

        $("#signUpForm").submit(function () {
            var submit = flag.email && flag.password && flag.username;
            if (submit == false) {
                alert("请检查是否存在错误！");
                return false;
            }
            return true;
        });

    })
</script>

</html>