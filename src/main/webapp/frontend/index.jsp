<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Home"/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1">
    <section class="my-5">
        <h2 class="text-center mb-4">New Books</h2>
        <div class="row justify-content-center">
            <c:forEach var="book" items="${listNewBooks}">
                <jsp:directive.include file="book_group.jsp"/>
            </c:forEach>
        </div>
    </section>

    <hr class="my-5">

    <section class="my-5">
        <h2 class="text-center mb-4">Best-Selling Books</h2>
        <div class="row justify-content-center">
            <c:forEach var="book" items="${listBestSellingBooks}">
                <jsp:directive.include file="book_group.jsp"/>
            </c:forEach>
        </div>
    </section>

    <hr class="my-5">

    <section class="my-5">
        <h2 class="text-center mb-4">Most-Favored Books</h2>
        <div class="row justify-content-center">
            <c:forEach var="book" items="${listFavoredBooks}">
                <jsp:directive.include file="book_group.jsp"/>
            </c:forEach>
        </div>
    </section>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>