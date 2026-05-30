<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="page_head.jsp">
    <jsp:param name="pageTitle" value="Write a Review"/>
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

                    <form id="reviewForm" method="post" action="submit_review">
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
                                    <label class="form-label fw-bold">Your Rating <span
                                            class="text-danger">*</span></label>
                                    <div class="star-rating">
                                        <input type="radio" id="star5" name="rating" value="5"/>
                                        <label for="star5" title="5 stars">★</label>

                                        <input type="radio" id="star4" name="rating" value="4"/>
                                        <label for="star4" title="4 stars">★</label>

                                        <input type="radio" id="star3" name="rating" value="3"/>
                                        <label for="star3" title="3 stars">★</label>

                                        <input type="radio" id="star2" name="rating" value="2"/>
                                        <label for="star2" title="2 stars">★</label>

                                        <input type="radio" id="star1" name="rating" value="1"/>
                                        <label for="star1" title="1 star">★</label>
                                    </div>
                                    <div id="ratingError" class="text-danger small mt-1" style="display: none;">
                                        Please select a rating
                                    </div>
                                    <input type="hidden" id="bookId" name="bookId" value="${book.bookId}"/>
                                </div>

                                <div class="mb-4">
                                    <label for="headline" class="form-label fw-bold">
                                        Headline <span class="text-danger">*</span>
                                    </label>
                                    <input type="text"
                                           id="headline"
                                           name="headline"
                                           class="form-control"
                                           placeholder="Headline or summary for your review"
                                           required
                                           maxlength="128"/>
                                </div>

                                <div class="mb-4">
                                    <label for="comment" class="form-label fw-bold">
                                        Review Details <span class="text-danger">*</span>
                                    </label>
                                    <textarea id="comment"
                                              name="comment"
                                              class="form-control"
                                              rows="8"
                                              placeholder="Write your review details..."
                                              required
                                              maxlength="500"></textarea>
                                </div>

                                <div class="d-flex gap-2 justify-content-center">
                                    <button type="submit" class="btn btn-primary btn-lg px-5">Submit Review</button>
                                    <button type="button" id="buttonCancel"
                                            class="btn btn-outline-secondary btn-lg px-4">Cancel
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
    .star-rating {
        display: flex;
        flex-direction: row-reverse;
        justify-content: flex-end;
        gap: 5px;
        font-size: 2.5rem;
    }

    .star-rating input[type="radio"] {
        display: none;
    }

    .star-rating label {
        cursor: pointer;
        color: #ddd;
        transition: color 0.2s;
    }

    .star-rating label:hover,
    .star-rating label:hover ~ label {
        color: #ffc107;
    }

    .star-rating input[type="radio"]:checked ~ label {
        color: #ffc107;
    }
</style>

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("reviewForm");
        const ratingInputs = document.querySelectorAll('input[name="rating"]');
        const ratingError = document.getElementById("ratingError");
        const starRating = document.querySelector(".star-rating");

        form.addEventListener("submit", function (event) {
            const ratingSelected = Array.from(ratingInputs).some(input => input.checked);

            if (!ratingSelected) {
                event.preventDefault();
                ratingError.style.display = "block";
                starRating.style.border = "2px solid #dc3545";
                starRating.style.padding = "10px";
                starRating.style.borderRadius = "5px";
            }
        });

        ratingInputs.forEach(input => {
            input.addEventListener("change", function () {
                ratingError.style.display = "none";
                starRating.style.border = "none";
                starRating.style.padding = "0";
            });
        });

        document.getElementById("buttonCancel").addEventListener("click", function () {
            history.back();
        });
    });
</script>
</body>
</html>