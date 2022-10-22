INSERT INTO readers (surname, name, address, birthday)
VALUES ('Петров', 'Василий', '', '2001-12-12');

INSERT INTO publishers (name, address)
VALUES ('p-1', 'msk');

INSERT INTO books (isbn, pages_num, year, name, author, publisher_name)
VALUES ('123456', 40, '1980-01-23', 'книга-1', 'автор-1', 'p-1');

INSERT INTO book_copies (isbn, position)
VALUES (123456, 56);

INSERT INTO rented_books (book_id, isbn, reader_id, return_date)
VALUES (1, 123456, (SELECT id FROM readers WHERE name = 'Василий' AND surname = 'Петров' LIMIT 1), '2023-01-10')

