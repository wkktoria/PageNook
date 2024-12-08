<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <title>PageNook - Administration</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h1 class="page-heading">Administrative Dashboard</h1>
    <hr style="width: 60%"/>
</div>

<div class="center">
    <h2 class="page-heading">Quick Actions:</h2>
    <a href="new_book">New Book</a> |
    <a href="user_form.jsp">New User</a> |
    <a href="category_form.jsp">New Category</a> |
    <a href="customer_form.jsp">New Customer</a>
    <hr style="width: 60%"/>
</div>

<div class="center">
    <h2 class="page-heading">Recent Sales:</h2>
    <hr style="width: 60%"/>
</div>

<div class="center">
    <h2 class="page-heading">Recent Reviews:</h2>
    <hr style="width: 60%"/>
</div>

<div class="center">
    <h2 class="page-heading">Statistics:</h2>
    <hr style="width: 60%"/>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
