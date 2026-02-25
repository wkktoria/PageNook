<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
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
                        <input type="text" size="60" id="headline" name="headline" value="${review.headline}" required/>
                    </label>
                </td>
            </tr>
            <tr>
                <td class="right">Comment:</td>
                <td class="left">
                    <label>
                        <textarea rows="5" cols="70" id="comment" name="comment" required>${review.comment}</textarea>
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
        $("#buttonCancel").click(function () {
            history.back();
        });
    });
</script>
</body>
</html>
