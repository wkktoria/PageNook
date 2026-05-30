<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Payment Receipt"/>
</jsp:include>
<body class="d-flex flex-column min-vh-100" onload="window.print()">
<div class="container flex-grow-1 my-5">
    <jsp:directive.include file="../common/receipt.jsp"/>
</div>
</body>
</html>
