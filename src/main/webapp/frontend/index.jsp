<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
            integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js"
            integrity="sha384-G/EV+4j2dNv+tEPo3++6LCgdCROaejBqfUeNjuKAiuXbjrxilcCdDz6ZAVfHWe1Y"
            crossorigin="anonymous"></script>
    <title>PageNook - Online Bookstore</title>
</head>
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
