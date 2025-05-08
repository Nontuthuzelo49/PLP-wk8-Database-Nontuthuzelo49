CREATE database HotelBookingSystemsDB;
USE HotelBookingSystemsDB;
CREATE TABLE Guests (
    GuestID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL
);

CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY AUTO_INCREMENT,
    RoomType VARCHAR(50) NOT NULL,
    PricePerNight DECIMAL(10,2) NOT NULL,
    Status ENUM('Available', 'Booked', 'Maintenance') DEFAULT 'Available'
);

CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    GuestID INT,
    RoomID INT,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    Status ENUM('Confirmed', 'Cancelled', 'Checked-Out') DEFAULT 'Confirmed',
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    ReservationID INT,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentMethod ENUM('Credit Card', 'Debit Card', 'Cash') NOT NULL,
    FOREIGN KEY (ReservationID) REFERENCES Reservations(ReservationID)
);
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    GuestID INT,
    RoomID INT,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    Comment TEXT,
    ReviewDate DATE NOT NULL,
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL
);
CREATE TABLE MaintenanceRequests (
    RequestID INT PRIMARY KEY AUTO_INCREMENT,
    RoomID INT,
    RequestDate DATE NOT NULL,
    Status ENUM('Pending', 'In Progress', 'Completed') DEFAULT 'Pending',
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);  

CREATE TABLE Discounts (
    DiscountID INT PRIMARY KEY AUTO_INCREMENT,
    DiscountCode VARCHAR(50) UNIQUE NOT NULL,
    Percentage DECIMAL(5,2) CHECK (Percentage > 0 AND Percentage <= 100),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL
);
CREATE TABLE Amenities (
    AmenityID INT PRIMARY KEY AUTO_INCREMENT,
    AmenityName VARCHAR(50) NOT NULL,
    Description TEXT
);

CREATE TABLE RoomAmenities (
    RoomID INT,
    AmenityID INT,
    PRIMARY KEY (RoomID, AmenityID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    FOREIGN KEY (AmenityID) REFERENCES Amenities(AmenityID)
);

CREATE TABLE EventBookings (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    GuestID INT,
    EventDate DATE NOT NULL,
    NumberOfGuests INT NOT NULL,
    TotalAmount DECIMAL(10,2),
    Status ENUM('Confirmed', 'Cancelled') DEFAULT 'Confirmed',
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID)
);

CREATE TABLE EventFacilities (
    FacilityID INT PRIMARY KEY AUTO_INCREMENT,
    FacilityName VARCHAR(50) NOT NULL,
    Description TEXT
);

CREATE TABLE EventFacilityBookings (
    EventID INT,
    FacilityID INT,
    PRIMARY KEY (EventID, FacilityID),
    FOREIGN KEY (EventID) REFERENCES EventBookings(EventID),
    FOREIGN KEY (FacilityID) REFERENCES EventFacilities(FacilityID)
);

CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    GuestID INT,
    FeedbackDate DATE NOT NULL,
    Comments TEXT,
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID)
);

CREATE TABLE CustomerSupport (
    SupportID INT PRIMARY KEY AUTO_INCREMENT,
    GuestID INT,
    IssueDescription TEXT NOT NULL,
    ResolutionStatus ENUM('Open', 'In Progress', 'Resolved') DEFAULT 'Open',
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID)
);
CREATE TABLE CustomerSupportTickets (
    TicketID INT PRIMARY KEY AUTO_INCREMENT,
    SupportID INT,
    TicketDate DATE NOT NULL,
    FOREIGN KEY (SupportID) REFERENCES CustomerSupport(SupportID)
);
CREATE TABLE CustomerSupportResponses (
    ResponseID INT PRIMARY KEY AUTO_INCREMENT,
    TicketID INT,
    ResponseDate DATE NOT NULL,
    ResponseText TEXT NOT NULL,
    FOREIGN KEY (TicketID) REFERENCES CustomerSupportTickets(TicketID)
);
CREATE TABLE CustomerSupportFeedback (
    FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    TicketID INT,
    FeedbackDate DATE NOT NULL,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    Comments TEXT,
    FOREIGN KEY (TicketID) REFERENCES CustomerSupportTickets(TicketID)
);

-- Insert into Tables --

INSERT INTO Guests (FirstName, LastName, Email, PhoneNumber) VALUES
('Jake', 'keys', 'jake.keys@hotmail.com', '03556718788'),
('Jane', 'Ruffalo', 'jane.rufallo@hotmail.com', '0467824321'),
('Emmah', 'Stark', 'emmah.stark@yahoo.com', '0866894455');

INSERT INTO Rooms (RoomType, PricePerNight, Status) VALUES
('Deluxe', 120.00, 'Available'),
('Suite', 200.00, 'Booked'),
('Standard', 80.00, 'Maintenance');

INSERT INTO Reservations (GuestID, RoomID, CheckInDate, CheckOutDate, TotalAmount, Status) VALUES
(1, 1, '2025-05-10', '2025-05-12', 240.00, 'Confirmed'),
(2, 2, '2025-06-01', '2025-06-05', 800.00, 'Cancelled'),
(3, 3, '2025-04-15', '2025-04-18', 240.00, 'Checked-Out');

INSERT INTO Payments (ReservationID, Amount, PaymentDate, PaymentMethod) VALUES
(1, 240.00, '2025-05-10', 'Credit Card'),
(2, 800.00, '2025-06-01', 'Cash'),
(3, 240.00, '2025-04-15', 'Debit Card');

