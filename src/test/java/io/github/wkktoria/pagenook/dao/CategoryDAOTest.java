package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Category;
import org.junit.jupiter.api.*;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class CategoryDAOTest extends BaseDAOTest {
    private static CategoryDAO categoryDAO;

    @BeforeAll
    static void setUp() {
        BaseDAOTest.setUp();
        categoryDAO = new CategoryDAO();
        categoryDAO.create(new Category("Test Category"));
    }

    @AfterAll
    static void tearDown() {
        BaseDAOTest.tearDown();
    }

    @Order(1)
    @Test
    void testCreate() {
        Category category = new Category();
        category.setName("Test Category");

        Category createdCategory = categoryDAO.create(category);

        assertTrue(createdCategory.getCategoryId() > 0);
    }

    @Order(2)
    @Test
    void testUpdate() {
        Category category = categoryDAO.get(2);
        category.setName("Updated Test Category");

        Category updatedCategory = categoryDAO.update(category);

        assertEquals("Updated Test Category", updatedCategory.getName());
    }

    @Test
    void testGet() {
        Integer categoryId = 1;

        Category foundCategory = categoryDAO.get(categoryId);

        assertNotNull(foundCategory);
    }

    @Test
    void testDelete() {
        Integer categoryId = 2;

        categoryDAO.delete(categoryId);

        assertNull(categoryDAO.get(categoryId));
    }

    @Test
    void testListAll() {
        List<Category> listCategory = categoryDAO.listAll();

        assertFalse(listCategory.isEmpty());
    }

    @Test
    void testCount() {
        long totalCategories = categoryDAO.count();

        assertTrue(totalCategories > 0);
    }

    @Test
    void testFindByName() {
        final String name = "Category";
        Category category = categoryDAO.findByName(name);

        assertNotNull(category);
    }

    @Test
    void testFindByNameNotFound() {
        final String name = "Non-Existent Category";
        assertNull(categoryDAO.findByName(name));
    }
}