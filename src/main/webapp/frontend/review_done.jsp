<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <title>Review Posted | PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <table style="border: 0; width: 60%;">
        <tr>
            <td>
                <h2>Your Reviews</h2>
            </td>
            <td></td>
            <td>
                <h2>${loggedCustomer.fullname}</h2>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <hr/>
            </td>
        </tr>
        <tr>
            <td>
                <span id="bookTitle">${book.title}</span>
                <img class="book-large" src="data:image/jpg;base64,${book.base64Image}" alt="Book Cover"/>
            </td>
            <td colspan="2">
                <h3>Your review has been posted. Thank you!</h3>
            </td>
        </tr>
    </table>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
