package io.github.wkktoria.pagenook.entity;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class CategoryTest {
    public static void main(String[] args) {
        Category category = new Category();
        category.setName("Test Category");


        try (EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("PageNook")) {
            EntityManager entityManager = entityManagerFactory.createEntityManager();

            entityManager.getTransaction().begin();
            entityManager.persist(category);
            entityManager.getTransaction().commit();

            entityManager.close();

            System.out.println("Category object has been persisted");
        }
    }
}