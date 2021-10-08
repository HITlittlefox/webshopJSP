package com.example.rewebshop;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.io.*;
import java.util.*;
import java.sql.*;

import com.example.rewebshop.util.ConnectionUtil;

import java.util.stream.Collectors;

@WebServlet(name = "PutItCart", value = "/PutItCart")
public class PutItCart extends HttpServlet {
    private String id;
    private String price;


    public void init() {
        String message = "Hello World!";
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        int productId = Integer.parseInt(request.getParameter("productId"));
        int count = Integer.parseInt(request.getParameter("count"));
        int singlePrice = Integer.parseInt(request.getParameter("singlePrice"));
        int userid = Integer.parseInt(request.getParameter("userId"));

        int nextOrderId = 1 + Integer.parseInt(request.getParameter("orderid"));

        System.out.println("useridofPutItCart:" + userid);

        request.setAttribute("id", productId);
        request.setAttribute("userid", userid);

        try (Connection conn = ConnectionUtil.getConnection()) {
            try (PreparedStatement addToCart = conn.prepareStatement("insert into shopping_cart (product_id, amount, price, user_id, order_id) values (?, ?, ?, ?, ?)")) {
                addToCart.setInt(1, productId);
                addToCart.setInt(2, count);
                addToCart.setInt(3, count * singlePrice);
                addToCart.setInt(4, userid);
                addToCart.setInt(5, nextOrderId);
                addToCart.execute();
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(500, e.toString());
            return;
        }

        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("<h3>添加商品到购物车成功!</h3>");
        response.getWriter().write("<h3>" + userid + "</h3>");

        response.getWriter().write("<a href=\"showCart.jsp?userid=" + userid + "&nextOrderId=" + nextOrderId + "\">查看购物车</a>");
        response.getWriter().write("<a href=\"submitOrder.jsp?userid=" + userid + "\">直接下单</a>");
    }

    public void destroy() {
    }
}