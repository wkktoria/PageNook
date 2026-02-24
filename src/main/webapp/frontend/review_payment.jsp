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
    <title>Review Payment | PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h3>
        <i>Please carefully review the following information before making payment.</i>
    </h3>

    <h2>Payer Information</h2>
    <table>
        <tr>
            <td>
                <b>First Name:</b>
            </td>
            <td>${payer.firstName}</td>
        </tr>
        <tr>
            <td>
                <b>Last Name:</b>
            </td>
            <td>${payer.lastName}</td>
        </tr>
        <tr>
            <td>
                <b>Email:</b>
            </td>
            <td>${payer.email}</td>
        </tr>
    </table>

    <h2>Recipient Information</h2>
    <table>
        <tr>
            <td>
                <b>Recipient Name:</b>
            </td>
            <td>${recipient.recipientName}</td>
        </tr>
        <tr>
            <td>
                <b>Address Line 1:</b>
            </td>
            <td>${recipient.line1}</td>
        </tr>
        <tr>
            <td>
                <b>Address Line 2:</b>
            </td>
            <td>${recipient.line2}</td>
        </tr>
        <tr>
            <td>
                <b>City:</b>
            </td>
            <td>${recipient.city}</td>
        </tr>
        <tr>
            <td>
                <b>State:</b>
            </td>
            <td>${recipient.state}</td>
        </tr>
        <tr>
            <td>
                <b>Country Code:</b>
            </td>
            <td>${recipient.countryCode}</td>
        </tr>
        <tr>
            <td>
                <b>Postal Code:</b>
            </td>
            <td>${recipient.postalCode}</td>
        </tr>
    </table>

    <h2>Transaction Details</h2>
    <table>
        <tr>
            <td>
                <b>Description:</b>
            </td>
            <td>${transaction.description}</td>
        </tr>
        <tr>
            <td colspan="2">
                <b>Item List:</b>
            </td>
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

    <div>
        <form action="execute_payment" method="post">
            <input type="hidden" name="paymentId" value="${param.paymentId}"/>
            <input type="hidden" name="payerId" value="${param.payerId}"/>
            <input type="submit" value="Pay now"/>
        </form>
    </div>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
