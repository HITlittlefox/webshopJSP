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

        request.setAttribute("id", productId);
        request.setAttribute("userid", userid);

        try (Connection conn = ConnectionUtil.getConnection()) {
            try (PreparedStatement addToCart = conn.prepareStatement("insert into shopping_cart (product_id, amount, price, user_id) values (?, ?, ?, ?)")) {
                addToCart.setInt(1, productId);
                addToCart.setInt(2, count);
                addToCart.setInt(3, count * singlePrice);
                addToCart.setInt(4, userid);
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
    }

    public void destroy() {
    }
}