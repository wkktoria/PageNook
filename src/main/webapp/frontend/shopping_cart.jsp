<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Shopping Cart"/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1 my-5">
    <h2 class="text-center mb-4">Your Cart Details</h2>

    <c:if test="${message != null}">
        <div class="alert alert-info text-center" role="alert">
                ${message}
        </div>
    </c:if>

    <c:set var="cart" value="${sessionScope['cart']}"/>

    <c:if test="${cart.totalItems == 0}">
        <div class="text-center my-5">
            <h3>Your cart is empty.</h3>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary mt-3">Start Shopping</a>
        </div>
    </c:if>
    <c:if test="${cart.totalItems > 0}">
        <form action="update_cart" method="post" id="cartForm">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                    <tr>
                        <th style="width: 5%;">No.</th>
                        <th style="width: 15%;" colspan="2">Book</th>
                        <th style="width: 20%">Quantity</th>
                        <th style="width: 15%;">Price</th>
                        <th style="width: 15%;">Subtotal</th>
                        <th style="width: 10%;"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${cart.items}" var="item" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td style="width: 80px;">
                                <img class="img-fluid rounded" src="data:image/jpg;base64,${item.key.base64Image}"
                                     alt="Book Cover" style="max-width: 60px;"/>
                            </td>
                            <td><strong>${item.key.title}</strong></td>
                            <td>
                                <input type="hidden" name="bookId" value="${item.key.bookId}"/>
                                <label>
                                    <input type="number" name="quantity${status.index + 1}" value="${item.value}"
                                           size="5" class="form-control" style="max-width: 100px;"/>
                                </label>
                            </td>
                            <td><fmt:formatNumber value="${item.key.price}" type="currency"/></td>
                            <td><fmt:formatNumber value="${item.value * item.key.price}" type="currency"/></td>
                            <td><a href="remove_from_cart?bookId=${item.key.bookId}"
                                   class="btn btn-sm btn-outline-danger">Remove</a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tfoot class="table-light">
                    <tr>
                        <td colspan="3"></td>
                        <td><strong>${cart.totalQuantity} book(s)</strong></td>
                        <td><strong>Total:</strong></td>
                        <td colspan="2">
                            <strong class="text-primary fs-5">
                                <fmt:formatNumber value="${cart.totalAmount}" type="currency"/>
                            </strong>
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>
            <div class="d-flex justify-content-between flex-wrap gap-2 mt-4">
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Update Cart</button>
                    <button type="button" id="clearCart" class="btn btn-outline-secondary">Clear Cart</button>
                </div>
                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary">Continue Shopping</a>
                    <a href="checkout" class="btn btn-success">Proceed to Checkout</a>
                </div>
            </div>
        </form>
    </c:if>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    <%--$(document).ready(function () {--%>
    <%--    $('#cartForm').validate({--%>
    <%--        rules: {--%>
    <%--            <c:forEach items="${cart.items}" var="item" varStatus="status">--%>
    <%--            quantity${status.index + 1}: {--%>
    <%--                required: true,--%>
    <%--                number: true,--%>
    <%--                min: 1,--%>
    <%--            },--%>
    <%--            </c:forEach>--%>
    <%--        },--%>
    <%--        messages: {--%>
    <%--            <c:forEach items="${cart.items}" var="item" varStatus="status">--%>
    <%--            quantity${status.index + 1}: {--%>
    <%--                required: "Please enter quantity.",--%>
    <%--                number: "Quantity must be a number.",--%>
    <%--                min: "Quantity must be greater than 0."--%>
    <%--            },--%>
    <%--            </c:forEach>--%>
    <%--        },--%>
    <%--    });--%>
    <%--});--%>

    document.getElementById("clearCart").addEventListener("click", function () {
        if (confirm("Are you sure you want to clear your cart?")) {
            window.location.href = "clear_cart";
        }
    });
</script>
</body>
</html>
