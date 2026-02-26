<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Customer Login"/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1 py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h2 class="text-center mb-4">Customer Login</h2>

                    <c:if test="${message != null}">
                        <div class="alert alert-danger" role="alert">
                                ${message}
                        </div>
                    </c:if>

                    <form action="login" method="post" id="loginForm">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email"
                                   class="form-control"
                                   name="email"
                                   id="email"
                                   required
                                   minlength="5"
                                   maxlength="64"
                                   placeholder="Enter your email"/>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password"
                                   class="form-control"
                                   name="password"
                                   id="password"
                                   required
                                   minlength="6"
                                   maxlength="32"
                                   placeholder="Enter your password"/>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg">Login</button>
                        </div>

                        <div class="text-center mt-3">
                            <p class="text-muted mb-0">Don't have an account? <a href="register"
                                                                                 class="text-decoration-none">Register
                                here</a></p>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>