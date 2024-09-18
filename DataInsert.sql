INSERT STUDENTS(ID, StudentNo, StudentName, StudentSurname,Name_Surname ,Gender, Birthdate, Class)
VALUES(1, 312, 'Eda', 'Ece','Eda Ece', 'Kadýn', '01.01.2005', 1),
	(2,313,'Merve', 'Akay', 'Merve Akay', 'Kadýn', '02.05.2001',3),
	(3,610, 'Kerem', 'Bilgin','Kerem Bilgin', 'Erkek', '05.27.1999',4),
	(4, 571, 'Ali', 'Bulut','Ali Bulut', 'Erkek', '12.11.1998', 2),
	(5,210, 'Þahin', 'Kaya','Þahin Kaya', 'Erkek', '06.08.2002',3),
	(6,245, 'Elif', 'Þener', 'Eif Þener', 'Kadýn', '12.10.2005',1),
	(7, 890, 'Nevzat', 'Kasap','Nevzat Kasap',  'Erkek', '12.06.2001',3),
	(8, 110, 'Mehmet', 'Güneþ','Mehmet Güneþ', 'Erkek', '09.07.1997',4),
	(9, 364, 'Buse', 'Kara', 'Buse Kara', 'Kadýn', '01.12.2000',2),
	(10, 152,'Seher', 'Okan','Seher Okan', 'Kadýn','11.02.2004', 1),
	(11,745,'Ýbrahim', 'Ay', 'Ýbrahim Ay',  'Erkek', '05.08.2006',1),
	(12, 126,'Hatice', 'Matar','Hatice Matar', 'Kadýn', '03.03.2001',3),
	(13,652,'Ayþe', 'Mercimek', 'Ayþe Mercimek', 'Kadýn', '09.23.2004',4),
	(14, 287,'Ezgi', 'Yýldýrým','Ezgi Yýldýrým',  'Kadýn', '07.04.2003',2),
	(15, 368,'Beyza', 'Turan', 'Beyza Turan','Kadýn', '01.02.2001',4),
	(16,749,'Zeynep', 'Kolon', 'Zeynep Kolon', 'Kadýn', '05.24.1999',2),
	(17, 520, 'Muratcan', 'Keser', 'Muratcan Keser', 'Erkek', '07.08.2001',3),
	(18, 312, 'Kaðan', 'Þeker', 'Kaðan Þeker', 'Erkek', '03.08.2002',2),
	(19,289, 'Onur', 'Budak', 'Onur Budak', 'Erkek', '08.25.2005',1),
	(20, 821,'Emre', 'Boran','Emre Boran', 'Erkek', '01.10.2004',3)




INSERT AUTHORS(ID, AuthorName, AuthorSurname)
VALUES(1, 'Yaþar', 'Kemal' ),
		(2, 'Oðuz', 'Atay'),
		(3,'Ahmet Hamdi', 'Tanpýnar'),
		(4,'Orhan', 'Pamuk'),
		(5,'Orhan', 'Kemal'),
		(6, 'Elif', 'Þafak'),
		(7, 'Franz', 'Kafka'),
		(8, 'Zülfü', 'Livaneli'),
		(9, 'Sabahattin', 'Ali'),
		(10,'Memduh Þevket', 'Esendal'),
		(11, 'Vedat', 'Türkeli'), 
		(12,'Fuat', 'Sezgin'),
		(13, 'Bilge', 'Karasu'),
		(14,'Fyodor', 'Dostoyevski'),
		(15,'Peyami', 'Safa'),
		(16,'Fakir', 'Baykurt'),
		(17, 'Atilla', 'Ýlhan'),
		(18,'Ömer', 'Seyfettin'),
		(19, 'Falih Rýfký', 'Atay'),
		(20, 'Yakup Kadri','Karaosmanoðlu')


-- uzun uzun yazmak yerine tek seferde isimleri aþaðýdki þekilde birleþtirebilirsiniz
update AUTHORS SET Name_Surname = AuthorName + ' ' +AuthorSurname




INSERT PUBLISHING_HOUSE(ID, Name_,Address_)
values(1, 'Can','Ýstanbul/Beylikdüzü'),
		(2,'Melek', 'Bursa/Osmangazi'),
		(3, 'Kýrmýzý', 'Ankara/Çankaya'),
		(4,'Sarý Kedi', 'Hatay/Antakya'),
		(5, 'Mor Menekþe','Ýstanbul/Kadýköy')


-- hata alýrsanýz veri tipinin boyutunu büyütünüz
ALTER TABLE PUBLISHING_HOUSE
ALTER COLUMN Address_ NVARCHAR(100)




--Category tablosuna veri ekleme iþlemi
Insert Category(ID, CategoryName)
values(1, 'Roman'),
	(2,'Hikaye'),
	(3, 'Þiir'),
	(4,'Aný')




