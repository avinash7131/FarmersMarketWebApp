<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Produce</title>
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
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
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
            max-width: 500px;
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

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 3px;
            font-weight: 600;
            font-size: 0.9em;
        }

        input[type="text"],
        input[type="number"],
        textarea,
        input[type="file"] {
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 0.9em;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
        }

        button[type="submit"] {
            background-color: #27ae60;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #219856;
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
            <h2>Add Produce</h2>
            <form action="${pageContext.request.contextPath}/AddProduceServlet" method="post" enctype="multipart/form-data">
                <label for="produceName">Produce Name:</label>
                <input type="text" id="produceName" name="produceName" required>

                <label for="description">Description:</label>
                <textarea id="description" name="description" required></textarea>

                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" required>

                <label for="unit">Unit:</label>
                <input type="text" id="unit" name="unit" required>

                <label for="price">Price:</label>
                <input type="number" id="price" name="price" required>

                <label for="image">Image:</label>
                <input type="file" id="image" name="image" accept="image/*" required>

                <button type="submit">Add Produce</button>
            </form>
        </div>
    </div>
    <footer>
        &copy; <%= java.time.Year.now() %> Farmers Market. All rights reserved.
    </footer>
</body>
</html>