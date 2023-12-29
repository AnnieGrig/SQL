-- Database Setup
CREATE DATABASE IF NOT EXISTS BookstoreDB;
USE BookstoreDB;

-- Table Creation - Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(255),
    Genre VARCHAR(255),
    Price DECIMAL(10, 2),
    QuantityInStock INT
);

-- Populate the Books table with at least 10 entries
INSERT INTO Books (BookID, Title, Author, Genre, Price, QuantityInStock) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 12.99, 100),
(2, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 15.99, 75),
(3, '1984', 'George Orwell', 'Dystopian', 10.99, 120),
(4, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 18.99, 50),
(5, 'The Catcher in the Rye', 'J.D. Salinger', 'Coming-of-Age', 14.99, 90),
(6, 'Pride and Prejudice', 'Jane Austen', 'Romance', 22.99, 110),
(7, 'The Da Vinci Code', 'Dan Brown', 'Mystery', 24.99, 80),
(8, 'The Hitchhiker''s Guide to the Galaxy', 'Douglas Adams', 'Science Fiction', 20.99, 65),
(9, 'The Alchemist', 'Paulo Coelho', 'Philosophical', 15.99, 105),
(10, 'The Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy', 30.99, 40);

-- Table Creation - Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(20)
);

-- Populate the Customers table with at least 5 entries
INSERT INTO Customers (CustomerID, Name, Email, Phone) VALUES
(1, 'Alice Johnson', 'alice@example.com', '123-456-7890'),
(2, 'Bob Smith', 'bob@example.com', '987-654-3210'),
(3, 'Charlie Brown', 'charlie@example.com', '456-789-0123'),
(4, 'David Miller', 'david@example.com', '789-012-3456'),
(5, 'Eva Davis', 'eva@example.com', '012-345-6789');

-- Table Creation - Sales Table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    BookID INT,
    CustomerID INT,
    DateOfSale DATE,
    QuantitySold INT,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Populate the Sales table with at least 5 entries
INSERT INTO Sales (SaleID, BookID, CustomerID, DateOfSale, QuantitySold, TotalPrice) VALUES
(1, 1, 1, '2023-01-01', 2, 25.98),
(2, 2, 2, '2023-01-02', 1, 15.99),
(3, 3, 3, '2023-01-03', 3, 32.97),
(4, 4, 4, '2023-01-04', 2, 37.98),
(5, 5, 5, '2023-01-05', 1, 19.99),
-- Add more entries as needed
;

-- Join Query
SELECT Books.Title AS BookTitle, Customers.Name AS CustomerName, Sales.DateOfSale
FROM Sales
JOIN Books ON Sales.BookID = Books.BookID
JOIN Customers ON Sales.CustomerID = Customers.CustomerID;

-- Aggregation Query
SELECT Books.Genre, SUM(Sales.TotalPrice) AS TotalRevenue
FROM Sales
JOIN Books ON Sales.BookID = Books.BookID
GROUP BY Books.Genre;


--DELIMITER //

CREATE TRIGGER update_quantity_in_stock AFTER INSERT ON Sales
FOR EACH ROW
BEGIN
    UPDATE Books
    SET QuantityInStock = QuantityInStock - NEW.QuantitySold
    WHERE BookID = NEW.BookID;
END //

DELIMITER ;

