<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="PageNook"/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1 my-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="alert alert-info text-center" role="alert">
                <h3 class="mb-0">${message}</h3>
            </div>
            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go to Home</a>
            </div>
        </div>
    </div>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
