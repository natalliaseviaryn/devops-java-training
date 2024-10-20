package com.exadel.books.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.stereotype.Service;

import com.exadel.books.dto.Book;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@AllArgsConstructor
@Service
public class DBService {

    private final DataSource dataSource;

    private static final String SELECT_BOOKS = "select id, title, author from books";

    public List<Book> getBooksData() throws SQLException {
        try (final Connection connection = dataSource.getConnection();
             final PreparedStatement pstmt = connection.prepareStatement(SELECT_BOOKS)) {

            ResultSet result = pstmt.executeQuery();

            List<Book> books = new ArrayList<>();
            while (result.next()) {
                books.add(new Book(result.getInt("id"), result.getString("title"), result.getString("author")));
            }
            return books;
        } catch (Exception e) {
            log.error("Cannot read books: ", e);
            throw e;
        }
    }
}
