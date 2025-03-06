<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #689F38, #AED581);
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .navbar {
            background: rgba(255, 255, 255, 0.9);
            padding: 10px 15px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .navbar a {
            color: #333;
            text-decoration: none;
            margin: 0 10px;
            padding: 6px 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-size: 0.9em;
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
            padding: 10px;
        }

        .content {
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 350px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
            text-align: center;
        }

        h2 {
            color: #4CAF50;
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        p {
            font-size: 0.9em;
            margin-bottom: 10px;
        }

        a {
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9em;
        }

        a:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        footer {
            text-align: center;
            padding: 10px;
            background: #2c3e50;
            color: white;
            margin-top: 15px;
            width: 100%;
            font-size: 0.8em;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar" style="background-color: #4CAF50;">
        <a href="<%=request.getContextPath()%>/index.jsp">Home</a>
    </div>

    <!-- Order Confirmation Content -->
    <div class="container">
        <div class="content">
            <h2>Order Confirmation</h2>
            <%
                String successMessage = (String) request.getAttribute("success");

                if (successMessage != null) {
                    out.println("<p style='color: green;'>" + successMessage + "</p>");
                } else {
                    out.println("<p>Your order was processed.</p>");
                }
            %>

            <!-- Links -->
            <p>
                <a href="<%=request.getContextPath()%>/BrowseProduceServlet">Continue Shopping</a> |
                <a href="<%=request.getContextPath()%>/index.jsp">Home</a> |
                <a href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>
            </p>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        &copy; <%= java.time.Year.now() %> Farmers Market.
    </footer>
</body>
</html>
