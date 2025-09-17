DROP TABLE bookss;





CREATE TABLE bookss (
book_id int primary key,
title text not null,
author text not null,
genre text,
price decimal (6,2) check (price>0),
stock int check (stock>=0),
published_year INT CHECK (published_year BETWEEN 1700 AND 2025),
added_at DATE
);
INSERT INTO bookss (book_id, title, author, genre, price, stock, published_year, added_at) VALUES
(1, 'Kayıp Zamanın İzinde', 'M. Proust', 'roman', 129.90, 25, 1913, '2025-08-20'),
(2, 'Simyacı', 'P. Coelho', 'roman', 89.50, 40, 1988, '2025-08-21'),
(3, 'Sapiens', 'Y. N. Harari', 'tarih', 159.00, 18, 2011, '2025-08-25'),
(4, 'İnce Memed', 'Y. Kemal', 'roman', 99.90, 12, 1955, '2025-08-22'),
(5, 'Körlük', 'J. Saramago', 'roman', 119.00, 7, 1995, '2025-08-28'),
(6, 'Dune', 'F. Herbert', 'bilim', 149.00, 30, 1965, '2025-09-01'),
(7, 'Hayvan Çiftliği', 'G. Orwell', 'roman', 79.90, 55, 1945, '2025-08-23'),
(8, '1984', 'G. Orwell', 'roman', 99.00, 35, 1949, '2025-08-24'),
(9, 'Nutuk', 'M. K. Atatürk', 'tarih', 139.00, 20, 1927, '2025-08-27'),
(10, 'Küçük Prens', 'A. de Saint-Exupéry', 'çocuk', 69.90, 80, 1943, '2025-08-26'),
(11, 'Başlangıç', 'D. Brown', 'roman', 109.00, 22, 2017, '2025-09-02'),
(12, 'Atomik Alışkanlıklar', 'J. Clear', 'kişisel gelişim', 129.00, 28, 2018, '2025-09-03'),
(13, 'Zamanın Kısa Tarihi', 'S. Hawking', 'bilim', 119.50, 16, 1988, '2025-08-29'),
(14, 'Şeker Portakalı', 'J. M. de Vasconcelos', 'roman', 84.90, 45, 1968, '2025-08-30'),
(15, 'Bir İdam Mahkûmunun Son Günü', 'V. Hugo', 'roman', 74.90, 26, 1829, '2025-08-31');


--1.	1. Tüm kitapların title, author, price alanlarını fiyatı artan şekilde sıralayarak listeleyin.
SELECT title, author, price FROM bookss ORDER BY price ASC;
--2.	2. Türü 'roman' olan kitapları A→Z title sırasıyla gösterin
SELECT *FROM bookss WHERE genre = 'roman' ORDER BY title ASC;
--3.	3. Fiyatı 80 ile 120 (dahil) arasındaki kitapları listeleyin (BETWEEN).
SELECT * FROM bookss WHERE price BETWEEN 80 AND 120;
--4.	4. Stok adedi 20’den az olan kitapları bulun (title, stock_qty).
SELECT title,stock FROM bookss WHERE stock < 20;
--5.	5. title içinde 'zaman' geçen kitapları LIKE ile filtreleyin (büyük/küçük harf durumunu not edin).
SELECT * FROM bookss WHERE title LIKE '%zaman%';
--6.	6. genre değeri 'roman' veya 'bilim' olanları IN ile listeleyin.
SELECT * FROM bookss WHERE genre IN ('roman', 'bilim');
--7.	7. published_year değeri 2000 ve sonrası olan kitapları, en yeni yıldan eskiye doğru sıralayın.
SELECT * FROM bookss WHERE published_year >= 2000 ORDER BY published_year DESC;
--8.	8. Son 10 gün içinde eklenen kitapları bulun (added_at tarihine göre).
SELECT * FROM bookss WHERE added_at >='04.09.2025';
--9.	9. En pahalı 5 kitabı price azalan sırada listeleyin (LIMIT 5).
--SELECT * FROM bookss ORDER BY price DESC top 5;  --limit olmadı top kullanıldı.
SELECT TOP 5 * FROM bookss ORDER BY price DESC;

--10.	10. Stok adedi 30 ile 60 arasında olan kitapları price artan şekilde sıralayın.
SELECT * FROM bookss WHERE stock BETWEEN 30 AND 60 ORDER BY price ASC;












