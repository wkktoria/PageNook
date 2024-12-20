package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Book;
import io.github.wkktoria.pagenook.entity.Category;
import jakarta.persistence.PersistenceException;
import org.junit.jupiter.api.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * If the database is empty, the testCreate test should be run to make all the tests work properly.
 */
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class BookDAOTest extends BaseDAOTest {
    private static BookDAO bookDAO;
    private static CategoryDAO categoryDAO;

    @BeforeAll
    static void setUp() {
        BaseDAOTest.setUp();

        categoryDAO = new CategoryDAO();
        categoryDAO.create(new Category("Test Category"));

        bookDAO = new BookDAO();
    }

    @AfterAll
    static void tearDown() {
        BaseDAOTest.tearDown();
    }

    @Test
    @Order(1)
    void testCreate() throws ParseException, IOException {
        Book newBook = new Book();

        Category category = categoryDAO.listAll().getFirst();
        newBook.setCategory(category);

        if (bookDAO.listAll().isEmpty()) {
            newBook.setTitle("Test Title");
        } else {
            newBook.setTitle("Test Title@" + DateFormat.getDateTimeInstance().format(new Date()));
        }
        newBook.setAuthor("Test Author");
        newBook.setDescription("This is a test description");
        newBook.setPrice(21.37f);
        newBook.setIsbn("123456789");

        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        Date publishDate = dateFormat.parse("01/01/2000");
        newBook.setPublishDate(publishDate);

        String imagePath = "src/test/resources/images/test-image.jpg";
        byte[] imageBytes = Files.readAllBytes(Paths.get(imagePath));
        newBook.setImage(imageBytes);

        Book createdBook = bookDAO.create(newBook);

        assertTrue(createdBook.getBookId() > 0);
    }

    @Test
    void testListAll() {
        List<Book> listBooks = bookDAO.listAll();

        assertFalse(listBooks.isEmpty());
    }

    @Test
    void testFindByTitleNotExists() {
        final String title = "Non-Existent Title";
        Book book = bookDAO.findByTitle(title);

        assertNull(book);
    }

    @Test
    void testFindByTitleExists() {
        final String title = "Test Title";
        Book book = bookDAO.findByTitle(title);

        assertNotNull(book);
    }

    @Test
    void testUpdate() {
        Category category = categoryDAO.listAll().getLast();

        Book book = bookDAO.listAll().getFirst();
        book.setCategory(category);

        Book updatedBook = bookDAO.update(book);

        assertEquals(category.getName(), updatedBook.getCategory().getName());
    }

    @Test
    void testDeleteSuccess() {
        Integer bookId = bookDAO.listAll().getLast().getBookId();

        bookDAO.delete(bookId);

        assertNull(bookDAO.get(bookId));
    }

    @Test
    void testDeleteFail() {
        Integer bookId = -1;

        assertThrows(PersistenceException.class,
                () -> bookDAO.delete(bookId));
    }

    @Test
    void testGetFail() {
        Integer bookId = -1;

        Book book = bookDAO.get(bookId);

        assertNull(book);
    }

    @Test
    void testGetSuccess() {
        Integer bookId = bookDAO.listAll().getFirst().getBookId();

        Book book = bookDAO.get(bookId);

        assertNotNull(book);
    }

    @Test
    void testCount() {
        long totalBooks = bookDAO.count();

        assertTrue(totalBooks > 0);
    }

    @Test
    void testListByCategory() {
        Integer categoryId = bookDAO.listAll().getFirst().getCategory().getCategoryId();
        List<Book> listBooks = bookDAO.listByCategory(categoryId);
        assertFalse(listBooks.isEmpty());
    }

    @Test
    void testListNewBooks() {
        List<Book> listNewBooks = bookDAO.listNewBooks();

        assertFalse(listNewBooks.isEmpty());
    }

    @Test
    void testSearchByTitle() {
        final String keyword = "Title";
        List<Book> result = bookDAO.search(keyword);

        assertFalse(result.isEmpty());
    }

    @Test
    void testSearchByAuthor() {
        final String keyword = "Author";
        List<Book> result = bookDAO.search(keyword);

        assertFalse(result.isEmpty());
    }

    @Test
    void testSearchByDescription() {
        final String keyword = "description";
        List<Book> result = bookDAO.search(keyword);

        assertFalse(result.isEmpty());
    }

    @Test
    void testCountByCategory() {
        final int categoryId = categoryDAO.listAll().getFirst().getCategoryId();
        long numOfBooks = bookDAO.countByCategory(categoryId);

        assertTrue(numOfBooks > 0);
    }

    @Test
    void testListBestSellingBooks() {
        List<Book> topBestSellingBooks = bookDAO.listBestSellingBooks();

        assertFalse(topBestSellingBooks.isEmpty());
    }

    @Test
    void testListMostFavoredBooks() {
        List<Book> topFavoredBooks = bookDAO.listMostFavoredBooks();

        assertFalse(topFavoredBooks.isEmpty());
    }
}