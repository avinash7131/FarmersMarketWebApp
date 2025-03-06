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

@WebServlet("/FarmerRegistrationServlet")
public class FarmerRegistrationServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String farmName = request.getParameter("farmName");
		String location = request.getParameter("location");
		String contactInfo = request.getParameter("contactInfo");

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(
						"INSERT INTO Farmers (username, password, farm_name, location, contact_info) VALUES (?, ?, ?, ?, ?)")) {

			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, farmName);
			pstmt.setString(4, location);
			pstmt.setString(5, contactInfo);

			int rowsAffected = pstmt.executeUpdate();

			if (rowsAffected > 0) {
				request.setAttribute("successMessage", "Successfully Registered and you can login"); // Set success
																										// message
				request.getRequestDispatcher("farmer/login.jsp").forward(request, response); // Forward to login page
			} else {
				request.setAttribute("error", "Registration failed");
				request.getRequestDispatcher("farmer/register.jsp").forward(request, response);
			}

		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			request.setAttribute("error", "Database error");
			request.getRequestDispatcher("farmer/register.jsp").forward(request, response);
		}
	}
}