# Bookstore Database Project

This project implements a relational database system for managing the operations of a bookstore. The system is designed to handle books, authors, customers, orders, shipping methods, and more, with a focus on data integrity, efficient querying, and access control.

## Database Structure

The database consists of the following main components:

### 1. Books & Authors
- **book**: Stores details about each book (title, ISBN, price, etc.)
- **author**: Stores author information
- **book_author**: Manages the many-to-many relationship between books and authors
- **book_language**: Lists available book languages
- **publisher**: Stores information about book publishers

### 2. Customers & Addresses
- **customer**: Holds customer information
- **address**: Contains address details (linked to countries)
- **country**: Lists countries for address referencing
- **address_status**: Represents status of an address (e.g., current, old)
- **customer_address**: Manages the many-to-many relationship between customers and addresses, with address statuses

### 3. Orders & Shipping
- **cust_order**: Stores orders made by customers
- **order_line**: Details the individual items (books) in each order
- **order_status**: Represents the current status of an order (e.g., pending, delivered)
- **order_history**: Tracks historical changes in order status
- **shipping_method**: Lists available shipping methods

## User Roles and Permissions

Roles are created to manage user access:

- *reader*: Can only SELECT data
- *writer*: Can SELECT, INSERT, UPDATE, and DELETE data
- *admin*: Has ALL PRIVILEGES

Users are created and assigned to these roles:
- book_reader
- book_writer
- book_admin

