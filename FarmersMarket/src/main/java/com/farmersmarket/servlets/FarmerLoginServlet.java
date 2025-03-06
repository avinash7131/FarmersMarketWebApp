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

@WebServlet("/FarmerLoginServlet")

public class FarmerLoginServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)

			throws ServletException, IOException {

		String username = request.getParameter("username");

		String password = request.getParameter("password");

		try (Connection conn = DatabaseConnection.getConnection();

				PreparedStatement pstmt = conn

						.prepareStatement("SELECT farmer_id FROM Farmers WHERE username = ? AND password = ?")) {

			pstmt.setString(1, username);

			pstmt.setString(2, password);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {

				HttpSession session = request.getSession();

				session.setAttribute("farmerId", rs.getInt("farmer_id"));

				response.sendRedirect("FarmerProduceListServlet");

			} else {

				request.setAttribute("error", "Invalid username or password");

				request.getRequestDispatcher("farmer/login.jsp").forward(request, response);

			}

		} catch (SQLException | ClassNotFoundException e) {

			e.printStackTrace();

			request.setAttribute("error", "Database error");

			request.getRequestDispatcher("farmer/login.jsp").forward(request, response);

		}

	}

}