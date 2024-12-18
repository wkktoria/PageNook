<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="center">
    <div>
        <a href="${pageContext.request.contextPath}/admin">
            <img style="vertical-align:middle" src="../images/pagenook-admin-logo.svg" width="200" height="100"
                 alt="PageNook Admin Logo"/>
            <span style="vertical-align:middle; font-weight: bold; font-size: 32px; color: black;">PageNook</span>
        </a>
    </div>
    <div>
        <span>Welcome, <c:out value="${sessionScope.useremail}"/> | </span><a href="logout">Logout</a>
    </div>
    <div id="headerMenu">
        <div>
            <a href="list_user">
                <img src="../images/user.svg" alt="User" height="40" width="40"/><br/>Users
            </a>
        </div>
        <div>
            <a href="list_category">
                <img src="../images/category.svg" alt="User" height="40" width="40"/><br/>Categories
            </a>
        </div>
        <div>
            <a href="list_book">
                <img src="../images/book.svg" alt="User" height="40" width="40"/><br/>Books
            </a>
        </div>
        <div>
            <a href="list_customer">
                <img src="../images/customer.svg" alt="User" height="40" width="40"/><br/>Customers
            </a>
        </div>
        <div>
            <a href="list_review">
                <img src="../images/review.svg" alt="User" height="40" width="40"/><br/>Reviews
            </a>
        </div>
        <div>
            <a href="list_order">
                <img src="../images/order.svg" alt="User" height="40" width="40"/><br/>Orders
            </a>
        </div>
    </div>
</div>