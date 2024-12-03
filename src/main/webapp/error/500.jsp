<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../css/stylesheet.css">
    <title>Internal Server Error | PageNook</title>
</head>
<body>
<div class="center">
    <div>
        <img style="vertical-align:middle" src="${pageContext.request.contextPath}/images/pagenook-logo.svg"
             width="200" height="100"
             alt="PageNook Admin Logo"/>
        <span style="vertical-align:middle; font-weight: bold; font-size: 32px">PageNook</span>
    </div>
    <h2 class="error">Sorry, the server has encountered an error while fulfilling your request.</h2>
    <p>Please check back later or contact the administrator.</p>
    <a href="javascript:history.back()">Go Back</a>
</div>
</body>
</html>
