package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Book;
import io.github.wkktoria.pagenook.entity.Category;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.assertTrue;

class BookDAOTest extends BaseDAOTest {
    private static BookDAO bookDAO;
    private static CategoryDAO categoryDAO;

    @BeforeAll
    static void setUp() {
        BaseDAOTest.setUp();

        categoryDAO = new CategoryDAO();
        categoryDAO.create(new Category("Test Category"));

        bookDAO = new BookDAO();
//        bookDAO.create(new Book());
    }

    @AfterAll
    static void tearDown() {
        BaseDAOTest.tearDown();
    }

    @Test
    void testCreate() throws ParseException, IOException {
        Book newBook = new Book();

        Category category = categoryDAO.listAll().getFirst();
        newBook.setCategory(category);

        newBook.setTitle("Test Title@" + DateFormat.getDateTimeInstance().format(new Date()));
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
}