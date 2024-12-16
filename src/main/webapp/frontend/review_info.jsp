<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.4/jquery.rateyo.min.css"
          integrity="sha512-JEUoTOcC35/ovhE1389S9NxeGcVLIqOAEzlpcJujvyUaxvIXJN9VxPX0x1TwSo22jCxz2fHQPS1de8NgUyg+nA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.4/jquery.rateyo.min.js"
            integrity="sha512-09bUVOnphTvb854qSgkpY/UGKLW9w7ISXGrN0FR/QdXTkjs0D+EfMFMTB+CGiIYvBoFXexYwGUD5FD8xVU89mw=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <title>Write Review | PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <form id="reviewForm">
        <table style="border: 0; width: 60%;">
            <tr>
                <td>
                    <h3>You have already written a review for this book.</h3>
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
                <td>
                    <div id="rateYo"></div>
                    <br/>
                    <br/>
                    <label>
                        <input type="text" id="headline" name="headline" size="60" readonly value="${review.headline}"/>
                    </label>
                    <br/>
                    <br/>
                    <label>
                        <textarea id="comment" name="comment" cols="70" rows="10" readonly>${review.comment}</textarea>
                    </label>
                </td>
            </tr>
        </table>
    </form>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function () {
        $("#rateYo").rateYo({
            starWidth: "40px",
            fullStar: true,
            rating: ${review.rating},
            readOnly: true,
        });
    });
</script>
</body>
</html>
