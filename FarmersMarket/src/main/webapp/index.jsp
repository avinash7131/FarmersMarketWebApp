<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Farmers' Market - Fresh & Local</title>
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
	max-width: 700px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

h1 {
	color: #4CAF50;
	margin-bottom: 20px;
}

p {
	line-height: 1.6;
	margin-bottom: 15px;
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
}

a {
	color: #2196F3;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

.about-section, .contact-section {
	display: none; /* Initially hide these sections */
	background: rgba(255, 255, 255, 0.9);
	padding: 30px;
	border-radius: 10px;
	width: 80%;
	max-width: 700px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

.about-section.show, .contact-section.show {
	display: block; /* Show when 'show' class is added */
}
</style>
<script>
        function showSection(sectionId) {
            const sections = document.querySelectorAll('.about-section, .contact-section');
            sections.forEach(section => section.classList.remove('show'));
            document.getElementById(sectionId).classList.add('show');
        }
    </script>
</head>
<body>
	<div class="navbar" style="background-color: #4CAF50;">
		<a href="#">Home</a> <a href="javascript:void(0);"
			onclick="showSection('about')">About</a> <a
			href="javascript:void(0);" onclick="showSection('contact')">Contact</a>
	</div>


	<div class="container">
		<div class="content">
			<h1>Fresh & Local Farmers' Market</h1>
			<p>Welcome! This is a simple platform to connect farmers with
				buyers for fresh, organic produce. Enjoy!</p>
			<div class="btn-container">
				<a href="farmer/login.jsp" class="btn">Farmer Login</a> <a
					href="farmer/register.jsp" class="btn btn-secondary">Farmer
					Registration</a> <a href="buyer/login.jsp" class="btn">Buyer Login</a>
				<a href="buyer/register.jsp" class="btn btn-secondary">Buyer
					Registration</a>
			</div>
		</div>

		<div id="about" class="about-section">
			<h2>About This Project</h2>
			<p>This project is a fun way to bring local farmers and buyers
				together. It's all about fresh food and supporting our community!</p>
			<p>
				<strong>What we have:</strong>
			</p>
			<ul>
				<li>Simple logins for farmers and buyers.</li>
				<li>Easy registration.</li>
				<li>A place to connect!</li>
			</ul>
			<p>
				<strong>What we hope to add:</strong>
			</p>
			<ul>
				<li>More features for farmers to show their products.</li>
				<li>Ways for buyers to find what they need easily.</li>
				<li>Maybe even online orders!</li>
			</ul>
		</div>

		<div id="contact" class="contact-section">
			<h2>Get in Touch!</h2>
			<p>
				<strong>Name:</strong> Avinash
			</p>
			<p>
				<strong>Phone:</strong> 9704471311
			</p>
			<p>
				<strong>Email:</strong> <a
					href="mailto:avinashreddy1742001@gmail.com">avinashreddy1742001@gmail.com</a>
			</p>
			<p>
				<strong>LinkedIn:</strong> <a
					href="https://www.linkedin.com/in/kolta-budde-avinash-9169b2290"
					target="_blank">LinkedIn</a>
			</p>
			<p>
				<strong>GitHub:</strong> <a href="https://github.com/avinash7131"
					target="_blank">GitHub</a>
			</p>
		</div>
	</div>
	<div
		style="text-align: center; position: fixed; bottom: 0; width: 100%;">
		&copy;
		<%=java.time.Year.now()%>
		Farmers Market. All rights reserved.
	</div>
</body>
</html>