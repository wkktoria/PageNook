package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.PersistenceException;
import org.junit.jupiter.api.*;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/*
Some of the tests (update, delete, listAll) won't pass,
unless the database is not empty and contains a record with ID equal to 1.

The problem with already active transaction can occur
when running all the tests at once.

In the future it should mock the database connection.
 */
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class UserDAOTest {
    private static EntityManagerFactory entityManagerFactory;
    private static EntityManager entityManager;
    private static UserDAO userDAO;

    @BeforeAll
    static void setUp() {
        entityManagerFactory = Persistence.createEntityManagerFactory("PageNook");
        entityManager = entityManagerFactory.createEntityManager();
        userDAO = new UserDAO(entityManager);
    }

    @AfterAll
    static void tearDown() {
        entityManager.close();
        entityManagerFactory.close();
    }

    @Test
    void testCreate() {
        User user = new User();
        user.setEmail("testuser@gmail.com");
        user.setFullName("Test User");
        user.setPassword("Str0ngP@sw00rd");

        User createdUser = userDAO.create(user);

        assertTrue(createdUser.getUserId() > 0);
    }

    @Test
    void testCreateFieldsNotSet() {
        User user = new User();

        assertThrows(PersistenceException.class, () -> {
            userDAO.create(user);
        });
    }


    @Test
    void testUpdate() {
        User user = new User();
        user.setUserId(1);
        user.setEmail("testuser@gmail.com");
        user.setFullName("Updated Test User");
        user.setPassword("Str0ngP@sw00rd");

        User updatedUser = userDAO.update(user);

        assertEquals("Updated Test User", updatedUser.getFullName());
    }

    @Test
    void testGetFound() {
        Integer userId = 1;

        User foundUser = userDAO.get(userId);

        assertNotNull(foundUser);
    }

    @Test
    void testGetNotFound() {
        Integer userId = -1;

        User foundUser = userDAO.get(userId);

        assertNull(foundUser);
    }

    @Test
    void testDelete() {
        Integer userId = 1;

        userDAO.delete(userId);

        assertNull(userDAO.get(userId));
    }

    @Test
    void testDeleteNonexistent() {
        Integer userId = -1;

        assertThrows(PersistenceException.class, () -> {
            userDAO.delete(userId);
        });
    }

    @Test
    void testListAll() {
        List<User> listUsers = userDAO.listAll();

        assertFalse(listUsers.isEmpty());
    }

    @Test
    void testCount() {
        long totalUsers = userDAO.count();

        assertTrue(totalUsers > 0);
    }
}