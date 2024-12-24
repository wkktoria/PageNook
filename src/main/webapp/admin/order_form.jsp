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
                <td class="left"><b>Recipient Name:</b></td>
                <td class="left">
                    <label>
                        <input type="text" name="recipientName" value="${order.recipientName}" size="45"/>
                    </label>
                </td>
            </tr>
            <tr>
                <td class="left"><b>Recipient Phone:</b></td>
                <td class="left">
                    <label>
                        <input type="text" name="recipientPhone" value="${order.recipientPhone}" size="45"/>
                    </label>
                </td>
            </tr>
            <tr>
                <td class="left"><b>Ship to:</b></td>
                <td class="left">
                    <label>
                        <input type="text" name="shippingAddress" value="${order.shippingAddress}" size="45"/>
                    </label>
                </td>
            </tr>
            <tr>
                <td class="left"><b>Payment Method:</b></td>
                <td class="left">
                    <label>
                        <select name="paymentMethod">
                            <option value="Cash on Delivery">Cash on Delivery</option>
                        </select>
                    </label>
                </td>
            </tr>
            <tr>
                <td class="left"><b>Order Status:</b></td>
                <td class="left">
                    <label>
                        <select name="orderStatus">
                            <option value="Processing">Processing</option>
                            <option value="Shipping">Shipping</option>
                            <option value="Delivered">Delivered</option>
                            <option value="Completed">Completed</option>
                            <option value="Canceled">Canceled</option>
                        </select>
                    </label>
                </td>
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
            <c:forEach items="${order.orderDetails}" var="orderDetail" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${orderDetail.book.title}</td>
                    <td>${orderDetail.book.author}</td>
                    <td><fmt:formatNumber value="${orderDetail.book.price}" type="currency"/></td>
                    <td>
                        <label>
                        	<input type="hidden" name="bookId" value="${orderDetail.book.bookId}" />
                            <input type="number" name="quantity${status.index + 1}" value="${orderDetail.quantity}" size="5"/>
                        </label>
                    </td>
                    <td><fmt:formatNumber value="${orderDetail.subtotal}" type="currency"/></td>
                    <td><a href="remove_book_from_order?id=${orderDetail.book.bookId}">Remove</a></td>
                </tr>
            </c:forEach>
            <tr>
                <td colspan="4" class="right">
                    <b>TOTAL:</b>
                </td>
                <td>
                    <b>${order.bookCopies}</b>
                </td>
                <td>
                    <b><fmt:formatNumber value="${order.total}" type="currency"/></b>
                </td>
                <td></td>
            </tr>
        </table>
    </div>

    <div class="center">
        <br/>
        <a href="javascript:showAddBookPopup()"><b>Add Books</b></a> |
        <input type="submit" value="Save"/> |
        <input type="button" value="Cancel" onclick="javascript:window.location.href='list_order';"/>
    </div>
</form>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function () {
        $("#orderForm").validate({
            rules: {
                recipientName: "required",
                recipientPhone: "required",
                shippingAddress: "required",
                <c:forEach items="${order.orderDetails}" var="book" varStatus="status">
                quantity${status.index + 1}: {
                    required: true,
                    number: true,
                    min: 1
                },
        		</c:forEach>
            },
            messages: {
            	recipientName: "Please enter recipient name.",
            	recipientPhone: "Please enter recipient phone number.",
            	shippingAddress: "Please enter shipping address.",
                <c:forEach items="${order.orderDetails}" var="book" varStatus="status">
            	quantity${status.index + 1}: {
                	required: "Please enter quantity.",
                	number: "Quantity must be a number.",
                	min: "Quantity must be greater than 0."
            	},
    			</c:forEach>
            }
        });
    });

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
