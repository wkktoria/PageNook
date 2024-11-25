<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Manage Users | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div style="text-align: center">
    <h2>Users Management</h2>
    <a href="user_form.jsp">Create New User</a>
    <hr style="width: 60%"/>
</div>

<c:if test="${message != null}">
    <div style="text-align: center">
        <i>${message}</i>
    </div>
</c:if>

<div style="text-align: center">
    <table style="border: 1px solid black; margin-left: auto; margin-right: auto;">
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
                    <a href="javascript:confirmDelete(${user.userId})">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div style="text-align: center; margin-top: 16px;">
    <input type="button" value="Back to Dashboard" onclick="history.back()"/>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    function confirmDelete(userId) {
        if (confirm('Are you sure you want to delete the user with ID ' + userId + '?')) {
            window.location = 'delete_user?id=' + userId;
        }
    }
</script>
</body>
</html>
