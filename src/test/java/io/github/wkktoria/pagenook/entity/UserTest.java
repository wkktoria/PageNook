package io.github.wkktoria.pagenook.entity;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class UserTest {
    public static void main(String[] args) {
        User user = new User();
        user.setEmail("testuser@gmail.com");
        user.setFullName("Test User");
        user.setPassword("Str0ngP@sw00rd");

        try (EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("PageNookTest")) {
            EntityManager entityManager = entityManagerFactory.createEntityManager();

            entityManager.getTransaction().begin();
            entityManager.persist(user);
            entityManager.getTransaction().commit();
            System.out.println("User object has been persisted");

            entityManager.getTransaction().begin();
            entityManager.remove(user);
            entityManager.getTransaction().commit();
            System.out.println("User object has been removed");

            entityManager.close();
        }
    }
}