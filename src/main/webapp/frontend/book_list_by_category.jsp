<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <title>Books in ${category.name} | PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h2>${category.name}</h2>
</div>

<div class="center" style="width: 80%; margin: 0 auto;">
    <c:forEach var="book" items="${listBook}">
        <div style="display: inline-block; margin: 20px; float: left;">
            <div>
                <a href="view_book?id=${book.bookId}">
                    <img src="data:image/jpg;base64,${book.base64Image}" alt="Book Cover" width="128" height="164"/>
                </a>
            </div>
            <div>
                <a href="view_book?id=${book.bookId}">
                    <b>${book.title}</b>
                </a>
            </div>
            <div>Average rating</div>
            <div><i>by ${book.author}</i></div>
            <div><b>$${book.price}</b></div>
        </div>
    </c:forEach>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
