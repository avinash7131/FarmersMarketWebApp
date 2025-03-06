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
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/ManageProduceServlet")
public class ManageProduceServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ManageProduceServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("farmerId") == null) {
            response.sendRedirect("../login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String produceIdParam = request.getParameter("produceId");

        if (produceIdParam == null || produceIdParam.trim().isEmpty() || !isNumeric(produceIdParam)) {
            request.setAttribute("error", "Invalid produce ID.");
            request.getRequestDispatcher("farmer/produceList.jsp").forward(request, response);
            return;
        }

        int produceId = Integer.parseInt(produceIdParam);

        if ("delete".equals(action)) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                conn.setAutoCommit(false); // Start transaction

                // Delete order items first
                try (PreparedStatement deleteOrderItems = conn.prepareStatement("DELETE FROM orderitems WHERE produce_id = ?")) {
                    deleteOrderItems.setInt(1, produceId);
                    deleteOrderItems.executeUpdate();
                }

                // Then delete the produce
                try (PreparedStatement deleteProduce = conn.prepareStatement("DELETE FROM Produce WHERE produce_id = ?")) {
                    deleteProduce.setInt(1, produceId);
                    int rowsAffected = deleteProduce.executeUpdate();

                    if (rowsAffected > 0) {
                        conn.commit(); // Commit transaction
                        request.setAttribute("success", "Produce item deleted successfully.");
                        LOGGER.log(Level.INFO, "Produce item with ID " + produceId + " and associated orders deleted.");
                    } else {
                        conn.rollback(); // Rollback on failure
                        request.setAttribute("error", "Produce item not found.");
                        LOGGER.log(Level.WARNING, "Produce item with ID " + produceId + " not found for deletion.");
                    }
                }
            } catch (SQLException | ClassNotFoundException e) {
                LOGGER.log(Level.SEVERE, "Database error during produce deletion.", e);
                request.setAttribute("error", "Database error during produce deletion: " + e.getMessage());
                try(Connection conn = DatabaseConnection.getConnection()){
                    conn.rollback();
                }catch(SQLException | ClassNotFoundException rollbackException){
                    LOGGER.log(Level.SEVERE,"Rollback failed",rollbackException);
                }
            } finally {
                try(Connection conn = DatabaseConnection.getConnection()){
                    conn.setAutoCommit(true);
                } catch(SQLException | ClassNotFoundException autoCommitException){
                    LOGGER.log(Level.SEVERE,"Resetting autocommit failed",autoCommitException);
                }
            }
            response.sendRedirect("FarmerProduceListServlet"); // Redirect to the servlet to refresh the list.
            return; // Add return to prevent further processing.
        } else if ("update".equals(action)) {
            String produceName = request.getParameter("produceName");
            String description = request.getParameter("description");
            String quantityParam = request.getParameter("quantity");
            String unit = request.getParameter("unit");
            String priceParam = request.getParameter("price");

            if (produceName == null || produceName.trim().isEmpty() || quantityParam == null
                    || quantityParam.trim().isEmpty() || !isNumeric(quantityParam) || unit == null
                    || unit.trim().isEmpty() || priceParam == null || priceParam.trim().isEmpty()
                    || !isNumeric(priceParam)) {
                request.setAttribute("error", "Invalid input data for update.");
                request.getRequestDispatcher("farmer/produceList.jsp").forward(request, response);
                return;
            }

            double quantity = Double.parseDouble(quantityParam);
            double price = Double.parseDouble(priceParam);

            try (Connection conn = DatabaseConnection.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(
                         "UPDATE Produce SET produce_name = ?, description = ?, quantity = ?, unit = ?, price = ? WHERE produce_id = ?")) {

                pstmt.setString(1, produceName);
                pstmt.setString(2, description);
                pstmt.setDouble(3, quantity);
                pstmt.setString(4, unit);
                pstmt.setDouble(5, price);
                pstmt.setInt(6, produceId);

                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    request.setAttribute("success", "Produce item updated successfully.");
                    LOGGER.log(Level.INFO, "Produce item with ID " + produceId + " updated.");
                } else {
                    request.setAttribute("error", "Produce item not found for update.");
                    LOGGER.log(Level.WARNING, "Produce item with ID " + produceId + " not found for update.");
                }

                response.sendRedirect("FarmerProduceListServlet"); //Redirect after successful update.
                return; // Add return to prevent further processing.

            } catch (SQLException | ClassNotFoundException e) {
                LOGGER.log(Level.SEVERE, "Database error during produce update.", e);
                request.setAttribute("error", "Database error during produce update: " + e.getMessage());
                request.getRequestDispatcher("farmer/produceList.jsp").forward(request, response);
                return; // Add return to prevent further processing.
            }
        } else {
            request.setAttribute("error", "Invalid action.");
            request.getRequestDispatcher("farmer/produceList.jsp").forward(request, response);
            return; // Add return to prevent further processing.
        }
    }

    private boolean isNumeric(String str) {
        if (str == null) {
            return false;
        }
        try {
            Double.parseDouble(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}