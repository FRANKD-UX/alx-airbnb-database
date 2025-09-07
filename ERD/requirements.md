# Entity-Relationship Diagram (ERD) Requirements

## Database Specification for Airbnb-like Application

### Core Entities

#### 1. User

**Attributes:**

- user_id (Primary Key, UUID)
- first_name (VARCHAR, NOT NULL)
- last_name (VARCHAR, NOT NULL)
- email (VARCHAR, UNIQUE, NOT NULL)
- password_hash (VARCHAR, NOT NULL)
- phone_number (VARCHAR)
- role (ENUM: 'guest', 'host', 'admin', DEFAULT 'guest')
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- updated_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP)

#### 2. Property

**Attributes:**

- property_id (Primary Key, UUID)
- host_id (Foreign Key → User.user_id)
- name (VARCHAR, NOT NULL)
- description (TEXT, NOT NULL)
- location (VARCHAR, NOT NULL)
- pricepernight (DECIMAL(10,2), NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- updated_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP)

#### 3. Booking

**Attributes:**

- booking_id (Primary Key, UUID)
- property_id (Foreign Key → Property.property_id)
- user_id (Foreign Key → User.user_id)
- start_date (DATE, NOT NULL)
- end_date (DATE, NOT NULL)
- total_price (DECIMAL(10,2), NOT NULL)
- status (ENUM: 'pending', 'confirmed', 'canceled', DEFAULT 'pending')
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

#### 4. Payment

**Attributes:**

- payment_id (Primary Key, UUID)
- booking_id (Foreign Key → Booking.booking_id)
- amount (DECIMAL(10,2), NOT NULL)
- payment_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- payment_method (ENUM: 'credit_card', 'paypal', 'stripe', NOT NULL)

#### 5. Review

**Attributes:**

- review_id (Primary Key, UUID)
- property_id (Foreign Key → Property.property_id)
- user_id (Foreign Key → User.user_id)
- rating (INTEGER, CHECK(rating >= 1 AND rating <= 5), NOT NULL)
- comment (TEXT, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

#### 6. Message

**Attributes:**

- message_id (Primary Key, UUID)
- sender_id (Foreign Key → User.user_id)
- recipient_id (Foreign Key → User.user_id)
- message_body (TEXT, NOT NULL)
- sent_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Relationships

#### 1. User ↔ Property (One-to-Many)

- **Relationship**: A user (host) can own multiple properties
- **Cardinality**: 1:N
- **Foreign Key**: Property.host_id → User.user_id

#### 2. User ↔ Booking (One-to-Many)

- **Relationship**: A user (guest) can make multiple bookings
- **Cardinality**: 1:N
- **Foreign Key**: Booking.user_id → User.user_id

#### 3. Property ↔ Booking (One-to-Many)

- **Relationship**: A property can have multiple bookings
- **Cardinality**: 1:N
- **Foreign Key**: Booking.property_id → Property.property_id

#### 4. Booking ↔ Payment (One-to-One)

- **Relationship**: Each booking has exactly one payment
- **Cardinality**: 1:1
- **Foreign Key**: Payment.booking_id → Booking.booking_id

#### 5. Property ↔ Review (One-to-Many)

- **Relationship**: A property can have multiple reviews
- **Cardinality**: 1:N
- **Foreign Key**: Review.property_id → Property.property_id

#### 6. User ↔ Review (One-to-Many)

- **Relationship**: A user can write multiple reviews
- **Cardinality**: 1:N
- **Foreign Key**: Review.user_id → User.user_id

#### 7. User ↔ Message (Many-to-Many)

- **Relationship**: Users can send and receive multiple messages
- **Cardinality**: M:N (implemented with sender_id and recipient_id)
- **Foreign Keys**:
  - Message.sender_id → User.user_id
  - Message.recipient_id → User.user_id

### Business Rules

1. **User Roles**: Users can be guests, hosts, or admins
2. **Booking Constraints**:
   - End date must be after start date
   - No overlapping bookings for the same property
3. **Payment Integrity**: Every confirmed booking must have a payment
4. **Review Validation**: Only users who have completed bookings can review properties
5. **Message System**: Users can communicate with each other through the messaging system

### Indexes for Performance

1. **User Table**:

   - Index on email (for login)
   - Index on role (for role-based queries)

2. **Property Table**:

   - Index on host_id (for host's properties)
   - Index on location (for location-based searches)
   - Index on pricepernight (for price filtering)

3. **Booking Table**:

   - Index on property_id (for property bookings)
   - Index on user_id (for user bookings)
   - Composite index on (start_date, end_date) for availability checks

4. **Review Table**:

   - Index on property_id (for property reviews)
   - Index on rating (for rating-based queries)

5. **Message Table**:
   - Index on sender_id (for sent messages)
   - Index on recipient_id (for received messages)

### ERD Visual Representation

The ERD should be created using Draw.io or similar tools showing:

1. **Entities** as rectangles with attributes listed
2. **Primary Keys** underlined
3. **Foreign Keys** with appropriate notation
4. **Relationships** with cardinality indicators
5. **Constraints** and business rules documented

### Key Design Decisions

1. **UUID Primary Keys**: Used for better scalability and security
2. **Timestamps**: Automatic tracking of creation and modification times
3. **ENUM Types**: Used for status fields to ensure data integrity
4. **Decimal Types**: Used for monetary values to avoid floating-point precision issues
5. **Text vs VARCHAR**: TEXT for potentially long content, VARCHAR for shorter fields
