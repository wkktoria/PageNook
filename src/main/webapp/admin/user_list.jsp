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
    <title>Manage Users | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h1 class="pageHeading">Users Management</h1>
    <a href="user_form.jsp">Create New User</a>
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
            <th scope="col">Email</th>
            <th scope="col">Full Name</th>
            <th scope="col">Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${listUser}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${user.userId}</td>
                <td>${user.email}</td>
                <td>${user.fullName}</td>
                <td>
                    <a href="edit_user?id=${user.userId}">Edit</a> |
                    <a class="deleteLink" href="javascript:void(0)" id="${user.userId}">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function () {
        $(".deleteLink").each(function () {
            $(this).on("click", function () {
                const userId = $(this).attr("id");
                if (confirm("Are you sure you want do delete the user with ID " + userId + "?")) {
                    window.location = "delete_user?id=" + userId;
                }
            });
        });
    });
</script>
</body>
</html>
