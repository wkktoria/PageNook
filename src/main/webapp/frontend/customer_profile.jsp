<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Customer Profile"/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">

<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1">
    <div class="my-5">
        <div class="text-center mb-5">
            <h2 class="fw-bold">My Account</h2>
            <p class="text-muted mb-0">
                Welcome, ${loggedCustomer.fullname}
            </p>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-8">

                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="mb-0 fw-bold">Profile Information</h5>
                            <a href="edit_profile" class="btn btn-sm btn-outline-primary">
                                Edit Profile
                            </a>
                        </div>

                        <hr class="mb-4"/>

                        <div class="row gy-3">
                            <div class="col-5 col-md-4 text-muted">Email</div>
                            <div class="col-7 col-md-8 fw-semibold">
                                ${loggedCustomer.email}
                            </div>

                            <div class="col-5 col-md-4 text-muted">Phone Number</div>
                            <div class="col-7 col-md-8 fw-semibold">
                                ${loggedCustomer.phone}
                            </div>

                            <div class="col-5 col-md-4 text-muted">First Name</div>
                            <div class="col-7 col-md-8 fw-semibold">
                                ${loggedCustomer.firstname}
                            </div>

                            <div class="col-5 col-md-4 text-muted">Last Name</div>
                            <div class="col-7 col-md-8 fw-semibold">
                                ${loggedCustomer.lastname}
                            </div>

                            <div class="col-5 col-md-4 text-muted">Address Line 1</div>
                            <div class="col-7 col-md-8 fw-semibold">
                                ${loggedCustomer.addressLine1}
                            </div>

                            <div class="col-5 col-md-4 text-muted">Address Line 2</div>
                            <div class="col-7 col-md-8 fw-semibold">
                                ${loggedCustomer.addressLine2}
                            </div>

                            <div class="col-5 col-md-4 text-muted">City</div>
                            <div class="col-7 col-md-8 fw-semibold">
                                ${loggedCustomer.city}
                            </div>

                            <div class="col-5 col-md-4 text-muted">State</div>
                            <div class="col-7 col-md-8 fw-semibold">
                                ${loggedCustomer.state}
                            </div>

                            <div class="col-5 col-md-4 text-muted">Zip Code</div>
                            <div class="col-7 col-md-8 fw-semibold">
                                ${loggedCustomer.zipcode}
                            </div>

                            <div class="col-5 col-md-4 text-muted">Country</div>
                            <div class="col-7 col-md-8 fw-semibold">
                                ${loggedCustomer.countryName}
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<jsp:directive.include file="footer.jsp"/>

</body>
</html>
