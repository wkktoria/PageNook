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
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
    <title>Order Details | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h1 class="page-heading">Details of Order ID: ${order.orderId}</h1>
    <hr style="width: 60%"/>
</div>

<c:if test="${message != null}">
    <div class="center">
        <h4 class="message">${message}</h4>
    </div>
</c:if>

<div class="center">
    <h3>Order Overview:</h3>
    <table>
        <tr>
            <td class="left"><b>Ordered by:</b></td>
            <td class="left">${order.customer.fullname}</td>
        </tr>
        <tr>
            <td class="left"><b>Order Status:</b></td>
            <td class="left">${order.status}</td>
        </tr>
        <tr>
            <td class="left"><b>Order Date:</b></td>
            <td class="left">${order.orderDate}</td>
        </tr>
        <tr>
            <td class="left"><b>Payment Method:</b></td>
            <td class="left">${order.paymentMethod}</td>
        </tr>
        <tr>
            <td class="left"><b>Book Copies:</b></td>
            <td class="left">${order.bookCopies}</td>
        </tr>
        <tr>
            <td class="left"><b>Total Amount:</b></td>
            <td class="left"><fmt:formatNumber value="${order.total}" type="currency"/></td>
        </tr>
    </table>
    <h3>Recipient Information:</h3>
    <table>
        <tr>
            <td class="left"><b>First Name:</b></td>
            <td class="left">${order.firstname}</td>
        </tr>
        <tr>
            <td class="left"><b>Last Name:</b></td>
            <td class="left">${order.lastname}</td>
        </tr>
        <tr>
            <td class="left"><b>Phone:</b></td>
            <td class="left">${order.phone}</td>
        </tr>
        <tr>
            <td class="left"><b>Address Line 1:</b></td>
            <td class="left">${order.addressLine1}</td>
        </tr>
        <tr>
            <td class="left"><b>Address Line 2:</b></td>
            <td class="left">${order.addressLine2}</td>
        </tr>
        <tr>
            <td class="left"><b>City:</b></td>
            <td class="left">${order.city}</td>
        </tr>
        <tr>
            <td class="left"><b>State:</b></td>
            <td class="left">${order.state}</td>
        </tr>
        <tr>
            <td class="left"><b>Country:</b></td>
            <td class="left">${order.countryName}</td>
        </tr>
        <tr>
            <td class="left"><b>Zipcode:</b></td>
            <td class="left">${order.zipcode}</td>
        </tr>
    </table>
</div>

<div class="center">
    <h3>Ordered Books</h3>
    <table>
        <tr>
            <th>Index</th>
            <th>Book Title</th>
            <th>Author</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
        </tr>
        <c:forEach items="${order.orderDetails}" var="orderDetail" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${orderDetail.book.title}</td>
                <td>${orderDetail.book.author}</td>
                <td><fmt:formatNumber value="${orderDetail.book.price}" type="currency"/></td>
                <td>${orderDetail.quantity}</td>
                <td><fmt:formatNumber value="${orderDetail.subtotal}" type="currency"/></td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="6" class="right">
                <p>Subtotal: <fmt:formatNumber value="${order.subtotal}" type="currency"/></p>
                <p>Tax: <fmt:formatNumber value="${order.tax}" type="currency"/></p>
                <p>Shipping Fee: <fmt:formatNumber value="${order.shippingFee}" type="currency"/></p>
                <b>TOTAL: <fmt:formatNumber value="${order.total}" type="currency"/></b>
            </td>
        </tr>
    </table>
</div>

<div class="center">
    <br/>
    <a href="edit_order?id=${order.orderId}">Edit this Order</a> |
    <a href="#">Delete this Order</a>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function () {
    });
</script>
</body>
</html>
