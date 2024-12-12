<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forTokens items="${book.ratingStars}" delims="," var="star">
    <c:if test="${star eq 'on'}">
        <img alt="Star" src="images/rating-on.svg"/>
    </c:if>

    <c:if test="${star eq 'half'}">
        <img alt="Half of Star" src="images/rating-half.svg"/>
    </c:if>

    <c:if test="${star eq 'off'}">
        <img alt="Empty Star" src="images/rating-off.svg"/>
    </c:if>
</c:forTokens>