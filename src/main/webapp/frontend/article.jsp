<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="${article.title}"/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1 py-5">
    <article class="row justify-content-center">
        <div class="col-lg-8">
            <h1 class="mb-4">${article.title}</h1>
            <div>
                ${article.content}
            </div>
        </div>
    </article>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>