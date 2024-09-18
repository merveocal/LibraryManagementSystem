-- Mevcut tablolar görüntelemek için;
SELECT * FROM SYS.tables

-- dilini türkçe yapmak için kullaniliyor
set language turkish


-- Tablolari olusturuldu. Simdi JOIN islemi ile birlestirerek bir sorgu yazacagım

select P.ID, CONCAT(S.StudentName, ' ', S.StudentSurname) Name_surname, S.StudentNo, S.Gender,	S.Birthdate, S.Class, CONCAT(A.AuthorName, ' ', A.AuthorSurname) Authors, 
B.BookName, P.RegDate, P.EndDate, C.CategoryName, PB.Name_, B.PageCount_, B.ISBNno, PB.Address_
from STUDENTS S JOIN PROCESS P ON S.ID = P.StudentID
JOIN BOOKS B  ON B.ID = P.BookID 
JOIN AUTHORS A ON A.ID = P.BookID
JOIN PUBLISHING_HOUSE PB ON PB.ID = B.PblsHouseID
JOIN Category C ON C.ID = B.CategoryID




--Ben bir view ile bir tablo oluşturmuştum. Daha sonra bu tabloyu kalici bir tablo haline getirmek için ManagementSystem2 adini vererek bir tablo olusturdum. Böylece view kullanmadan ya da join islemi yapmadan 
--select islemi ile tek seferde tabloyu cagırabiliyorum

select * INTO ManagementSystem2 from VW_ManagementSystem

select * from ManagementSystem2


--NOT: Ben kalici tablo olusturdum ama geçici tablo da olusturulur
select *into #Gecici from ManagementSystem2

select * from #Gecici





 -- Kitap adına göre, yazari, yayınevini,türünü ve  rafta kaç adet olduðunu getiren stored procedure 'yi olusturalim
 CREATE procedure SPBOOKS
 @BookName as varchar(50)
 as
 BEGIN
	 select B.BookName, A.Name_Surname, PB.Name_, C.CategoryName, B.BookCount from BOOKS B JOIN AUTHORS A  ON B.AuthorID = A.ID 
	 JOIN PUBLISHING_HOUSE PB ON PB.ID  = B.PblsHouseID
	 JOIN Category C ON C.ID = B.CategoryID WHERE B.BookName = @BookName
 END


-- Stored Procedure'ü cagırma islemi
 EXEC SPBOOKS 'CEMÝLE'






 --Stored Procedure ile ögrenci adına göre kaç kitap adığının sorgusunu getirelim

 create proc SP_PROCESS
 @StudentName_surname as nvarchar(50)
 as
 select s.Name_Surname, count(S.ID) BookCount from PROCESS P JOIN STUDENTS S ON P.StudentID = S.ID
 WHERE s.Name_Surname = @StudentName_surname
 GROUP BY S.Name_Surname


 exec SP_PROCESS 'EDA ECE'



-- Viewler fiziksel verileri saklamaz onun yerine mevcut tablolardan sorgu yapmamızı sağlayan bir yapı. aşağıda bir view oluşturun
create view VW_ManagementSystem
as 
select P.ID, CONCAT(S.StudentName, ' ', S.StudentSurname) Name_surname, S.StudentNo, S.Gender,	S.Birthdate, S.Class, CONCAT(A.AuthorName, ' ', A.AuthorSurname) Authors, 
B.BookName, P.RegDate, P.EndDate, C.CategoryName, PB.Name_, B.PageCount_, B.ISBNno, PB.Address_
from STUDENTS S JOIN PROCESS P ON S.ID = P.StudentID
JOIN BOOKS B  ON B.ID = P.BookID 
JOIN AUTHORS A ON A.ID = P.BookID
JOIN PUBLISHING_HOUSE PB ON PB.ID = B.PblsHouseID
JOIN Category C ON C.ID = B.CategoryID


--bir view nasıl çağrılır
select * from VW_ManagementSystem




--öðrenci numarasına göre bilgileri getiren bir Inline table valued function oluşturacağım.
create function dbo.StudentNo(@number as int)
returns table
as
return
Select * from VW_ManagementSystem where StudentNo = @number


--Inline table values function nasıl çağrılır
select * from  dbo.StudentNo(312)




		-- TRIGGER 'LARLA ÝLGÝLÝ ÖRNEK SORGULAR

--Bir öğrenci kitap aldığında alış tarihini  ve son teslim tarihini de 15 gün ileri tarih vererek güncellesin.

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






--Trigger örnek 2 => Burada Books tablosunu her veri eklediğinde bana eklediğim verinin adını, raf tarihin, sayfa sayısını ve kaç adet olduklarını göstersin
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

INSERT BOOKS VALUES(21, 'Kuyucaklı Yusuf',9, 1,5,300, '458-895-6325-65-4', getdate(), 1 )




-- Trigger örnek 3 => işlem her güncellendiðinde ya da silindiðinde ben o silinen ya da güncellenen işlemi başka bir tabloda tutma işlemi yapacağım
lemi
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






-- Hangi kategoriden toplam kaç tane var, bunu grup şeklinde getireceğim
select CategoryName ,count(*) Roman from VW_ManagementSystem group by CategoryName



-- sayfa sayısı en fazla olan kitap
select top 1* from VW_ManagementSystem order by  PageCount_ desc



-- Addresi İstanbul/Beylikdüzü de olan kitapları getireceğim
select BookName from VW_ManagementSystem where Address_ = 'Ýstanbul/Beylikdüzü'



