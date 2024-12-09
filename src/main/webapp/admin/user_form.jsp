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
    <title>Create New User | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <c:choose>
        <c:when test="${user != null}">
            <c:set value="Edit User" var="headingText"/>
        </c:when>
        <c:otherwise>
            <c:set value="Create New User" var="headingText"/>
        </c:otherwise>
    </c:choose>
    <h1 class="page-heading">${headingText}</h1>
    <hr style="width: 60%"/>
</div>

<div class="center">
    <c:choose>
        <c:when test="${user != null}">
            <c:set value="update_user" var="formAction"/>
        </c:when>
        <c:otherwise>
            <c:set value="create_user" var="formAction"/>
        </c:otherwise>
    </c:choose>

    <form action="${formAction}" method="post" id="userForm">
        <input type="hidden" name="userId" value="${user.userId}"/>
        <table class="form">
            <tr>
                <td>Email:</td>
                <td><label for="email"></label><input id="email" type="email" name="email" size="20"
                                                      value="${user.email}"/></td>
            </tr>
            <tr>
                <td>Full Name:</td>
                <td><label for="fullname"></label><input id="fullname" type="text" name="fullname" size="20"
                                                         value="${user.fullName}"/></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><label for="password"></label><input id="password" type="password" name="password" size="20"
                                                         value="${user.password}"/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Save</button>
                    <button type="button" id="buttonCancel">Cancel</button>
                </td>
            </tr>
        </table>
    </form>
</div>

<jsp:directive.include file="footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function () {
        $("#userForm").validate({
            rules: {
                email: {
                    required: true,
                    email: true
                },
                fullname: "required",
                <c:if test="${user == null}">
                password: "required"
                </c:if>
            },
            messages: {
                email: {
                    required: "Please enter an email address.",
                    email: "Please enter a valid email address.",
                },
                fullname: "Please enter a full name.",
                <c:if test="${user == null}">
                password: "Please enter a password.",
                </c:if>
            }
        });

        $("#buttonCancel").click(function () {
            history.back();
        });
    });
</script>
</body>
</html>
