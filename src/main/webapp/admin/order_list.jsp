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
    <title>Manage Orders | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h1 class="page-heading">Book Orders Management</h1>
    <hr style="width: 60%"/>
</div>

<c:if test="${message != null}">
    <div class="center">
        <h4 class="message">${message}</h4>
    </div>
</c:if>

<div class="center">
    <table>
        <thead>
        <tr>
            <th scope="col">Index</th>
            <th scope="col">Order ID</th>
            <th scope="col">Ordered By</th>
            <th scope="col">Book Copies</th>
            <th scope="col">Total</th>
            <th scope="col">Payment Method</th>
            <th scope="col">Status</th>
            <th scope="col">Order Date</th>
            <th scope="col">Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${listOrder}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${order.orderId}</td>
                <td>${order.customer.fullname}</td>
                <td>${order.bookCopies}</td>
                <td><fmt:formatNumber value="${order.total}" type="currency"/></td>
                <td>${order.paymentMethod}</td>
                <td>${order.status}</td>
                <td>${order.orderDate}</td>
                <td>
                    <a href="view_order?id=${order.orderId}">Details</a> |
                    <a href="edit_order?id=${order.orderId}">Edit</a> |
                    <a href="javascript:void(0)" class="delete-link" id="${order.orderId}">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function () {
        $(".delete-link").each(function () {
            $(this).on("click", function () {
                const orderId = $(this).attr("id");
                if (confirm("Are you sure you want do delete the order with ID " + orderId + "?")) {
                    window.location = "delete_order?id=" + orderId;
                }
            });
        });
    });
</script>
</body>
</html>
