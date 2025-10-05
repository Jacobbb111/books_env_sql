-- 1. Musteri tablosu
CREATE TABLE Musteri (
  id INT IDENTITY(1,1) PRIMARY KEY,
  ad NVARCHAR(50) NOT NULL CHECK(LEN(ad) >= 2),
  soyad NVARCHAR(50) NOT NULL CHECK(LEN(soyad) >= 2),
  email NVARCHAR(50) NOT NULL UNIQUE,
  sehir NVARCHAR(20) NOT NULL,
  kayit_tarihi DATE DEFAULT CAST(GETDATE() AS DATE)
);

-- 2. Kategori tablosu
CREATE TABLE Kategori (
  id INT IDENTITY(1,1) PRIMARY KEY,
  ad NVARCHAR(50) NOT NULL UNIQUE
);

-- 3. Satici tablosu
CREATE TABLE Satici (
  id INT IDENTITY(1,1) PRIMARY KEY,
  ad NVARCHAR(50) NOT NULL CHECK(LEN(ad) >= 2),
  adres NVARCHAR(50) NOT NULL
);

-- 4. Urun tablosu
CREATE TABLE Urun (
  id INT IDENTITY(1,1) PRIMARY KEY,
  ad NVARCHAR(50) NOT NULL UNIQUE,
  fiyat DECIMAL(10,2) NOT NULL CHECK(fiyat > 0),
  stok INT NOT NULL CHECK(stok >= 0),
  kategori_id INT NOT NULL FOREIGN KEY REFERENCES Kategori(id),
  satici_id INT NOT NULL FOREIGN KEY REFERENCES Satici(id)
);

-- 5. Siparis tablosu
CREATE TABLE Siparis (
  id INT IDENTITY(1,1) PRIMARY KEY,
  musteri_id INT NOT NULL FOREIGN KEY REFERENCES Musteri(id),
  tarih DATE DEFAULT CAST(GETDATE() AS DATE),
  toplam_tutar DECIMAL(10,2) NOT NULL CHECK(toplam_tutar >= 0),
  odeme_turu NVARCHAR(10) NOT NULL CHECK(odeme_turu IN ('Nakit', 'Kart', 'Havale'))
);

-- 6. Siparis_Detay tablosu
CREATE TABLE Siparis_Detay (
  id INT IDENTITY(1,1) PRIMARY KEY,
  siparis_id INT NOT NULL FOREIGN KEY REFERENCES Siparis(id),
  urun_id INT NOT NULL FOREIGN KEY REFERENCES Urun(id),
  adet INT NOT NULL CHECK(adet > 0),
  fiyat DECIMAL(10,2) NOT NULL CHECK(fiyat > 0)
);


INSERT INTO Musteri (ad, soyad, email, sehir) VALUES
('Ali', 'Y�lmaz', 'ali@example.com', 'Ankara'),
('Ay�e', 'Kaya', 'ayse@example.com', '�stanbul'),
('Mehmet', 'Demir', 'mehmet@example.com', '�zmir'),
('Fatma', '�elik', 'fatma@example.com', 'Bursa'),
('Can', 'Arslan', 'can@example.com', 'Antalya'),
('Zeynep', 'Ko�', 'zeynep@example.com', 'Eski�ehir'),
('Ahmet', '�ahin', 'ahmet@example.com', 'Konya'),
('Elif', 'Ayd�n', 'elif@example.com', 'Adana'),
('Burak', 'Y�ld�z', 'burak@example.com', 'Trabzon'),
('Seda', 'Kurt', 'seda@example.com', 'Kayseri'),
('Mert', 'Polat', 'mert@example.com', 'Samsun'),
('Hale', 'G�ne�', 'hale@example.com', 'Mersin'),
('Emre', 'Aksoy', 'emre@example.com', 'Diyarbak�r'),
('Buse', 'Erdo�an', 'buse@example.com', 'Van'),
('Deniz', 'Karaca', 'deniz@example.com', 'Gaziantep');

INSERT INTO Kategori (ad) VALUES
('Elektronik'),
('Kitap'),
('Ev E�yalar�');


INSERT INTO Satici (ad, adres) VALUES
('TeknoMarket', '�stanbul'),
('KitapEv', '�zmir'),
('EvDekor', 'Bursa');


INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('Laptop', 20000.00, 10, 1, 1),
('Telefon', 12000.00, 20, 1, 1),
('Tablet', 8000.00, 15, 1, 1),
('Roman Kitab�', 150.00, 50, 2, 2),
('Tarih Kitab�', 200.00, 30, 2, 2),
('Yast�k', 100.00, 40, 3, 3),
('Battaniye', 300.00, 25, 3, 3),
('�aydanl�k', 250.00, 35, 3, 3),
('Bluetooth Kulakl�k', 750.00, 60, 1, 1),
('Masa Lambas�', 400.00, 20, 3, 3);


