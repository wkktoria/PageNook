<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="My Order History"/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1 my-5">
    <div class="text-center mb-4">
        <h1>My Order History</h1>
        <hr class="w-50 mx-auto"/>
    </div>

    <c:if test="${fn:length(listOrders) == 0}">
        <div class="text-center my-5">
            <div class="alert alert-info d-inline-block" role="alert">
                <h4 class="mb-3">You have not placed any orders.</h4>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Start Shopping</a>
            </div>
        </div>
    </c:if>

    <c:if test="${fn:length(listOrders) > 0}">
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                <tr>
                    <th scope="col" style="width: 5%;">Index</th>
                    <th scope="col" style="width: 15%;">Order ID</th>
                    <th scope="col" style="width: 10%;">Quantity</th>
                    <th scope="col" style="width: 15%;">Total Amount</th>
                    <th scope="col" style="width: 20%;">Order Date</th>
                    <th scope="col" style="width: 15%;">Status</th>
                    <th scope="col" style="width: 20%;">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="order" items="${listOrders}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td><strong>${order.orderId}</strong></td>
                        <td>${order.bookCopies}</td>
                        <td><strong><fmt:formatNumber value="${order.total}" type="currency"/></strong></td>
                        <td>${order.orderDate}</td>
                        <td>
                            <c:choose>
                                <c:when test="${order.status == 'Delivered'}">
                                    <span class="badge bg-success">${order.status}</span>
                                </c:when>
                                <c:when test="${order.status == 'Processing' || order.status == 'Pending'}">
                                    <span class="badge bg-warning text-dark">${order.status}</span>
                                </c:when>
                                <c:when test="${order.status == 'Shipped'}">
                                    <span class="badge bg-info text-dark">${order.status}</span>
                                </c:when>
                                <c:when test="${order.status == 'Cancelled'}">
                                    <span class="badge bg-danger">${order.status}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">${order.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="show_order_detail?id=${order.orderId}" class="btn btn-sm btn-outline-primary">
                                View Details
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="card mt-4">
            <div class="card-body">
                <div class="row text-center">
                    <div class="col-md-4">
                        <h5 class="text-muted">Total Orders</h5>
                        <h3 class="text-primary">${fn:length(listOrders)}</h3>
                    </div>
                    <div class="col-md-4">
                        <h5 class="text-muted">Total Books Purchased</h5>
                        <h3 class="text-primary">
                            <c:set var="totalBooks" value="0"/>
                            <c:forEach var="order" items="${listOrders}">
                                <c:set var="totalBooks" value="${totalBooks + order.bookCopies}"/>
                            </c:forEach>
                                ${totalBooks}
                        </h3>
                    </div>
                    <div class="col-md-4">
                        <h5 class="text-muted">Total Amount Spent</h5>
                        <h3 class="text-primary">
                            <c:set var="totalSpent" value="0"/>
                            <c:forEach var="order" items="${listOrders}">
                                <c:set var="totalSpent" value="${totalSpent + order.total}"/>
                            </c:forEach>
                            <fmt:formatNumber value="${totalSpent}" type="currency"/>
                        </h3>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>

<jsp:directive.include file="footer.jsp"/>

</body>
</html>
