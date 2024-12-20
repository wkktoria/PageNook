package io.github.wkktoria.pagenook.service;

import io.github.wkktoria.pagenook.dao.ArticleDAO;
import io.github.wkktoria.pagenook.entity.Article;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import static io.github.wkktoria.pagenook.util.CommonUtil.forwardToPage;
import static io.github.wkktoria.pagenook.util.CommonUtil.showMessageBackend;

public class ArticleService {
    private final ArticleDAO articleDAO;
    private final HttpServletRequest request;
    private final HttpServletResponse response;

    public ArticleService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;

        articleDAO = new ArticleDAO();
    }

    public void listArticle(final String message) throws ServletException, IOException {
        List<Article> listArticle = articleDAO.listAll();
        request.setAttribute("listArticle", listArticle);

        if (message != null) {
            request.setAttribute("message", message);
        }

        final String listPage = "article_list.jsp";
        forwardToPage(listPage, request, response);
    }

    public void listArticle() throws ServletException, IOException {
        listArticle(null);
    }

    public void createArticle() throws ServletException, IOException {
        final String title = request.getParameter("title");
        final String content = request.getParameter("content");
        Article existingArticle = articleDAO.findByTitle(title);

        if (existingArticle != null) {
            final String message = "Could not create new article, because the article with title " + title + " already exists.";
            showMessageBackend(message, request, response);
        } else {
            Article newArticle = new Article();
            newArticle.setTitle(title);
            newArticle.setContent(content);

            Article createdArticle = articleDAO.create(newArticle);

            if (createdArticle != null && createdArticle.getArticleId() > 0) {
                final String message = "A new article has been created successfully.";
                listArticle(message);
            }
        }
    }

    public void editArticle() throws ServletException, IOException {
        final Integer articleId = Integer.parseInt(request.getParameter("id"));
        Article article = articleDAO.get(articleId);

        if (article == null) {
            final String message = "Could not find article with ID " + articleId + ".";
            showMessageBackend(message, request, response);
        } else {
            request.setAttribute("article", article);
            forwardToPage("article_form.jsp", request, response);
        }
    }

    public void updateArticle() throws ServletException, IOException {
        final Integer articleId = Integer.parseInt(request.getParameter("articleId"));
        final String title = request.getParameter("title");
        final String content = request.getParameter("content");

        Article existingArticle = articleDAO.get(articleId);
        Article articleByTitle = articleDAO.findByTitle(title);

        if (articleByTitle != null && !existingArticle.equals(articleByTitle)) {
            final String message = "Could not update article, because there's another article having the same title.";
            showMessageBackend(message, request, response);
        } else {
            existingArticle.setTitle(title);
            existingArticle.setContent(content);

            articleDAO.update(existingArticle);

            final String message = "The article has been updated successfully.";
            listArticle(message);
        }
    }

    public void deleteArticle() throws ServletException, IOException {
        final Integer articleId = Integer.parseInt(request.getParameter("id"));

        if (articleDAO.get(articleId) == null) {
            final String message = "Could not find article with ID " + articleId + ", or it might have been deleted.";
            showMessageBackend(message, request, response);
        } else {
            articleDAO.delete(articleId);

            final String message = "The article has been deleted successfully.";
            listArticle(message);
        }
    }
}
