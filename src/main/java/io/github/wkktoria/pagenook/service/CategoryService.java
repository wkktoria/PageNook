package io.github.wkktoria.pagenook.service;

import io.github.wkktoria.pagenook.dao.CategoryDAO;
import io.github.wkktoria.pagenook.entity.Category;
import jakarta.persistence.EntityManagerFactory;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class CategoryService {
    private final CategoryDAO categoryDAO;
    private final HttpServletRequest request;
    private final HttpServletResponse response;

    public CategoryService(EntityManagerFactory entityManagerFactory,
                           HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;

        categoryDAO = new CategoryDAO(entityManagerFactory);
    }

    public void listCategory() throws ServletException, IOException {
        List<Category> categoryList = categoryDAO.listAll();

        request.setAttribute("listCategory", categoryList);

        final String listPage = "category_list.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);

        dispatcher.forward(request, response);
    }
}
