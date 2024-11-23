<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Manage Categories | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div style="text-align: center">
    <h2>Categories Management</h2>
    <a href="category_form.jsp">Create New Category</a>
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
            <th scope="col">Name</th>
            <th scope="col">Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="category" items="${listCategory}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${category.id}</td>
                <td>${category.name}</td>
                <td>
                    <a href="edit_category?id=${category.id}">Edit</a> |
                    <a href="javascript:confirmDelete(${category.id})">Delete</a>
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
    function confirmDelete(categoryId) {
        if (confirm('Are you sure you want to delete the category with ID ' + categoryId + '?')) {
            window.location = 'delete_category?id=' + categoryId;
        }
    }
</script>
</body>
</html>
