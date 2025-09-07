-- ALX Airbnb Database - Sample Data Seeding
-- Database: airbnb_db
-- Purpose: Populate database with realistic sample data
-- Version: 1.0

USE airbnb_db;

-- Disable foreign key checks temporarily for data loading
SET FOREIGN_KEY_CHECKS = 0;

-- =============================================
-- CLEAR EXISTING DATA (for clean seeding)
-- =============================================
TRUNCATE TABLE Message;
TRUNCATE TABLE Review;
TRUNCATE TABLE Payment;
TRUNCATE TABLE Booking;
TRUNCATE TABLE Property;
TRUNCATE TABLE User;

-- =============================================
-- SEED USER DATA
-- =============================================

INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Guests
('550e8400-e29b-41d4-a716-446655440001', 'John', 'Doe', 'john.doe@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0101', 'guest', '2025-01-15 10:00:00'),
('550e8400-e29b-41d4-a716-446655440002', 'Jane', 'Smith', 'jane.smith@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0102', 'guest', '2025-01-16 11:30:00'),
('550e8400-e29b-41d4-a716-446655440003', 'Michael', 'Johnson', 'michael.j@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0103', 'guest', '2025-01-17 09:15:00'),
('550e8400-e29b-41d4-a716-446655440004', 'Emily', 'Davis', 'emily.davis@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0104', 'guest', '2025-01-18 14:20:00'),
('550e8400-e29b-41d4-a716-446655440005', 'Sarah', 'Wilson', 'sarah.wilson@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0105', 'guest', '2025-01-19 16:45:00'),

-- Hosts
('550e8400-e29b-41d4-a716-446655440011', 'Robert', 'Brown', 'robert.brown@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0111', 'host', '2025-01-10 08:00:00'),
('550e8400-e29b-41d4-a716-446655440012', 'Lisa', 'Garcia', 'lisa.garcia@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0112', 'host', '2025-01-11 10:30:00'),
('550e8400-e29b-41d4-a716-446655440013', 'David', 'Miller', 'david.miller@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0113', 'host', '2025-01-12 12:15:00'),
('550e8400-e29b-41d4-a716-446655440014', 'Maria', 'Rodriguez', 'maria.rodriguez@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0114', 'host', '2025-01-13 15:45:00'),
('550e8400-e29b-41d4-a716-446655440015', 'James', 'Taylor', 'james.taylor@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0115', 'host', '2025-01-14 17:20:00'),

-- Admins
('550e8400-e29b-41d4-a716-446655440021', 'Admin', 'User', 'admin@airbnb.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0121', 'admin', '2025-01-01 00:00:00'),

-- Additional users for testing
('550e8400-e29b-41d4-a716-446655440031', 'Alice', 'Anderson', 'alice.anderson@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0131', 'guest', '2025-01-20 10:00:00'),
('550e8400-e29b-41d4-a716-446655440032', 'Bob', 'Thompson', 'bob.thompson@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0132', 'host', '2025-01-21 11:00:00');

-- =============================================
-- SEED PROPERTY DATA
-- =============================================

INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at) VALUES
-- Robert Brown's properties
('660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440011', 'Cozy Downtown Apartment', 'Beautiful 2-bedroom apartment in the heart of downtown with modern amenities, high-speed WiFi, and stunning city views. Perfect for business travelers and tourists alike.', 'New York, NY', 150.00, '2025-01-20 09:00:00'),
('660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011', 'Luxury Penthouse Suite', 'Spectacular penthouse with panoramic city views, private terrace, jacuzzi, and premium furnishings. The ultimate luxury experience in the city.', 'New York, NY', 450.00, '2025-01-20 09:30:00'),

-- Lisa Garcia's properties  
('660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440012', 'Beachfront Villa', 'Stunning oceanfront villa with private beach access, infinity pool, and breathtaking sunset views. Sleeps up to 8 guests in 4 luxurious bedrooms.', 'Miami, FL', 300.00, '2025-01-21 10:00:00'),
('660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440012', 'Art Deco Studio', 'Stylish studio apartment in the famous Art Deco district, walking distance to South Beach, restaurants, and nightlife. Modern amenities in a historic building.', 'Miami, FL', 120.00, '2025-01-21 10:30:00'),

-- David Miller's properties
('660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440013', 'Mountain Cabin Retreat', 'Rustic log cabin nestled in the mountains with fireplace, hot tub, and hiking trails right outside your door. Perfect for a peaceful getaway.', 'Aspen, CO', 200.00, '2025-01-22 11:00:00'),
('660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440013', 'Ski Lodge Chalet', 'Luxury ski-in/ski-out chalet with gourmet kitchen, stone fireplace, and stunning mountain views. Accommodates up to 10 guests.', 'Aspen, CO', 500.00, '2025-01-22 11:30:00'),

