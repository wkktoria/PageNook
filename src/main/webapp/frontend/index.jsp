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
            <div class="book">
                <div>
                    <a href="view_book?id=${book.bookId}">
                        <img class="book-small" src="data:image/jpg;base64,${book.base64Image}" alt="Book Cover"/>
                    </a>
                </div>
                <div>
                    <a href="view_book?id=${book.bookId}">
                        <b>${book.title}</b>
                    </a>
                </div>
                <div>
                    <jsp:directive.include file="book_rating.jsp"/>
                </div>
                <div><i>by ${book.author}</i></div>
                <div><b>$${book.price}</b></div>
            </div>
        </c:forEach>
    </div>

    <div class="next-row">
        <h2>Best-Selling Books:</h2>
    </div>

    <div class="next-row">
        <h2>Most Favored Books:</h2>
    </div>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