-- Ali
INSERT INTO Siparis (musteri_id, toplam_tutar, odeme_turu)
VALUES (1, 20750.00, 'Kart');

-- Ay�e
INSERT INTO Siparis (musteri_id, toplam_tutar, odeme_turu)
VALUES (2, 950.00, 'Nakit');

-- Mehmet
INSERT INTO Siparis (musteri_id, toplam_tutar, odeme_turu)
VALUES (3, 16150.00, 'Havale');

-- Sipari�  Ali 
INSERT INTO Siparis_Detay (siparis_id, urun_id, adet, fiyat)
VALUES 
(1, 1, 1, 20000.00),
(1, 9, 1, 750.00);  

-- Sipari� Ay�e
INSERT INTO Siparis_Detay (siparis_id, urun_id, adet, fiyat)
VALUES 
(2, 4, 2, 150.00),
(2, 5, 1, 200.00),
(2, 6, 1, 100.00);

-- Sipari� Mehmet
INSERT INTO Siparis_Detay (siparis_id, urun_id, adet, fiyat)
VALUES 
(3, 2, 1, 12000.00),
(3, 3, 1, 8000.00);

--Stok Azaltma

UPDATE Urun SET stok = stok - 1 WHERE id = 1;
UPDATE Urun SET stok = stok - 1 WHERE id = 9;

UPDATE Urun SET stok = stok - 2 WHERE id = 4;  
UPDATE Urun SET stok = stok - 1 WHERE id = 5;
UPDATE Urun SET stok = stok - 1 WHERE id = 6;

UPDATE Urun SET stok = stok - 1 WHERE id = 2;
UPDATE Urun SET stok = stok - 1 WHERE id = 3;



DELETE FROM Urun WHERE stok = 0;

TRUNCATE TABLE Urun;

-- En �ok sipari� veren 5 m��teri.
select top 5 Musteri.id, Musteri.ad, Musteri.soyad, count(Siparis.id) as Siparis_Sayisi from Musteri 
join Siparis on Musteri.id = Siparis.musteri_id
group by Musteri.id, Musteri.ad, Musteri.soyad
order by Siparis_Sayisi desc;

-- En �ok sat�lan �r�nler.
select Urun.id, Urun.ad, sum(Siparis_Detay.adet) as Total_Satis
from Urun
join Siparis_Detay on Urun.id = Siparis_Detay.urun_id
group by Urun.id, Urun.ad
order by Total_Satis desc;

-- En y�ksek cirosu olan sat�c�lar.
select Satici.id, Satici.ad, sum(Siparis_Detay.adet * Siparis_Detay.fiyat) as Total_Ciro
from Satici
join Urun on Satici.id = Urun.satici_id
join Siparis_Detay on Siparis_Detay.urun_id = Urun.id
group by Satici.id, Satici.ad
order by Total_Ciro desc;

-- �ehirlere g�re m��teri say�s�.
select sehir, count(*) as M��teri_Sayisi
from Musteri
group by sehir
order by M��teri_Sayisi desc;

-- Kategori bazl� toplam sat��lar.
select Kategori.id,	Kategori.ad, sum(Siparis_Detay.adet * Siparis_Detay.fiyat) as Total_Sat��
from Kategori
join Urun on Urun.kategori_id = Kategori.id
join Siparis_Detay on Siparis_Detay.urun_id = Urun.id
group by Kategori.id, Kategori.ad
order by Total_Sat�� desc;

-- Aylara g�re sipari� say�s�.
select year(tarih) as YIL, month(tarih) as AY, count(*) as Sipari�_Say�s�
from Siparis
group by year(tarih), month(tarih)
order by YIL, AY;

-- Sipari�lerde m��teri bilgisi + �r�n bilgisi + sat�c� bilgisi.
select Siparis.id, Musteri.ad, Musteri.soyad, Urun.ad, Satici.ad
from Siparis
join Musteri on Musteri.id = Siparis.musteri_id
join Siparis_Detay on Siparis_Detay.siparis_id = Siparis.id
join Urun on Siparis_Detay.id = Urun.id
join Satici on Satici.id = Urun.satici_id;

-- Hi� sat�lmam�� �r�nler.
select Urun.id, Urun.ad
from Urun
left join Siparis_Detay on Urun.id = Siparis_Detay.urun_id
where Siparis_Detay.id is null;

-- Hi� sipari� vermemi� m��teriler.
select Musteri.id, Musteri.ad, Musteri.soyad
from Musteri
left join Siparis on Siparis.musteri_id = Musteri.id
where Siparis.id is null;
