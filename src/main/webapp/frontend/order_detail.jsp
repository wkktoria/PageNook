<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="My Order Details"/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1 my-5">
    <c:if test="${order == null}">
        <div class="text-center my-5">
            <div class="alert alert-warning d-inline-block" role="alert">
                <h2 class="mb-3">Sorry, you are not authorized to view this order.</h2>
                <a href="view_orders" class="btn btn-primary">View My Orders</a>
            </div>
        </div>
    </c:if>

    <c:if test="${order != null}">
        <div class="text-center mb-4">
            <h1>Your Order ID: <span class="text-primary">${order.orderId}</span></h1>
            <hr class="w-50 mx-auto"/>
        </div>

        <jsp:directive.include file="../common/order_detail.jsp"/>
    </c:if>
</div>

<jsp:directive.include file="footer.jsp"/>

</body>
</html>
