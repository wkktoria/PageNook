<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Books in ${category.name}"/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1">
    <div class="my-5">
        <h2 class="text-center mb-4">${category.name}</h2>

        <div class="row">
            <c:forEach var="book" items="${listBook}">
                <jsp:directive.include file="book_group.jsp"/>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>