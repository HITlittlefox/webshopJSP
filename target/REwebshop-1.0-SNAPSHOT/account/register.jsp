<%--
  Created by IntelliJ IDEA.
  User: 96361
  Date: 2021/10/7
  Time: 21:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>商城|注册</title>
    </head>
    <body>
        <div>
            <form method="post" action="register-check.jsp">
                <h1>注册</h1>
                <table>
                    <tr>
                        <td>用户姓名:</td>
                        <td><input placeholder="请输入账号" type="text" name="user" autofocus required></td>

                    </tr>

                    <tr>
                        <td>用户密码:</td>
                        <td><input placeholder="请输入密码" id="psd" type="password" name="psd" required></td>
                    </tr>

                    <tr>
                        <td>确认密码:</td>
                        <td><input placeholder="请再次输入密码" id="psd-check" type="password" name="psd-check" required></td>
                    </tr>
                </table>
                <p>
                    <input type="submit" class="button" value="注册" onclick="checkPassword()">
                </p>
            </form>
        </div>

    </body>
</html>
<script>

    function checkPassword() {
        var value1 = document.getElementById("psd").value;
        var value2 = document.getElementById("psd-check").value;
        if (value1 !== value2) {
            alert("你输入的两次密码不一致0v0!请重新输入！");
            //alert("你输入的两次密码一致-v-");
        }
    }
</script>