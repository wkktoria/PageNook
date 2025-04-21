package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.User;
import jakarta.persistence.PersistenceException;
import org.junit.jupiter.api.*;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class UserDAOTest extends BaseDAOTest {
    private static UserDAO userDAO;

    @BeforeAll
    static void setUp() {
        BaseDAOTest.setUp();

        userDAO = new UserDAO();
    }

    @AfterAll
    static void tearDown() {
        BaseDAOTest.tearDown();
    }

    @Order(1)
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

        assertThrows(Exception.class, () -> {
            userDAO.create(user);
        });
    }

@Order(2)
    @Test
    void testUpdate() {
        User user = userDAO.get(2);
        user.setFullName("Updated Test User");
        user.setEmail("updateduser@gmail.com");

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
        Integer userId = 2;

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
        final String email = "test@email.com";
        User user = userDAO.findByEmail(email);

        assertNotNull(user);
    }

    @Test
    void testCheckLoginSuccess() {
        final String email = "test@email.com";
        final String password = "mysecret";

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