<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Your Review"/>
</jsp:include>

<body class="d-flex flex-column min-vh-100">
<jsp:directive.include file="header.jsp"/>

<div class="container flex-grow-1 py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card shadow-sm">
                <div class="card-body p-4">

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="mb-0">Your Review</h2>
                        <h4 class="text-muted mb-0">${loggedCustomer.fullname}</h4>
                    </div>

                    <hr class="mb-4"/>

                    <div class="alert alert-info text-center mb-4">
                        You have already written a review for this book.
                    </div>

                    <form id="reviewForm">
                        <div class="row g-4">
                            <div class="col-md-4 text-center">
                                <img class="img-fluid rounded shadow-sm mb-3"
                                     src="data:image/jpg;base64,${book.base64Image}"
                                     alt="Book Cover"
                                     style="max-width: 200px;"/>
                                <h5 class="mb-0">${book.title}</h5>
                            </div>

                            <div class="col-md-8">
                                <div class="mb-4">
                                    <label class="form-label fw-bold">Your Rating</label>
                                    <div class="stars-readonly">
                                        <c:forEach var="i" begin="1" end="5">
                                            <span class="star ${i <= review.rating ? 'filled' : ''}">&#9733;</span>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label for="headline" class="form-label fw-bold">Headline</label>
                                    <input id="headline" type="text"
                                           class="form-control"
                                           value="${review.headline}"
                                           readonly/>
                                </div>

                                <div class="mb-4">
                                    <label for="comment" class="form-label fw-bold">Review Details</label>
                                    <textarea id="comment" class="form-control"
                                              rows="8"
                                              readonly>${review.comment}</textarea>
                                </div>

                                <div class="text-center">
                                    <button type="button"
                                            onclick="history.back()"
                                            class="btn btn-outline-secondary px-4">
                                        Back
                                    </button>
                                </div>

                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<jsp:directive.include file="footer.jsp"/>

<style>
    .stars-readonly {
        font-size: 2rem;
        display: flex;
        gap: 4px;
    }

    .stars-readonly .star {
        color: #ddd;
    }

    .stars-readonly .star.filled {
        color: #ffc107;
    }
</style>
</body>
</html>