<%--
  Created by IntelliJ IDEA.
  User: 96361
  Date: 2021/10/8
  Time: 1:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.rewebshop.util.ConnectionUtil" %>

<%
    String userid = request.getParameter("userid");
    String nextOrderId = request.getParameter("nextOrderId");
    System.out.println("nextOrderIdofshowCart:" + nextOrderId);
    System.out.println("userid in showCart:" + userid);


    //实例化链接
    Connection conn = ConnectionUtil.getConnection();
    Statement stmt = conn.createStatement();

    String sql4name = "select * from users where userid=" + userid + " ";
    ResultSet rs4name = stmt.executeQuery(sql4name);
    rs4name.next();
    String user_name = rs4name.getString("name");

%>


<html>
    <head>
        <title>您的购物车页面！</title>
        <link rel="stylesheet" href="css/category1.css">

    </head>
    <body>
        <div align="center">

            <div>
                <h1>
                    这里是
                    <em>
                        <%=user_name%>
                    </em>
                    的购物车页面！</h1>
                <h3><a href="index.jsp">回到首页</a></h3>
                <h3><a href="category1.jsp?userid=<%=userid%>">返回产品分类页面</a></h3>
            </div>
            <table style="border: 5px wheat solid">
                <tr>
                    <td>产品id</td>
                    <td>产品名称</td>
                    <td>单价</td>
                    <td>购买数量</td>
                    <td>总价</td>
                </tr>
                <%

                    //Eureka! 锦囊妙计：给放入购物车的货物设置一个flag。flag=0是指“放入购物车但是没有购买”的产品。
                    //当下单一次，就让购物车里的产品，flag=1。
                    //同时需要给放入购物车的产品加一个字段，就是订单表中最大订单号+1，也就是下一个订单！
                    //查看订单的时候，检索购物车表单中flag=0且订单号符合的货物
                    String sql = "select * from shopping_cart where user_id=" + userid + " " + "and flag=0 and order_id=" + nextOrderId + " ";
                    System.out.println("showCartSql：" + sql);
                    ResultSet rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        int productId = rs.getInt("product_id");
                        int userId = rs.getInt("user_id");
                        int amount = rs.getInt("amount");
                        int totalPrice = rs.getInt("price");
                        try (PreparedStatement getProduct = conn.prepareStatement("select name, price from products where product_id = ?")) {
                            getProduct.setInt(1, productId);
                            try (ResultSet product = getProduct.executeQuery()) {
                                if (product.next()) {
                                    String productName = product.getString("name");
                                    int singlePrice = product.getInt("price");
                %>
                <tr>
                    <td><%=productId%>
                    </td>
                    <td><%=productName%>
                    </td>
                    <td><%=singlePrice%>
                    </td>
                    <td><%=amount%>
                    </td>
                    <td><%=totalPrice%>
                    </td>
                </tr>
                <%
                                }
                            }
                        }
                    }
                %>
            </table>

            <%
                String flagOrder = request.getParameter("flagOrder");
                System.out.println("yourflagis" + flagOrder);

            %>
            <form style="margin-top: 30px" method="post" action="submitOrder.jsp?nextOrderId=<%=nextOrderId%>"
                  accept-charset="UTF-8"
                  charset="UTF-8">
                <input type="hidden" name="userid" value="<%=userid%>"/>
                <table>
                    <tr>
                        <td>收货地址：</td>
                        <td><input class="button" type="text" name="address"></td>
                    </tr>
                    <tr>
                        <td>电话号码：</td>
                        <td><input class="button" type="text" name="phone"></td>
                    </tr>
                </table>
                <input type="submit" value="提交">
            </form>
        </div>
    </body>

</html>
