
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int produceId = Integer.parseInt(request.getParameter("produceId"));
        double quantity = Double.parseDouble(request.getParameter("quantity"));

        HttpSession session = request.getSession();
        List<Object[]> cart = (List<Object[]>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        double unitPrice = -1;
        int farmerId = -1;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT price, farmer_id FROM Produce WHERE produce_id = ?")) {
            pstmt.setInt(1, produceId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    unitPrice = rs.getDouble("price");
                    farmerId = rs.getInt("farmer_id");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        if (unitPrice != -1 && farmerId != -1) {
            Object[] item = new Object[]{produceId, quantity, unitPrice, farmerId};
            cart.add(item);
            response.sendRedirect("CartServlet");
        } else {
            request.setAttribute("error", "Error adding item to cart. Please try again.");
            request.getRequestDispatcher("BrowseProduceServlet").forward(request, response);
        }
    }
}