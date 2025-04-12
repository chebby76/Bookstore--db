-- 1. Create the Database
CREATE DATABASE bookstore_db;
USE bookstore_db;

-- 2. Create Tables

-- country
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- address
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- address_status
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_description VARCHAR(50)
);

-- customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20)
);

-- customer_address
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- author
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

-- book_language
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50)
);

-- publisher
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100),
    publisher_contact VARCHAR(100)
);

-- book
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    isbn VARCHAR(20),
    publication_year INT,
    language_id INT,
    publisher_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- book_author
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- shipping_method
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100),
    cost DECIMAL(10,2)
);

-- order_status
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_description VARCHAR(50)
);

-- cust_order
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- order_line
CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- order_history
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- 3. Set Up User Groups & Roles 

-- Create Roles
CREATE ROLE reader, writer, admin;

-- Grant Permissions
GRANT SELECT ON bookstore_db.* TO reader;
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore_db.* TO writer;
GRANT ALL PRIVILEGES ON bookstore_db.* TO admin;

-- Create Users and Assign Roles
CREATE USER 'book_reader'@'localhost' IDENTIFIED BY 'readpass';
GRANT reader TO 'book_reader'@'localhost';

CREATE USER 'book_writer'@'localhost' IDENTIFIED BY 'writepass';
GRANT writer TO 'book_writer'@'localhost';

CREATE USER 'book_admin'@'localhost' IDENTIFIED BY 'adminpass';
GRANT admin TO 'book_admin'@'localhost';

-- 4. Test Queries

-- Get all books with author names
SELECT b.title, a.first_name, a.last_name
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id;

-- Get all orders and their current status
SELECT o.order_id, c.first_name, c.last_name, os.status_description
FROM cust_order o
JOIN customer c ON o.customer_id = c.customer_id
JOIN order_status os ON o.status_id = os.status_id;

