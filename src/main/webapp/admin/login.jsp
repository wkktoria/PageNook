<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Login | PageNook - Administration</title>
</head>
<body>
<div class="center">
    <h1 class="page-heading">PageNook Administration</h1>
    <h2>Admin Login</h2>

    <c:if test="${message != null}">
        <h4 class="message">${message}</h4>
    </c:if>

    <form action="login" method="post" id="login-form">
        <table class="form">
            <tr>
                <td>Email:</td>
                <td><label>
                    <input type="text" name="email" id="email" size="20"/>
                </label></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><label>
                    <input type="password" name="password" id="password" size="20"/>
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

<script type="text/javascript">
    $(document).ready(function () {
        $("#login-form").validate({
            rules: {
                email: {
                    required: true,
                    email: true
                },
                password: "required",
            },
            messages: {
                email: {
                    required: "Please enter an email address.",
                    email: "Please enter a valid email address.",
                },
                password: "Please enter a password.",
            }
        });
    });
</script>
</body>
</html>
