CREATE DATABASE LibraryManagementSystem2


use LibraryManagementSystem2

-- NOT: Tablolaru oluştururken IDENTTIY kullanmak istemedim ama siz kullanabilirsiniz.,
--Ayrıca trigger oluştururken bazı işlemlerde foreign keyden dolayı işlem çalışamıyor olabiliyor onu da isteğe bağlı oluşturabilirsiniz


--STUDENTS tablosu oluşturma
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


--AUTHORS tablosu oluşturma
create table AUTHORS
(
	ID INT PRIMARY KEY,
	AuthorName nvarchar(25),
	AuthorSurname nvarchar(25),
	Name_Surname nvarchar(50)
)


-- Category tablosu oluşturma
Create table Category 
(
	ID INT PRIMARY KEY,
	CategoryName nvarchar(15)
)


--PUBLISHING_HOUSE tablosunu oluşturma
Create table PUBLISHING_HOUSE
(
	ID INT PRIMARY KEY,
	Name_ nvarchar(15),
	Address_ nvarchar(15)
)




-- BOOKS tablosunu oluşturma
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



-- PROCESS tablosunu oluşturma
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


-- Bu tabloyu trigger işlemlerinde kullanmak için oluşturacağım
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
