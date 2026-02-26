<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Results for ${keyword} "/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1">
    <c:if test="${fn:length(result) == 0}">
        <div class="alert alert-info text-center my-5" role="alert">
            <h4 class="alert-heading">No results found</h4>
            <p class="mb-0">We couldn't find any books matching "<strong>${keyword}</strong>".</p>
        </div>
    </c:if>

    <c:if test="${fn:length(result) > 0}">
        <div class="my-4">
            <h2 class="mb-4">Results for "<span class="text-primary">${keyword}</span>"</h2>
            <p class="text-muted">Found ${fn:length(result)} ${fn:length(result) == 1 ? 'book' : 'books'}</p>
        </div>

        <div class="row row-cols-1 g-4">
            <c:forEach var="book" items="${result}">
                <div class="col">
                    <div class="card shadow-sm h-100">
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-3 col-lg-2 text-center">
                                    <a href="view_book?id=${book.bookId}">
                                        <img class="img-fluid rounded"
                                             src="data:image/jpg;base64,${book.base64Image}"
                                             alt="${book.title} cover"
                                             style="max-height: 200px; object-fit: cover;"/>
                                    </a>
                                </div>

                                <div class="col-md-6 col-lg-7">
                                    <h4 class="card-title mb-2">
                                        <a href="view_book?id=${book.bookId}" class="text-decoration-none text-dark">
                                                ${book.title}
                                        </a>
                                    </h4>

                                    <div class="mb-2">
                                        <jsp:directive.include file="book_rating.jsp"/>
                                    </div>

                                    <p class="text-muted mb-2">
                                        <small>by ${book.author}</small>
                                    </p>

                                    <p class="card-text text-secondary">
                                            ${fn:substring(book.description, 0, 150)}...
                                    </p>
                                </div>

                                <div class="col-md-3 col-lg-3 text-center text-md-end d-flex flex-column justify-content-center">
                                    <h3 class="text-success mb-3">$${book.price}</h3>
                                    <a href="add_to_cart?bookId=${book.bookId}"
                                       class="btn btn-primary btn-lg">
                                        Add to Cart
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>