INSERT INTO Reviews (GuestID, RoomID, Rating, Comment, ReviewDate) VALUES
(1, 1, 5, 'Excellent service and cozy rooms!', '2025-05-12'),
(2, 2, 4, 'Very spacious, but expensive.', '2025-06-05'),
(3, 3, 3, 'Good for budget travelers.', '2025-04-18');

INSERT INTO Staff (FirstName, LastName, Position, Email, PhoneNumber) VALUES
('Michael', 'Smith', 'Manager', 'michael.smith@outlook.com', '1234598765'),
('Aria', 'James', 'Cleaner', 'ariajames@hotmail.com', '0672874883'),
('Sarah', 'Brown', 'Receptionist', 'sarah.brown@gmail.com', '9876543210');

INSERT INTO MaintenanceRequests (RoomID, RequestDate, Status) VALUES
(3, '2025-05-08', 'In Progress'),
(2, '2025-06-02', 'Pending'),
(1, '2025-04-16', 'Completed');

INSERT INTO Discounts (DiscountCode, Percentage, StartDate, EndDate) VALUES
('LUXURY251', 25.00, '2025-06-01', '2025-07-31'),
('VIP256', 10.00, '2025-01-01', '2025-12-31');

INSERT INTO Amenities (AmenityName, Description) VALUES
('Free Wi-Fi', 'High-speed internet for all guests.'),
('Swimming Pool', 'Luxury pool available for all guests.'),
('Gym Access', '24/7 fitness center.');

INSERT INTO RoomAmenities (RoomID, AmenityID) VALUES
(1, 3),
(2, 1),
(3, 2);

INSERT INTO Feedback (GuestID, FeedbackDate, Comments) VALUES
(1, '2025-05-12', 'Great experience overall.'),
(2, '2025-06-05', 'Would like better discounts.'),
(3, '2025-04-18', 'Satisfied with the service.');

INSERT INTO EventBookings (GuestID, EventDate, NumberOfGuests, TotalAmount, Status) VALUES
(1, '2025-06-15', 50, 5000.00, 'Confirmed'),
(2, '2025-07-10', 30, 3000.00, 'Cancelled'),
(3, '2025-08-05', 80, 8000.00, 'Confirmed');

INSERT INTO EventFacilities (FacilityName, Description) VALUES
('Conference Hall', 'Large hall for corporate events'),
('Banquet Hall', 'Spacious hall for celebrations'),
('Garden Venue', 'Outdoor venue for weddings and events');

INSERT INTO EventFacilityBookings (EventID, FacilityID) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO CustomerSupport (GuestID, IssueDescription, ResolutionStatus) VALUES
(1, 'Issue with event payment processing', 'Open'),
(2, 'Room service was delayed', 'In Progress'),
(3, 'Wi-Fi connectivity issues', 'Resolved');

INSERT INTO CustomerSupportTickets (SupportID, TicketDate) VALUES
(1, '2025-06-10'),
(2, '2025-07-12'),
(3, '2025-08-03');

INSERT INTO CustomerSupportResponses (TicketID, ResponseDate, ResponseText) VALUES
(1, '2025-06-11', 'Payment issue is being reviewed by the billing team.'),
(2, '2025-07-13', 'Apologies for the delay. Service will be improved.'),
(3, '2025-08-04', 'Wi-Fi network upgraded for better coverage.');

INSERT INTO CustomerSupportFeedback (TicketID, FeedbackDate, Rating, Comments) VALUES
(1, '2025-06-12', 4, 'Issue resolved quickly.'),
(2, '2025-07-14', 3, 'Staff was helpful but took time to respond.'),
(3, '2025-08-05', 5, 'Excellent resolution.');

ALTER TABLE Reservations
ADD CONSTRAINT fk_guest_reservation 
FOREIGN KEY (GuestID) REFERENCES Guests(GuestID) 
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Payments
ADD CONSTRAINT fk_reservation_payment 
FOREIGN KEY (ReservationID) REFERENCES Reservations(ReservationID) 
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE EventFacilityBookings 
ADD CONSTRAINT fk_event_facility 
FOREIGN KEY (FacilityID) REFERENCES EventFacilities(FacilityID);
ALTER TABLE Guests ADD COLUMN EncryptedEmail VARBINARY(255);

UPDATE Guests
SET EncryptedEmail = AES_ENCRYPT(Email, 'SecureKey123');

CREATE INDEX idx_guest_email ON Guests(Email);
CREATE INDEX idx_reservation_dates ON Reservations(CheckInDate, CheckOutDate);
CREATE INDEX idx_room_status ON Rooms(Status);
CREATE INDEX idx_payment_date ON Payments(PaymentDate);

CREATE PROCEDURE CalculateTotalAmount(IN resID INT)
BEGIN
  UPDATE Reservations
  SET TotalAmount = (SELECT PricePerNight * (DATEDIFF(CheckOutDate, CheckInDate)) 
                     FROM Rooms WHERE RoomID = (SELECT RoomID FROM Reservations WHERE ReservationID = resID))
  WHERE ReservationID = resID;
END;

CREATE PROCEDURE GetAvailableRooms(IN checkIn DATE, IN checkOut DATE)
BEGIN
  SELECT * FROM Rooms
  WHERE Status = 'Available' AND RoomID NOT IN 
  (SELECT RoomID FROM Reservations WHERE (CheckInDate < checkOut AND CheckOutDate > checkIn));
END;

CREATE USER 'hotel_admin'@'localhost' IDENTIFIED BY 'Hotel25';
GRANT ALL PRIVILEGES ON HotelBookingSystemsDB.* TO 'hotel_admin'@'localhost';

