CREATE DATABASE LibraryManagementSystem2


use LibraryManagementSystem2

-- NOT: Tablolar� olu�tururken IDENTTIY kullanmak istemedim ama siz kullanabilirsiniz.,
--Ayr�ca trigger olu�tururken baz� i�lemlerde foreign keyden dolayo i�lem �al��am�yor olabiliyor onu da iste�e ba�l� olu�turabilirsiniz


--STUDENTS tablosu olu�turma
create table STUDENTS
(	
	ID INT PRIMARY KEY,
	StudentNo INT,
	StudentName nvarchar(25),
	StudentSurname nvarchar(25),
	Name_Surname nvarchar (50),
	Gender nvarchar(10),
	Birthdate date,
	Class int
)


--AUTHORS tablosu olu�turun
create table AUTHORS
(
	ID INT PRIMARY KEY,
	AuthorName nvarchar(25),
	AuthorSurname nvarchar(25),
	Name_Surname nvarchar(50)
)


-- Category tablosunu olu�turun
Create table Category 
(
	ID INT PRIMARY KEY,
	CategoryName nvarchar(15)
)


--PUBLISHING_HOUSE tablosunu olu�turun
Create table PUBLISHING_HOUSE
(
	ID INT PRIMARY KEY,
	Name_ nvarchar(15),
	Address_ nvarchar(15)
)




-- BOOKS tablosunu olu�turun
Create table BOOKS
(
	ID INT PRIMARY KEY,
	BookName nvarchar(50),
	AuthorID INT,
	CategoryID INT,
	PblsHouseID INT,
	PageCount_ INT,
	ISBNno nvarchar(13),
	ShelfDate date,
	BookCount int
	FOREIGN KEY (AuthorID) REFERENCES AUTHORS(ID),
	FOREIGN KEY (CategoryID) REFERENCES Category(ID),
	FOREIGN KEY (PblsHouseID) REFERENCES PUBLISHING_HOUSE(ID)
)



-- PROCESS tablosunu olu�turun
create table PROCESS
(
	ID INT PRIMARY KEY,
	StudentID INT,
	BookID INT,
	RegDate DATE,
	EndDate DATE
	FOREIGN KEY (StudentID) REFERENCES STUDENTS(ID),
	FOREIGN KEY (BookID) REFERENCES BOOKS(ID)
)


-- Bu tabloyu trigger i�lemlerinde kullanmak i�in olu�turaca��m
create table Process_Log
(
	ID INT, 
	StudentID INT,
	BookID INT,
	RegDate date,
	EndDate date,
	Log_ActionType nvarchar(20),
	Log_Date date, 
	Log_UserName nvarchar(50),
	Log_HostName nvarchar(50),
	Log_Programname nvarchar(50)
)