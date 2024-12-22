

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,          -- Unique user ID
    username VARCHAR(255) NOT NULL,             -- User's username
    email VARCHAR(255) NOT NULL UNIQUE,         -- User's email (unique)
    password VARCHAR(255) NOT NULL,             -- User's password (hashed)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Account creation date
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,           -- Unique product ID
    name VARCHAR(255) NOT NULL,                  -- Product name
    price DECIMAL(10, 2) NOT NULL,               -- Product price
    description TEXT,                            -- Product description
    category_id INT,                             -- Foreign key to categories table
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Date when product was added
    FOREIGN KEY (category_id) REFERENCES categories(id) on update cascade ON DELETE CASCADE  -- Relation to categories
);


CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,           -- Unique order ID
    user_id INT,                                 -- Foreign key to users table
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Date when the order was made
    total_price DECIMAL(10, 2),                  -- Total price for the order
    FOREIGN KEY (user_id) REFERENCES users(id) on update cascade ON DELETE CASCADE  -- Relation to users
);


CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,          -- Unique category ID
    name VARCHAR(255) NOT NULL UNIQUE,           -- Category name
    description TEXT,                           -- Category description
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Date when category was created
);


CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,           -- Unique review ID
    user_id INT,                                 -- Foreign key to users table
    product_id INT,                              -- Foreign key to products table
    rating INT CHECK (rating BETWEEN 1 AND 5),    -- Rating between 1 and 5
    review_text TEXT,                            -- Review text
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Date when review was created
    FOREIGN KEY (user_id) REFERENCES users(id) on update cascade ON DELETE CASCADE,    -- Relation to users
    FOREIGN KEY (product_id) REFERENCES products(id) on update cascade  ON DELETE CASCADE  -- Relation to products
);


CREATE TABLE order_products (
    order_id INT,                                -- Foreign key to orders table
    product_id INT,                              -- Foreign key to products table
    quantity INT DEFAULT 1,                      -- Quantity of the product in the order
    PRIMARY KEY (order_id, product_id),          -- Composite primary key
    FOREIGN KEY (order_id) REFERENCES orders(id) on update cascade ON DELETE CASCADE,    -- Relation to orders
    FOREIGN KEY (product_id) REFERENCES products(id) on update cascade ON DELETE CASCADE  -- Relation to products
);
