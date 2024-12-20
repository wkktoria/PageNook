package io.github.wkktoria.pagenook.controller.frontend.shoppingcart;

import io.github.wkktoria.pagenook.entity.Book;

import java.util.HashMap;
import java.util.Map;

public class ShoppingCart {
    private Map<Book, Integer> cart = new HashMap<>();

    public void addItem(final Book book) {
        if (cart.containsKey(book)) {
            Integer quantity = cart.get(book) + 1;
            cart.put(book, quantity);
        } else {
            cart.put(book, 1);
        }
    }

    public Map<Book, Integer> getItems() {
        return cart;
    }

    public void removeItem(final Book book) {
        cart.remove(book);
    }

    public int getTotalQuantity() {
        int total = 0;

        for (final Book next : cart.keySet()) {
            Integer quantity = cart.get(next);
            total += quantity;
        }

        return total;
    }

    public float getTotalAmount() {
        float total = 0;

        for (final Book next : cart.keySet()) {
            Integer quantity = cart.get(next);
            float subTotal = quantity * next.getPrice();
            total += subTotal;
        }

        return total;
    }

    public void clear() {
        cart.clear();
    }

    public int getTotalItems() {
        return cart.size();
    }

    public void updateCart(int[] bookIds, int[] quantities) {
        for (int i = 0; i < bookIds.length; i++) {
            Book key = new Book(bookIds[i]);
            Integer value = quantities[i];
            cart.put(key, value);
        }
    }
}
