<%--
  Created by IntelliJ IDEA.
  User: 96361
  Date: 2021/10/7
  Time: 21:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.rewebshop.util.ConnectionUtil" %>

<%
    //实例化链接
    Connection conn = ConnectionUtil.getConnection();
    Statement stmt = conn.createStatement();
%>

<html>
    <head>
        <title>登录检查页面</title>
    </head>
    <body>
        <%
            String name = request.getParameter("user");
            String psd = request.getParameter("psd");

            //todo:(已完成)通过username拿到userid，然后把userid传到下一个页面

            String sql = "select userid from users where name ='" + name + "' and psd= '" + psd + "'";
            System.out.println(sql);
            stmt.execute(sql);
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                //这里传过去的其实是一个userid，数据库第一列名
                session.setAttribute("userid", String.valueOf(rs.getString("userid")));
                response.sendRedirect("../category1.jsp?userid=" + rs.getString("userid") + "");
            } else {

                //如果数据库中没有这个username，则返回登录页面并传输一个标记为否
                response.sendRedirect("login.jsp?login_msg=false");
            }
        %>
    </body>
</html>
