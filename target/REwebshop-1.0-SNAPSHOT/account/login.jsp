<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <title>商城|登录</title>
    </head>
    <body>
        <div>
            <form method="post" action="login-check.jsp">
                <h1>登陆</h1>
                <table>
                    <tr>
                        <td>用户:</td>
                        <td><input type="text" name="user"></td>
                    </tr>
                    <tr>
                        <td>密码:</td>
                        <td><input type="password" name="psd"></td>
                    </tr>
                </table>
                <div>
                    <input type="submit" value="登陆">
                    <%--保持注册与登录按钮样式相同，并点击注册后跳转页面--%>
                    <input type="button" value="注册" onclick="window.location.href='register.jsp'">

                </div>
                <div>
                    <%--有一个登录成功与否的标记，如果标记为否,则在本页面显示登录失败                    --%>
                    <%
                        String flag = request.getParameter("login_msg");
                        System.out.println(flag);
                        if (Objects.equals(flag, "false")) {
                    %>
                    <h2>您的登录情况：登陆失败！
                    </h2>
                    <%
                        }
                    %></div>
            </form>
        </div>
    </body>
</html>
