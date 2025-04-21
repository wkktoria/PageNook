package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Article;
import org.junit.jupiter.api.*;

import java.text.DateFormat;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.assertTrue;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class ArticleDAOTest extends BaseDAOTest {
    private static ArticleDAO articleDAO;

    @BeforeAll
    static void setUp() {
        BaseDAOTest.setUp();

        articleDAO = new ArticleDAO();
    }

    @AfterAll
    static void tearDown() {
        BaseDAOTest.tearDown();
    }

    @Test
    @Order(1)
    void testCreate() {
        Article article = new Article();

        if (articleDAO.listAll().isEmpty()) {
            article.setTitle("Test Title");
        } else {
            article.setTitle("Test Title@" + DateFormat.getDateTimeInstance().format(new Date()));
        }
        article.setContent("This is the test content of the article.");

        Article createdArticle = articleDAO.create(article);

        assertTrue(createdArticle.getArticleId() > 0);
    }

    @Test
    void testCount() {
        long totalArticles = articleDAO.count();

        assertTrue(totalArticles > 0);
    }
}