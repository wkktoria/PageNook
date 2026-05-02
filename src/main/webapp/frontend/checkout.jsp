<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Checkout"/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1 my-5">
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
        <div class="row">
            <div class="col-12 mb-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2>Review Your Order Details</h2>
                    <a href="view_cart" class="btn btn-outline-primary btn-sm">Edit Cart</a>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                        <tr>
                            <th style="width: 5%;">No.</th>
                            <th style="width: 10%;" colspan="2">Book</th>
                            <th style="width: 25%;">Author</th>
                            <th style="width: 15%;">Price</th>
                            <th style="width: 10%;">Quantity</th>
                            <th style="width: 15%;">Subtotal</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${cart.items}" var="item" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td style="width: 60px;">
                                    <img class="img-fluid rounded" src="data:image/jpg;base64,${item.key.base64Image}"
                                         alt="Book Cover" style="max-width: 50px;"/>
                                </td>
                                <td><strong>${item.key.title}</strong></td>
                                <td>${item.key.author}</td>
                                <td><fmt:formatNumber value="${item.key.price}" type="currency"/></td>
                                <td>${item.value}</td>
                                <td><strong><fmt:formatNumber value="${item.value * item.key.price}"
                                                              type="currency"/></strong></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="card mt-3">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 offset-md-6">
                                <table class="table table-sm mb-0">
                                    <tr>
                                        <td>Number of copies:</td>
                                        <td class="text-end">${cart.totalQuantity}</td>
                                    </tr>
                                    <tr>
                                        <td>Subtotal:</td>
                                        <td class="text-end"><fmt:formatNumber value="${cart.totalAmount}"
                                                                               type="currency"/></td>
                                    </tr>
                                    <tr>
                                        <td>Tax:</td>
                                        <td class="text-end"><fmt:formatNumber value="${tax}" type="currency"/></td>
                                    </tr>
                                    <tr>
                                        <td>Shipping fee:</td>
                                        <td class="text-end"><fmt:formatNumber value="${shippingFee}"
                                                                               type="currency"/></td>
                                    </tr>
                                    <tr class="table-light">
                                        <td><strong>TOTAL:</strong></td>
                                        <td class="text-end">
                                            <strong class="text-primary fs-5">
                                                <fmt:formatNumber value="${total}" type="currency"/>
                                            </strong>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12">
                <form id="orderForm" action="place_order" method="post">
                    <div class="card mb-4">
                        <div class="card-header bg-light">
                            <h3 class="mb-0">Recipient Information</h3>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="firstname" class="form-label">First Name <span
                                            class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="firstname" name="firstname"
                                           value="${loggedCustomer.firstname}"/>
                                </div>
                                <div class="col-md-6">
                                    <label for="lastname" class="form-label">Last Name <span
                                            class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="lastname" name="lastname"
                                           value="${loggedCustomer.lastname}"/>
                                </div>
                                <div class="col-md-6">
                                    <label for="phone" class="form-label">Phone <span
                                            class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="phone" name="phone"
                                           value="${loggedCustomer.phone}"/>
                                </div>
                                <div class="col-md-6">
                                    <label for="address1" class="form-label">Address Line 1 <span
                                            class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="address1" name="address1"
                                           value="${loggedCustomer.addressLine1}"/>
                                </div>
                                <div class="col-md-6">
                                    <label for="address2" class="form-label">Address Line 2 <span
                                            class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="address2" name="address2"
                                           value="${loggedCustomer.addressLine2}"/>
                                </div>
                                <div class="col-md-6">
                                    <label for="city" class="form-label">City <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="city" name="city"
                                           value="${loggedCustomer.city}"/>
                                </div>
                                <div class="col-md-4">
                                    <label for="state" class="form-label">State <span
                                            class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="state" name="state"
                                           value="${loggedCustomer.state}"/>
                                </div>
                                <div class="col-md-4">
                                    <label for="zipcode" class="form-label">Zip Code <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="zipcode" name="zipcode"
                                           value="${loggedCustomer.zipcode}"/>
                                </div>
                                <div class="col-md-4">
                                    <label for="country" class="form-label">Country <span
                                            class="text-danger">*</span></label>
                                    <select class="form-select" name="country" id="country">
                                        <c:forEach items="${mapCountries}" var="country">
                                            <option value="${country.value}"
                                                    <c:if test="${loggedCustomer.country eq country.value}">selected</c:if>>${country.key}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card mb-4">
                        <div class="card-header bg-light">
                            <h3 class="mb-0">Payment</h3>
                        </div>
                        <div class="card-body">
                            <label for="paymentMethod" class="form-label">Choose your payment method <span
                                    class="text-danger">*</span></label>
                            <select class="form-select" name="paymentMethod" id="paymentMethod">
                                <option value="Cash on Delivery">Cash on Delivery</option>
                                <option value="paypal">PayPal or Credit Card</option>
                            </select>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between flex-wrap gap-2">
                        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">
                            Continue Shopping
                        </a>
                        <button type="submit" class="btn btn-success btn-lg">
                            Place Order
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </c:if>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    // $(document).ready(function () {
    //     $('#orderForm').validate({
    //         rules: {
    //             firstname: "required",
    //             lastname: "required",
    //             phone: "required",
    //             address1: "required",
    //             address2: "required",
    //             city: "required",
    //             state: "required",
    //             zipcode: "required",
    //             country: "required"
    //         },
    //         messages: {
    //             firstname: "Please enter first name.",
    //             lastname: "Please enter last name.",
    //             phone: "Please enter phone number.",
    //             address1: "Please enter street address line 1.",
    //             address2: "Please enter street address line 2.",
    //             city: "Please enter city.",
    //             state: "Please enter state.",
    //             zipcode: "Please enter zip code.",
    //             country: "Please enter country."
    //         },
    //     });
    // });
</script>
</body>
</html>
