<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <title>Login | PageNook - Administration</title>
</head>
<body>
<div class="center">
    <h1 class="page-heading">PageNook Administration</h1>
    <h2>Admin Login</h2>

    <c:if test="${message != null}">
        <h4 class="message">${message}</h4>
    </c:if>

    <form action="login" method="post" id="loginForm">
        <table class="form">
            <tr>
                <td>Email:</td>
                <td><label>
                    <input type="email" name="email" id="email" size="20" required minlength="5" maxlength="64"/>
                </label></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><label>
                    <input type="password" name="password" id="password" size="20" required minlength="32" />
                </label></td>
            </tr>
            <tr>
                <td colspan="2" class="center">
                    <button type="submit">Login</button>
                </td>
            </tr>
        </table>
    </form>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
