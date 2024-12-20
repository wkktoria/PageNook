<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <title>PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <div class="center book-group">
        <h2>New Books:</h2>
        <c:forEach var="book" items="${listNewBooks}">
            <jsp:directive.include file="book_group.jsp"/>
        </c:forEach>
    </div>

    <div class="next-row">
        <div class="center book-group">
            <h2>Best-Selling Books:</h2>
            <c:forEach var="book" items="${listBestSellingBooks}">
                <jsp:directive.include file="book_group.jsp"/>
            </c:forEach>
        </div>
    </div>

    <div class="next-row">
        <div class="center book-group">
            <h2>Most Favored Books:</h2>
            <c:forEach var="book" items="${listFavoredBooks}">
                <jsp:directive.include file="book_group.jsp"/>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
