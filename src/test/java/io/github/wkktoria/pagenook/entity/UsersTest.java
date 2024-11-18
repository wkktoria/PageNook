package io.github.wkktoria.pagenook.entity;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class UsersTest {
    public static void main(String[] args) {
        Users user = new Users();
        user.setEmail("testuser@gmail.com");
        user.setFullName("Test User");
        user.setPassword("Str0ngP@sw00rd");

        try (EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("PageNook")) {
            EntityManager entityManager = entityManagerFactory.createEntityManager();

            entityManager.getTransaction().begin();
            entityManager.persist(user);
            entityManager.getTransaction().commit();

            entityManager.close();

            System.out.println("Users object has been persisted");
        }
    }
}