-- Maria Rodriguez's properties
('660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440014', 'Historic Victorian Home', 'Beautifully restored Victorian mansion with original architectural details, modern updates, and gorgeous gardens. A unique stay experience.', 'San Francisco, CA', 250.00, '2025-01-23 12:00:00'),
('660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440014', 'Modern Loft Space', 'Contemporary loft in SOMA district with exposed brick, high ceilings, and industrial design. Walking distance to tech companies and restaurants.', 'San Francisco, CA', 180.00, '2025-01-23 12:30:00'),

-- James Taylor's properties
('660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440015', 'Lakefront Cottage', 'Charming cottage on pristine lake with private dock, kayaks included, and peaceful surroundings. Perfect for fishing and relaxation.', 'Lake Tahoe, CA', 175.00, '2025-01-24 13:00:00'),
('660e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440015', 'Desert Oasis Villa', 'Stunning desert villa with pool, spa, and mountain views. Modern architecture meets natural beauty in this unique retreat.', 'Scottsdale, AZ', 220.00, '2025-01-24 13:30:00'),

-- Bob Thompson's property
('660e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440032', 'Urban Studio Loft', 'Trendy studio loft in arts district with exposed brick walls, modern amenities, and walking distance to galleries and cafes.', 'Portland, OR', 95.00, '2025-01-25 14:00:00');

