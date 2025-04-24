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
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.min.js"
            integrity="sha256-AlTido85uXPlSyyaZNsjJXeCs07eSv3r43kyCVc8ChI="
            crossorigin="anonymous"></script>
    <title><c:if test="${customer != null}">Edit Customer</c:if><c:if
            test="${customer == null}">Create New Customer</c:if> | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <c:choose>
        <c:when test="${customer != null}">
            <c:set value="Edit Customer" var="headingText"/>
        </c:when>
        <c:otherwise>
            <c:set value="Create New Customer" var="headingText"/>
        </c:otherwise>
    </c:choose>
    <h1 class="page-heading">${headingText}</h1>
    <hr style="width: 60%"/>
</div>

<div class="center">
    <c:choose>
        <c:when test="${customer != null}">
            <c:set value="update_customer" var="formAction"/>
        </c:when>
        <c:otherwise>
            <c:set value="create_customer" var="formAction"/>
        </c:otherwise>
    </c:choose>

    <form action="${formAction}" method="post" id="customerForm">
        <input type="hidden" name="customerId" value="${customer.customerId}"/>
        <jsp:directive.include file="../common/customer_form.jsp"/>
    </form>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript" src="../js/customer-form.js"></script>
</body>
</html>
