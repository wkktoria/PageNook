<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <title>Customer Profile | PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h2>Welcome, ${loggedCustomer.fullname}</h2>

    <table style="border: 0;">
        <tr>
            <td class="left bold">E-mail Address:</td>
            <td class="left">${loggedCustomer.email}</td>
        </tr>
        <tr>
            <td class="left bold">Full Name:</td>
            <td class="left">${loggedCustomer.fullname}</td>
        </tr>
        <tr>
            <td class="left bold">Phone Number:</td>
            <td class="left">${loggedCustomer.phone}</td>
        </tr>
        <tr>
            <td class="left bold">Address:</td>
            <td class="left">${loggedCustomer.address}</td>
        </tr>
        <tr>
            <td class="left bold">City:</td>
            <td class="left">${loggedCustomer.city}</td>
        </tr>
        <tr>
            <td class="left bold">Zip Code:</td>
            <td class="left">${loggedCustomer.zipcode}</td>
        </tr>
        <tr>
            <td class="left bold">Country:</td>
            <td class="left">${loggedCustomer.country}</td>
        </tr>
        <tr>
            <td colspan="2">
                <a href="edit_profile">Edit My Profile</a>
            </td>
        </tr>
    </table>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
