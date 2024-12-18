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
            <td class="left"><b>Book Copies:</b></td>
            <td class="left">${order.bookCopies}</td>
        </tr>
        <tr>
            <td class="left"><b>Total Amount:</b></td>
            <td class="left"><fmt:formatNumber value="${order.total}" type="currency"/></td>
        </tr>
        <tr>
            <td class="left"><b>Recipient Name:</b></td>
            <td class="left">${order.recipientName}</td>
        </tr>
        <tr>
            <td class="left"><b>Recipient Phone:</b></td>
            <td class="left">${order.recipientPhone}</td>
        </tr>
        <tr>
            <td class="left"><b>Payment Method:</b></td>
            <td class="left">${order.paymentMethod}</td>
        </tr>
        <tr>
            <td class="left"><b>Shipping Address:</b></td>
            <td class="left">${order.shippingAddress}</td>
        </tr>
        <tr>
            <td class="left"><b>Order Status:</b></td>
            <td class="left">${order.status}</td>
        </tr>
        <tr>
            <td class="left"><b>Order Date:</b></td>
            <td class="left">${order.orderDate}</td>
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
            <td colspan="4" class="right">
                <b>TOTAL:</b>
            </td>
            <td>
                <b>${order.bookCopies}</b>
            </td>
            <td>
                <b><fmt:formatNumber value="${order.total}" type="currency"/></b>
            </td>
        </tr>
    </table>
</div>

<div class="center">
    <br/>
    <a href="#">Edit this Order</a> |
    <a href="#">Delete this Order</a>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function () {
    });
</script>
</body>
</html>