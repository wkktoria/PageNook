<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div style="text-align: center">
    <h2>Administrative Dashboard</h2>
    <hr style="width: 60%"/>
</div>

<div style="text-align: center">
    <h3>Quick Actions:</h3>
    <a href="#">New Book</a> |
    <a href="user_form.jsp">New User</a> |
    <a href="#">New Category</a> |
    <a href="#">New Customer</a>
    <hr style="width: 60%"/>
</div>

<div style="text-align: center">
    <h3>Recent Sales:</h3>
    <hr style="width: 60%"/>
</div>

<div style="text-align: center">
    <h3>Recent Reviews:</h3>
    <hr style="width: 60%"/>
</div>

<div style="text-align: center">
    <h3>Statistics:</h3>
    <hr style="width: 60%"/>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
