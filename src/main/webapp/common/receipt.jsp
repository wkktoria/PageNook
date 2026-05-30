<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="text-center mb-4">
    <h2>Your Payment Receipt</h2>
    <hr class="w-50 mx-auto"/>
</div>

<div class="row">
    <div class="col-lg-6 mb-4">
        <div class="card h-100">
            <div class="card-header bg-light">
                <h4 class="mb-0">Seller Information</h4>
            </div>
            <div class="card-body">
                <table class="table table-sm mb-0">
                    <tr>
                        <td class="text-muted" style="width: 40%;">Company Name:</td>
                        <td><strong>PageNook Co., Ltd.</strong></td>
                    </tr>
                    <tr>
                        <td class="text-muted">E-mail:</td>
                        <td>sales@pagenook.com</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Phone:</td>
                        <td>+1 123 456 789</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <div class="col-lg-6 mb-4">
        <div class="card h-100">
            <div class="card-header bg-light">
                <h4 class="mb-0">Buyer Information</h4>
            </div>
            <div class="card-body">
                <table class="table table-sm mb-0">
                    <tr>
                        <td class="text-muted" style="width: 40%;">E-mail:</td>
                        <td>${payer.email}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">First Name:</td>
                        <td><strong>${payer.firstName}</strong></td>
                    </tr>
                    <tr>
                        <td class="text-muted">Last Name:</td>
                        <td><strong>${payer.lastName}</strong></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="card mb-4">
    <div class="card-header bg-light">
        <h4 class="mb-0">Order Details</h4>
    </div>
    <div class="card-body">
        <table class="table table-sm mb-3">
            <tr>
                <td class="text-muted" style="width: 25%;">Order ID:</td>
                <td><strong>${orderId}</strong></td>
            </tr>
            <tr>
                <td class="text-muted">Ordered by:</td>
                <td><strong>${loggedCustomer.fullname}</strong></td>
            </tr>
            <tr>
                <td class="text-muted">Description:</td>
                <td>${transaction.description}</td>
            </tr>
        </table>

        <h5 class="mb-3">Items</h5>
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
                        <td><strong><fmt:formatNumber value="${item.price * item.quantity}" type="currency"/></strong></td>
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
                        <td class="text-end"><fmt:formatNumber value="${transaction.amount.details.subtotal}" type="currency"/></td>
                    </tr>
                    <tr>
                        <td>Tax:</td>
                        <td class="text-end"><fmt:formatNumber value="${transaction.amount.details.tax}" type="currency"/></td>
                    </tr>
                    <tr>
                        <td>Shipping fee:</td>
                        <td class="text-end"><fmt:formatNumber value="${transaction.amount.details.shipping}" type="currency"/></td>
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
