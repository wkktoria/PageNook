<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row mb-2">
    <a href="${pageContext.request.contextPath}/"
       class="d-inline-flex align-items-center text-decoration-none">
        <img src="images/pagenook-logo.svg"
             class="img-fluid me-2"
             style="max-height: 60px;"
             alt="PageNook Logo">
        <span class="fw-bold fs-2 text-dark">PageNook</span>
    </a>
</div>

<nav class="navbar navbar-expand-lg">
    <button class="navbar-toggler mb-2 me-2" type="button"
            data-bs-toggle="collapse"
            data-bs-target="#topNavbar"
            aria-controls="topNavbar"
            aria-expanded="false"
            aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="topNavbar">
        <form class="d-flex align-items-center me-auto" action="search" method="get">
            <input class="form-control form-control-sm me-2" type="search"
                   name="keyword" placeholder="Search by keyword..."
                   aria-label="Search"/>
            <button type="submit" class="btn btn-outline-success btn-sm">Search</button>
        </form>
        <ul class="navbar-nav">
            <c:choose>
                <c:when test="${loggedCustomer == null}">
                    <li class="nav-item"><a href="login" class="nav-link">Sign In</a></li>
                    <li class="nav-item"><a href="register" class="nav-link">Register</a></li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item"><a href="view_profile" class="nav-link">Welcome, ${loggedCustomer.fullname}</a>
                    </li>
                    <li class="nav-item"><a href="view_orders" class="nav-link">My Orders</a></li>
                    <li class="nav-item"><a href="logout" class="nav-link">Logout</a></li>
                </c:otherwise>
            </c:choose>
            <li class="nav-item"><a href="view_cart" class="nav-link">Cart</a></li>
        </ul>
    </div>
</nav>

<div class="row">
    <div class="col">
        <nav class="d-flex flex-wrap gap-2 justify-content-center py-2 border-top border-bottom">
            <c:forEach var="category" items="${listCategory}">
                <a href="view_category?id=${category.categoryId}"
                   class="text-decoration-none text-secondary fw-medium px-2">
                    <c:out value="${category.name}"/>
                </a>
            </c:forEach>
        </nav>
    </div>
</div>