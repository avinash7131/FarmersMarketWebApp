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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/FarmerProduceListServlet")
public class FarmerProduceListServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(FarmerProduceListServlet.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer farmerId = (Integer) session.getAttribute("farmerId");

        if (farmerId == null) {
            LOGGER.log(Level.WARNING, "Farmer ID is null. Redirecting to login.");
            response.sendRedirect("farmer/login.jsp");
            return;
        }

        LOGGER.log(Level.INFO, "Farmer ID: " + farmerId);

        List<Produce> produceList = new ArrayList<>();

        String sql = "SELECT * FROM Produce WHERE farmer_id = ?";
        LOGGER.log(Level.INFO, "SQL: " + sql + ", farmerId: " + farmerId);

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, farmerId);
            ResultSet rs = pstmt.executeQuery();

            int rowCount = 0;
            while (rs.next()) {
                rowCount++;
                Produce produce = new Produce();
                produce.setProduceId(rs.getInt("produce_id"));
                produce.setFarmerId(rs.getInt("farmer_id"));
                produce.setProduceName(rs.getString("produce_name"));
                produce.setDescription(rs.getString("description"));
                produce.setQuantity(rs.getDouble("quantity"));
                produce.setUnit(rs.getString("unit"));
                produce.setPrice(rs.getDouble("price"));
                produce.setImagePath(rs.getString("image_path"));
                produceList.add(produce);
            }

            LOGGER.log(Level.INFO, "Number of Rows Returned: " + rowCount);

            request.setAttribute("produceList", produceList);
            request.getRequestDispatcher("farmer/produceList.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Database error: " + e.getMessage(), e);
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("farmer/produceList.jsp").forward(request, response);
        }
    }
}