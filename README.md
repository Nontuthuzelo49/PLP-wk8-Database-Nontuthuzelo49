# PLP-wk8-Database
# Hotel Booking System Database (HotelBookingSystemsDB)

## 📌 Project Overview
This project defines a relational database model for managing hotel reservations, guests, payments, events, customer support, and related services. It ensures **data integrity, optimized queries**, and supports **role-based access control**.

## ⚙️ Features
- **Guest Management:** Stores guest details securely.
- **Room Booking System:** Tracks room availability and reservations.
- **Payment Processing:** Handles payments and supports different payment methods.
- **Event Bookings:** Allows guests to book events using hotel facilities.
- **Customer Support:** Manages issue tracking and resolution statuses.
- **Security Measures:** Supports encrypted guest emails and role-based access.

## 🏗️ Database Schema
### **Key Tables & Relationships**
| Table | Description |
|-------|------------|
| `Guests` | Stores guest information. |
| `Rooms` | Defines available hotel rooms. |
| `Reservations` | Links guests to booked rooms. |
| `Payments` | Tracks payments for reservations. |
| `Staff` | Manages hotel employees. |
| `Reviews` | Guest reviews of their stay. |
| `EventBookings` | Handles hotel event reservations. |
| `EventFacilities` | Lists available facilities for events. |
| `CustomerSupport` | Manages guest inquiries. |

### **Relationships**
- **One-to-Many (`1-M`)** → Guests → Reservations
- **One-to-One (`1-1`)** → CustomerSupportTickets → CustomerSupportResponses
- **Many-to-Many (`M-M`)** → Rooms ↔ Amenities, EventBookings ↔ EventFacilities

## 🚀 Installation & Setup
1️⃣ **Clone the repository**:
```sh
git clone https://github.com/Nontuthuzelo49/PLP-wk8-Database-Nontuthuzelo49.git
```
2️⃣ **Import the database in MySQL**:
```sh
mysql -u root -p < HotelBookingSystemsDB.sql
```
3️⃣ **Verify Tables**:
```sql
SHOW TABLES;
```

## 🔧 Stored Procedures
### **Automated Calculations**
```sql
CALL CalculateTotalAmount(reservation_id);
```
- Auto-calculates the total amount for a reservation.

### **Retrieve Available Rooms**
```sql
CALL GetAvailableRooms('2025-06-10', '2025-06-15');
```
- Finds available rooms for the specified dates.

## 🛡️ Security Features
- **Encrypted Guest Emails**:
```sql
UPDATE Guests SET EncryptedEmail = AES_ENCRYPT(Email, 'SecureKey123');
```
- **Role-Based Access Control (RBAC)**:
```sql
CREATE USER 'hotel_admin'@'localhost' IDENTIFIED BY 'Hotel25';
GRANT ALL PRIVILEGES ON HotelBookingSystemsDB.* TO 'hotel_admin'@'localhost';
```

## 🔍 Indexing for Optimization
```sql
CREATE INDEX idx_guest_email ON Guests(Email);
CREATE INDEX idx_reservation_dates ON Reservations(CheckInDate, CheckOutDate);
```
- Improves query performance for frequent searches.

## 📄 License
This project is licensed under the **MIT License**.

## 👥 Contributors
- Nontuthuzelo Mahlangu



