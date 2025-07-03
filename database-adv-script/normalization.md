### User
- user_id (PK)
- first_name
- last_name
- email
- password_hash
- phone_number
- role
- created_at

### Property
- property_id (PK)
- host_id (FK → User)
- name
- description
- location
- pricepernight
- created_at
- updated_at

### Booking
- booking_id (PK)
- property_id (FK → Property)
- user_id (FK → User)
- start_date
- end_date
- status
- created_at

### Payment
- payment_id (PK)
- booking_id (FK → Booking)
- amount
- payment_date
- payment_method

### Review
- review_id (PK)
- property_id (FK → Property)
- user_id (FK → User)
- rating (1-5)
- comment
- created_at

### Message
- message_id (PK)
- sender_id (FK → User)
- recipient_id (FK → User)
- message_body
- sent_at
