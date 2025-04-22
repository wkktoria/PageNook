<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <title>PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h1 class="page-heading">Administrative Dashboard</h1>
    <hr style="width: 60%"/>
</div>

<div class="center">
    <h2 class="page-heading">Quick Actions:</h2>
    <a href="new_book">New Book</a> |
    <a href="user_form.jsp">New User</a> |
    <a href="category_form.jsp">New Category</a> |
    <a href="new_customer">New Customer</a>
    <hr style="width: 60%"/>
</div>

<div class="center">
    <h2 class="page-heading">Recent Sales:</h2>
    <table>
        <tr>
            <th>Order ID</th>
            <th>Ordered by</th>
            <th>Book Copies</th>
            <th>Total</th>
            <th>Payment Method</th>
            <th>Status</th>
            <th>Order Date</th>
        </tr>
        <c:forEach items="${listMostRecentSales}" var="order" varStatus="status">
            <tr>
                <td>
                    <a href="view_order?id=${order.orderId}">${order.orderId}</a>
                </td>
                <td>${order.customer.fullname}</td>
                <td>${order.bookCopies}</td>
                <td><fmt:formatNumber value="${order.total}" type="currency"/></td>
                <td>${order.paymentMethod}</td>
                <td>${order.status}</td>
                <td>${order.orderDate}</td>
            </tr>
        </c:forEach>
    </table>
    <hr style="width: 60%"/>
</div>

<div class="center">
    <h2 class="page-heading">Recent Reviews:</h2>
    <table>
        <tr>
            <th>Book</th>
            <th>Rating</th>
            <th>Headline</th>
            <th>Customer</th>
            <th>Review On</th>
        </tr>
        <c:forEach items="${listMostRecentReviews}" var="review" varStatus="status">
            <tr>
                <td>${review.book.title}</td>
                <td>${review.rating}</td>
                <td>
                    <a href="edit_review?id=${review.reviewId}">${review.headline}</a>
                </td>
                <td>${review.customer.fullname}</td>
                <td>${review.reviewTime}</td>
            </tr>
        </c:forEach>
    </table>
    <hr style="width: 60%"/>
</div>

<div class="center">
    <h2 class="page-heading">Statistics:</h2>
    <span>Total Users: ${totalUsers}</span> <span>Total Books: ${totalBooks}</span>
    <span>Total Customers: ${totalCustomers}</span> <span>Total Reviews: ${totalReviews}</span>
    <span>Total Orders: ${totalOrders}</span>
    <hr style="width: 60%"/>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
