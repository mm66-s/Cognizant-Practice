package com.library.repository;

import org.springframework.stereotype.Repository;

@Repository
public class BookRepository {

    public String getBookDetails() {
        return "Book: Effective Java, Author: Joshua Bloch";
    }
}
