DELETE FROM rented_books WHERE isbn IN (SELECT books.isbn FROM books WHERE year >= '2001-01-01');
DELETE FROM book_copies WHERE isbn IN (SELECT books.isbn FROM books WHERE year >= '2001-01-01');
DELETE FROM books WHERE year >= '2001-01-01'

ALTER TABLE book_copies
    ADD FOREIGN KEY (isbn) REFERENCES books (isbn) ON DELETE CASCADE;
ALTER TABLE rented_books
    ADD FOREIGN KEY (book_id, isbn) REFERENCES book_copies (id, isbn) ON DELETE CASCADE;

DELETE
FROM books
WHERE year >= '2001-01-01'