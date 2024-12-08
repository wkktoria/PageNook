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
    <title>Manage Customers | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h1 class="page-heading">Customers Management</h1>
    <a href="new_customer">Create New Customer</a>
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
            <th scope="col">ID</th>
            <th scope="col">E-mail</th>
            <th scope="col">Full Name</th>
            <th scope="col">City</th>
            <th scope="col">Country</th>
            <th scope="col">Registered Date</th>
            <th scope="col">Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="customer" items="${listCustomer}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${customer.customerId}</td>
                <td>${customer.email}</td>
                <td>${customer.fullname}</td>
                <td>${customer.city}</td>
                <td>${customer.country}</td>
                <td><fmt:formatDate pattern="MM/dd/yyyy" value='${customer.registerDate}'/></td>
                <td>
                    <a href="edit_customer?id=${book.bookId}">Edit</a> |
                    <a class="delete-link" href="javascript:void(0)" id="${book.bookId}">Delete</a>
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
                const customerId = $(this).attr("id");
                if (confirm("Are you sure you want do delete the customer with ID " + customerId + "?")) {
                    window.location = "delete_customer?id=" + customerId;
                }
            });
        });
    });
</script>
</body>
</html>
