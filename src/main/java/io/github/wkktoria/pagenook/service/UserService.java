package io.github.wkktoria.pagenook.service;

import io.github.wkktoria.pagenook.dao.UserDAO;
import io.github.wkktoria.pagenook.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;

public class UserService {
    private final UserDAO userDAO;
    private EntityManagerFactory entityManagerFactory;
    private EntityManager entityManager;

    public UserService() {
        entityManagerFactory = Persistence.createEntityManagerFactory("PageNook");
        entityManager = entityManagerFactory.createEntityManager();
        userDAO = new UserDAO(entityManager);
    }

    public List<User> listUsers() {
        return userDAO.listAll();
    }
}
