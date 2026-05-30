<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row">
    <div class="col-lg-6 mb-4">
        <div class="card h-100">
            <div class="card-header bg-light">
                <h4 class="mb-0">Order Overview</h4>
            </div>
            <div class="card-body">
                <table class="table table-sm mb-0">
                    <tr>
                        <td class="text-muted" style="width: 45%;">Ordered by:</td>
                        <td><strong>${order.customer.fullname}</strong></td>
                    </tr>
                    <tr>
                        <td class="text-muted">Order Status:</td>
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
                    </tr>
                    <tr>
                        <td class="text-muted">Order Date:</td>
                        <td><strong>${order.orderDate}</strong></td>
                    </tr>
                    <tr>
                        <td class="text-muted">Payment Method:</td>
                        <td><strong>${order.paymentMethod}</strong></td>
                    </tr>
                    <tr>
                        <td class="text-muted">Book Copies:</td>
                        <td><strong>${order.bookCopies}</strong></td>
                    </tr>
                    <tr>
                        <td class="text-muted">Total Amount:</td>
                        <td><strong class="text-primary"><fmt:formatNumber value="${order.total}"
                                                                           type="currency"/></strong></td>
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
                        <td class="text-muted" style="width: 45%;">First Name:</td>
                        <td><strong>${order.firstname}</strong></td>
                    </tr>
                    <tr>
                        <td class="text-muted">Last Name:</td>
                        <td><strong>${order.lastname}</strong></td>
                    </tr>
                    <tr>
                        <td class="text-muted">Phone:</td>
                        <td>${order.phone}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Address Line 1:</td>
                        <td>${order.addressLine1}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Address Line 2:</td>
                        <td>${order.addressLine2}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">City:</td>
                        <td>${order.city}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">State:</td>
                        <td>${order.state}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Country:</td>
                        <td>${order.countryName}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Zipcode:</td>
                        <td>${order.zipcode}</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="card mb-4">
    <div class="card-header bg-light">
        <h4 class="mb-0">Ordered Books</h4>
    </div>
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                <tr>
                    <th style="width: 5%;">Index</th>
                    <th style="width: 35%;">Book Title</th>
                    <th style="width: 25%;">Author</th>
                    <th style="width: 15%;">Price</th>
                    <th style="width: 10%;">Quantity</th>
                    <th style="width: 15%;">Subtotal</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${order.orderDetails}" var="orderDetail" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>
                            <a href="view_book?id=${orderDetail.book.bookId}" class="text-decoration-none">
                                <strong>${orderDetail.book.title}</strong>
                            </a>
                        </td>
                        <td>${orderDetail.book.author}</td>
                        <td><fmt:formatNumber value="${orderDetail.book.price}" type="currency"/></td>
                        <td>${orderDetail.quantity}</td>
                        <td><strong><fmt:formatNumber value="${orderDetail.subtotal}" type="currency"/></strong></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <div class="row">
            <div class="col-md-6 offset-md-6">
                <table class="table table-sm mb-0">
                    <tr>
                        <td>Subtotal:</td>
                        <td class="text-end"><fmt:formatNumber value="${order.subtotal}" type="currency"/></td>
                    </tr>
                    <tr>
                        <td>Tax:</td>
                        <td class="text-end"><fmt:formatNumber value="${order.tax}" type="currency"/></td>
                    </tr>
                    <tr>
                        <td>Shipping Fee:</td>
                        <td class="text-end"><fmt:formatNumber value="${order.shippingFee}" type="currency"/></td>
                    </tr>
                    <tr class="table-light">
                        <td><strong>TOTAL:</strong></td>
                        <td class="text-end">
                            <strong class="text-primary fs-5">
                                <fmt:formatNumber value="${order.total}" type="currency"/>
                            </strong>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="text-center mt-4">
    <a href="view_orders" class="btn btn-outline-primary">Back to Order History</a>
</div>