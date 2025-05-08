--Library Management System
CREATE DATABASE LibraryDB;
USE LibraryDB;

--Table:Members
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15),
    MembershipDate DATE NOT NULL
);

--Table:Books
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Author VARCHAR(100),
    ISBN VARCHAR(20) UNIQUE,
    PublishedYear INT,
    Genre VARCHAR(50),
    CopiesAvailable INT NOT NULL
);

--Table:Staff
CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Role VARCHAR(50),
    HireDate DATE NOT NULL
);

--Table:BookLoans
CREATE TABLE BookLoans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    StaffID INT,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,

    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

--Table: Fines (1-to-1 with BookLoans)
CREATE TABLE Fines (
    FineID INT AUTO_INCREMENT PRIMARY KEY,
    LoanID INT UNIQUE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Paid BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (LoanID) REFERENCES BookLoans(LoanID)
);

--Table:BookGenres (Many-to-Many between Books and Genres)
CREATE TABLE Genres (
    GenreID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE BookGenre (
    BookID INT,
    GenreID INT,
    PRIMARY KEY (BookID, GenreID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);