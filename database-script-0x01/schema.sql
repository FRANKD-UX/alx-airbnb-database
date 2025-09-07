-- ALX Airbnb Database Schema
-- Database: airbnb_db
-- Version: 1.0
-- Created: September 2025

-- Create database
CREATE DATABASE IF NOT EXISTS airbnb_db;
USE airbnb_db;

-- Drop tables if they exist (for clean installation)
DROP TABLE IF EXISTS Message;
DROP TABLE IF EXISTS Review;  
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS User;

-- =============================================
-- USER TABLE
-- =============================================
CREATE TABLE User (
    user_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role ENUM('guest', 'host', 'admin') NOT NULL DEFAULT 'guest',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT chk_email_format CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT chk_phone_format CHECK (phone_number IS NULL OR phone_number REGEXP '^[+]?[0-9\s\-\(\)]{10,20}$')
);

-- =============================================
-- PROPERTY TABLE  
-- =============================================
CREATE TABLE Property (
    property_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    host_id CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_property_host 
        FOREIGN KEY (host_id) REFERENCES User(user_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_price_positive CHECK (pricepernight > 0),
    CONSTRAINT chk_name_length CHECK (CHAR_LENGTH(name) >= 3),
    CONSTRAINT chk_description_length CHECK (CHAR_LENGTH(description) >= 10)
);

-- =============================================
-- BOOKING TABLE
-- =============================================
CREATE TABLE Booking (
    booking_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_booking_property 
        FOREIGN KEY (property_id) REFERENCES Property(property_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    CONSTRAINT fk_booking_user 
        FOREIGN KEY (user_id) REFERENCES User(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_booking_dates CHECK (end_date > start_date),
    CONSTRAINT chk_total_price_positive CHECK (total_price > 0),
    CONSTRAINT chk_start_date_future CHECK (start_date >= CURDATE())
);

-- =============================================
-- PAYMENT TABLE
-- =============================================
CREATE TABLE Payment (
    payment_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    booking_id CHAR(36) NOT NULL UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_payment_booking 
        FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_payment_amount_positive CHECK (amount > 0)
);

-- =============================================
-- REVIEW TABLE
-- =============================================
CREATE TABLE Review (
    review_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_review_property 
        FOREIGN KEY (property_id) REFERENCES Property(property_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    CONSTRAINT fk_review_user 
        FOREIGN KEY (user_id) REFERENCES User(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_rating_range CHECK (rating >= 1 AND rating <= 5),
    CONSTRAINT chk_comment_length CHECK (CHAR_LENGTH(comment) >= 10),
    
    -- Unique Constraint (one review per user per property)
    CONSTRAINT uk_user_property_review UNIQUE (user_id, property_id)
);

-- =============================================
-- MESSAGE TABLE
-- =============================================
CREATE TABLE Message (
    message_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    sender_id CHAR(36) NOT NULL,
    recipient_id CHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_message_sender 
        FOREIGN KEY (sender_id) REFERENCES User(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    CONSTRAINT fk_message_recipient 
        FOREIGN KEY (recipient_id) REFERENCES User(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_message_length CHECK (CHAR_LENGTH(message_body) >= 1),
    CONSTRAINT chk_different_users CHECK (sender_id != recipient_id)
);

-- =============================================
-- INDEXES for PERFORMANCE OPTIMIZATION
-- =============================================

-- User table indexes
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);
CREATE INDEX idx_user_created_at ON User(created_at);

-- Property table indexes
CREATE INDEX idx_property_host ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_price ON Property(pricepernight);
CREATE INDEX idx_property_created_at ON Property(created_at);

-- Booking table indexes
CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_user ON Booking(user_id);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_created_at ON Booking(created_at);

-- Payment table indexes
CREATE INDEX idx_payment_booking ON Payment(booking_id);
CREATE INDEX idx_payment_method ON Payment(payment_method);
CREATE INDEX idx_payment_date ON Payment(payment_date);

-- Review table indexes
CREATE INDEX idx_review_property ON Review(property_id);
CREATE INDEX idx_review_user ON Review(user_id);
CREATE INDEX idx_review_rating ON Review(rating);
CREATE INDEX idx_review_created_at ON Review(created_at);

-- Message table indexes
CREATE INDEX idx_message_sender ON Message(sender_id);
CREATE INDEX idx_message_recipient ON Message(recipient_id);
CREATE INDEX idx_message_sent_at ON Message(sent_at);

-- =============================================
-- VIEWS for COMMON QUERIES
-- =============================================

-- View: Property with Host Information
CREATE VIEW PropertyWithHost AS
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.pricepernight,
    u.first_name AS host_first_name,
    u.last_name AS host_last_name,
    u.email AS host_email,
    p.created_at
FROM Property p
JOIN User u ON p.host_id = u.user_id
WHERE u.role IN ('host', 'admin');

-- View: Booking Details with Property and User Info
CREATE VIEW BookingDetails AS
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    p.name AS property_name,
    p.location,
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    CONCAT(h.first_name, ' ', h.last_name) AS host_name
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
JOIN User u ON b.user_id = u.user_id
JOIN User h ON p.host_id = h.user_id;

-- View: Property Reviews with User Information
CREATE VIEW PropertyReviews AS
SELECT 
    r.review_id,
    r.property_id,
    p.name AS property_name,
    r.rating,
    r.comment,
    CONCAT(u.first_name, ' ', u.last_name) AS reviewer_name,
    r.created_at
FROM Review r
JOIN Property p ON r.property_id = p.property_id
JOIN User u ON r.user_id = u.user_id;

-- =============================================
-- TRIGGERS for BUSINESS LOGIC
-- =============================================

-- Trigger: Update Property Rating when Review is Added/Updated/Deleted
DELIMITER //

CREATE TRIGGER update_property_rating_after_review_insert
AFTER INSERT ON Review
FOR EACH ROW
BEGIN
    -- This would update a property_rating field if we had one
    -- For now, we'll just ensure data consistency
    UPDATE Property 
    SET updated_at = CURRENT_TIMESTAMP 
    WHERE property_id = NEW.property_id;
END//

CREATE TRIGGER update_property_rating_after_review_update
AFTER UPDATE ON Review
FOR EACH ROW
BEGIN
    UPDATE Property 
    SET updated_at = CURRENT_TIMESTAMP 
    WHERE property_id = NEW.property_id;
END//

CREATE TRIGGER update_property_rating_after_review_delete
AFTER DELETE ON Review
FOR EACH ROW
BEGIN
    UPDATE Property 
    SET updated_at = CURRENT_TIMESTAMP 
    WHERE property_id = OLD.property_id;
END//

-- Trigger: Validate booking dates don't overlap for the same property
CREATE TRIGGER check_booking_overlap_before_insert
BEFORE INSERT ON Booking
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO overlap_count
    FROM Booking
    WHERE property_id = NEW.property_id
        AND status IN ('confirmed', 'pending')
        AND (
            (NEW.start_date BETWEEN start_date AND end_date) OR
            (NEW.end_date BETWEEN start_date AND end_date) OR
            (start_date BETWEEN NEW.start_date AND NEW.end_date)
        );
    
    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Booking dates overlap with existing booking';
    END IF;
END//

DELIMITER ;

-- =============================================
-- FUNCTIONS for COMMON CALCULATIONS
-- =============================================

DELIMITER //

-- Function: Calculate booking duration in days
CREATE FUNCTION GetBookingDuration(start_date DATE, end_date DATE)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    RETURN DATEDIFF(end_date, start_date);
END//

-- Function: Get property average rating
CREATE FUNCTION GetPropertyAverageRating(prop_id CHAR(36))
RETURNS DECIMAL(3,2)
READS SQL DATA
BEGIN
    DECLARE avg_rating DECIMAL(3,2) DEFAULT 0.00;
    
    SELECT AVG(rating) INTO avg_rating
    FROM Review
    WHERE property_id = prop_id;
    
    RETURN COALESCE(avg_rating, 0.00);
END//

DELIMITER ;

-- =============================================
-- STORED PROCEDURES for COMMON OPERATIONS
-- =============================================

DELIMITER //

-- Procedure: Get available properties for date range
CREATE PROCEDURE GetAvailableProperties(
    IN check_in_date DATE,
    IN check_out_date DATE,
    IN max_price DECIMAL(10,2)
)
BEGIN
    SELECT p.property_id, p.name, p.location, p.pricepernight,
           GetPropertyAverageRating(p.property_id) as avg_rating
    FROM Property p
    WHERE p.pricepernight <= COALESCE(max_price, 999999.99)
        AND p.property_id NOT IN (
            SELECT DISTINCT property_id
            FROM Booking
            WHERE status IN ('confirmed', 'pending')
                AND (
                    (check_in_date BETWEEN start_date AND end_date) OR
                    (check_out_date BETWEEN start_date AND end_date) OR
                    (start_date BETWEEN check_in_date AND check_out_date)
                )
        )
    ORDER BY p.pricepernight ASC;
END//

DELIMITER ;

-- =============================================
-- GRANT PERMISSIONS (for production use)
-- =============================================

-- Create application user (uncomment for production)
-- CREATE USER 'airbnb_app'@'localhost' IDENTIFIED BY 'secure_password_here';
-- GRANT SELECT, INSERT, UPDATE, DELETE ON airbnb_db.* TO 'airbnb_app'@'localhost';
-- FLUSH PRIVILEGES;

-- Display schema creation summary
SELECT 'Database schema created successfully!' as Status;