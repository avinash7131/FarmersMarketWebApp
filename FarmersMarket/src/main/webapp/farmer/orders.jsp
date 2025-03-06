<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.farmersmarket.models.Order, java.util.List, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Farmer Orders</title>
    <style>
        body {
            background: linear-gradient(135deg, #689F38, #AED581);
            color: #333;
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .navbar {
            background: rgba(255, 255, 255, 0.9);
            padding: 15px 20px;
            text-align: center;
            box-box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .navbar a {
            color: #333;
            text-decoration: none;
            margin: 0 15px;
            padding: 8px 12px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .navbar a:hover {
            background-color: #E8F5E9;
        }

        .container {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .content {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            width: 80%;
            max-width: 900px; /* Adjusted for table width */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        h1, h2 {
            color: #4CAF50;
            text-align: center;
        }

        h1 {
            margin-bottom: 20px;
        }

        h2 {
            margin-bottom: 15px;
        }

        p {
            line-height: 1.6;
            margin-bottom: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            border: 1px solid #ddd;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #2c3e50;
            color: white;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .no-orders {
            text-align: center;
            color: #777;
            margin-top: 20px;
            font-size: 16px;
        }

        footer {
            text-align: center;
            padding: 15px;
            background: #2c3e50;
            color: white;
            margin-top: 20px;
            width: 100%;
            position: relative;
        }
    </style>
</head>
<body>
	<div class="navbar" style="background-color: #4CAF50;">
        <a href="<%= request.getContextPath() %>/index.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
        <a href="<%= request.getContextPath() %>/FarmerProduceListServlet">My Produce</a>
        <a href="<%= request.getContextPath() %>/FarmerOrdersServlet">View Orders</a>
    </div>
    <div class="container">
        <div class="content">
            <h2>Your Orders</h2>
            <% List<Order> orderList = (List<Order>) request.getAttribute("orderList"); %>
            <% if (orderList != null && !orderList.isEmpty()) { %>
                <% SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Buyer ID</th>
                            <th>Total Amount</th>
                            <th>Shipping Address</th>
                            <th>Status</th>
                            <th>Order Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Order order : orderList) { %>
                        <tr>
                            <td><%= order.getOrderId() %></td>
                            <td><%= order.getBuyerId() %></td>
                            <td>$<%= order.getTotalAmount() %></td>
                            <td><%= order.getShippingAddress() %></td>
                            <td><%= order.getOrderStatus() %></td>
                            <td><%= sdf.format(order.getOrderDate()) %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <p class="no-orders">No orders found.</p>
            <% } %>
        </div>
    </div>
    <footer>
        &copy; <%= java.time.Year.now() %> Farmers Market. All rights reserved.
    </footer>
</body>
</html>