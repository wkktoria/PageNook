package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Customer;
import jakarta.persistence.PersistenceException;
import org.junit.jupiter.api.*;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class CustomerDAOTest extends BaseDAOTest {
    private static CustomerDAO customerDAO;

    @BeforeAll
    static void setUp() {
        BaseDAOTest.setUp();

        customerDAO = new CustomerDAO();
    }

    @AfterAll
    static void tearDown() {
        BaseDAOTest.tearDown();
    }

    @Test
    @Order(1)
    void testCreate() {
        Customer customer = new Customer();
        customer.setEmail("customer " + DateFormat.getDateTimeInstance().format(new Date()) + "@email.com");
        customer.setFirstname("Test Customer");
        customer.setCity("New York");
        customer.setCountry("United Stated");
        customer.setAddressLine1("Test Address in New York");
        customer.setPassword("secret");
        customer.setPhone("1234567890");
        customer.setZipcode("1001");

        Customer savedCustomer = customerDAO.create(customer);

        assertTrue(savedCustomer.getCustomerId() > 0);
    }

    @Test
    void testGetFail() {
        Integer customerId = -1;

        Customer customer = customerDAO.get(customerId);

        assertNull(customer);
    }

    @Test
    void testGetSuccess() {
        Integer customerId = 1;

        Customer customer = customerDAO.get(customerId);

        assertNotNull(customer);
    }

    @Order(2)
    @Test
    void testUpdate() {
        final String fullName = "Updated Test Customer";
        Customer customer = customerDAO.get(2);
        customer.setFirstname(fullName);

        Customer updatedCustomer = customerDAO.update(customer);

        assertEquals(fullName, updatedCustomer.getFirstname());
    }

    @Test
    void testDeleteSuccess() {
        Integer customerId = 2;

        customerDAO.delete(customerId);

        assertNull(customerDAO.get(customerId));
    }

    @Test
    void testDeleteFail() {
        Integer customerId = -1;

        assertThrows(PersistenceException.class, () -> customerDAO.delete(customerId));
    }

    @Test
    void testListAll() {
        List<Customer> listCustomers = customerDAO.listAll();

        assertFalse(listCustomers.isEmpty());
    }

    @Test
    void testCount() {
        long totalCustomers = customerDAO.count();

        assertTrue(totalCustomers > 0);

    }

    @Test
    void testFindByEmail() {
        final String email = "test@email.com";
        Customer customer = customerDAO.findByEmail(email);

        assertNotNull(customer);
    }

    @Test
    void testCheckLoginSuccess() {
        final String email = "test@email.com";
        final String password = "mysecret";

        Customer customer = customerDAO.checkLogin(email, password);

        assertNotNull(customer);
    }

    @Test
    void testCheckLoginFail() {
        final String email = "nonexistant@email.com";
        final String password = "secret";

        Customer customer = customerDAO.checkLogin(email, password);

        assertNull(customer);
    }
}