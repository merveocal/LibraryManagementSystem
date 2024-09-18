-- Mevcut tablolar g�r�ntelemek i�in;
SELECT * FROM SYS.tables

-- dilini t�rk�e yapmak i�in kullan�l�r
set language turkish


-- Tablolar� olu�turuldu. �imdi JOIN i�lemi ile birle�tirerek bir sorgu yazaca��m

select P.ID, CONCAT(S.StudentName, ' ', S.StudentSurname) Name_surname, S.StudentNo, S.Gender,	S.Birthdate, S.Class, CONCAT(A.AuthorName, ' ', A.AuthorSurname) Authors, 
B.BookName, P.RegDate, P.EndDate, C.CategoryName, PB.Name_, B.PageCount_, B.ISBNno, PB.Address_
from STUDENTS S JOIN PROCESS P ON S.ID = P.StudentID
JOIN BOOKS B  ON B.ID = P.BookID 
JOIN AUTHORS A ON A.ID = P.BookID
JOIN PUBLISHING_HOUSE PB ON PB.ID = B.PblsHouseID
JOIN Category C ON C.ID = B.CategoryID




--Ben bir view ile bir tablo olu�turmu�tum. Daha sonra bu tabloyu kal�c� bir tablo haline getirmek i�in ManagementSystem2 ad�n� vererek bir tablo olu�turdum. B�ylece view kullanmadan ya da jo�n i�lemi yapmadan 
--select i�lemi ile tek seferde tabloyu �a��rabiliyorum

select * INTO ManagementSystem2 from VW_ManagementSystem

select * from ManagementSystem2


--NOT: Ben kal�c� tablo olu�turdum ama ge�ici tablo da olu�turulur
select *into #Gecici from ManagementSystem2

select * from #Gecici





 -- Kitap ad�na g�re, yazar�, yay�evini,t�r�n� ve  rafta ka� adet oldu�unu getiren stored procedure 'yi olu�tural�m
 CREATE procedure SPBOOKS
 @BookName as varchar(50)
 as
 BEGIN
	 select B.BookName, A.Name_Surname, PB.Name_, C.CategoryName, B.BookCount from BOOKS B JOIN AUTHORS A  ON B.AuthorID = A.ID 
	 JOIN PUBLISHING_HOUSE PB ON PB.ID  = B.PblsHouseID
	 JOIN Category C ON C.ID = B.CategoryID WHERE B.BookName = @BookName
 END


-- Stored Procedure'� �a��rma i�lemi
 EXEC SPBOOKS 'CEM�LE'






 --Stored Procedure i�e ��renci ad�na g�re ka� kitap ald���n� sorgusunu getirelim

 create proc SP_PROCESS
 @StudentName_surname as nvarchar(50)
 as
 select s.Name_Surname, count(S.ID) BookCount from PROCESS P JOIN STUDENTS S ON P.StudentID = S.ID
 WHERE s.Name_Surname = @StudentName_surname
 GROUP BY S.Name_Surname


 exec SP_PROCESS 'EDA ECE'



-- View olu�turma, viewler fiziksel verileri saklamaz onun yerine mevcut tablolardan sorgu yapmam�z� sa�layan bir yap�. A�a��da bir view olu�turun
create view VW_ManagementSystem
as 
select P.ID, CONCAT(S.StudentName, ' ', S.StudentSurname) Name_surname, S.StudentNo, S.Gender,	S.Birthdate, S.Class, CONCAT(A.AuthorName, ' ', A.AuthorSurname) Authors, 
B.BookName, P.RegDate, P.EndDate, C.CategoryName, PB.Name_, B.PageCount_, B.ISBNno, PB.Address_
from STUDENTS S JOIN PROCESS P ON S.ID = P.StudentID
JOIN BOOKS B  ON B.ID = P.BookID 
JOIN AUTHORS A ON A.ID = P.BookID
JOIN PUBLISHING_HOUSE PB ON PB.ID = B.PblsHouseID
JOIN Category C ON C.ID = B.CategoryID


--bir view nas�l �a�r�l�r
select * from VW_ManagementSystem




--��renci numaras�na g�re bilgileri getiren bir Inline table valued function olu�turaca��m.
create function dbo.StudentNo(@number as int)
returns table
as
return
Select * from VW_ManagementSystem where StudentNo = @number


