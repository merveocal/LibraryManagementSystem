-- Mevcut tablolar görüntelemek için;
SELECT * FROM SYS.tables

-- dilini türkçe yapmak için kullanýlýr
set language turkish


-- Tablolarý oluþturuldu. Þimdi JOIN iþlemi ile birleþtirerek bir sorgu yazacaðým

select P.ID, CONCAT(S.StudentName, ' ', S.StudentSurname) Name_surname, S.StudentNo, S.Gender,	S.Birthdate, S.Class, CONCAT(A.AuthorName, ' ', A.AuthorSurname) Authors, 
B.BookName, P.RegDate, P.EndDate, C.CategoryName, PB.Name_, B.PageCount_, B.ISBNno, PB.Address_
from STUDENTS S JOIN PROCESS P ON S.ID = P.StudentID
JOIN BOOKS B  ON B.ID = P.BookID 
JOIN AUTHORS A ON A.ID = P.BookID
JOIN PUBLISHING_HOUSE PB ON PB.ID = B.PblsHouseID
JOIN Category C ON C.ID = B.CategoryID




--Ben bir view ile bir tablo oluþturmuþtum. Daha sonra bu tabloyu kalýcý bir tablo haline getirmek için ManagementSystem2 adýný vererek bir tablo oluþturdum. Böylece view kullanmadan ya da joýn iþlemi yapmadan 
--select iþlemi ile tek seferde tabloyu çaðýrabiliyorum

select * INTO ManagementSystem2 from VW_ManagementSystem

select * from ManagementSystem2


--NOT: Ben kalýcý tablo oluþturdum ama geçici tablo da oluþturulur
select *into #Gecici from ManagementSystem2

select * from #Gecici





 -- Kitap adýna göre, yazarý, yayýevini,türünü ve  rafta kaç adet olduðunu getiren stored procedure 'yi oluþturalým
 CREATE procedure SPBOOKS
 @BookName as varchar(50)
 as
 BEGIN
	 select B.BookName, A.Name_Surname, PB.Name_, C.CategoryName, B.BookCount from BOOKS B JOIN AUTHORS A  ON B.AuthorID = A.ID 
	 JOIN PUBLISHING_HOUSE PB ON PB.ID  = B.PblsHouseID
	 JOIN Category C ON C.ID = B.CategoryID WHERE B.BookName = @BookName
 END


-- Stored Procedure'ü Çaðýrma iþlemi
 EXEC SPBOOKS 'CEMÝLE'






 --Stored Procedure iþe öðrenci adýna göre kaç kitap aldýðýný sorgusunu getirelim

 create proc SP_PROCESS
 @StudentName_surname as nvarchar(50)
 as
 select s.Name_Surname, count(S.ID) BookCount from PROCESS P JOIN STUDENTS S ON P.StudentID = S.ID
 WHERE s.Name_Surname = @StudentName_surname
 GROUP BY S.Name_Surname


 exec SP_PROCESS 'EDA ECE'



-- View oluþturma, viewler fiziksel verileri saklamaz onun yerine mevcut tablolardan sorgu yapmamýzý saðlayan bir yapý. Aþaðýda bir view oluþturun
create view VW_ManagementSystem
as 
select P.ID, CONCAT(S.StudentName, ' ', S.StudentSurname) Name_surname, S.StudentNo, S.Gender,	S.Birthdate, S.Class, CONCAT(A.AuthorName, ' ', A.AuthorSurname) Authors, 
B.BookName, P.RegDate, P.EndDate, C.CategoryName, PB.Name_, B.PageCount_, B.ISBNno, PB.Address_
from STUDENTS S JOIN PROCESS P ON S.ID = P.StudentID
JOIN BOOKS B  ON B.ID = P.BookID 
JOIN AUTHORS A ON A.ID = P.BookID
JOIN PUBLISHING_HOUSE PB ON PB.ID = B.PblsHouseID
JOIN Category C ON C.ID = B.CategoryID


--bir view nasýl çaðrýlýr
select * from VW_ManagementSystem




--öðrenci numarasýna göre bilgileri getiren bir Inline table valued function oluþturacaðým.
create function dbo.StudentNo(@number as int)
returns table
as
return
Select * from VW_ManagementSystem where StudentNo = @number


--ýnlýne table values function nasýl çaðrýlýr
select * from  dbo.StudentNo(312)




		-- TRIGGER 'LARLA ÝLGÝLÝ ÖRNEK SORGULAR

--Bir öðrenci kitap aldýðýnda alýþ tarihini  ve son teslim tarihini de 15 gün ileri tarih vererek güncellesin.

create trigger ProcessDate
on PROCESS
AFTER INSERT
AS 
BEGIN
	UPDATE PROCESS SET RegDate = getdate() , 
	EndDate = dateadd(day, 15, getdate())
	where ID IN( SELECT ID FROM INSERTED)

END


--trigger 'ý çalýþtýralým
select * from PROCESS

-- tarihleri girmedim otomatik kendi girecek
insert PROCESS values(39, 7, 2,NULL, NULL)

--KONTROL
select * from PROCESS order by ID DESC






--Trigger örnek 2 => Burada Books tablosunu her veri eklediðinde bana eklediðim verinin adýný, raf tarihin, sayfa sayýsýný ve kaç adet olduklarýný göstersin göater
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

INSERT BOOKS VALUES(21, 'Kuyucaklý Yusuf',9, 1,5,300, '458-895-6325-65-4', getdate(), 1 )




-- Trigger örnek 3 => Ýþlem her güncellendiðinde ya da silindiðinde ben o silinen ya da güncellenen iþlemi baþka bir tabloda tutma iþlemi yapacaðým

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
-- PROCESS tablosunda ID 'si 1 olan satýrýn RegDate'ni deðiþtireceðim ve sonra gidip eski halini Process_Log dosyasýnda görüntüleyceðim
--Eski Regdate:2024-12-23 
--Yeni Regdate: 2023-11-14 
update PROCESS set RegDate = '2023-11-14' where ID = 1


--buraya kayýdýn güncellemeden önceki tarihi geldi
SELECT * FROM Process_Log

select * from Process_Log






-- Þu an aþaðýda sorgulama iþlemleri yapacaðým
SELECT * FROM VW_ManagementSystem

-- Hangi kategoriden toplam kaç tane var, bunu grup þeklinde getireceðim
select CategoryName ,count(*) Roman from VW_ManagementSystem group by CategoryName



-- sayfa sayýsý en fazla olan kitap
select top 1* from VW_ManagementSystem order by  PageCount_ desc



-- Addresi Ýstanbul/Beylikdüzü de olan kitaplarý getireceðim
select BookName from VW_ManagementSystem where Address_ = 'Ýstanbul/Beylikdüzü'



