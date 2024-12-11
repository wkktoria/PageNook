<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.min.js"
            integrity="sha256-AlTido85uXPlSyyaZNsjJXeCs07eSv3r43kyCVc8ChI="
            crossorigin="anonymous"></script>
    <title>Edit Customer Profile | PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h1 class="page-heading">Edit My Profile</h1>
    <hr style="width: 60%"/>
</div>

<div class="center">
    <form action="update_profile" method="post" id="customerForm">
        <table class="form">
            <tr>
                <td class="right">E-mail:</td>
                <td class="left"><b>${loggedCustomer.email}</b> (cannot be changed)</td>
            </tr>
            <tr>
                <td class="right">Full Name:</td>
                <td class="left"><label for="fullname"></label><input id="fullname" type="text" name="fullname"
                                                                      size="45" value="${loggedCustomer.fullname}"/>
                </td>
            </tr>
            <tr>
                <td class="right">Phone Number:</td>
                <td class="left"><label for="phone"></label><input id="phone" type="text" name="phone" size="45"
                                                                   value="${loggedCustomer.phone}"/>
                </td>
            </tr>
            <tr>
                <td class="right">Address:</td>
                <td class="left"><label for="address"></label><input id="address" type="text" name="address" size="45"
                                                                     value="${loggedCustomer.address}"/>
                </td>
            </tr>
            <tr>
                <td class="right">City:</td>
                <td class="left"><label for="city"></label><input id="city" type="text" name="city" size="45"
                                                                  value="${loggedCustomer.city}"/></td>
            </tr>
            <tr>
                <td class="right">Zip Code:</td>
                <td class="left"><label for="zipcode"></label><input id="zipcode" type="text" name="zipcode" size="45"
                                                                     value="${loggedCustomer.zipcode}"/>
                </td>
            </tr>
            <tr>
                <td class="right">Country:</td>
                <td class="left"><label for="country"></label><input id="country" type="text" name="country" size="45"
                                                                     value="${loggedCustomer.country}"/>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <i>(leave password fields blank, if you don't want to change password)</i>
                </td>
            </tr>
            <tr>
                <td class="right">Password:</td>
                <td class="left"><label for="password"></label><input id="password" type="password" name="password"
                                                                      size="45"/></td>
            </tr>
            <tr>
                <td class="right">Confirm Password:</td>
                <td class="left"><label for="confirmPassword"></label><input id="confirmPassword" type="password"
                                                                             name="confirmPassword" size="45"/></td>
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
        $("#customerForm").validate({
            rules: {
                email: {
                    required: true,
                    email: true
                },
                fullname: "required",
                confirmPassword: {
                    equalTo: "#password"
                },
                phone: "required",
                address: "required",
                city: "required",
                zipcode: "required",
                country: "required"
            },
            messages: {
                email: {
                    required: "Please enter an e-mail address.",
                    email: "Please enter a valid e-mail address.",
                },
                fullname: "Please enter full name.",
                confirmPassword: {
                    equalTo: "Confirm password does not match the password.",
                },
                phone: "Please enter phone number.",
                address: "Pleas enter address.",
                city: "Please enter city.",
                zipcode: "Please enter zip code.",
                country: "Please enter country.",
            }
        });

        $("#buttonCancel").click(function () {
            history.back();
        });
    });
</script>
</body>
</html>