--�nl�ne table values function nas�l �a�r�l�r
select * from  dbo.StudentNo(312)




		-- TRIGGER 'LARLA �LG�L� �RNEK SORGULAR

--Bir ��renci kitap ald���nda al�� tarihini  ve son teslim tarihini de 15 g�n ileri tarih vererek g�ncellesin.

create trigger ProcessDate
on PROCESS
AFTER INSERT
AS 
BEGIN
	UPDATE PROCESS SET RegDate = getdate() , 
	EndDate = dateadd(day, 15, getdate())
	where ID IN( SELECT ID FROM INSERTED)

END


--trigger '� �al��t�ral�m
select * from PROCESS

-- tarihleri girmedim otomatik kendi girecek
insert PROCESS values(39, 7, 2,NULL, NULL)

--KONTROL
select * from PROCESS order by ID DESC






--Trigger �rnek 2 => Burada Books tablosunu her veri ekledi�inde bana ekledi�im verinin ad�n�, raf tarihin, sayfa say�s�n� ve ka� adet olduklar�n� g�stersin g�ater
create trigger Current2
on BOOKS
AFTER INSERT
AS 
BEGIN
	DECLARE @ID  AS INT
	DECLARE @BookName as varchar(50)
	Declare @BookCount as int
	DECLARE @ShelDate as date
	DECLARE @PageCount_ as int


	select @BookName = BookName,@ShelDate = ShelfDate, @PageCount_ = PageCount_, @BookCount = BookCount from inserted

	select @BookName BookName, @ShelDate ShelfDate, @PageCount_ PageCount_ ,@BookCount BookCount
end

INSERT BOOKS VALUES(21, 'Kuyucakl� Yusuf',9, 1,5,300, '458-895-6325-65-4', getdate(), 1 )




-- Trigger �rnek 3 => ��lem her g�ncellendi�inde ya da silindi�inde ben o silinen ya da g�ncellenen i�lemi ba�ka bir tabloda tutma i�lemi yapaca��m

create trigger TRG_PROCESS_UP_DEL
ON PROCESS
AFTER UPDATE, DELETE
AS 
BEGIN

DECLARE @INSERTEDCOUNT AS INT
DECLARE @DELETEDCOUNT AS INT
	DECLARE @LOG_ACTIONTYPE AS VARCHAR(10)

SELECT @INSERTEDCOUNT = COUNT(*) FROM inserted
SELECT @DELETEDCOUNT  = COUNT(*) FROM deleted

IF @INSERTEDCOUNT >0 AND @DELETEDCOUNT>0
	SET @LOG_ACTIONTYPE = 'UPDATE'
IF @INSERTEDCOUNT= 0 AND @DELETEDCOUNT >0
	SET @LOG_ACTIONTYPE = 'DELETE'

	INSERT Process_Log(ID, StudentID, BookID, RegDate, EndDate, Log_ActionType,	Log_Date, Log_UserName, Log_HostName, Log_Programname )
	select ID, StudentID, BookID, RegDate, EndDate, @LOG_ACTIONTYPE, getdate(), SUSER_NAME(), HOST_NAME(), PROGRAM_NAME() from deleted

	
end

SELECT * FROM PROCESS
-- PROCESS tablosunda ID 'si 1 olan sat�r�n RegDate'ni de�i�tirece�im ve sonra gidip eski halini Process_Log dosyas�nda g�r�nt�leyce�im
--Eski Regdate:2024-12-23 
--Yeni Regdate: 2023-11-14 
update PROCESS set RegDate = '2023-11-14' where ID = 1


--buraya kay�d�n g�ncellemeden �nceki tarihi geldi
SELECT * FROM Process_Log

select * from Process_Log






-- �u an a�a��da sorgulama i�lemleri yapaca��m
SELECT * FROM VW_ManagementSystem

-- Hangi kategoriden toplam ka� tane var, bunu grup �eklinde getirece�im
select CategoryName ,count(*) Roman from VW_ManagementSystem group by CategoryName



-- sayfa say�s� en fazla olan kitap
select top 1* from VW_ManagementSystem order by  PageCount_ desc



-- Addresi �stanbul/Beylikd�z� de olan kitaplar� getirece�im
select BookName from VW_ManagementSystem where Address_ = '�stanbul/Beylikd�z�'



