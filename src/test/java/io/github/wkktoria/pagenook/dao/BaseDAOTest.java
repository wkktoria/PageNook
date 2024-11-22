package io.github.wkktoria.pagenook.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class BaseDAOTest {
    protected static EntityManagerFactory entityManagerFactory;
    protected static EntityManager entityManager;

    static void setUp() {
        entityManagerFactory = Persistence.createEntityManagerFactory("PageNook");
        entityManager = entityManagerFactory.createEntityManager();
    }

    static void tearDown() {
        entityManager.close();
        entityManagerFactory.close();
    }
}
