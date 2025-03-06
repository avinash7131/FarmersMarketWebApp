<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Buyer Registration</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        }

        h2 {
            color: #4CAF50;
            text-align: center;
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        p {
            line-height: 1.4;
            margin-bottom: 10px;
            font-size: 0.9em;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            text-align: left;
            margin-bottom: 3px;
            font-weight: 600;
            font-size: 0.9em;
        }

        input {
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 0.9em;
        }

        input[type="submit"] {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px;
            font-size: 0.9em;
            cursor: pointer;
            border-radius: 4px;
            font-weight: bold;
        }

        input[type="submit"]:hover {
            background: #0056b3;
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
	<div class="navbar" style="background-color: #4CAF50;">
        <a href="<%=request.getContextPath()%>/index.jsp">Home</a>
    </div>
    <div class="container">
        <div class="content">
            <h2>Buyer Registration</h2>
            <p>
                Register to buy fresh produce.
            </p>
            <form action="<%=request.getContextPath()%>/BuyerRegistrationServlet" method="post">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <label for="contactInfo">Contact Info:</label>
                <input type="text" id="contactInfo" name="contactInfo" required>

                <input type="submit" value="Register">
            </form>
            <p>
                Already have an account? <a href="<%=request.getContextPath()%>/buyer/login.jsp">Login</a>
            </p>
        </div>
    </div>
    <footer>
        &copy; <%= java.time.Year.now() %> Farmers Market.
    </footer>
</body>
</html>