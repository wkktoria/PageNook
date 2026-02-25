<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
    <title>Payment Receipt | PageNook - Online Bookstore</title>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="center">
    <h2>You have made payment successfully. Thank you for purchasing.</h2>

    <jsp:directive.include file="../common/receipt.jsp"/>

    <div>
        <br/>
        <input type="button" value="Print Receipt" onclick="showPrintReceiptPopup()"/>
    </div>
</div>

<jsp:directive.include file="footer.jsp"/>

<script>
    function showPrintReceiptPopup() {
        const width = 600;
        const height = 250;
        const left = (screen.width - width) / 2;
        const top = (screen.width - width) / 2;

        window.open('frontend/print_receipt.jsp', '_blank',
            'width=' + width + ", height=" + height + ", top=" + top + ", left=" + left);
    }
</script>
</body>
</html>
