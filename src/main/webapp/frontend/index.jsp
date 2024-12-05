<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <div class="center" style="width: 80%; margin: 0 auto;">
        <h2>New Books:</h2>
        <c:forEach var="book" items="${listNewBooks}">
            <div style="display: inline-block; margin: 20px;">
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

    <div class="center" style="clear: both;">
        <h2>Best-Selling Books:</h2>
    </div>

    <div class="center" style="clear: both;">
        <h2>Most Favored Books:</h2>
    </div>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
