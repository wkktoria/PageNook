package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Users;
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
    void testCreate() {
        Users user = new Users();
        user.setEmail("testuser@gmail.com");
        user.setFullName("Test User");
        user.setPassword("Str0ngP@sw00rd");

        Users createdUser = usersDAO.create(user);

        assertTrue(createdUser.getUserId() > 0);
    }

    @Test
    void testCreateFieldsNotSet() {
        Users user = new Users();

        assertThrows(PersistenceException.class, () -> {
            usersDAO.create(user);
        });
    }


    @Test
    void testUpdate() {
        Users user = new Users();
        user.setUserId(1);
        user.setEmail("testuser@gmail.com");
        user.setFullName("Updated Test User");
        user.setPassword("Str0ngP@sw00rd");

        Users updatedUser = usersDAO.update(user);

        assertEquals("Updated Test User", updatedUser.getFullName());
    }

    @Test
    void testGetFound() {
        Integer userId = 1;

        Users foundUser = usersDAO.get(userId);

        assertNotNull(foundUser);
    }

    @Test
    void testGetNotFound() {
        Integer userId = -1;

        Users foundUser = usersDAO.get(userId);

        assertNull(foundUser);
    }

    @Test
    void testDelete() {
        Integer userId = 1;

        usersDAO.delete(userId);

        assertNull(usersDAO.get(userId));
    }

    @Test
    void testDeleteNonexistent() {
        Integer userId = -1;

        assertThrows(PersistenceException.class, () -> {
            usersDAO.delete(userId);
        });
    }

    @Test
    void testListAll() {
        List<Users> listUsers = usersDAO.listAll();

        assertFalse(listUsers.isEmpty());
    }

    @Test
    void testCount() {
        long totalUsers = usersDAO.count();

        assertTrue(totalUsers > 0);
    }
}