<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="${book.title} "/>
</jsp:include>
<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1 py-4">
    <h2 class="mb-4">${book.title} <span class="text-muted fw-normal fs-4">by ${book.author}</span></h2>

    <div class="row g-4">
        <div class="col-sm-4">
            <img class="img-fluid rounded shadow-sm" src="data:image/jpg;base64,${book.base64Image}" alt="Book Cover"/>
        </div>
        <div class="col-sm-6">
            <div class="d-flex align-items-center gap-2 mb-2">
                <jsp:directive.include file="book_rating.jsp"/>
                <a href="#reviews" class="text-decoration-none text-muted small">
                    ${fn:length(book.reviews)} Reviews
                </a>
            </div>
            <p class="text-secondary">${book.description}</p>
        </div>
        <div class="col-sm-2">
            <div class="card border-0 shadow-sm text-center p-3">
                <p class="fs-4 fw-bold mb-2">$${book.price}</p>
                <button class="btn btn-primary w-100" id="buttonAddToCart">Add to Cart</button>
            </div>
        </div>
    </div>

    <hr class="my-4"/>

    <div class="row mb-3">
        <div class="col-12 text-center">
            <h3 id="reviews" class="mb-3">Customer Reviews</h3>
            <button class="btn btn-outline-secondary" id="buttonWriteReview">Write a Customer Review</button>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-8">
            <c:forEach items="${book.reviews}" var="review">
                <div class="card mb-3 border-0 shadow-sm">
                    <div class="card-body">
                        <div class="d-flex align-items-center gap-2 mb-1">
                            <c:forTokens items="${review.stars}" delims="," var="star">
                                <c:if test="${star eq 'on'}">
                                    <img alt="Star" src="images/rating-on.svg" width="16" height="16"/>
                                </c:if>
                                <c:if test="${star eq 'off'}">
                                    <img alt="Empty Star" src="images/rating-off.svg" width="16" height="16"/>
                                </c:if>
                            </c:forTokens>
                            <span class="fw-semibold">${review.headline}</span>
                        </div>
                        <p class="text-muted small mb-2">
                            by <strong>${review.customer.fullname}</strong> on ${review.reviewTime}
                        </p>
                        <p class="mb-0 fst-italic text-secondary">${review.comment}</p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:directive.include file="footer.jsp"/>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        document.getElementById("buttonWriteReview")
            .addEventListener("click", function () {
                window.location = "write_review?bookId=" + ${book.bookId};
            });

        document.getElementById("buttonAddToCart")
            .addEventListener("click", function () {
                window.location = "add_to_cart?bookId=" + ${book.bookId};
            });
    });
</script>
</body>
</html>