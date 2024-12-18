package io.github.wkktoria.pagenook.controller.frontend.shoppingcart;

import io.github.wkktoria.pagenook.entity.Book;
import org.junit.jupiter.api.Test;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class ShoppingCartTest {
    @Test
    void testAddItem() {
        ShoppingCart cart = new ShoppingCart();
        Book book = new Book(1);
        cart.addItem(book);

        Map<Book, Integer> items = cart.getItems();
        Integer quantity = items.get(book);

        assertEquals(1, quantity);
    }

    @Test
    void testRemoveItemWhenItIsOnlyBook() {
        ShoppingCart cart = new ShoppingCart();
        Book book = new Book(1);

        cart.addItem(book);
        cart.removeItem(book);

        assertTrue(cart.getItems().isEmpty());
    }

    @Test
    void testRemoveItemWhenThereAreMoreBooks() {
        ShoppingCart cart = new ShoppingCart();
        cart.addItem(new Book(1));

        Book bookToRemove = new Book(2);

        cart.addItem(bookToRemove);
        cart.removeItem(bookToRemove);

        assertNull(cart.getItems().get(bookToRemove));
    }

    @Test
    void testGetTotalQuantity() {
        ShoppingCart cart = new ShoppingCart();
        Book book = new Book(3);

        cart.addItem(book);
        cart.addItem(book);
        cart.addItem(book);

        assertEquals(3, cart.getTotalQuantity());
    }

    @Test
    void testGetTotalAmountWhenCartIsEmpty() {
        ShoppingCart emptyCart = new ShoppingCart();
        assertEquals(0, emptyCart.getTotalAmount());
    }

    @Test
    void testGetTotalAmountWhenThereAreSomeBooks() {
        ShoppingCart cart = new ShoppingCart();
        Book book = new Book(1);
        book.setPrice(10);

        cart.addItem(book);
        cart.addItem(book);

        assertEquals(20, cart.getTotalAmount());
    }

    @Test
    void testClear() {
        ShoppingCart cart = new ShoppingCart();
        Book book = new Book(1);

        cart.addItem(book);
        cart.addItem(book);

        cart.clear();

        assertEquals(0, cart.getTotalQuantity());
    }

    @Test
    void testGetTotalItemsWhenCartIsEmpty() {
        ShoppingCart emptyCart = new ShoppingCart();
        assertEquals(0, emptyCart.getTotalItems());
    }

    @Test
    void testGetTotalItemsWhenThereAreSomeBooksInCart() {
        ShoppingCart cart = new ShoppingCart();
        Book firstBook = new Book(1);
        Book secondBook = new Book(2);

        cart.addItem(firstBook);
        cart.addItem(secondBook);

        assertEquals(2, cart.getTotalItems());
    }

    @Test
    void testUpdateCart() {
        ShoppingCart cart = new ShoppingCart();
        Book firstBook = new Book(1);
        Book secondBook = new Book(2);

        cart.addItem(firstBook);
        cart.addItem(secondBook);

        int[] bookIds = {1, 2};
        int[] quantities = {3, 4};

        cart.updateCart(bookIds, quantities);

        assertEquals(7, cart.getTotalQuantity());
    }
}
