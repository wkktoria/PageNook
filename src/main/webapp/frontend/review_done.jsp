<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Review Posted"/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1">
    <div class="my-5">
        <h2 class="text-center mb-4">Your Reviews</h2>
        <p class="text-center text-muted mb-5">
            ${loggedCustomer.fullname}
        </p>

        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                <div class="card shadow-sm border-0">
                    <div class="row g-0 align-items-center">
                        <div class="col-md-4 text-center p-4">
                            <img src="data:image/jpg;base64,${book.base64Image}"
                                 alt="Book Cover"
                                 class="img-fluid rounded"
                                 style="max-height: 280px;">
                        </div>
                        <div class="col-md-8 p-4">
                            <h4 class="fw-semibold mb-3">${book.title}</h4>

                            <div class="alert alert-success mb-0" role="alert">
                                <strong>Your review has been posted.</strong><br>
                                Thank you for your feedback!
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
