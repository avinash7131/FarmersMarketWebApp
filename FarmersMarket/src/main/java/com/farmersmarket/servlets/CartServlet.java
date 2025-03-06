// CartServlet.java
package com.farmersmarket.servlets;

import com.farmersmarket.models.Produce;
import com.farmersmarket.utils.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Object[]> cart = (List<Object[]>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            request.getRequestDispatcher("buyer/cart.jsp").forward(request, response);
            return;
        }

        List<Produce> cartItems = new ArrayList<>();
        double totalPrice = 0.0;

        try (Connection conn = DatabaseConnection.getConnection()) {
            for (Object[] item : cart) {
                int produceId = (Integer) item[0];
                double quantity = (Double) item[1];
                double unitPrice = (Double) item[2];

                try (PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM Produce WHERE produce_id = ?")) {
                    pstmt.setInt(1, produceId);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next()) {
                            Produce produce = new Produce();
                            produce.setProduceId(rs.getInt("produce_id"));
                            produce.setProduceName(rs.getString("produce_name"));
                            produce.setDescription(rs.getString("description"));
                            produce.setPrice(rs.getDouble("price"));
                            produce.setUnit(rs.getString("unit"));
                            produce.setImagePath(rs.getString("image_path"));
                            cartItems.add(produce);
                            totalPrice += produce.getPrice() * quantity;
                        }
                    }
                }
            }
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("totalPrice", totalPrice);
            request.getRequestDispatcher("buyer/cart.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("buyer/cart.jsp").forward(request, response);
        }
    }
}