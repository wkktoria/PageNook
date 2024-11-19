package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Users;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.PersistenceException;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class UsersDAOTest {
    private static EntityManagerFactory entityManagerFactory;
    private static EntityManager entityManager;
    private static UsersDAO usersDAO;

    @BeforeAll
    static void setUp() {
        entityManagerFactory = Persistence.createEntityManagerFactory("PageNook");
        entityManager = entityManagerFactory.createEntityManager();
        usersDAO = new UsersDAO(entityManager);
    }

    @AfterAll
    static void tearDown() {
        entityManager.close();
        entityManagerFactory.close();
    }

    @Test
    void testCreateUsers() {
        Users user = new Users();
        user.setEmail("testuser@gmail.com");
        user.setFullName("Test User");
        user.setPassword("Str0ngP@sw00rd");

        Users createdUser = usersDAO.create(user);

        assertTrue(createdUser.getUserId() > 0);
    }

    @Test
    void testCreateUsersFieldsNotSet() {
        Users user = new Users();

        assertThrows(PersistenceException.class, () -> {
            usersDAO.create(user);
        });
    }

    @Test
    void testUpdateUsers() {
        Users user = new Users();
        user.setUserId(1);
        user.setEmail("testuser@gmail.com");
        user.setFullName("Updated Test User");
        user.setPassword("Str0ngP@sw00rd");

        Users updatedUser = usersDAO.update(user);

        assertEquals("Updated Test User", updatedUser.getFullName());
    }
}