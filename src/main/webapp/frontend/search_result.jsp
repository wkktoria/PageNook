<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <title>Results for ${keyword} | PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <c:if test="${fn:length(result) == 0}">
        <h2>No results for "${keyword}".</h2>
    </c:if>
    <c:if test="${fn:length(result) > 0}">
        <div style="width: 80%; margin: 0 auto; text-align: left;">
            <h2 class="center">Results for "${keyword}":</h2>
            <c:forEach var="book" items="${result}">
                <div>
                    <div style="display: inline-block; margin: 20px; text-align: left; width: 10%;">
                        <div>
                            <a href="view_book?id=${book.bookId}">
                                <img src="data:image/jpg;base64,${book.base64Image}" alt="Book Cover" width="128"
                                     height="164"/>
                            </a>
                        </div>
                    </div>
                    <div style="display: inline-block; margin: 20px; vertical-align: top; text-align: left; width: 60%;">
                        <div>
                            <h2>
                                <a href="view_book?id=${book.bookId}">
                                    <b>${book.title}</b>
                                </a>
                            </h2>
                        </div>
                        <div>
                            Average rating
                        </div>
                        <div>
                            <p>${fn:substring(book.description, 0, 100)}...</p>
                        </div>
                    </div>
                    <div style="display: inline-block; margin: 20px; vertical-align: top;">
                        <h3><b>$${book.price}</b></h3>
                        <h3><a href="#">Add to Cart</a></h3>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
