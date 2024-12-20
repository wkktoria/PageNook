package io.github.wkktoria.pagenook.controller.frontend;

import io.github.wkktoria.pagenook.dao.ArticleDAO;
import io.github.wkktoria.pagenook.dao.BookDAO;
import io.github.wkktoria.pagenook.entity.Article;
import io.github.wkktoria.pagenook.entity.Book;
import io.github.wkktoria.pagenook.util.CommonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookDAO bookDAO = new BookDAO();
        ArticleDAO articleDAO = new ArticleDAO();

        List<Book> listNewBooks = bookDAO.listNewBooks();
        request.setAttribute("listNewBooks", listNewBooks);

        List<Book> listBestSellingBooks = bookDAO.listBestSellingBooks();
        request.setAttribute("listBestSellingBooks", listBestSellingBooks);

        List<Book> listFavoredBooks = bookDAO.listMostFavoredBooks();
        request.setAttribute("listFavoredBooks", listFavoredBooks);

        HttpSession session = request.getSession();
        List<Article> listArticles = articleDAO.listAll();
        session.setAttribute("listArticles", listArticles);

        final String homepage = "frontend/index.jsp";
        CommonUtil.forwardToPage(homepage, request, response);
    }
}
