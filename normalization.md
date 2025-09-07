# Database Normalization Analysis

## Objective

Apply normalization principles to ensure the Airbnb-like database design achieves Third Normal Form (3NF), eliminating redundancy and ensuring data integrity.

## Initial Database Analysis

### Original Schema Review

The initial database schema includes the following entities:

- User
- Property
- Booking
- Payment
- Review
- Message

## Normalization Process

### First Normal Form (1NF)

**Definition**: Each table cell contains only atomic (indivisible) values, and each record is unique.

**Analysis**:
✅ **User Table**: All attributes are atomic

- first_name, last_name, email, phone_number are single values
- No repeating groups or multi-valued attributes

✅ **Property Table**: All attributes are atomic

- name, description, location, pricepernight are single values
- No complex data structures within fields

✅ **Booking Table**: All attributes are atomic

- start_date, end_date, total_price, status are single values
- Each booking record is unique

✅ **Payment Table**: All attributes are atomic

- amount, payment_date, payment_method are single values

✅ **Review Table**: All attributes are atomic

- rating, comment are single values

✅ **Message Table**: All attributes are atomic

- message_body, sent_at are single values

**Result**: All tables are in 1NF.

### Second Normal Form (2NF)

**Definition**: The table is in 1NF and all non-key attributes are fully functionally dependent on the primary key.

**Analysis**:

✅ **User Table**:

- Primary Key: user_id
- All attributes (first_name, last_name, email, etc.) depend entirely on user_id
- No partial dependencies

✅ **Property Table**:

- Primary Key: property_id
- All attributes depend entirely on property_id
- host_id creates a proper foreign key relationship

✅ **Booking Table**:

- Primary Key: booking_id
- All attributes depend entirely on booking_id
- Foreign keys (property_id, user_id) create proper relationships

✅ **Payment Table**:

- Primary Key: payment_id
- All attributes depend entirely on payment_id
- booking_id creates proper foreign key relationship

✅ **Review Table**:

- Primary Key: review_id
- All attributes depend entirely on review_id
- Foreign keys properly established

✅ **Message Table**:

- Primary Key: message_id
- All attributes depend entirely on message_id
- Foreign keys for sender_id and recipient_id properly established

**Result**: All tables are in 2NF.

### Third Normal Form (3NF)

**Definition**: The table is in 2NF and no non-key attribute depends transitively on the primary key (no transitive dependencies).

**Analysis and Potential Issues**:

#### User Table - ✅ Already in 3NF

- No transitive dependencies identified
- All attributes directly relate to the user entity

#### Property Table - ✅ Already in 3NF

- All attributes directly relate to the property
- host_id is a proper foreign key reference
- location could potentially be normalized further, but for this application scope, keeping it as a single field is acceptable

#### Booking Table - ⚠️ Potential Optimization

**Issue**: total_price could be calculated from pricepernight × number_of_nights
**Analysis**:

- This creates a calculated dependency
- However, storing total_price is justified for business reasons:
  - Price changes over time
  - Promotional rates
  - Dynamic pricing
  - Historical accuracy

**Decision**: Keep total_price as stored value for business integrity

#### Payment Table - ✅ Already in 3NF

- No transitive dependencies
- All attributes directly relate to the payment

#### Review Table - ✅ Already in 3NF

- No transitive dependencies
- All attributes directly relate to the review

#### Message Table - ✅ Already in 3NF

- No transitive dependencies
- All attributes directly relate to the message

## Advanced Normalization Considerations

### Potential Further Normalization (Beyond 3NF)

#### Location Normalization

**Current State**: Property.location stored as VARCHAR
**Potential Enhancement**:

```sql
-- Could be normalized to:
Location Table:
- location_id (PK)
- city
- state
- country
- postal_code

Property Table:
- location_id (FK → Location.location_id)
```

**Decision**: For the current scope, keeping location as a single field provides:

- Flexibility for various location formats
- Simpler queries for location-based searches
- Reduced complexity for this educational project

#### User Address Normalization

**Current State**: User table has no address information
**Consideration**: If addresses were needed, they should be in a separate Address table to avoid repetition

## Final Schema Validation

### Normalization Compliance Summary

| Table    | 1NF | 2NF | 3NF | Notes                                   |
| -------- | --- | --- | --- | --------------------------------------- |
| User     | ✅  | ✅  | ✅  | Fully normalized                        |
| Property | ✅  | ✅  | ✅  | Location kept as single field by design |
| Booking  | ✅  | ✅  | ✅  | total_price stored for business reasons |
| Payment  | ✅  | ✅  | ✅  | Fully normalized                        |
| Review   | ✅  | ✅  | ✅  | Fully normalized                        |
| Message  | ✅  | ✅  | ✅  | Fully normalized                        |

## Benefits Achieved Through Normalization

### 1. Elimination of Data Redundancy

- Each piece of information is stored only once
- User information is not repeated across bookings
- Property details are not duplicated in multiple bookings

### 2. Data Integrity

- Referential integrity through foreign keys
- Consistent data across related tables
- Reduced risk of inconsistent updates

### 3. Efficient Storage

- Minimal data duplication
- Optimized storage usage
- Scalable design

### 4. Maintainability

- Changes to user or property information require updates in only one place
- Clear relationships between entities
- Reduced complexity in data management

## Constraints and Business Rules Implementation

### Referential Integrity Constraints

1. Property.host_id → User.user_id (CASCADE ON DELETE to handle host deletion)
2. Booking.property_id → Property.property_id (RESTRICT to prevent deletion of booked properties)
3. Booking.user_id → User.user_id (CASCADE ON DELETE)
4. Payment.booking_id → Booking.booking_id (CASCADE ON DELETE)
5. Review.property_id → Property.property_id (CASCADE ON DELETE)
6. Review.user_id → User.user_id (CASCADE ON DELETE)

### Check Constraints

1. Booking: end_date > start_date
2. Review: rating BETWEEN 1 AND 5
3. Payment: amount > 0
4. Property: pricepernight > 0

## Conclusion

The database design successfully achieves Third Normal Form (3NF) compliance while maintaining practical business requirements. The schema eliminates redundancy, ensures data integrity, and provides a solid foundation for a scalable Airbnb-like application.

Key design decisions prioritize:

- Data integrity and consistency
- Performance through appropriate denormalization where justified
- Business rule enforcement
- Scalability and maintainability

The normalized design provides an optimal balance between theoretical normalization principles and practical application requirements.
