<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sign in</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">

    <style type="text/css">
        body {
            padding-top: 40px;
            padding-bottom: 40px;
            background-color: #eee;
        }

        .form-signin {
            max-width: 330px;
            padding: 15px;
            margin: 0 auto;
        }
        .text-signin {
            max-width: 330px;
            padding: 15px;
            margin: 0 auto;
        }
    </style>
<body>

<div class="container">

    <form id="signInForm" class="form-signin" action="/signin" method="post">
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
                <input type="password" class="form-control" id="userPassword" name="userPassword"
                       placeholder="请输入密码" required>
                <span id="userPassword_info" style="color:red"></span>
            </div>
        </div>

        <div class="checkbox">
            <label>
                <input type="checkbox" value="1" name="remember"> 记住我
            </label>
        </div>

        <div class="form-group">
            <div>
                <button type="submit" class="btn btn-lg btn-primary btn-block">登录</button>
            </div>
        </div>
    </form>

    <div class="text-signin">
        <span>没有账户？>> <a href="/signup">注册</a></span>
        <br>
        <span style="color: aqua">数据库：H2内存模式</span>
        <br>
        <span style="color: aqua">持久层框架：Spring Data JPA</span>
        <br>
        <span style="color: aqua">数据库管理：/console</span>
    </div>

</div>

</body>
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>

<script type="text/javascript">
    var flag = {
        "username": false,
        "password": false
    };

    $(document).ready(function () {

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
                flag.password=true;
            }
        });

        $("#signInForm").submit(function () {
            var submit = flag.password && flag.username;
            if (submit == false) {
                alert("请检查是否存在错误！");
                return false;
            }
            return true;
        });

    })
</script>
</html>