# Database Sample Data Seeding - README

## Overview

This directory contains SQL scripts to populate the ALX Airbnb database with realistic sample data that simulates a real-world Airbnb-like environment with users, properties, bookings, payments, reviews, and messages.

## Files

- `seed.sql` - Complete sample data insertion script
- `README.md` - This documentation file

## Sample Data Overview

### Data Scale

- **13 Users** (8 guests, 4 hosts, 1 admin)
- **11 Properties** across various locations
- **13 Bookings** with different statuses
- **10 Payments** for confirmed bookings
- **10 Reviews** with ratings 3-5 stars
- **16 Messages** showing realistic communication

### Data Characteristics

#### Geographic Distribution

Properties are distributed across major US destinations:

- **New York, NY**: Downtown apartment, luxury penthouse
- **Miami, FL**: Beachfront villa, Art Deco studio
- **Aspen, CO**: Mountain cabin, ski lodge chalet
- **San Francisco, CA**: Victorian home, modern loft
- **Lake Tahoe, CA**: Lakefront cottage
- **Scottsdale, AZ**: Desert oasis villa
- **Portland, OR**: Urban studio loft

#### Price Range

- **Budget**: $95-120/night (urban studios, small apartments)
- **Mid-range**: $150-250/night (standard properties, cabins)
- **Premium**: $300-500/night (villas, luxury properties)

#### User Roles and Behavior

- **Guests**: Realistic booking patterns with various trip lengths
- **Hosts**: Multiple property owners and single property hosts
- **Admin**: System oversight and community management

## Installation Instructions

### Prerequisites

- MySQL database with `airbnb_db` created
- Schema tables already created (run `schema.sql` first)
- Appropriate database permissions

### Installation Steps

1. **Ensure Schema Exists**:

   ```sql
   USE airbnb_db;
   SHOW TABLES;
   ```

2. **Execute Seeding Script**:

   ```sql
   SOURCE seed.sql;
   ```

3. **Verify Data Load**:
   ```sql
   SELECT COUNT(*) FROM User;
   SELECT COUNT(*) FROM Property;
   SELECT COUNT(*) FROM Booking;
   ```

## Data Details

### User Accounts

#### Sample Guests

- **John Doe** (john.doe@email.com) - Active booker
- **Jane Smith** (jane.smith@email.com) - Regular traveler
- **Michael Johnson** (michael.j@email.com) - Mountain enthusiast
- **Emily Davis** (emily.davis@email.com) - City explorer
- **Sarah Wilson** (sarah.wilson@email.com) - Family traveler
- **Alice Anderson** (alice.anderson@email.com) - New user

#### Sample Hosts

- **Robert Brown** - NYC properties (downtown & luxury)
- **Lisa Garcia** - Miami properties (beachfront & urban)
- **David Miller** - Colorado mountain properties
- **Maria Rodriguez** - San Francisco properties
- **James Taylor** - Diverse portfolio (lake & desert)
- **Bob Thompson** - Portland urban property

#### Administrative User

- **Admin User** (admin@airbnb.com) - Platform administration

### Property Portfolio

#### Property Types

1. **Urban Apartments**: Downtown locations with city amenities
2. **Luxury Properties**: High-end accommodations with premium features
3. **Vacation Rentals**: Beachfront, lakefront, and mountain properties
4. **Historic Properties**: Victorian homes and unique architectural features
5. **Modern Accommodations**: Contemporary lofts and studios

#### Amenities Represented

- Private pools and hot tubs
- Beach and lake access
- Mountain views and hiking access
- Business-friendly features (WiFi, workspaces)
- Family accommodations
- Pet-friendly options (implied in descriptions)

### Booking Patterns

#### Booking Status Distribution

- **Confirmed Bookings** (10): Mix of past, current, and future stays
- **Pending Bookings** (2): Awaiting host approval
- **Canceled Bookings** (1): Realistic cancellation scenario

#### Trip Characteristics

- **Short Stays** (2-3 nights): City breaks and business travel
- **Medium Stays** (4-7 nights): Standard vacation length
- **Extended Stays** (5-7 nights): Longer vacations and relocations

#### Seasonal Patterns

- Winter bookings for ski properties
- Year-round urban bookings
- Advance bookings for popular destinations

### Payment Processing

#### Payment Methods

- **Credit Card** (40%): Traditional payment method
- **Stripe** (40%): Modern payment processing
- **PayPal** (20%): Alternative payment option

#### Payment Timing

- Immediate payment for confirmed bookings
- Realistic payment dates following booking creation
- Various payment amounts reflecting different trip values

### Review System

#### Rating Distribution

- **5 Stars** (60%): Excellent experiences
- **4 Stars** (30%): Good experiences with minor issues
- **3 Stars** (10%): Average experiences with notable concerns

#### Review Content

- Detailed, realistic feedback
- Mentions of specific amenities and features
- Host appreciation and recommendations
- Constructive criticism where appropriate
- Varied review lengths and styles

### Communication Patterns

#### Message Types

