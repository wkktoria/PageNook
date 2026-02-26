<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="mt-5 pt-4 pb-3 border-top bg-light">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center mb-3">
                <div class="d-flex flex-wrap justify-content-center gap-3 mb-3">
                    <c:forEach var="article" items="${listArticles}" varStatus="status">
                        <a href="view_article?id=${article.articleId}"
                           class="text-decoration-none text-secondary">
                                ${article.title}
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12 text-center">
                <p class="text-muted mb-0">
                    &copy; 2024 PageNook Co., Ltd. All rights reserved.
                </p>
            </div>
        </div>
    </div>
</footer>