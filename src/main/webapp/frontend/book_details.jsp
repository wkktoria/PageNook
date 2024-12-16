<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
    <title>${book.title} | PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <table class="book">
        <tr>
            <td colspan="3" style="text-align: left;">
                <p id="bookTitle">${book.title}</p> by <span id="author">${book.author}</span>
            </td>
        </tr>
        <tr>
            <td rowspan="2">
                <img class="book-large" src="data:image/jpg;base64,${book.base64Image}" alt="Book Cover"/>
            </td>
            <td style="vertical-align: top; text-align: left;">
                <jsp:directive.include file="book_rating.jsp"/>
                <a href="#reviews"> ${fn:length(book.reviews)} Reviews</a>
            </td>
            <td rowspan="2" style="vertical-align: top; width: 20%;">
                <h2>$${book.price}</h2>
                <br/><br/>
                <button id="buttonAddToCart">Add to Cart</button>
            </td>
        </tr>
        <tr>
            <td id="description">
                ${book.description}
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td><h2 id="reviews">Customer Reviews</h2></td>
            <td colspan="2" class="center">
                <button id="buttonWriteReview">Write a Customer Review</button>
            </td>
        </tr>
        <tr>
            <td colspan="3" class="left">
                <table style="border: 0; margin: 0;">
                    <c:forEach items="${book.reviews}" var="review">
                        <tr>
                            <td>
                                <c:forTokens items="${review.stars}" delims="," var="star">
                                    <c:if test="${star eq 'on'}">
                                        <img alt="Star" src="images/rating-on.svg"/>
                                    </c:if>

                                    <c:if test="${star eq 'off'}">
                                        <img alt="Empty Star" src="images/rating-off.svg"/>
                                    </c:if>
                                </c:forTokens>
                                <b>${review.headline}</b>
                            </td>
                        </tr>
                        <tr>
                            <td>by ${review.customer.fullname} on ${review.reviewTime}</td>
                        </tr>
                        <tr>
                            <td><i>${review.comment}</i></td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                    </c:forEach>
                </table>
            </td>
        </tr>
    </table>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function () {
        $("#buttonWriteReview").click(function () {
            window.location = "write_review?bookId=" + ${book.bookId};
        });

        $("#buttonAddToCart").click(function () {
            window.location = "add_to_cart?bookId=" + ${book.bookId};
        });
    });
</script>
</body>
</html>
