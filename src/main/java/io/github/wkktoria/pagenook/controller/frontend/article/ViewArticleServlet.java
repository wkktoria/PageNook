package io.github.wkktoria.pagenook.controller.frontend.article;

import io.github.wkktoria.pagenook.dao.ArticleDAO;
import io.github.wkktoria.pagenook.entity.Article;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static io.github.wkktoria.pagenook.util.CommonUtil.forwardToPage;
import static io.github.wkktoria.pagenook.util.CommonUtil.showMessageFrontend;

@WebServlet("/view_article")
public class ViewArticleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArticleDAO articleDAO = new ArticleDAO();
        final Integer articleId = Integer.parseInt(request.getParameter("id"));
        Article article = articleDAO.get(articleId);

        if (article == null) {
            final String message = "Could not find article with ID " + articleId + ".";
            showMessageFrontend(message, request, response);
        } else {
            request.setAttribute("article", article);
            forwardToPage("frontend/article.jsp", request, response);
        }
    }
}
