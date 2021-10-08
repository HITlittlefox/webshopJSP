<%--
  Created by IntelliJ IDEA.
  User: 96361
  Date: 2021/10/8
  Time: 9:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.rewebshop.util.ConnectionUtil" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    int orderId = -1;
    //实例化链接
    Connection connection = ConnectionUtil.getConnection();
    Statement stmt = connection.createStatement();

    //获得userid
    int userid = Integer.parseInt(request.getParameter("userid"));
    //时间
    Date orderTime = new Date();
    //地址
    String address = request.getParameter("address");
    //电话
    String phone = request.getParameter("phone");
    //String orderContent = request.getParameter("order_content");

//todo:下单后把shopping_cart中已加入购物车但是没有下单的(order_id=最新+1且flag=0)货物的flag=1


    PreparedStatement addOrder = connection.prepareStatement(
            "insert into order_sheet (user_id, order_time, address, order_content, phone) " +
                    "values (?,?, ?, ?, ?)",
            Statement.RETURN_GENERATED_KEYS);
    addOrder.setInt(1, userid);
    addOrder.setTimestamp(2, new java.sql.Timestamp(System.currentTimeMillis() + 3600 * 8 * 1000));
    addOrder.setString(3, address);
    addOrder.setString(4, null);
    addOrder.setString(5, phone);
    addOrder.executeUpdate();
    ResultSet rs = addOrder.getGeneratedKeys();


    if (rs.next()) {
        orderId = rs.getInt(1);
    }

//    PreparedStatement clearShoppingCart = connection.prepareStatement("delete from shopping_cart where user_id = ?");
//    clearShoppingCart.setInt(1, userId);
//    clearShoppingCart.execute();
%>

<html>
    <head>
        <title>提交订单</title>
    </head>
    <body>
        <div align="center">
            <h2>下单成功</h2>
            <hr/>
            <p>您的订单编号为 <%=orderId%>
            </p>
            <form method="get" action="category1.jsp">
                <input type="hidden" name="userid" value=<%=userid%>/>
                <input type="submit" value="继续购物"/>
            </form>
        </div>

        <%--//todo:订单详情：找出shopping_cart中已加入购物车且已下单的(order_id=最新+1-1 且flag=1)货物--%>


    </body>
</html>
