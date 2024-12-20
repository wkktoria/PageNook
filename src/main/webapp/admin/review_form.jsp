<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Edit Review | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h1 class="page-heading">Edit Review</h1>
    <hr style="width: 60%"/>
</div>

<div class="center">
    <form action="update_review" method="post" id="reviewForm">
        <input type="hidden" name="reviewId" value="${review.reviewId}"/>
        <table class="form">
            <tr>
                <td class="right">Book:</td>
                <td class="left"><b>${review.book.title}</b></td>
            </tr>
            <tr>
                <td class="right">Rating:</td>
                <td class="left"><b>${review.rating}</b></td>
            </tr>
            <tr>
                <td class="right">Customer:</td>
                <td class="left"><b>${review.customer.fullname}</b></td>
            </tr>
            <tr>
                <td class="right">Headline:</td>
                <td class="left">
                    <label>
                        <input type="text" size="60" id="headline" name="headline" value="${review.headline}"/>
                    </label>
                </td>
            </tr>
            <tr>
                <td class="right">Comment:</td>
                <td class="left">
                    <label>
                        <textarea rows="5" cols="70" id="comment" name="comment">${review.comment}</textarea>
                    </label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Save</button>
                    <input type="button" id="buttonCancel" value="Cancel"/>
                </td>
            </tr>
        </table>
    </form>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function () {
        $('#reviewForm').validate({
            rules: {
                headline: "required",
                comment: "required"
            }, messages: {
                headline: "Please enter headline.",
                comment: "Pleas enter comment."
            }
        });

        $("#buttonCancel").click(function () {
            history.back();
        });
    });
</script>
</body>
</html>
