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
    <title>Edit Order | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h1 class="page-heading">Edit Order ID: ${order.orderId}</h1>
    <hr style="width: 60%"/>
</div>

<c:if test="${message != null}">
    <div class="center">
        <h4 class="message">${message}</h4>
    </div>
</c:if>

<form action="update_order" method="post" id="orderForm">
    <div class="center">
        <h2>Order Overview</h2>
        <table>
            <tr>
                <td class="left"><b>Ordered by:</b></td>
                <td class="left">${order.customer.fullname}</td>
            </tr>
            <tr>
                <td class="left"><b>Order Date:</b></td>
                <td class="left">${order.orderDate}</td>
            </tr>
            <tr>
                <td class="left"><b>Payment Method:</b></td>
                <td class="left"><label> <select name="paymentMethod">
                    <option value="Cash on Delivery"
                            <c:if test="${order.paymentMethod eq 'Cash on Delivery'}">selected="selected"</c:if>>Cash on
                        Delivery
                    </option>
                    <option value="PayPal" <c:if test="${order.paymentMethod eq 'PayPal'}">selected="selected"</c:if>>
                        PayPal or Credit Card
                    </option>
                </select>
                </label></td>
            </tr>
            <tr>
                <td class="left"><b>Order Status:</b></td>
                <td class="left"><label> <select name="orderStatus">
                    <option value="Processing" <c:if test="${order.status eq 'Processing'}">selected</c:if>>Processing
                    </option>
                    <option value="Shipping" <c:if test="${order.status eq 'Shipping'}">selected</c:if>>Shipping
                    </option>
                    <option value="Delivered" <c:if test="${order.status eq 'Delivered'}">selected</c:if>>Delivered
                    </option>
                    <option value="Completed" <c:if test="${order.status eq 'Completed'}">selected</c:if>>Completed
                    </option>
                    <option value="Canceled" <c:if test="${order.status eq 'Canceled'}">selected</c:if>>Canceled
                    </option>
                </select>
                </label></td>
            </tr>
        </table>
        <h2>Recipient Information</h2>
        <table>
            <tr>
                <td class="left"><b>First Name:</b></td>
                <td class="left"><label><input type="text"
                                               name="firstname" id="firstname" value="${order.firstname}" size="45"
                                               minlength="3" maxlength="30" required/>
                </label></td>
            </tr>
            <tr>
                <td class="left"><b>Last Name:</b></td>
                <td class="left"><label><input type="text"
                                               name="lastname" id="lastname" value="${order.lastname}" size="45"
                                               minlength="3" maxlength="30" required/>
                </label></td>
            </tr>
            <tr>
                <td class="left"><b>Phone:</b></td>
                <td class="left"><label><input type="tel"
                                               name="phone" id="phone" value="${order.phone}" size="45"
                                               minlength="9" maxlength="15" required/>
                </label></td>
            </tr>
            <tr>
                <td class="left"><b>Address Line 1:</b></td>
                <td class="left"><label><input type="text"
                                               name="address1" id="address1" value="${order.addressLine1}" size="45"
                                               minlength="10" maxlength="128" required/>
                </label></td>
            </tr>
            <tr>
                <td class="left"><b>Address Line 2:</b></td>
                <td class="left"><label><input type="text"
                                               name="address2" id="address2" value="${order.addressLine2}" size="45"
                                               minlength="10" maxlength="128" required/>
                </label></td>
            </tr>
            <tr>
                <td class="left"><b>City:</b></td>
                <td class="left"><label><input type="text"
                                               name="city" id="city" value="${order.city}" size="45"
                                               minlength="3" maxlength="32" required/>
                </label></td>
            </tr>
            <tr>
                <td class="left"><b>State:</b></td>
                <td class="left"><label><input type="text"
                                               name="state" id="state" value="${order.state}" size="45"
                                               minlength="3" maxlength="45" required/>
                </label></td>
            </tr>
            <tr>
                <td class="left"><b>Zip Code:</b></td>
                <td class="left"><label><input type="text"
                                               name="zipcode" id="zipcode" value="${order.zipcode}" size="45"
                                               minlength="5" maxlength="24" required/>
                </label></td>
            </tr>
            <tr>
                <td class="left"><b>Country:</b></td>
                <td class="left"><label><select name="country" id="country" required>
                    <c:forEach items="${mapCountries}" var="country">
                        <option value="${country.value}"
                                <c:if test="${order.country eq country.value}">selected</c:if>>${country.key}</option>
                    </c:forEach>
                </select>
                </label></td>
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
                <th></th>
            </tr>
            <c:forEach items="${order.orderDetails}" var="orderDetail"
                       varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${orderDetail.book.title}</td>
                    <td>${orderDetail.book.author}</td>
                    <td><input type="hidden" name="price"
                               value="${orderDetail.book.price}"/> <fmt:formatNumber
                            value="${orderDetail.book.price}" type="currency"/></td>
                    <td><label> <input type="hidden" name="bookId"
                                       value="${orderDetail.book.bookId}"/> <input type="number"
                                                                                   name="quantity${status.index + 1}"
                                                                                   value="${orderDetail.quantity}"
                                                                                   size="5" required step="1" min="1"/>
                    </label></td>
                    <td><fmt:formatNumber value="${orderDetail.subtotal}"
                                          type="currency"/></td>
                    <td><a
                            href="remove_book_from_order?id=${orderDetail.book.bookId}">Remove</a></td>
                </tr>
            </c:forEach>
            <tr>
                <td colspan="7" class="right">
                    <p>Subtotal: <fmt:formatNumber value="${order.subtotal}" type="currency"/></p>
                    <p>Tax: <label for="tax"></label><input type="number" size="5" name="tax" id="tax"
                                                            value="${order.tax}" required step="0.1" min="0.0"/></p>
                    <p>Shipping Fee: <label for="shippingFee"></label><input type="number" size="5" name="shippingFee"
                                                                             id="shippingFee"
                                                                             value="${order.shippingFee}" required
                                                                             step="0.1" min="0.0"/></p>
                    <b>TOTAL: <fmt:formatNumber value="${order.total}" type="currency"/></b>
                </td>
            </tr>
        </table>
    </div>

    <div class="center">
        <br/> <a href="javascript:showAddBookPopup()"><b>Add Books</b></a> |
        <input type="submit" value="Save"/> | <input type="button"
                                                     value="Cancel"
                                                     onclick="javascript:window.location.href='list_order';"/>
    </div>
</form>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    function showAddBookPopup() {
        const width = 600;
        const left = (screen.width - width) / 2;
        const height = 300;
        const top = (screen.height - height) / 2;
        window.open("add_book_form", "_blank", "width=" + width + ", height=" + height + ", top=" + top + ", left=" + left);
    }
</script>
</body>
</html>
