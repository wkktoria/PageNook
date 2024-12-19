<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <title>My Order History | PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h1 class="page-heading">My Order History</h1>
    <hr style="width: 60%"/>
</div>

<c:if test="${fn:length(listOrders) == 0}">
    <div class="center">
        <h3>You have not placed any orders.</h3>
    </div>
</c:if>
<c:if test="${fn:length(listOrders) > 0}">
    <div class="center">
        <table>
            <thead>
            <tr>
                <th scope="col">Index</th>
                <th scope="col">Order ID</th>
                <th scope="col">Quantity</th>
                <th scope="col">Total Amount</th>
                <th scope="col">Order Date</th>
                <th scope="col">Status</th>
                <th scope="col">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="order" items="${listOrders}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${order.orderId}</td>
                    <td>${order.bookCopies}</td>
                    <td><fmt:formatNumber value="${order.total}" type="currency"/></td>
                    <td>${order.orderDate}</td>
                    <td>${order.status}</td>
                    <td>
                        <a href="show_order_detail?id=${order.orderId}">View Details</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function () {
    });
</script>
</body>
</html>
