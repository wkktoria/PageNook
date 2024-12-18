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
    <title>Checkout | PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <c:if test="${message != null}">
        <h4 class="message">${message}</h4>
    </c:if>

    <c:set var="cart" value="${sessionScope['cart']}"/>

    <c:if test="${cart.totalItems == 0}">
        <h2>Your cart is empty.</h2>
    </c:if>
    <c:if test="${cart.totalItems > 0}">
        <div>
            <h2>Review Your Order Details <a href="view_cart">Edit</a></h2>
            <table>
                <tr>
                    <th>No.</th>
                    <th colspan="2">Book</th>
                    <th>Author</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                </tr>
                <c:forEach items="${cart.items}" var="item" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>
                            <img class="book-small" src="data:image/jpg;base64,${item.key.base64Image}"
                                 alt="Book Cover"/>
                        </td>
                        <td><span id="bookTitle">${item.key.title}</span></td>
                        <td>${item.key.author}</td>
                        <td><fmt:formatNumber value="${item.key.price}" type="currency"/></td>
                        <td>${item.value}</td>
                        <td><fmt:formatNumber value="${item.value * item.key.price}" type="currency"/></td>
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
            <h2>Your Shipping Information</h2>
            <form id="orderForm" action="place_order" method="post">
                <table style="border: 0;">
                    <tr>
                        <td class="left">Recipient Name:</td>
                        <td class="right">
                            <label>
                                <input type="text" name="recipientName" value="${loggedCustomer.fullname}"/>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td class="left">Recipient Phone:</td>
                        <td class="right">
                            <label>
                                <input type="text" name="recipientPhone" value="${loggedCustomer.phone}"/>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td class="left">Street Address:</td>
                        <td class="right">
                            <label>
                                <input type="text" name="address" value="${loggedCustomer.address}"/>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td class="left">City:</td>
                        <td class="right">
                            <label>
                                <input type="text" name="city" value="${loggedCustomer.city}"/>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td class="left">Zip Code:</td>
                        <td class="right">
                            <label>
                                <input type="text" name="zipcode" value="${loggedCustomer.zipcode}"/>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td class="left">Country:</td>
                        <td class="right">
                            <label>
                                <input type="text" name="country" value="${loggedCustomer.country}"/>
                            </label>
                        </td>
                    </tr>
                </table>
                <div>
                    <h2>Payment</h2>
                    <label>Choose your payment method:
                        <select name="paymentMethod">
                            <option value="Cash on Delivery">Cash on Delivery</option>
                        </select>
                    </label>
                </div>
                <div>
                    <table style="border: 0;">
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <button type="submit">Place Order</button>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/">Continue Shopping</a>
                            </td>
                        </tr>
                    </table>
                </div>
            </form>
        </div>
    </c:if>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function () {
        $('#orderForm').validate({
            rules: {
                recipientName: "required",
                recipientPhone: "required",
                address: "required",
                city: "required",
                zipcode: "required",
                country: "required"
            },
            messages: {
                recipientName: "Please enter recipient name.",
                recipientPhone: "Please enter phone number.",
                address: "Please enter street address.",
                city: "Please enter city.",
                zipcode: "Please enter zip code.",
                country: "Please enter country."
            },
        });
    });
</script>
</body>
</html>
