<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Edit Customer Profile"/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1">
    <div class="my-5">
        <h2 class="text-center mb-4">Edit My Profile</h2>

        <form action="update_profile" method="post" id="customerForm">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="email" class="form-label">Email <span
                            class="fw-bold">(cannot be changed)</span></label>
                    <input id="email"
                           type="email"
                           name="email"
                           class="form-control"
                           value="${loggedCustomer.email}"
                           required
                           readonly
                           maxlength="64"/>
                </div>

                <div class="col-md-6">
                    <label for="phone" class="form-label">Phone Number <span class="text-danger">*</span></label>
                    <input id="phone"
                           type="tel"
                           name="phone"
                           class="form-control"
                           value="${loggedCustomer.phone}"
                           required
                           maxlength="15"/>
                </div>

                <div class="col-md-6">
                    <label for="firstname" class="form-label">First Name <span class="text-danger">*</span></label>
                    <input id="firstname"
                           type="text"
                           name="firstname"
                           class="form-control"
                           value="${loggedCustomer.firstname}"
                           required
                           maxlength="30"/>
                </div>

                <div class="col-md-6">
                    <label for="lastname" class="form-label">Last Name <span class="text-danger">*</span></label>
                    <input id="lastname"
                           type="text"
                           name="lastname"
                           class="form-control"
                           value="${loggedCustomer.lastname}"
                           required
                           maxlength="30"/>
                </div>

                <div class="col-md-6">
                    <label for="password" class="form-label">
                        Password
                    </label>
                    <input id="password"
                           type="password"
                           name="password"
                           class="form-control"
                           minlength="6"
                           maxlength="32"/>
                    <div class="form-text">
                        Leave blank if you don't want to change password.
                    </div>
                </div>

                <div class="col-md-6">
                    <label for="confirmPassword" class="form-label">
                        Confirm Password
                    </label>
                    <input id="confirmPassword"
                           type="password"
                           name="confirmPassword"
                           class="form-control"
                           maxlength="32"/>
                    <div class="form-text">
                        Leave blank if you don't want to change password.
                    </div>
                </div>

                <div class="col-12">
                    <label for="address1" class="form-label">Address Line 1 <span class="text-danger">*</span></label>
                    <input id="address1"
                           type="text"
                           name="address1"
                           class="form-control"
                           value="${loggedCustomer.addressLine1}"
                           required
                           maxlength="128"/>
                </div>

                <div class="col-12">
                    <label for="address2" class="form-label">Address Line 2 <span class="text-danger">*</span></label>
                    <input id="address2"
                           type="text"
                           name="address2"
                           class="form-control"
                           value="${loggedCustomer.addressLine2}"
                           required
                           maxlength="128"/>
                </div>

                <div class="col-md-6">
                    <label for="city" class="form-label">City <span class="text-danger">*</span></label>
                    <input id="city"
                           type="text"
                           name="city"
                           class="form-control"
                           value="${loggedCustomer.city}"
                           required
                           maxlength="32"/>
                </div>

                <div class="col-md-6">
                    <label for="state" class="form-label">State <span class="text-danger">*</span></label>
                    <input id="state"
                           type="text"
                           name="state"
                           class="form-control"
                           value="${loggedCustomer.state}"
                           required
                           maxlength="45"/>
                </div>

                <div class="col-md-6">
                    <label for="zipcode" class="form-label">Zip Code <span class="text-danger">*</span></label>
                    <input id="zipcode"
                           type="text"
                           name="zipcode"
                           class="form-control"
                           value="${loggedCustomer.zipcode}"
                           required
                           maxlength="24"/>
                </div>

                <div class="col-md-6">
                    <label for="country" class="form-label">Country <span class="text-danger">*</span></label>
                    <select name="country" id="country" class="form-select" required>
                        <option value="">Select a country...</option>
                        <c:forEach items="${mapCountries}" var="country">
                            <option value="${country.value}"
                                    <c:if test="${loggedCustomer.country eq country.value}">selected</c:if>>${country.key}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-12 mt-4">
                    <div class="d-flex gap-2 justify-content-center">
                        <button type="submit" class="btn btn-primary btn-lg px-5">Save</button>
                        <button type="button" class="btn btn-outline-secondary btn-lg px-4" onclick="history.back()">
                            Cancel
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<jsp:directive.include file="footer.jsp"/>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("customerForm");
        const password = document.getElementById("password");
        const confirmPassword = document.getElementById("confirmPassword");

        function validatePasswords() {
            const pass = password.value.trim();
            const confirm = confirmPassword.value.trim();

            if (pass === "" && confirm === "") {
                password.setCustomValidity("");
                confirmPassword.setCustomValidity("");
                return;
            }

            if (pass === "" || confirm === "") {
                confirmPassword.setCustomValidity("Please fill both password fields");
                return;
            }

            if (pass !== confirm) {
                confirmPassword.setCustomValidity("Passwords do not match");
            } else {
                confirmPassword.setCustomValidity("");
            }
        }

        password.addEventListener("input", validatePasswords);
        confirmPassword.addEventListener("input", validatePasswords);

        form.addEventListener("submit", function (event) {
            validatePasswords();
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
        });
    });
</script>
</body>
</html>
