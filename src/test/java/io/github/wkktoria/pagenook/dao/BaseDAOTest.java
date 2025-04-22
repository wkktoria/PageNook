package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;
import org.hibernate.Session;

import java.time.Instant;
import java.util.Date;
import java.util.Random;

class BaseDAOTest {
    protected static EntityManagerFactory entityManagerFactory;

    static void setUp() {
        entityManagerFactory = Persistence.createEntityManagerFactory("PageNookTest");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        entityManager.getTransaction().begin();
        entityManager.createNativeQuery("insert into category(category_id, name) values(1, 'Category')", Category.class).executeUpdate();
        entityManager.createNativeQuery("insert into users(user_id, email, full_name, password) values(1, 'test@email.com', 'Name', '06c219e5bc8378f3a8a3f83b4b7e4649')", User.class).executeUpdate();
        entityManager.createNativeQuery("insert into book(book_id, title, author, description, isbn, image, price, publish_date, last_update_time, category_id) values(1, 'Title', 'Author', 'Description', '123456789012345', 'TEST', 100.0, '2025-04-21', '2025-04-21', 1)", Book.class).executeUpdate();
        entityManager.createNativeQuery("insert into book(book_id, title, author, description, isbn, image, price, publish_date, last_update_time, category_id) values(2, 'Title 2', 'Author', 'Description', '123456789012345', 'TEST', 100.0, '2025-04-21', '2025-04-21', 1)", Book.class).executeUpdate();
        entityManager.createNativeQuery("insert into customer(customer_id, email, firstname, lastname, address_line1, address_line2, city, state, country, phone, zipcode, password, register_date) values(1, 'test@email.com', 'First Name', 'Last Name', 'Address Line 1', 'Address Line 2', 'City', 'State', 'Country', '123456789', '12345', '06c219e5bc8378f3a8a3f83b4b7e4649', '2025-04-21')", Customer.class).executeUpdate();
        entityManager.createNativeQuery("insert into book_order(order_id, customer_id, order_date, shipping_address, recipient_name, recipient_phone, payment_method, total, status) values(1, 1, '2025-04-21', 'Address', 'Name', '123456789', 'Method', 100.0, 'Status')", BookOrder.class).executeUpdate();
        entityManager.createNativeQuery("insert into order_detail(order_id, book_id, quantity, subtotal) values(1, 1, 1, 100.0)", OrderDetail.class).executeUpdate();
        entityManager.createNativeQuery("insert into review(review_id, book_id, customer_id, rating, headline, comment, review_time) values(1, 1, 1, 5, 'Heading', 'Commenet', '2025-04-21')", Review.class).executeUpdate();
        entityManager.getTransaction().commit();
    }

    static void tearDown() {
        entityManagerFactory.close();
    }
}
