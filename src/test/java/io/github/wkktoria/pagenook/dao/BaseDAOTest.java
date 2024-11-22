package io.github.wkktoria.pagenook.dao;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class BaseDAOTest {
    protected static EntityManagerFactory entityManagerFactory;

    static void setUp() {
        entityManagerFactory = Persistence.createEntityManagerFactory("PageNookTest");
    }

    static void tearDown() {
        entityManagerFactory.close();
    }
}