-- =============================================
-- SEED BOOKING DATA
-- =============================================

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- Confirmed bookings (past and present)
('770e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '2025-02-01', '2025-02-04', 450.00, 'confirmed', '2025-01-25 10:00:00'),
('770e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', '2025-02-15', '2025-02-20', 1500.00, 'confirmed', '2025-01-26 11:00:00'),
('770e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', '2025-03-01', '2025-03-07', 1200.00, 'confirmed', '2025-01-27 12:00:00'),
('770e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440004', '2025-02-10', '2025-02-14', 1000.00, 'confirmed', '2025-01-28 13:00:00'),
('770e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440005', '2025-02-20', '2025-02-25', 875.00, 'confirmed', '2025-01-29 14:00:00'),

-- Future confirmed bookings
('770e8400-e29b-41d4-a716-446655440006', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440031', '2025-12-15', '2025-12-18', 1350.00, 'confirmed', '2025-01-30 15:00:00'),
('770e8400-e29b-41d4-a716-446655440007', '660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440001', '2025-11-01', '2025-11-05', 480.00, 'confirmed', '2025-01-31 16:00:00'),
('770e8400-e29b-41d4-a716-446655440008', '660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440002', '2025-12-20', '2025-12-27', 3500.00, 'confirmed', '2025-02-01 17:00:00'),

-- Pending bookings
('770e8400-e29b-41d4-a716-446655440009', '660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', '2025-10-15', '2025-10-20', 900.00, 'pending', '2025-02-02 18:00:00'),
('770e8400-e29b-41d4-a716-446655440010', '660e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440004', '2025-11-10', '2025-11-15', 1100.00, 'pending', '2025-02-03 19:00:00'),

-- Canceled bookings
('770e8400-e29b-41d4-a716-446655440011', '660e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440005', '2025-10-01', '2025-10-05', 380.00, 'canceled', '2025-02-04 20:00:00'),

-- Additional bookings for different users
('770e8400-e29b-41d4-a716-446655440012', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440031', '2025-11-20', '2025-11-23', 450.00, 'confirmed', '2025-02-05 10:30:00'),
('770e8400-e29b-41d4-a716-446655440013', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', '2025-12-01', '2025-12-08', 2100.00, 'confirmed', '2025-02-06 11:30:00');

-- =============================================
-- SEED PAYMENT DATA
-- =============================================

INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
-- Payments for confirmed bookings
('880e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440001', 450.00, '2025-01-25 10:15:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440002', 1500.00, '2025-01-26 11:15:00', 'stripe'),
('880e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440003', 1200.00, '2025-01-27 12:15:00', 'paypal'),
('880e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440004', 1000.00, '2025-01-28 13:15:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440005', '770e8400-e29b-41d4-a716-446655440005', 875.00, '2025-01-29 14:15:00', 'stripe'),
('880e8400-e29b-41d4-a716-446655440006', '770e8400-e29b-41d4-a716-446655440006', 1350.00, '2025-01-30 15:15:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440007', '770e8400-e29b-41d4-a716-446655440007', 480.00, '2025-01-31 16:15:00', 'paypal'),
('880e8400-e29b-41d4-a716-446655440008', '770e8400-e29b-41d4-a716-446655440008', 3500.00, '2025-02-01 17:15:00', 'stripe'),
('880e8400-e29b-41d4-a716-446655440012', '770e8400-e29b-41d4-a716-446655440012', 450.00, '2025-02-05 10:45:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440013', '770e8400-e29b-41d4-a716-446655440013', 2100.00, '2025-02-06 11:45:00', 'stripe');

-- =============================================
-- SEED REVIEW DATA
-- =============================================

INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
-- Reviews for completed stays
('990e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 5, 'Absolutely fantastic stay! The apartment was exactly as described, beautifully furnished, and in a perfect location. Robert was an excellent host, very responsive and helpful. Would definitely stay again!', '2025-02-05 10:00:00'),

('990e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', 5, 'The beachfront villa exceeded all expectations! Waking up to ocean views every morning was magical. The infinity pool and private beach access made this a truly unforgettable vacation. Lisa was incredibly accommodating.', '2025-02-22 09:30:00'),

('990e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', 4, 'Great mountain retreat! The cabin was cozy and well-equipped. Hot tub under the stars was amazing. Only minor issue was the WiFi was a bit spotty, but that added to the disconnected mountain experience.', '2025-03-08 14:20:00'),

('990e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440004', 5, 'The Victorian home is a masterpiece! Every detail has been thoughtfully restored while maintaining modern comfort. The gardens are beautiful and the location is perfect for exploring San Francisco. Highly recommended!', '2025-02-15 16:45:00'),

('990e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440005', 4, 'Lovely lakefront cottage! Perfect for a peaceful getaway. The kayaks were a nice touch and we enjoyed fishing from the dock. The only downside was the kitchen could use some updated cookware, but overall a great experience.', '2025-02-26 11:15:00'),

-- Additional reviews from different users
('990e8400-e29b-41d4-a716-446655440006', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440031', 4, 'Nice downtown apartment with great city views. Clean, comfortable, and well-located. The building is a bit noisy at night, but that is to be expected in such a central location. Good value for money.', '2025-02-10 13:30:00'),

('990e8400-e29b-41d4-a716-446655440007', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440031', 5, 'Incredible beachfront experience! The villa is stunning with amazing amenities. Private beach access was the highlight. Lisa went above and beyond to ensure our stay was perfect. Will definitely book again!', '2025-02-12 15:45:00'),

('990e8400-e29b-41d4-a716-446655440008', '660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', 3, 'Art Deco studio was cute and in a great location. However, it was smaller than expected and could use some maintenance. The neighborhood is fantastic with lots to do within walking distance.', '2025-02-08 12:20:00'),

('990e8400-e29b-41d4-a716-446655440009', '660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440003', 5, 'The Victorian home is absolutely gorgeous! Every room tells a story and the restoration work is impeccable. Maria was a wonderful host with great local recommendations. A truly unique stay.', '2025-02-18 10:30:00'),

('990e8400-e29b-41d4-a716-446655440010', '660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440004', 4, 'Modern loft in great SOMA location. Perfect for business travel with fast WiFi and close to everything. Industrial design is very cool. Only complaint is the street noise, but that comes with the territory.', '2025-02-25 14:10:00');

-- =============================================
-- SEED MESSAGE DATA
-- =============================================

INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
-- Guest to Host communications
('aa0e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440011', 'Hi Robert! I just booked your downtown apartment for February. Looking forward to staying there. Do you have any local restaurant recommendations?', '2025-01-25 10:30:00'),

('aa0e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440001', 'Hi John! Welcome and thank you for booking! I would highly recommend Joes Pizza just two blocks away, and for fine dining, Le Bernardin is about 10 minutes walk. Let me know if you need anything else!', '2025-01-25 11:00:00'),

('aa0e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440012', 'Hello Lisa! We are so excited about our Miami trip! Is there parking available at the beachfront villa? We are planning to rent a car.', '2025-01-26 12:15:00'),

('aa0e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440002', 'Hi Jane! Yes, there is a private garage that fits two cars. The gate code will be in your check-in instructions. Have a wonderful trip!', '2025-01-26 13:00:00'),

('aa0e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440013', 'David, quick question about the mountain cabin - is firewood provided or should we bring our own? Also, are there grocery stores nearby?', '2025-01-27 14:30:00'),

('aa0e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440003', 'Hi Michael! Firewood is stocked and replenished weekly. There is a small market about 5 miles away, but I recommend stocking up in town before heading up the mountain. Enjoy your stay!', '2025-01-27 15:15:00'),

-- Host to Guest follow-ups
('aa0e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440004', 'Hi Emily! Just wanted to check in and see how your stay at the Victorian home is going. Is everything to your satisfaction?', '2025-02-12 10:00:00'),

('aa0e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440014', 'Hi Maria! Everything is absolutely perfect. The house is even more beautiful than the photos. Thank you for the welcome basket and the detailed guidebook. You are an amazing host!', '2025-02-12 11:30:00'),

-- Guest inquiries before booking
('aa0e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440031', '550e8400-e29b-41d4-a716-446655440015', 'Hi James! I am interested in your lakefront cottage for November. Is it suitable for families with young children? Are there safety barriers around the dock area?', '2025-02-01 09:00:00'),

('aa0e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440031', 'Hi Alice! The cottage is very family-friendly. The dock has railings and there is a shallow area perfect for kids. I also have life jackets in various sizes available. Would love to host your family!', '2025-02-01 10:30:00'),

-- Post-stay thank you messages
('aa0e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440015', 'James, thank you so much for a wonderful stay at the lake cottage! The fishing was great and the kids loved kayaking. We left everything clean and locked up. Hope to visit again next year!', '2025-02-26 16:00:00'),

('aa0e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440005', 'Sarah, it was a pleasure hosting your family! Thank you for leaving everything in perfect condition. You are always welcome back. I have left a 5-star review for you as a guest!', '2025-02-26 18:30:00'),

-- Admin communications
('aa0e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440021', '550e8400-e29b-41d4-a716-446655440011', 'Hi Robert, we have received excellent feedback about your properties. Thank you for maintaining such high standards. Keep up the great work!', '2025-02-15 12:00:00'),

('aa0e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440021', 'Thank you! I really appreciate the positive feedback. I take pride in providing excellent experiences for all guests. Looking forward to continuing to work with the platform.', '2025-02-15 14:00:00'),

-- More casual conversations
('aa0e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655440031', 'Hey Alice! I see you are new to the platform. If you have any questions about hosting or the area, feel free to reach out. Us Portland hosts stick together!', '2025-02-20 16:30:00'),

('aa0e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440031', '550e8400-e29b-41d4-a716-446655440032', 'Hi Bob! Thanks so much for the welcome message. I would love any tips you have for new hosts. This community seems really supportive!', '2025-02-20 17:15:00');

-- =============================================
-- RE-ENABLE FOREIGN KEY CHECKS
-- =============================================
SET FOREIGN_KEY_CHECKS = 1;

-- =============================================
-- DATA VERIFICATION QUERIES
-- =============================================

-- Display summary of seeded data
SELECT 'Data Seeding Summary' as Info;

SELECT 
    'Users' as Entity,
    COUNT(*) as Total_Count,
    COUNT(CASE WHEN role = 'guest' THEN 1 END) as Guests,
    COUNT(CASE WHEN role = 'host' THEN 1 END) as Hosts,
    COUNT(CASE WHEN role = 'admin' THEN 1 END) as Admins
FROM User;

SELECT 
    'Properties' as Entity,
    COUNT(*) as Total_Count,
    ROUND(AVG(pricepernight), 2) as Average_Price,
    MIN(pricepernight) as Min_Price,
    MAX(pricepernight) as Max_Price
FROM Property;

SELECT 
    'Bookings' as Entity,
    COUNT(*) as Total_Count,
    COUNT(CASE WHEN status = 'confirmed' THEN 1 END) as Confirmed,
    COUNT(CASE WHEN status = 'pending' THEN 1 END) as Pending,
    COUNT(CASE WHEN status = 'canceled' THEN 1 END) as Canceled,
    ROUND(SUM(total_price), 2) as Total_Revenue
FROM Booking;

SELECT 
    'Payments' as Entity,
    COUNT(*) as Total_Count,
    ROUND(SUM(amount), 2) as Total_Amount,
    COUNT(CASE WHEN payment_method = 'credit_card' THEN 1 END) as Credit_Card,
    COUNT(CASE WHEN payment_method = 'stripe' THEN 1 END) as Stripe,
    COUNT(CASE WHEN payment_method = 'paypal' THEN 1 END) as PayPal
FROM Payment;

SELECT 
    'Reviews' as Entity,
    COUNT(*) as Total_Count,
    ROUND(AVG(rating), 2) as Average_Rating,
    COUNT(CASE WHEN rating = 5 THEN 1 END) as Five_Stars,
    COUNT(CASE WHEN rating = 4 THEN 1 END) as Four_Stars,
    COUNT(CASE WHEN rating = 3 THEN 1 END) as Three_Stars
FROM Review;

SELECT 
    'Messages' as Entity,
    COUNT(*) as Total_Count,
    COUNT(DISTINCT sender_id) as Unique_Senders,
    COUNT(DISTINCT recipient_id) as Unique_Recipients
FROM Message;

-- Sample queries to verify relationships work correctly
SELECT 'Sample Property with Host Info:' as Info;
SELECT * FROM PropertyWithHost LIMIT 3;

SELECT 'Sample Booking Details:' as Info;
SELECT * FROM BookingDetails WHERE status = 'confirmed' LIMIT 3;

SELECT 'Sample Property Reviews:' as Info;
SELECT property_name, rating, LEFT(comment, 50) as comment_preview 
FROM PropertyReviews LIMIT 3;

SELECT 'Database seeding completed successfully!' as Status;