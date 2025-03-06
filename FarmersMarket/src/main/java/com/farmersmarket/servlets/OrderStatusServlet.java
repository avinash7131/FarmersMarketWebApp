// OrderStatusServlet.java
package com.farmersmarket.servlets;

import com.farmersmarket.utils.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/OrderStatusServlet")
public class OrderStatusServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		String orderStatus = request.getParameter("orderStatus");

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn
						.prepareStatement("UPDATE Orders SET order_status = ? WHERE order_id = ?")) {

			pstmt.setString(1, orderStatus);
			pstmt.setInt(2, orderId);
			pstmt.executeUpdate();

			response.sendRedirect("farmer/orders.jsp");

		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			request.setAttribute("error", "Failed to update order status");
			request.getRequestDispatcher("farmer/orders.jsp").forward(request, response);
		}
	}
}