<%--
  Created by IntelliJ IDEA.
  User: 96361
  Date: 2021/10/7
  Time: 21:49
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.rewebshop.util.ConnectionUtil" %>

<%
    //实例化链接
    Connection conn = ConnectionUtil.getConnection();
    Statement stmt = conn.createStatement();
%>

<%
    //接收register的两个字符串
    String name = request.getParameter("user");
    String psd = request.getParameter("psd");
    System.out.println(name);
    System.out.println(psd);

    //第一条sql语句！进行insert (并且做了个保护，防止恶意输入)
    PreparedStatement prepared = conn.prepareStatement("insert into users (name, psd) values (?, ?)");
    prepared.setString(1, name);
    prepared.setString(2, psd);
    //老命令如下
    //String sql = "insert into users (name,psd) values ('" + name + "','" + psd + "')";

    prepared.execute();
    // stmt.execute(sql);

    // 第二条sql语句！进行select
    String sql = "select * from users";
    ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
    <head>
        <title>注册检查页面</title>
        <link rel="stylesheet" href="../css/register.css">

    </head>
    <body>
        <%
            if (rs.next()) {
        %>

        <div>
            <h1>注册成功，请登录</h1>
        </div>
        <br>
        <p></p>
        <div>
            <h1><a href="login.jsp">返回登陆</a></h1>
        </div>
        <%
        } else {
        %>
        <h1>注册失败，请重新注册</h1>
        <a href="register.jsp">返回注册页面</a>
        <%
            }
        %>

    </body>
</html>
