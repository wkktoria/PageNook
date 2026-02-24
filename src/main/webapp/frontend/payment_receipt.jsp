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
    <title>Payment Receipt | PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h2>You have made payment successfully. Thank you for purchasing.</h2>

    <h3>Your Payment Receipt</h3>

    <h2>Seller Information</h2>
    <table>
        <tr>
            <td><b>Company Name:</b></td>
            <td>PageNook Co., Ltd.</td>
        </tr>
        <tr>
            <td><b>E-mail:</b></td>
            <td>sales@pagenook.com</td>
        </tr>
        <tr>
            <td><b>Phone:</b></td>
            <td>+1 123 456 789</td>
        </tr>
    </table>

    <h2>Buyer Information</h2>
    <table>
        <tr>
            <td><b>E-mail:</b></td>
            <td>${payer.email}</td>
        </tr>
        <tr>
            <td><b>First Name:</b></td>
            <td>${payer.firstName}</td>
        </tr>
        <tr>
            <td><b>Last Name:</b></td>
            <td>${payer.lastName}</td>
        </tr>
    </table>

    <h2>Order Details</h2>
    <table>
        <tr>
            <td><b>Order ID:</b></td>
            <td>${orderId}</td>
        </tr>
        <tr>
            <td><b>Order by:</b></td>
            <td>${loggedCustomer.fullname}</td>
        </tr>
        <tr>
            <td><b>Transaction Description:</b></td>
            <td>${transaction.description}</td>
        </tr>
        <tr>
            <td colspan="2"><b>Items:</b></td>
        </tr>
        <tr>
            <td colspan="2">
                <table>
                    <tr>
                        <th>No.</th>
                        <th>Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Subtotal</th>
                    </tr>
                    <c:forEach items="${transaction.itemList.items}" var="item" varStatus="var">
                        <tr>
                            <td>${var.index + 1}</td>
                            <td>${item.name}</td>
                            <td>${item.quantity}</td>
                            <td><fmt:formatNumber value="${item.price}" type="currency"/></td>
                            <td><fmt:formatNumber value="${item.price * item.quantity}" type="currency"/></td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td class="right" colspan="5">
                            <p>Subtotal: <fmt:formatNumber value="${transaction.amount.details.subtotal}"
                                                           type="currency"/></p>
                            <p>Tax: <fmt:formatNumber value="${transaction.amount.details.tax}" type="currency"/></p>
                            <p>Shipping fee: <fmt:formatNumber value="${transaction.amount.details.shipping}"
                                                               type="currency"/></p>
                            <p>TOTAL:
                                <b><fmt:formatNumber value="${transaction.amount.total}" type="currency"/></b>
                            </p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