1. **Pre-booking Inquiries**: Questions about amenities, policies
2. **Booking Confirmations**: Welcome messages and instructions
3. **Check-in Coordination**: Logistics and recommendations
4. **During-stay Communication**: Issue resolution and check-ins
5. **Post-stay Follow-up**: Thank you messages and feedback
6. **Administrative Messages**: Platform communications
7. **Community Building**: Host-to-host networking

#### Realistic Communication Flow

- Guest inquiries before booking
- Host responses with helpful information
- Follow-up questions and clarifications
- Post-stay appreciation messages
- Professional yet friendly tone

## Business Scenarios Represented

### 1. Successful Guest Journey

John Doe books Robert's downtown apartment, receives recommendations, has excellent stay, leaves 5-star review.

### 2. Host Portfolio Management

Lisa Garcia manages multiple Miami properties with different price points and target markets.

### 3. Seasonal Booking Patterns

David Miller's mountain properties show winter bookings for ski season.

### 4. Community Building

Portland hosts Bob and Alice connect and share local knowledge.

### 5. Quality Assurance

Admin user monitors platform activity and provides host recognition.

### 6. Booking Lifecycle

Complete booking process from inquiry through payment and review.

## Data Relationships Verification

### Foreign Key Integrity

All relationships properly maintained:

- Properties linked to valid hosts
- Bookings reference existing properties and users
- Payments tied to confirmed bookings
- Reviews from guests who completed stays
- Messages between valid user accounts

### Business Rule Compliance

- No overlapping bookings for same property
- Payments match booking amounts
- Reviews only from completed bookings
- Realistic date progressions
- Proper role assignments

## Common Queries for Testing

### Property Search

```sql
-- Available properties in date range
CALL GetAvailableProperties('2025-11-01', '2025-11-07', 300.00);
```

### User Activity

```sql
-- Guest booking history
SELECT * FROM BookingDetails
WHERE guest_name = 'John Doe'
ORDER BY start_date DESC;
```

### Host Performance

```sql
-- Host revenue and ratings
SELECT
    p.name,
    COUNT(b.booking_id) as bookings,
    AVG(r.rating) as avg_rating,
    SUM(b.total_price) as revenue
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
LEFT JOIN Review r ON p.property_id = r.property_id
WHERE p.host_id = '550e8400-e29b-41d4-a716-446655440011'
GROUP BY p.property_id;
```

### Platform Analytics

```sql
-- Booking trends by status
SELECT
    status,
    COUNT(*) as count,
    AVG(total_price) as avg_value,
    SUM(total_price) as total_revenue
FROM Booking
GROUP BY status;
```

### Communication Analysis

```sql
-- Message activity by user
SELECT
    CONCAT(u.first_name, ' ', u.last_name) as user_name,
    COUNT(CASE WHEN m.sender_id = u.user_id THEN 1 END) as messages_sent,
    COUNT(CASE WHEN m.recipient_id = u.user_id THEN 1 END) as messages_received
FROM User u
LEFT JOIN Message m ON u.user_id IN (m.sender_id, m.recipient_id)
GROUP BY u.user_id
HAVING messages_sent > 0 OR messages_received > 0
ORDER BY (messages_sent + messages_received) DESC;
```

## Data Quality Features

### 1. Realistic Variety

- Different property types and price points
- Geographic diversity across major US markets
- Varied user behaviors and preferences
- Multiple communication patterns

### 2. Temporal Consistency

- Booking dates progress logically
- Payment dates follow booking creation
- Review dates after stay completion
- Message timestamps show realistic conversation flow

### 3. Business Logic Compliance

- Price calculations match booking duration
- Status transitions follow business rules
- User roles align with actions taken
- Relationship integrity maintained throughout

### 4. Edge Cases Included

- Canceled booking scenario
- Pending bookings awaiting approval
- Mixed review ratings including constructive feedback
- Various payment methods and amounts

## Maintenance and Updates

### Adding New Sample Data

1. Follow existing UUID patterns
2. Maintain referential integrity
3. Use realistic dates and values
4. Include variety in status and types

### Cleaning Sample Data

```sql
-- Reset all data (be careful!)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Message;
TRUNCATE TABLE Review;
TRUNCATE TABLE Payment;
TRUNCATE TABLE Booking;
TRUNCATE TABLE Property;
TRUNCATE TABLE User;
SET FOREIGN_KEY_CHECKS = 1;
```

### Data Refresh

Re-run the complete seed.sql script to refresh with latest sample data.

## Production Considerations

### Security Notes

- All passwords are hashed using bcrypt
- Sample data should not be used in production
- UUIDs provide security through obscurity
- Email addresses are fictional

### Performance Impact

- Sample data size is optimized for development
- Indexes will improve query performance
- Consider data archiving strategies for production scale
- Monitor query performance with larger datasets

### Compliance

- Sample data includes realistic but fictional information
- No real personal information used
- GDPR-compliant data structure ready for production
- Audit trail maintained through timestamps

This sample data provides a solid foundation for testing, development, and demonstration of the ALX Airbnb database system.
