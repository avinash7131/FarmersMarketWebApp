<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Farmer Registration</title>
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
            padding: 30px;
            border-radius: 10px;
            width: 80%;
            max-width: 700px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            text-align: center;
            box-sizing: border-box;
        }
        h1, h2 {
            color: #4CAF50;
            text-align: center;
        }
        h1 {
            margin-bottom: 20px;
        }
        h2 {
            margin-bottom: 10px;
        }
        p {
            line-height: 1.6;
            margin-bottom: 15px;
            text-align: left;
        }
        .btn-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        .btn, .btn-secondary {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            margin: 10px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            text-decoration: none;
        }
        .btn:hover, .btn-secondary:hover {
            background-color: #388E3C;
            transform: translateY(-2px);
        }
        .btn-secondary {
            background-color: #2196F3;
        }
        .btn-secondary:hover {
            background-color: #1976D2;
        }
        ul {
            list-style-type: disc;
            padding-left: 20px;
            text-align: left;
        }
        a {
            color: #2196F3;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .about-section, .contact-section {
            display: none;
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            width: 80%;
            max-width: 700px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .about-section.show, .contact-section.show {
            display: block;
        }
        form {
            display: flex;
            flex-direction: column;
            width: 100%;
            text-align: left;
            box-sizing: border-box;
        }
        label {
            font-weight: 600;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="password"] {
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: calc(100% - 18px);
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
            box-sizing: border-box;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 15px;
            margin-top: 20px;
            width: 100%;
        }
    </style>
    <script>
        function confirmRegistration() {
            return confirm("Are you sure you want to register as a farmer?");
        }
        function showSection(sectionId) {
            const sections = document.querySelectorAll('.about-section, .contact-section');
            sections.forEach(section => section.classList.remove('show'));
            document.getElementById(sectionId).classList.add('show');
        }
    </script>
</head>
<body>
	<div class="navbar" style="background-color: #4CAF50;">
        <a href="../index.jsp">Home</a>
        <a href="login.jsp">Login</a>
    </div>
    <div class="container">
        <div class="content">
            <h2>Farmer Registration</h2>
            <p style="text-align: center; color: #555; font-size: 0.9em;">Join our farmer community to sell your products directly to consumers.</p>
            <form action="../FarmerRegistrationServlet" method="post" onsubmit="return confirmRegistration()">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" placeholder="Choose a unique username" required>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter a strong password" required>
                <label for="farmName">Farm Name:</label>
                <input type="text" id="farmName" name="farmName" placeholder="Your farm's name" required>
                <label for="location">Location:</label>
                <input type="text" id="location" name="location" placeholder="Your farm's location" required>
                <label for="contactInfo">Contact Info:</label>
                <input type="text" id="contactInfo" name="contactInfo" placeholder="Your phone number" required>
                <input type="submit" value="Register">
            </form>
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </div>
    </div>
    <footer>
        &copy; <%= java.time.Year.now() %> Farmers Market. All rights reserved.
    </footer>
</body>
</html>