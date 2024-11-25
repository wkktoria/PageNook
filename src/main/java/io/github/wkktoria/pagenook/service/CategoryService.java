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
        listCategory(null);
    }

    public void listCategory(final String message) throws ServletException, IOException {
        List<Category> categoryList = categoryDAO.listAll();

        request.setAttribute("listCategory", categoryList);
        request.setAttribute("message", message);

        final String listPage = "category_list.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);

        dispatcher.forward(request, response);
    }

    public void createCategory() throws ServletException, IOException {
        final String name = request.getParameter("name");

        if (categoryDAO.findByName(name) != null) {
            final String message = "Could not create category. A category with name " + name + " already exists.";
            request.setAttribute("message", message);

            RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
            dispatcher.forward(request, response);
        } else {
            Category newCategory = new Category(name);
            categoryDAO.create(newCategory);
            listCategory("New category has been created successfully.");
        }
    }
}
