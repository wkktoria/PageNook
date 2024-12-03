<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="center">
    <div>
        <img style="vertical-align:middle" src="images/pagenook-logo.svg" width="200" height="100" alt="PageNook Logo"/>
        <span style="vertical-align:middle; font-weight: bold; font-size: 32px">PageNook</span>
    </div>

    <div>
        <label>
            <input type="text" name="keyword" size="50"/>
        </label>
        <input type="button" value="Search"/>

        <a href="#">Sign In</a> |
        <a href="#">Register</a> |
        <a href="#">Cart</a>
    </div>

    <div>
        <c:forEach var="category" items="${listCategory}" varStatus="status">
            <a href="view_category?id=${category.categoryId}">
                <c:out value="${category.name}"/>
            </a><c:if test="${not status.last}"> | </c:if>
        </c:forEach>
    </div>
</div>