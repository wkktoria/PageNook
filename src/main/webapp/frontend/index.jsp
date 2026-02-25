<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Home"/>
</jsp:include>
<body>
<div class="container">
    <jsp:directive.include file="header.jsp"/>

    <h2 class="text-center">New Books:</h2>
    <div class="row justify-content-center mb-3">
        <c:forEach var="book" items="${listNewBooks}">
            <jsp:directive.include file="book_group.jsp"/>
        </c:forEach>
    </div>

    <h2 class="text-center">Best-Selling Books:</h2>
    <div class="row justify-content-center mb-3">
        <c:forEach var="book" items="${listBestSellingBooks}">
            <jsp:directive.include file="book_group.jsp"/>
        </c:forEach>
    </div>

    <h2 class="text-center">Most-Favored Books:</h2>
    <div class="row justify-content-center mb-3">
        <c:forEach var="book" items="${listFavoredBooks}">
            <jsp:directive.include file="book_group.jsp"/>
        </c:forEach>
    </div>

    <jsp:directive.include file="footer.jsp"/>
</div>
</body>
</html>
