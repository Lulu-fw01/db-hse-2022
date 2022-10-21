
SELECT readers.name
FROM readers
WHERE (SELECT isbn FROM books WHERE author = 'Марк Твен') IN
      (SELECT rented_books.isbn
       FROM rented_books,
            books, readers
       WHERE readers.id = rented_books.reader_id
         AND rented_books.isbn = books.isbn)