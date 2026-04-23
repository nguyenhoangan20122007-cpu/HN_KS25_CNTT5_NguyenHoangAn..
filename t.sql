-- Tạo database
CREATE DATABASE IF NOT EXISTS hackathon_db;
USE hackathon_db;
-- Bảng Users
CREATE TABLE Users (
    user_id VARCHAR(5) PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE,
    user_phone VARCHAR(15) NOT NULL UNIQUE
);

-- Bảng Products
CREATE TABLE Products (
    product_id VARCHAR(5) PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    product_price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL
);

-- Bảng Orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(5) NOT NULL,
    order_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Bảng Order_Details
CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id VARCHAR(5) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Users
INSERT INTO Users VALUES
('U001','Nguyễn Văn An','an.nguyen@gmail.com','0912345678'),
('U002','Trần Thị Bích','bich.tran@gmail.com','0923456789'),
('U003','Lê Hoàng Minh','minh.le@gmail.com','0934567890'),
('U004','Phạm Thu Hà','ha.pham@gmail.com','0945678901'),
('U005','Võ Quốc Huy','huy.vo@gmail.com','0956789012');

-- Products
INSERT INTO Products VALUES
('P001','Áo thun nam',199000,50),
('P002','Quần jean nữ',399000,40),
('P003','Giày sneaker',899000,30),
('P004','Túi xách thời trang',599000,20),
('P005','Đồng hồ đeo tay',1299000,15);

-- Orders
INSERT INTO Orders (order_id,user_id,order_date,total_price,order_status) VALUES
(1,'U001','2025-03-01',398000,'Completed'),
(2,'U002','2025-03-02',899000,'Completed'),
(3,'U003','2025-03-03',399000,'Processing'),
(4,'U001','2025-03-04',2598000,'Cancelled'),
(5,'U004','2025-03-05',1797000,'Pending');

-- Order Details
INSERT INTO Order_Details VALUES
(1,1,'P001',2,199000),
(2,2,'P003',1,899000),
(3,3,'P002',1,399000),
(4,4,'P005',2,1299000),
(5,5,'P004',3,599000);
-- Cập nhật 
UPDATE Users
SET user_phone = '096532628'
WHERE user_id = 'U003';

UPDATE Orders
SET order_status = 'Cancelled'
WHERE order_id = 3;

-- Xóa 
DELETE FROM Orders
WHERE order_status = 'Cancelled'
AND order_date < '2025-03-04';
-- 6
SELECT order_id, order_date, order_status
FROM Orders
WHERE order_status = 'Completed'
AND order_date > '2025-03-01';

-- 7
SELECT user_name, user_phone, user_email
FROM Users
WHERE user_phone LIKE '09%';

-- 8
SELECT order_id, user_id, order_date
FROM Orders
ORDER BY order_date DESC;

-- 9
SELECT *
FROM Orders
WHERE order_status = 'Completed'
LIMIT 3;

-- 10
SELECT user_id, user_name
FROM Users
LIMIT 3 OFFSET 2;

-- 11
SELECT o.order_id, u.user_name, o.order_date, o.total_price
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
WHERE o.order_status = 'Completed';

-- 12
SELECT p.product_id, p.product_name, od.order_id
FROM Products p
LEFT JOIN Order_Details od ON p.product_id = od.product_id;

-- 13
SELECT order_status, COUNT(*) AS Total_Order
FROM Orders
GROUP BY order_status;

-- 14
SELECT user_id, COUNT(*) AS Count_Order
FROM Orders
GROUP BY user_id
HAVING COUNT(*) >= 2;

-- 15
SELECT order_id, order_date, total_price
FROM Orders
WHERE total_price > (
    SELECT AVG(total_price) FROM Orders
);
-- 17
SELECT o.order_id, u.user_name, p.product_name, od.quantity, od.unit_price
FROM Order_Details od
JOIN Orders o ON od.order_id = o.order_id
JOIN Users u ON o.user_id = u.user_id
JOIN Products p ON od.product_id = p.product_id;
