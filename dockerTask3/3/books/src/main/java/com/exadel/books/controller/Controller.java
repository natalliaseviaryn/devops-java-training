package com.exadel.books.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.exadel.books.dto.Book;
import com.exadel.books.service.BookService;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@RestController
@RequestMapping("")
public class Controller {

    private final BookService bookService;

    @GetMapping
    public ResponseEntity<List<Book>> getAllBooks() {
       List<Book> books = bookService.getAllBooks();
       return new ResponseEntity<>(books, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Book> getBookById(@PathVariable("id") Integer bookId) {
        Book book = bookService.getBookById(bookId);
        return new ResponseEntity<>(book, HttpStatus.OK);
    }
}