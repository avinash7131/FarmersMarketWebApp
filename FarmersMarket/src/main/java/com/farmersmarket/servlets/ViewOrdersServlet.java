// ViewOrdersServlet.java
package com.farmersmarket.servlets;

import com.farmersmarket.models.Order;
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

@WebServlet("/ViewOrdersServlet")
public class ViewOrdersServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		int farmerId = (int) session.getAttribute("farmerId");

		List<Order> orders = new ArrayList<>();

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM Orders WHERE farmer_id = ?")) {

			pstmt.setInt(1, farmerId);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				Order order = new Order(rs.getInt("order_id"), rs.getInt("buyer_id"), rs.getInt("farmer_id"),
						rs.getTimestamp("order_date"), rs.getDouble("total_amount"), rs.getString("order_status"),
						rs.getString("shipping_address"));
				orders.add(order);
			}

			request.setAttribute("orders", orders);
			request.getRequestDispatcher("farmer/orders.jsp").forward(request, response);

		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			request.setAttribute("error", "Database error during order retrieval");
			request.getRequestDispatcher("farmer/orders.jsp").forward(request, response);
		}
	}
}
