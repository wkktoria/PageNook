package io.github.wkktoria.pagenook.controller.admin;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.http.HttpServlet;

public abstract class BaseServlet extends HttpServlet {
    protected EntityManagerFactory entityManagerFactory;

    @Override
    public void init() {
        entityManagerFactory = Persistence.createEntityManagerFactory("PageNook");
    }

    @Override
    public void destroy() {
        entityManagerFactory.close();
    }
}
