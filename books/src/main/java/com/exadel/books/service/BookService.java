package com.exadel.books.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.exadel.books.dto.Book;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BookService {

    private static final List<Book> BOOKS = List.of(
        new Book(1, "To Kill a Mockingbird", "Harper Lee"),
        new Book(2, "1984", "George Orwell"),
        new Book(3, "The Great Gatsby", "F. Scott Fitzgerald"),
        new Book(4, "Clan Dominance: The Sleepless Ones", "Dem Mikhailov Test"));

    public List<Book> getAllBooks() {
        return BOOKS;
    }

    public Book getBookById(Integer id) {
        return BOOKS.stream().filter(book -> book.getId().equals(id)).findFirst().orElse(null);
    }
}