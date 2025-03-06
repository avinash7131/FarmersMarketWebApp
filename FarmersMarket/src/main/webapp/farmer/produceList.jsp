<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.farmersmarket.models.Produce, java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<title>Produce List</title>
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
	max-width: 800px; /* Adjusted for table width */
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

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 15px;
}

th, td {
	border-bottom: 1px solid #ddd;
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

button {
	background-color: #e74c3c;
	color: white;
	border: none;
	padding: 7px 10px;
	cursor: pointer;
	border-radius: 5px;
	transition: 0.3s;
}

button:hover {
	background-color: #c0392b;
}

.produce-actions {
	display: flex;
	flex-direction: column;
	gap: 6px;
}

input[type="text"], input[type="number"] {
	padding: 6px;
	border: 1px solid #ccc;
	border-radius: 4px;
	width: 100%;
}

.update-btn {
	background-color: #27ae60;
}

.update-btn:hover {
	background-color: #219856;
}

footer {
	text-align: center;
	padding: 15px;
	background: #2c3e50;
	color: white;
	margin-top: 20px;
	width: 100%; /* Ensure footer spans full width */
	position: relative; /* Keep footer in normal flow */
}
</style>
</head>
<body>
	<div class="navbar" style="background-color: #4CAF50;">
		<a href="<%=request.getContextPath()%>/farmer/addProduce.jsp">Add
			Produce</a> <a href="<%=request.getContextPath()%>/FarmerOrdersServlet">View
			Orders</a> <a href="<%=request.getContextPath()%>/index.jsp">Home</a> <a
			href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>
	</div>
	<div class="container">
		<div class="content">
			<h2>Produce List</h2>
			<%
			List<Produce> produceList = (List<Produce>) request.getAttribute("produceList");
			%>
			<%
			if (produceList != null && !produceList.isEmpty()) {
			%>
			<table>
				<tr>
					<th>Name</th>
					<th>Description</th>
					<th>Price</th>
					<th>Quantity</th>
					<th>Unit</th>
					<th>Actions</th>
				</tr>
				<%
				for (Produce produce : produceList) {
				%>
				<tr>
					<td><%=produce.getProduceName()%></td>
					<td><%=produce.getDescription()%></td>
					<td>$<%=produce.getPrice()%></td>
					<td><%=produce.getQuantity()%></td>
					<td><%=produce.getUnit()%></td>
					<td class="produce-actions">
						<form
							action='<%=request.getContextPath()%>/ManageProduceServlet'
							method='post'>
							<input type='hidden' name='produceId'
								value='<%=produce.getProduceId()%>'> <input
								type='hidden' name='action' value='delete'>
							<button type='submit'>Delete</button>
						</form>
						<form
							action='<%=request.getContextPath()%>/ManageProduceServlet'
							method='post'>
							<input type='hidden' name='produceId'
								value='<%=produce.getProduceId()%>'> <input
								type='hidden' name='action' value='update'> <input
								type='text' name='produceName' placeholder='Name'
								value='<%=produce.getProduceName()%>'> <input
								type='text' name='description' placeholder='Description'
								value='<%=produce.getDescription()%>'> <input
								type='number' name='quantity' placeholder='Quantity'
								value='<%=produce.getQuantity()%>'> <input type='text'
								name='unit' placeholder='Unit' value='<%=produce.getUnit()%>'>
							<input type='number' name='price' placeholder='Price'
								value='<%=produce.getPrice()%>'>
							<button type='submit' class='update-btn'>Update</button>
						</form>
					</td>
				</tr>
				<%
				}
				%>
			</table>
			<%
			} else {
			%>
			<p style="text-align: center; font-size: 1.1em; color: #888;">No
				produce available.</p>
			<%
			}
			%>
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