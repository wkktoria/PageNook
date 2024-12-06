<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <title>${book.title} | PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <table style="width: 80%; border: 0;">
        <tr>
            <td colspan="3" style="text-align: left;">
                <h2>${book.title}</h2> by ${book.author}
            </td>
        </tr>
        <tr>
            <td rowspan="2">
                <img src="data:image/jpg;base64,${book.base64Image}" alt="Book Cover" width="240" height="300"/>
            </td>
            <td style="vertical-align: top; text-align: left;">
                Average Rating
            </td>
            <td rowspan="2" style="vertical-align: top; width: 20%;">
                <h2>$${book.price}</h2>
                <br/><br/>
                <button type="submit">Add to Cart</button>
            </td>
        </tr>
        <tr>
            <td style="vertical-align: top; text-align: justify;">
                ${book.description}
            </td>
        </tr>
        <tr>
            <td><br/></td>
        </tr>
        <tr>
            <td><h2>Customer Reviews</h2></td>
            <td colspan="2" class="center">
                <button>Write a Customer Review</button>
            </td>
        </tr>
    </table>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
