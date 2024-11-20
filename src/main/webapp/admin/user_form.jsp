<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Create New User | PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div style="text-align: center">
    <h2>Create New User</h2>
    <hr style="width: 60%"/>
</div>

<div style="text-align: center">
    <form action="create_user" method="post" onsubmit="return isValidFormInput()">
        <div style="margin-bottom: 8px;">
            <label>Email:
                <input id="email" type="email" name="email" size="20"/>
            </label>
        </div>
        <div style="margin-bottom: 8px;">
            <label>Full name:
                <input id="fullname" type="text" name="fullname" size="20"/>
            </label>
        </div>
        <div style="margin-bottom: 8px;">
            <label>Password:
                <input id="password" type="password" name="password" size="20"/>
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
        const fieldEmail = document.getElementById("email");
        const fieldFullName = document.getElementById("fullname");
        const fieldPassword = document.getElementById("password");

        if (fieldEmail.value.length === 0) {
            alert("Email is required!");
            fieldEmail.focus();
            return false;
        }

        if (fieldFullName.value.length === 0) {
            alert("Full name is required!");
            fieldFullName.focus();
            return false;
        }

        if (fieldPassword.value.length === 0) {
            alert("Password is required!");
            fieldPassword.focus();
            return false;
        }

        return true;
    }
</script>
</body>
</html>
