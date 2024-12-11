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
    <title>Manage Reviews | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h1 class="page-heading">Reviews Management</h1>
    <hr style="width: 60%"/>
</div>

<c:if test="${message != null}">
    <div class="center">
        <h4 class="message">${message}</h4>
    </div>
</c:if>

<div class="center">
    <table>
        <thead>
        <tr>
            <th scope="col">Index</th>
            <th scope="col">ID</th>
            <th scope="col">Book</th>
            <th scope="col">Rating</th>
            <th scope="col">Headline</th>
            <th scope="col">Customer</th>
            <th scope="col">Review On</th>
            <th scope="col">Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="review" items="${listReview}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${review.reviewId}</td>
                <td>${review.book.title}</td>
                <td>${review.rating}</td>
                <td>${review.headline}</td>
                <td>${review.customer.fullname}</td>
                <td>${review.reviewTime}</td>
                <td>
                    <a href="edit_review?id=${review.reviewId}">Edit</a> |
                    <a href="javascript:void(0)" class="delete-link" id="${review.reviewId}">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function () {
        $(".delete-link").each(function () {
            $(this).on("click", function () {
                const reviewId = $(this).attr("id");
                if (confirm("Are you sure you want do delete the review with ID " + reviewId + "?")) {
                    window.location = "delete_review?id=" + reviewId;
                }
            });
        });
    });
</script>
</body>
</html>
