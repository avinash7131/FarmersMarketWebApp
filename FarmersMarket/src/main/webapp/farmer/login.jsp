<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Farmer Login</title>
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
            width: 100%;
        }
        .content {
            background: rgba(255, 255, 255, 0.9);
            padding: 40px; /* Increased padding */
            border-radius: 12px; /* More rounded corners */
            width: 80%;
            max-width: 450px; /* Adjusted max-width */
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1); /* Deeper shadow */
            margin-bottom: 30px; /* Increased margin */
            text-align: center;
            box-sizing: border-box;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .content:hover {
            transform: translateY(-8px); /* More pronounced lift */
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
        }
        h2 {
            color: #4CAF50;
            margin-bottom: 30px;
            font-size: 2em; /* Larger heading */
            letter-spacing: 1px; /* Slight letter spacing */
        }
        p {
            line-height: 1.7;
            margin-bottom: 30px;
            text-align: center;
            color: #555;
        }
        form {
            display: flex;
            flex-direction: column;
            width: 100%;
            text-align: left;
            box-sizing: border-box;
            max-width: 380px;
            margin: 0 auto;
        }
        label {
            font-weight: 600;
            margin-bottom: 10px;
            color: #444;
            transition: color 0.3s;
        }
        label:hover{
            color: #388E3C;
        }
        input[type="text"], input[type="password"] {
            padding: 14px;
            margin-bottom: 25px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            width: calc(100% - 28px);
            box-sizing: border-box;
            transition: border-color 0.3s, box-shadow 0.3s;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #4CAF50;
            outline: none;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        input[type="submit"] {
            background: linear-gradient(to right, #4CAF50, #66BB6A); /* Gradient button */
            color: white;
            padding: 16px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            width: 100%;
            box-sizing: border-box;
            font-size: 1.1em;
            font-weight: 600;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        input[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 15px;
            margin-top: 30px;
            width: 100%;
        }
        .success-message {
            color: green;
            margin-bottom: 20px;
            text-align: center;
        }
        a{
            transition: color 0.3s;
        }
        a:hover{
            color: #388E3C;
        }
    </style>
</head>
<body>
	<div class="navbar" style="background-color: #4CAF50;">
        <a href="<%=request.getContextPath()%>/index.jsp">Home</a>
        <a href="register.jsp">Register</a>
    </div>
    <div class="container">
        <div class="content">
            <h2>Farmer Login</h2>
            <% String successMessage = (String) request.getAttribute("successMessage");
               if (successMessage != null) {
                   out.println("<p class='success-message'>" + successMessage + "</p>");
               }
            %>
            <form action="<%=request.getContextPath()%>/FarmerLoginServlet" method="post">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" placeholder="Enter username" required>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter password" required>
                <input type="submit" value="Login">
            </form>
            <p>New here? <a href="register.jsp">Create an account</a></p>
        </div>
    </div>
    <footer>
        &copy; <%= java.time.Year.now() %> Farmers Market. All rights reserved.
    </footer>
</body>
</html>