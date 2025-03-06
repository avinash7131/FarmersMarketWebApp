<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.farmersmarket.models.Produce, java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
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
            padding: 15px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .navbar a {
            color: #333;
            text-decoration: none;
            margin: 0 15px;
            padding: 8px 15px;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-size: 1.1em;
        }

        .navbar a:hover {
            background-color: #E8F5E9;
        }

        .container {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            padding: 20px;
            margin-top: 20px;
        }

        .cart-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 800px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #4CAF50;
            text-align: center;
            font-size: 1.7em;
            margin-bottom: 20px;
        }

        .cart-item {
            background: #ffffff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .cart-item img {
            max-width: 120px;
            max-height: 120px;
            margin-right: 20px;
            border-radius: 8px;
        }

        .cart-item-details {
            flex-grow: 1;
            text-align: left;
        }

        .cart-item h3 {
            font-size: 1.2em;
            color: #333;
            margin-bottom: 5px;
        }

        .cart-item p {
            font-size: 1em;
            margin: 5px 0;
        }

        .total-price {
            text-align: center;
            font-size: 1.2em;
            font-weight: bold;
            margin-top: 20px;
        }

        .checkout-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            font-size: 1.1em;
            color: #007bff;
            text-decoration: none;
            padding: 10px 20px;
            border: 2px solid #007bff;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
        }

        .checkout-link:hover {
            background-color: #007bff;
            color: white;
        }

        footer {
            text-align: center;
            padding: 15px;
            background: #2c3e50;
            color: white;
            margin-top: 30px;
            width: 100%;
            font-size: 0.9em;
        }

        .empty-cart {
            text-align: center;
            font-size: 1.2em;
            color: #ff5722;
            margin-top: 30px;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar" style="background-color: #4CAF50;">
        <a href="<%=request.getContextPath()%>/index.jsp">Home</a>
        <a href="<%=request.getContextPath()%>/BrowseProduceServlet">Browse Produce</a>
		<a href="<%=request.getContextPath()%>/CartServlet">View Cart</a> 
		<a href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>
    </div>

    <!-- Cart Container -->
    <div class="container">
        <div class="cart-container">
            <h2>Your Cart</h2>

            <%
                List<Produce> cartItems = (List<Produce>) request.getAttribute("cartItems");
                List<Object[]> cart = (List<Object[]>) session.getAttribute("cart");
                Object totalObj = request.getAttribute("totalPrice");
                double totalPrice = (totalObj != null) ? Double.parseDouble(totalObj.toString()) : 0.0;

                if (cartItems != null && !cartItems.isEmpty() && cart != null) {
                    for (int i = 0; i < cartItems.size(); i++) {
                        Produce produce = cartItems.get(i);
                        if (i < cart.size()) {
                            Object[] item = cart.get(i);
                            Number quantity = (Number) item[1];
            %>
                    <!-- Cart Item -->
                    <div class="cart-item">
                            <img src="<%= produce.getImagePath() %>" alt="<%= produce.getProduceName() %>">
                            <div class="cart-item-details">
                                <h3><%= produce.getProduceName() %></h3>
                                <p>Price: $<%= produce.getPrice() %> (<%= produce.getUnit() %>)</p>
                                <p>Quantity: <%= quantity %></p>
                                <p>Subtotal: $<%= produce.getPrice() * quantity.doubleValue() %></p>
                            </div>
                    </div>
            <%
                        }
                    }
                } else {
            %>
                <div class="empty-cart">Your cart is empty.</div>
            <% } %>

            <!-- Total Price and Checkout Link -->
            <% if (totalPrice > 0) { %>
                <p class="total-price">Total Price: $<%= totalPrice %></p>
                <a class="checkout-link" href="<%= request.getContextPath() %>/buyer/checkout.jsp">Proceed to Checkout</a>
            <% } %>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        &copy; <%= java.time.Year.now() %> Farmers Market.
    </footer>
</body>
</html>
