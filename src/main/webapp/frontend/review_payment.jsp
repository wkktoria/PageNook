<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Review Payment"/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1 my-5">
    <div class="text-center mb-4">
        <h2>Review Payment</h2>
        <p class="text-muted fst-italic">Please carefully review the following information before making payment.</p>
        <hr class="w-50 mx-auto"/>
    </div>

    <div class="row">
        <div class="col-lg-6 mb-4">
            <div class="card h-100">
                <div class="card-header bg-light">
                    <h4 class="mb-0">Payer Information</h4>
                </div>
                <div class="card-body">
                    <table class="table table-sm mb-0">
                        <tr>
                            <td class="text-muted" style="width: 40%;">First Name:</td>
                            <td><strong>${payer.firstName}</strong></td>
                        </tr>
                        <tr>
                            <td class="text-muted">Last Name:</td>
                            <td><strong>${payer.lastName}</strong></td>
                        </tr>
                        <tr>
                            <td class="text-muted">Email:</td>
                            <td>${payer.email}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-lg-6 mb-4">
            <div class="card h-100">
                <div class="card-header bg-light">
                    <h4 class="mb-0">Recipient Information</h4>
                </div>
                <div class="card-body">
                    <table class="table table-sm mb-0">
                        <tr>
                            <td class="text-muted" style="width: 40%;">Recipient Name:</td>
                            <td><strong>${recipient.recipientName}</strong></td>
                        </tr>
                        <tr>
                            <td class="text-muted">Address Line 1:</td>
                            <td>${recipient.line1}</td>
                        </tr>
                        <tr>
                            <td class="text-muted">Address Line 2:</td>
                            <td>${recipient.line2}</td>
                        </tr>
                        <tr>
                            <td class="text-muted">City:</td>
                            <td>${recipient.city}</td>
                        </tr>
                        <tr>
                            <td class="text-muted">State:</td>
                            <td>${recipient.state}</td>
                        </tr>
                        <tr>
                            <td class="text-muted">Country Code:</td>
                            <td>${recipient.countryCode}</td>
                        </tr>
                        <tr>
                            <td class="text-muted">Postal Code:</td>
                            <td>${recipient.postalCode}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header bg-light">
            <h4 class="mb-0">Transaction Details</h4>
        </div>
        <div class="card-body">
            <div class="mb-3">
                <p class="mb-1"><strong>Description:</strong></p>
                <p class="text-muted">${transaction.description}</p>
            </div>

            <h5 class="mb-3">Item List</h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th style="width: 5%;">No.</th>
                        <th style="width: 40%;">Name</th>
                        <th style="width: 15%;">Quantity</th>
                        <th style="width: 20%;">Price</th>
                        <th style="width: 20%;">Subtotal</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${transaction.itemList.items}" var="item" varStatus="var">
                        <tr>
                            <td>${var.index + 1}</td>
                            <td><strong>${item.name}</strong></td>
                            <td>${item.quantity}</td>
                            <td><fmt:formatNumber value="${item.price}" type="currency"/></td>
                            <td><strong><fmt:formatNumber value="${item.price * item.quantity}"
                                                          type="currency"/></strong></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6 offset-md-6">
                    <table class="table table-sm mb-0">
                        <tr>
                            <td>Subtotal:</td>
                            <td class="text-end"><fmt:formatNumber value="${transaction.amount.details.subtotal}"
                                                                   type="currency"/></td>
                        </tr>
                        <tr>
                            <td>Tax:</td>
                            <td class="text-end"><fmt:formatNumber value="${transaction.amount.details.tax}"
                                                                   type="currency"/></td>
                        </tr>
                        <tr>
                            <td>Shipping fee:</td>
                            <td class="text-end"><fmt:formatNumber value="${transaction.amount.details.shipping}"
                                                                   type="currency"/></td>
                        </tr>
                        <tr class="table-light">
                            <td><strong>TOTAL:</strong></td>
                            <td class="text-end">
                                <strong class="text-primary fs-5">
                                    <fmt:formatNumber value="${transaction.amount.total}" type="currency"/>
                                </strong>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="text-center">
        <form action="execute_payment" method="post">
            <input type="hidden" name="paymentId" value="${param.paymentId}"/>
            <input type="hidden" name="payerId" value="${param.payerId}"/>
            <button type="submit" class="btn btn-success btn-lg px-5">Pay Now</button>
            <p class="text-muted mt-3 small">Your payment is secure and encrypted</p>
        </form>
    </div>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
