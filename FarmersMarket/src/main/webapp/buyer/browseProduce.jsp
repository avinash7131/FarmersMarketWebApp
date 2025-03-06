<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.farmersmarket.models.Produce, java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<title>Browse Produce</title>
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
	margin: 0 15px;
	padding: 8px 12px;
	border-radius: 5px;
	transition: background-color 0.3s;
	font-size: 1em;
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
	border-radius: 8px;
	width: 80%;
	max-width: 1200px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

h2 {
	color: #4CAF50;
	text-align: center;
	font-size: 2em;
	margin-bottom: 20px;
}

p {
	line-height: 1.5;
	margin-bottom: 20px;
	font-size: 1.1em;
	text-align: center;
}

/* Produce Grid */
.grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
	gap: 20px;
	margin-top: 20px;
}

.produce-item {
	background: #ffffff;
	padding: 10px; /* Reduced padding */
	border-radius: 8px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	text-align: center;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	font-size: 0.9em; /* Reduced font size */
}

.produce-item:hover {
	transform: translateY(-5px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
}

.produce-item img {
	width: 100%;
	height: auto;
	max-height: 180px; /* Reduced max-height */
	object-fit: contain;
	margin-bottom: 10px; /* Reduced margin */
	border-radius: 4px;
}

.produce-item h3 {
	font-size: 1.2em; /* Reduced font size */
	color: #388E3C;
	margin-bottom: 8px; /* Reduced margin */
}

.produce-item p {
	font-size: 1em; /* Reduced font size */
	color: #555;
	margin-bottom: 8px; /* Reduced margin */
}

.produce-item span {
	font-size: 1.1em; /* Slightly reduced font size */
	font-weight: bold;
	color: #007bff;
	display: block;
	margin-bottom: 12px; /* Reduced margin */
}

.produce-item form {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.produce-item input[type="number"] {
	width: 60px; /* Reduced width */
	padding: 6px; /* Reduced padding */
	font-size: 0.9em; /* Reduced font size */
	margin-bottom: 10px; /* Reduced margin */
	border-radius: 4px;
	border: 1px solid #ccc;
}

.produce-item input[type="submit"] {
	padding: 10px 15px; /* Reduced padding */
	font-size: 1em; /* Reduced font size */
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.produce-item input[type="submit"]:hover {
	background-color: #388E3C;
}

footer {
	text-align: center;
	padding: 15px;
	background: #2c3e50;
	color: white;
	margin-top: 20px;
	width: 100%;
	font-size: 1em;
}

/* Responsive Design */
@media screen and (max-width: 768px) {
	.navbar a {
		font-size: 1em;
		margin: 0 10px;
	}
	.content {
		padding: 20px;
		width: 90%;
	}
	h2 {
		font-size: 1.8em;
	}
	.produce-item h3 {
		font-size: 1.1em;
	}
	.produce-item p {
		font-size: 1em;
	}
}

@media screen and (max-width: 480px) {
	h2 {
		font-size: 1.5em;
	}
	.navbar a {
		font-size: 1em;
		margin: 0 5px;
	}
	.content {
		padding: 15px;
		width: 100%;
	}
	.produce-item {
		padding: 10px; /* Reduced padding */
	}
	.produce-item h3 {
		font-size: 1.1em; /* Reduced font size */
	}
	.produce-item input[type="number"] {
		width: 50px; /* Reduced width */
	}
	.produce-item input[type="submit"] {
		padding: 8px 12px; /* Reduced padding */
	}
}
</style>

</head>
<body>
	<div class="navbar" style="background-color: #4CAF50;">
		<a href="<%=request.getContextPath()%>/index.jsp">Home</a> <a
			href="<%=request.getContextPath()%>/CartServlet">View Cart</a> <a
			href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>
	</div>

	<div class="container">
		<div class="content">
			<h2>Browse Produce</h2>
			<p>Welcome to the Farmers Market! Here you can browse a wide variety of fresh, locally sourced produce directly from farmers. Select your favorite items, add them to your cart, and enjoy healthy, fresh food delivered to your doorstep.</p>

			<%
			List<Produce> produceList = (List<Produce>) request.getAttribute("produceList");
			%>

			<%
			if (produceList != null && !produceList.isEmpty()) {
			%>
			<div class="grid">
				<%
				for (Produce produce : produceList) {
				%>
				<div class="produce-item">
					<img src="<%=produce.getImagePath()%>" alt="<%=produce.getProduceName()%>">
					<h3><%=produce.getProduceName()%></h3>
					<p><%=produce.getDescription()%></p>
					<span>Price: $<%=String.format("%.2f", produce.getPrice())%> (<%=produce.getUnit()%>)</span>
					<p>Farmer ID: <%=produce.getFarmerId()%></p>
					<form action="<%=request.getContextPath()%>/AddToCartServlet" method="get">
						<input type="hidden" name="produceId" value="<%=produce.getProduceId()%>">
						Quantity: <input type="number" name="quantity" value="1" min="1" step="1" required><br>
						<input type="submit" value="Add to Cart">
					</form>
				</div>
				<%
				}
				%>
			</div>
			<%
			} else {
			%>
			<p>No produce available.</p>
			<%
			}
			%>
		</div>
	</div>

	<footer>
		&copy;
		<%=java.time.Year.now()%> Farmers Market.
	</footer>
</body>
</html>
