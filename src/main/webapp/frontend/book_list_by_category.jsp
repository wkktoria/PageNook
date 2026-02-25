<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Books in ${category.name}"/>
</jsp:include>
<body>
<div class="container">
    <jsp:directive.include file="header.jsp"/>

    <h2 class="text-center">${category.name}</h2>

    <div class="rowp">
        <c:forEach var="book" items="${listBook}">
            <jsp:directive.include file="book_group.jsp"/>
        </c:forEach>
    </div>

    <jsp:directive.include file="footer.jsp"/>
</div>
</body>
</html>