-- BOOKS tablsouna veri ekleme iþlemi
Insert BOOKS(ID, BookName, AuthorID, CategoryID, PblsHouseID, PageCount_, ISBNno, ShelfDate, BookCount )
values(1, 'Ýnce Memed', 1,1, 1,270, '995-895-2315-89-1', '2017-02-06',8),
		(2, 'Tutunamayanlar',2, 1, 4, 250, '456-987-2586-32-4', '2016-09-13',7),
		(3, 'Saatleri Ayarlama Enstitüsü', 3,1, 5,420, '254-568-456-1458', '2018-08-25',5),
		(4, 'Benim Adým Kýrmýzý', 4, 1, 4, 654, '1513-658-652-23-2', '2018-10-07',10),
		(5, 'Cemile',5, 1, 3, 250, '789-258-3651-12-1', '2019-03-01',14),
		(6,'Aþk', 6, 1,2, 475, '158-357-8965-4', '2019-01-04' ,2),
		(7, 'Dönüþüm',7,2, 1, 110, '147-987-2585-651', '2019-08-30',6),
		(8, 'Son Ada', 8, 1,4, 225, '789-245-8741-65-8','2018-11-17',4),
		(9, 'Ýçimizdeki Þeytan', 9,1,5,368,'159-358-1258-95-0','2017-02-21',3),
		(10,'Ayaþlý ve Kiracýlarý', 10,1,1,372, '7894-568-258-02-7','2018-10-25',11),
		(11,  'Bir Gün Tek Baþýna', 11, 1, 3, 685, '458-213-4689-96-6','2020-03-08',12),
		(12, 'Bilim Tarihi Sohbetleri', 12, 1, 5, 300, '458-258-6541-25-7', '2020-07-07',8),
		(13, 'Gece', 13, 1, 2, 250,'452-896-158-5850','2022-03-09',9),
		(14, 'Suç ve Ceza', 14,1,4,680, '128-654-2596-91-7', '2023-07-08',5),
		(15, 'Dokuzuncu Hariciye Koðuþu', 15, 1,3, 180, '158-684-4785-05-9', '2020-01-14',6),
		(16, 'Yýlanlarýn Öcü' , 16,1,1, 320, '7895-456-255-23-4','2018-02-18',1),
		(17,'Elde Var Hüzün', 17, 3,4, 130 , '789-658-2586-65-8','2019-03-26',2),
		(18, 'Falaka', 18, 2, 2, 90, '789-258-6584-56-1', '2021-04-09',5),
		(19, 'Çankaya', 19, 4,5, 686, '452-758-6589-4', '2017-05-17',7),
		(20,'Yaban', 20, 1,2, 246, '789-146-3254-78-5', '2016-12-24',9)



select * from BOOKS
-- Eðer ISBN no da hata aldýysanýz kullandýðýný veri boyutunu büyütebilirsiniz. 
ALTER TABLE BOOKS
ALTER COLUMN ISBNno NVARCHAR(50)




-- PROCESS tablosuna veri ekleme iþlemi
INSERT PROCESS(ID, StudentID, BookID, RegDate, EndDate)
VALUES	(1, 1,1,'2024-12-23' ,'2025-01-07'),
		(2,2, 2 , '2023-11-12', '2023-11-27'),
		(3,3,3, '2022-05-02', '2022-05-17'),
		(4,4,4, '2023-09-04', '2023-09-19'),
		(5, 5, 6, '2024-05-06','2024-05-21'),
		(6,6,8, '2025-01-03', '2024-01-18'),
		(7,7,12, '2019-04-06','2019-04-21'),
		(8,10, 15, '2023-08-29', '2023-09-13'),
		(9,19, 13, '2024-06-07', '2024-06-22'),
		(10,20, 11, '2023-04-01', '2023-04-16'),
		(11, 8, 18, '2024-09-17', '2024-10-02'),
		(12,9, 17, '2024-02-16', '2024-03-03'),
		(13, 13, 14, '2024-11-13','2024-11-28' ),
		(14, 16, 19, '2020-10-01','2021-10-16'),
		(15,11, 20, '2024-09-25','2024-10-10' ),
		(16, 12, 16, '2021-06-18', '2021-07-03'),
		(17, 14, 10, '2022-05-13', '2022-05-28'),
		(18, 15, 5, '2023-04-27', '2023-05-12'),
		(19,17, 7, '2020-02-05','2020-02-20'),
		(20, 18, 9, '2023-08-04', '2023-08-1')



-- biraz daha veri ekleyelim
INSERT PROCESS VALUES(22,1,3, '2024-02-03', '2024-02-18'),
					(23, 1,5,'2024-02-04', '2024-02-19'),
					(24,1,6,'2024-01-06','2024-01-21'),
					(25,1,8,'2024-04-06','2024-04-21'),
					(26, 3,7,'2023-01-02', '2023-01-17'),
					(27,3,11,'2023-01-04','2023-01-19'),
					(28,3,18,'2023-05-11','2023-05-26'),
					(29,5,19, '2024-10-08', '2024-10-23'),
					(30,5,14, '2024-10-09','2024-10-24'),
					(31,8,9, '2023-06-04', '2023-06-19'),
					(32,8,12,'2023-07-01','2023-07-16'),
					(33,8,16, '2023-07-05', '2023-07-20'),
					(34,8,1,'2023-07-10','2023-07-25'),
					(35,11,3,'2024-11-02','2024-11-17'),
					(36,11,13,'2024-12-02', '2024-12-17'),
					(37,19,4,'2022-02-08','2022-02-23'),
					(38, 17,5,'2023-12-03', '2023-12-18')