<div class="col-sm-6 col-md-4 col-lg-3 mb-4">
    <div class="card h-100 shadow-sm">
        <a href="view_book?id=${book.bookId}" class="text-decoration-none">
            <img src="data:image/jpg;base64,${book.base64Image}"
                 class="card-img-top"
                 alt="${book.title}"
                 style="height: 280px; object-fit: cover;"/>
        </a>
        <div class="card-body d-flex flex-column">
            <h5 class="card-title mb-2">
                <a href="view_book?id=${book.bookId}" class="text-dark text-decoration-none">
                    ${book.title}
                </a>
            </h5>
            <div class="mb-2">
                <jsp:directive.include file="book_rating.jsp"/>
            </div>
            <p class="card-text text-muted small mb-2">by ${book.author}</p>
            <div class="mt-auto">
                <h4 class="text-primary mb-0">$${book.price}</h4>
            </div>
        </div>
    </div>
</div>