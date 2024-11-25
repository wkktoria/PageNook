<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Create New Category | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div style="text-align: center">
    <c:choose>
        <c:when test="${category != null}">
            <c:set value="Edit Category" var="headingText"/>
        </c:when>
        <c:otherwise>
            <c:set value="Create New Category" var="headingText"/>
        </c:otherwise>
    </c:choose>
    <h2>${headingText}</h2>
    <hr style="width: 60%"/>
</div>

<div style="text-align: center">
    <c:choose>
        <c:when test="${category != null}">
            <c:set value="update_category" var="formAction"/>
        </c:when>
        <c:otherwise>
            <c:set value="create_category" var="formAction"/>
        </c:otherwise>
    </c:choose>

    <form action="${formAction}" method="post" onsubmit="return isValidFormInput()">
        <input type="hidden" name="id" value="${category.id}"/>
        <div style="margin-bottom: 8px;">
            <label>Name:
                <input id="name" type="text" name="name" size="20" value="${category.name}"/>
            </label>
        </div>
        <div style="margin-bottom: 8px;">
            <input type="submit" value="Save"/>
            <input type="button" value="Cancel" onclick="history.back()"/>
        </div>
    </form>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    function isValidFormInput() {
        const fieldName = document.getElementById("name");

        if (fieldName.value.length === 0) {
            alert("Category name is required!");
            fieldName.focus();
            return false;
        }

        return true;
    }
</script>
</body>
</html>
