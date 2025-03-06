package com.farmersmarket.servlets;

import com.farmersmarket.utils.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/AddProduceServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 5,      // 5 MB
        maxRequestSize = 1024 * 1024 * 10)   // 10 MB
public class AddProduceServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AddProduceServlet.class.getName());
    private static final String UPLOAD_DIRECTORY = "images"; // Directory to store images

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.log(Level.INFO, "AddProduceServlet called.");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("farmerId") == null) {
            response.sendRedirect("../login.jsp");
            return;
        }

        int farmerId = (Integer) session.getAttribute("farmerId");
        String produceName = request.getParameter("produceName");
        String description = request.getParameter("description");
        double quantity = Double.parseDouble(request.getParameter("quantity"));
        String unit = request.getParameter("unit");
        double price = Double.parseDouble(request.getParameter("price"));

        // Handle image upload
        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        String filePath = uploadPath + File.separator + fileName;
        LOGGER.log(Level.INFO, "File path: " + filePath);
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, Paths.get(filePath));
        }

        String relativeImagePath = UPLOAD_DIRECTORY + "/" + fileName; // Path to store in database
        LOGGER.log(Level.INFO, "relativeImagePath: " + relativeImagePath);
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                     "INSERT INTO Produce (farmer_id, produce_name, description, quantity, unit, price, image_path) VALUES (?, ?, ?, ?, ?, ?, ?)")) {

            pstmt.setInt(1, farmerId);
            pstmt.setString(2, produceName);
            pstmt.setString(3, description);
            pstmt.setDouble(4, quantity);
            pstmt.setString(5, unit);
            pstmt.setDouble(6, price);
            pstmt.setString(7, relativeImagePath);
            LOGGER.log(Level.INFO, "SQL: INSERT INTO Produce ...");
            int rowsAffected = pstmt.executeUpdate();
            LOGGER.log(Level.INFO, "Rows Affected: " + rowsAffected);

            request.setAttribute("success", "Produce item added successfully.");
            LOGGER.log(Level.INFO, "Produce item '" + produceName + "' added successfully.");
            response.sendRedirect(request.getContextPath() + "/FarmerProduceListServlet"); // Redirect to the produce list

        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Database error during produce addition.", e);
            request.setAttribute("error", "Database error during produce addition: " + e.getMessage());
            request.getRequestDispatcher("addProduce.jsp").forward(request, response);
        }
    }
}