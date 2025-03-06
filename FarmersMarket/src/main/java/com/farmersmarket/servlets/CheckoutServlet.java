// CheckoutServlet.java
package com.farmersmarket.servlets;

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
import java.util.List;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Map;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Object[]> cart = (List<Object[]>) session.getAttribute("cart");
        String shippingAddress = request.getParameter("shippingAddress");
        Integer buyerId = (Integer) session.getAttribute("buyerId");

        if (cart == null || cart.isEmpty() || shippingAddress == null || shippingAddress.trim().isEmpty() || buyerId == null) {
            request.setAttribute("error", "Cart is empty, shipping address missing, or buyer ID missing.");
            request.getRequestDispatcher("buyer/checkout.jsp").forward(request, response);
            return;
        }

        Map<Integer, List<Object[]>> farmerOrders = new HashMap<>();

        for (Object[] item : cart) {
            int farmerId = (Integer) item[3];
            if (!farmerOrders.containsKey(farmerId)) {
                farmerOrders.put(farmerId, new ArrayList<>());
            }
            farmerOrders.get(farmerId).add(item);
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false);

            for (Map.Entry<Integer, List<Object[]>> entry : farmerOrders.entrySet()) {
                int farmerId = entry.getKey();
                List<Object[]> farmerCart = entry.getValue();
                double farmerTotal = 0;

                for (Object[] item : farmerCart) {
                    farmerTotal += (Double) item[1] * (Double) item[2];
                }

                int orderId = -1;
                String orderSql = "INSERT INTO Orders (shipping_address, buyer_id, farmer_id, total_amount) VALUES (?, ?, ?, ?)";
                try (PreparedStatement orderStmt = conn.prepareStatement(orderSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    orderStmt.setString(1, shippingAddress);
                    orderStmt.setInt(2, buyerId);
                    orderStmt.setInt(3, farmerId);
                    orderStmt.setDouble(4, farmerTotal);
                    int rowsAffected = orderStmt.executeUpdate();

                    if (rowsAffected == 0) {
                        throw new SQLException("Creating order failed, no rows affected.");
                    }

                    try (ResultSet generatedKeys = orderStmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            orderId = generatedKeys.getInt(1);

                            String orderItemSql = "INSERT INTO OrderItems (order_id, produce_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
                            try (PreparedStatement orderItemStmt = conn.prepareStatement(orderItemSql)) {
                                for (Object[] item : farmerCart) {
                                    int produceId = (Integer) item[0];
                                    double quantity = (Double) item[1];
                                    double unitPrice = (Double) item[2];

                                    orderItemStmt.setInt(1, orderId);
                                    orderItemStmt.setInt(2, produceId);
                                    orderItemStmt.setDouble(3, quantity);
                                    orderItemStmt.setDouble(4, unitPrice);
                                    orderItemStmt.addBatch();
                                }
                                orderItemStmt.executeBatch();
                            }
                        } else {
                            throw new SQLException("Creating order failed, no ID obtained.");
                        }
                    }
                }
            }
            conn.commit();
            session.removeAttribute("cart");

            request.setAttribute("success", "Orders placed successfully!");
            request.getRequestDispatcher("buyer/orderConfirmation.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
//            try {
////                if (conn != null) {
////                    conn.rollback();
//                }
//            } catch (SQLException ex) {
//                ex.printStackTrace();
//            }
            e.printStackTrace();
            request.setAttribute("error", "Error placing order. Please try again.");
            request.getRequestDispatcher("buyer/checkout.jsp").forward(request, response);
        }
    }
}
