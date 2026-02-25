<div class="row text-center mt-5">
    <div class="col mb-3 mt-4">
        <h4>Copyright (c) 2024 by PageNook Co., Ltd</h4>
        <c:forEach var="article" items="${listArticles}">
            <a href="view_article?id=${article.articleId}">${article.title}</a> |
        </c:forEach>
    </div>
</div>