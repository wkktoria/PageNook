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
    <title>Shopping Cart | PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h2>Your Cart Details</h2>

    <c:if test="${message != null}">
        <h4 class="message">${message}</h4>
    </c:if>

    <c:set var="cart" value="${sessionScope['cart']}"/>

    <c:if test="${cart.totalItems == 0}">
        <h2>Your cart is empty.</h2>
    </c:if>
    <c:if test="${cart.totalItems > 0}">
        <form action="update_cart" method="post" id="cartForm">
            <div>
                <table>
                    <tr>
                        <th>No.</th>
                        <th colspan="2">Book</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Subtotal</th>
                        <th></th>
                    </tr>
                    <c:forEach items="${cart.items}" var="item" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>
                                <img class="book-small" src="data:image/jpg;base64,${item.key.base64Image}"
                                     alt="Book Cover"/>
                            </td>
                            <td><span id="bookTitle">${item.key.title}</span></td>
                            <td>
                                <input type="hidden" name="bookId" value="${item.key.bookId}"/>
                                <label>
                                    <input type="number" name="quantity${status.index + 1}" value="${item.value}"
                                           size="5"/>
                                </label>
                            </td>
                            <td><fmt:formatNumber value="${item.key.price}" type="currency"/></td>
                            <td><fmt:formatNumber value="${item.value * item.key.price}" type="currency"/></td>
                            <td><a href="remove_from_cart?bookId=${item.key.bookId}">Remove</a></td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td><b>${cart.totalQuantity} book(s)</b></td>
                        <td>Total:</td>
                        <td><b><fmt:formatNumber value="${cart.totalAmount}" type="currency"/></b></td>
                    </tr>
                </table>
            </div>
            <div>
                <table style="border: 0;">
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <button type="submit">Update</button>
                        </td>
                        <td>
                            <input type="button" id="clearCart" value="Clear Cart"/>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/">Continue Shopping</a>
                        </td>
                        <td>
                            <a href="checkout">Checkout</a>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </c:if>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function () {
        $('#cartForm').validate({
            rules: {
                <c:forEach items="${cart.items}" var="item" varStatus="status">
                quantity${status.index + 1}: {
                    required: true,
                    number: true,
                    min: 1,
                },
                </c:forEach>
            },
            messages: {
                <c:forEach items="${cart.items}" var="item" varStatus="status">
                quantity${status.index + 1}: {
                    required: "Please enter quantity.",
                    number: "Quantity must be a number.",
                    min: "Quantity must be greater than 0."
                },
                </c:forEach>
            },
        });

        $("#clearCart").click(function () {
            window.location = "clear_cart";
        });
    });
</script>
</body>
</html>
