# ERD Requirements
+----------------+       +-------------------+       +----------------+
|      User      |       |     Property      |       |     Review     |
+----------------+       +-------------------+       +----------------+
| PK: user_id    |1      | PK: property_id   |1      | PK: review_id  |
| first_name     |-------| FK: host_id       |-------| FK: property_id|
| last_name      |*      | name              |*      | FK: user_id    |
| email          |       | description       |       | rating         |
| password_hash  |       | location          |       | comment        |
| phone_number   |       | pricepernight     |       +----------------+
| role           |       +-------------------+               ^
| created_at     |               ^                           |
+----------------+               |                           |
    |   ^                       |1                          |1
    |   |                       |                           |
    |   |                       v                           |
    |   |               +----------------+                  |
    |   +---------------|     Booking     |-----------------+
    |1                 *+----------------+
    |                   | PK: booking_id  |
    |                   | FK: property_id |
    |                   | FK: user_id     |
    |                   | start_date     |
    |                   | end_date       |
    |                   | total_price    |
    |                   | status         |
    |                   +----------------+
    |                           |1
    |                           |
    |                           |*
    |                   +----------------+
    +-------------------|     Payment    |
                        +----------------+
                        | PK: payment_id |
                        | FK: booking_id |
                        | amount        |
                        | payment_date  |
                        | payment_method|
                        +----------------+

+----------------+       +----------------+
|      User      |       |    Message     |
+----------------+       +----------------+
| PK: user_id    |1      | PK: message_id |
| (attributes)   |-------| FK: sender_id  |
+----------------+*      | FK: recipient_id|
        ^                | message_body   |
        |                | sent_at        |
        +----------------+----------------+
                    1    *
