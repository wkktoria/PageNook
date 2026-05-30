<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="py-3 mb-4 border-bottom">
    <div class="container">
        <div class="d-flex align-items-center">
            <a href="${pageContext.request.contextPath}/"
               class="d-flex align-items-center text-decoration-none">
                <img src="images/pagenook-logo.svg"
                     class="img-fluid me-3"
                     style="max-height: 60px;"
                     alt="PageNook Logo">
                <span class="fw-bold fs-2 text-dark">PageNook</span>
            </a>
        </div>
    </div>
</header>

<nav class="navbar navbar-expand-lg navbar-light bg-light mb-3">
    <div class="container">
        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse"
                data-bs-target="#topNavbar"
                aria-controls="topNavbar"
                aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse mt-3 mt-lg-0" id="topNavbar">
            <!-- Search Form -->
            <form class="d-flex me-lg-auto mb-3 mb-lg-0 w-100" action="search" method="get" style="max-width: 500px;">
                <input class="form-control me-2" type="search"
                       name="keyword" placeholder="Search for books, authors..."
                       aria-label="Search"/>
                <button type="submit" class="btn btn-primary text-nowrap">Search</button>
            </form>

            <!-- User Navigation -->
            <ul class="navbar-nav ms-auto">
                <c:choose>
                    <c:when test="${loggedCustomer == null}">
                        <li class="nav-item">
                            <a href="login" class="nav-link">Sign In</a>
                        </li>
                        <li class="nav-item">
                            <a href="register" class="nav-link">Register</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a href="view_profile" class="nav-link fw-medium">
                                Welcome, ${loggedCustomer.fullname}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="view_orders" class="nav-link">My Orders</a>
                        </li>
                        <li class="nav-item">
                            <a href="logout" class="nav-link">Logout</a>
                        </li>
                    </c:otherwise>
                </c:choose>
                <li class="nav-item">
                    <a href="view_cart" class="nav-link fw-medium">Cart</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<nav class="mb-4 bg-light border-top border-bottom">
    <div class="container">
        <div class="d-flex flex-wrap gap-3 justify-content-center py-3">
            <c:forEach var="category" items="${listCategory}">
                <a href="view_category?id=${category.categoryId}"
                   class="text-decoration-none text-dark fw-medium px-2 category-link">
                    <c:out value="${category.name}"/>
                </a>
            </c:forEach>
        </div>
    </div>
</nav>
