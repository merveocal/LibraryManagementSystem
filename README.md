# LibraryManagementSystem
SQL ile Kütüphane Yönetim Sistemini geliştirdim. İşlem, öğrenci, kitap, yazar, yayın evi, kategori tablolarını oluşturdum.Daha sonrasında da  tablolara veri ekledim. **Trigger, stored procedure, view ve Inline table valued function** oluşturdum ve çeşitli sorgular da yaptım. 

*Oluşturduğum kalıcı tablomu **Excel**'e aktardım ve onu da paylaştım inceleyebilirsiniz*

*Library Management System veri tabanımın **.bak** dosyasını da aldım onu da burada paylaştım. Management Studio 'ya yükleyip siz de üzerinde sorgular deneyebilirsiniz* 

# Veri tabanı kurulumu
İşlemleri gerçekleştirmek için **Library Management System** isimli bir veri tabanı oluşturdum

## Tablo oluşturma
Veri ekleme işlemlerini gerçekleştirmek için 6 adet tablo oluşturdum
- PROCESS
- STUDENTS
- AUTHORS
- BOOKS
- PUBLISHING_HOUSE
- CATEGORY

NOT: İsteğe bağlı olarak foreign key ve identity kullanabilirsiniz. Foreign key de kullandığınızda bağlantılı olan tablodan kolayca bir işlem silemeyebilirsiniz ona dikkat ediniz


## Oluşturduğum veri sorguları konularu aşağıdaki şekildedir;
-  Joın işlemi
-  JOIN işlemlerini bir **view** olarak oluşturdum
-  Kalıcı tablo işlemi
-  Kitap adına göre, yazaarı, yayınevini, türünü ve rafta kaç adet olduğunu getiren **Stored Procedure** oluşturma
-  Öğrenci adına göre, toplam kaç adet kitap aldığı soruguyu **Stored Procedure** ile getirme işlemi
-  öğrenci numarasına göre bilgileri getiren bir **Inline table valued function** oluşturma işlemi
-  Bir öğrenci kitap aldığında alış tarihi ve son teslim tarihi 15 gün ileri tarih olarak güncelleyen **trigger** işlemi
-  BOOKS tablosuna veri eklediğimde bana eklediğim kitap hakkında bilgi veren **trigger** yazma işlemi
-  PROCESS tablosundaki  her bir veriyi güncellediğimde veya sildiğimde bana o silinen tablonun eski verisini PROCESS_LOG dosyasında tutmasın sağlayan **rigger** işlemi
-  Hangi kategoriden toplam kaç adet tane var
-  Sayfa sayısı en fazla olan kitap
-  Adresi İstanbul/Beylikdüzü olan kitapları getirme işlemi
  
