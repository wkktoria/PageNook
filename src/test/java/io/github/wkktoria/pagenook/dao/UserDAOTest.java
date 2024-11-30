package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.User;
import jakarta.persistence.PersistenceException;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class UserDAOTest extends BaseDAOTest {
    private static UserDAO userDAO;

    @BeforeAll
    static void setUp() {
        BaseDAOTest.setUp();
        userDAO = new UserDAO();
        userDAO.create(new User("testuser@gmail.com", "Test User", "Str0ngP@sw00rd"));
    }

    @AfterAll
    static void tearDown() {
        BaseDAOTest.tearDown();
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

    @Test
    void testFindByEmail() {
        final String email = "testuser@gmail.com";
        User user = userDAO.findByEmail(email);

        assertNotNull(user);
    }

    @Test
    void testCheckLoginSuccess() {
        final String email = "testuser@gmail.com";
        final String password = "Str0ngP@sw00rd";

        boolean loginResult = userDAO.checkLogin(email, password);

        assertTrue(loginResult);
    }

    @Test
    void testCheckLoginFail() {
        final String email = "nonexistant@gmail.com";
        final String password = "Str0ngP@sw00rd";

        boolean loginResult = userDAO.checkLogin(email, password);

        assertFalse(loginResult);
    }
}