<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="center">
    <div>
        <a href="${pageContext.request.contextPath}/">
            <img style="vertical-align:middle" src="images/pagenook-logo.svg" width="200" height="100"
                 alt="PageNook Logo"/>
            <span style="vertical-align:middle; font-weight: bold; font-size: 32px; color: black;">PageNook</span>
        </a>
    </div>

    <div>
        <form action="search" method="get">
            <label>
                <input type="text" name="keyword" size="50"/>
            </label>
            <input type="submit" value="Search"/>

            <c:if test="${loggedCustomer == null}">
                <a href="login">Sign In</a> |
                <a href="register">Register</a> |
            </c:if>
            <c:if test="${loggedCustomer != null}">
                <a href="view_profile">Welcome, ${loggedCustomer.fullname}</a> |
                <a href="view_orders">My Orders</a> |
                <a href="logout">Logout</a> |
            </c:if>
            <a href="#">Cart</a>
        </form>
    </div>

    <div>
        <c:forEach var="category" items="${listCategory}" varStatus="status">
            <a href="view_category?id=${category.categoryId}">
                <c:out value="${category.name}"/>
            </a><c:if test="${not status.last}"> | </c:if>
        </c:forEach>
    </div>
</div>