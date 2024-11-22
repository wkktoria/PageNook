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
        userDAO = new UserDAO(entityManagerFactory);
        userDAO.create(new User("testuser@gmail.com", "Test User", "Str0ngP@sw00rd"));
    }

    @AfterAll
    static void tearDown() {
        BaseDAOTest.tearDown();
    }

    @Test
    @Order(1)
    void testCreate() {
        User user = new User();
        user.setEmail("testuser@gmail.com");
        user.setFullName("Test User");
        user.setPassword("Str0ngP@sw00rd");

        User createdUser = userDAO.create(user);

        assertTrue(createdUser.getUserId() > 0);
    }

    @Test
    @Order(7)
    void testCreateFieldsNotSet() {
        User user = new User();

        assertThrows(PersistenceException.class, () -> {
            userDAO.create(user);
        });
    }


    @Test
    @Order(2)
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
    @Order(3)
    void testGetFound() {
        Integer userId = 1;

        User foundUser = userDAO.get(userId);

        assertNotNull(foundUser);
    }

    @Test
    @Order(8)
    void testGetNotFound() {
        Integer userId = -1;

        User foundUser = userDAO.get(userId);

        assertNull(foundUser);
    }

    @Test
    @Order(9)
    void testDelete() {
        Integer userId = 1;

        userDAO.delete(userId);

        assertNull(userDAO.get(userId));
    }

    @Test
    @Order(10)
    void testDeleteNonexistent() {
        Integer userId = -1;

        assertThrows(PersistenceException.class, () -> {
            userDAO.delete(userId);
        });
    }

    @Test
    @Order(6)
    void testListAll() {
        List<User> listUsers = userDAO.listAll();

        assertFalse(listUsers.isEmpty());
    }

    @Test
    @Order(5)
    void testCount() {
        long totalUsers = userDAO.count();

        assertTrue(totalUsers > 0);
    }

    @Test
    @Order(4)
    void testFindByEmail() {
        final String email = "testuser@gmail.com";
        User user = userDAO.findByEmail(email);

        assertNotNull(user);
    }
}