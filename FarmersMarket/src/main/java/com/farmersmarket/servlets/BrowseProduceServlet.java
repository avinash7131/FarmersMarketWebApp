// BrowseProduceServlet.java
package com.farmersmarket.servlets;

import com.farmersmarket.models.Produce;
import com.farmersmarket.utils.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/BrowseProduceServlet")
public class BrowseProduceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Produce> produceList = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection()) {
            try (PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM Produce");
                 ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
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

                request.setAttribute("produceList", produceList);
                request.getRequestDispatcher("buyer/browseProduce.jsp").forward(request, response);

            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("buyer/browseProduce.jsp").forward(request, response);
        }
    }
}