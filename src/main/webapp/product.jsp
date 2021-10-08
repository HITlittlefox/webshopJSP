<%--
  Created by IntelliJ IDEA.
  User: 96361
  Date: 2021/10/8
  Time: 0:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.rewebshop.util.ConnectionUtil" %>


<%
    //拿到userid，有备无患
    String userid = request.getParameter("userid");
    System.out.println("userid in product:" + userid);

    String category = request.getParameter("categoryid");
%>

<%
    //实例化链接
    Connection conn = ConnectionUtil.getConnection();
    Statement stmt = conn.createStatement();
%>
<%
    //拿出订单表中最大的订单号
    String sqlForOrderId = "select order_id from order_sheet ORDER BY order_id DESC LIMIT 1";
    System.out.println("拿出订单表中最大的订单号sql" + sqlForOrderId);
    stmt.execute(sqlForOrderId);
    ResultSet rsSqlForOrderId = stmt.executeQuery(sqlForOrderId);
    String orderid = null;
    while (rsSqlForOrderId.next()) {
        orderid = rsSqlForOrderId.getString("order_id");
    }
%>
<%
    //拿出第三分类(共3分类)
    String sql = "select * from products where category_id  = '" + category + "'";
    System.out.println(sql);
    stmt.execute(sql);
    ResultSet rs = stmt.executeQuery(sql);

%>


<!DOCTYPE html>
<html>
    <head>
        <title>商城|产品</title>
    </head>
    <body>
        <div>
            <h3>这里是产品页面！</h3>
            <h3>
                <a href="showCart.jsp?userid=<%=userid%>">查看购物车</a>
            </h3>
        </div>
        <%--while (rs2.next()) {--%>
        <%--1. 需要先把”第一分类“的信息从category取出来--%>
        <%while (rs.next()) {%>
        <form method="post" action="PutItCart">

            <table>
                <tr>

                    <input type="hidden" name="orderid" value="<%=orderid%>"/>
                    <input type="hidden" name="userId" value="<%=userid%>"/>
                    <input type="hidden" name="productId" value="<%=rs.getString("product_id")%>"/>
                    <input type="hidden" name="singlePrice" value="<%=rs.getString("price")%>"/>
                    <td>

                        <p>
                            商品名称：<%=rs.getString("name")%>
                        </p>
                        <p>
                            商品描述：<%=rs.getString("des")%>
                        </p>
                        <p>
                            商品价格：<%=rs.getString("price")%>
                        </p>
                        <p>
                            购买数量：<input min="1" step="1" type="number" name="count" value=1
                                        style="width:50px;color: black"/>
                        </p>
                        <p>
                            <img style="border-radius:10px;"
                                 src="<%=rs.getString("src")%>"
                                 alt="这里是图片"
                                 height="150"
                                 width="200">
                        </p>
                        <p style="margin-left: 50px">
                            <input style="background-color:red;margin-left: auto " type="submit" value="添加到购物车"/>
                        </p>
                    </td>

                </tr>
            </table>


        </form>
        <%}%>

    </body>
</html>