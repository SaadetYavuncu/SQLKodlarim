--SELECT - SIMILAR TO - REGEX(REGULAR EXPRESSİONS)--
/*
SIMILAR TO : Daha karmaşık pattern (kalıp) ile sorgulama işlemi için SIMILAR TO kullanılabilir.
Sadece PostgreSQL de kullanılır.Buyuk kucuk harf onemlidir.

REGEX : Herhangi bir kod, metin içerisinde istenen yazı veya kod parcasının aranıp bulunmasını sağlayan
kendine ait bir söz dizimi olan bir yapıdır.MySQL de (REGEXP_LİKE) olarak kullanılır
PostgreSQL 'de "-" karakteri ile kullanılır.

*/

CREATE TABLE kelimeler
(
id int,
kelime VARCHAR(50),
harf_sayisi int
);

INSERT INTO kelimeler VALUES (1001, 'hot', 3);
INSERT INTO kelimeler VALUES (1002, 'hat', 3);
INSERT INTO kelimeler VALUES (1003, 'hit', 3);
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
INSERT INTO kelimeler VALUES (1005, 'hct', 3);
INSERT INTO kelimeler VALUES (1006, 'adem', 4);
INSERT INTO kelimeler VALUES (1007, 'selim', 5);
INSERT INTO kelimeler VALUES (1008, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1009, 'hip', 3);
INSERT INTO kelimeler VALUES (1010, 'HOT', 3);
INSERT INTO kelimeler VALUES (1011, 'hOt', 3);
INSERT INTO kelimeler VALUES (1012, 'h9t', 3);
INSERT INTO kelimeler VALUES (1013, 'hoot', 4);
INSERT INTO kelimeler VALUES (1014, 'haaat', 5);
INSERT INTO kelimeler VALUES (1015, 'hooooot', 5);
INSERT INTO kelimeler VALUES (1016, 'booooot', 5);
INSERT INTO kelimeler VALUES (1017, 'bolooot', 5);

select * from kelimeler

--  İçerisinde 'ot' veya 'at' bulunan kelimeleri listeleyiniz
--Veya işlemi için | karakteri kullanılır
--SIMILAR TO ile
select * from kelimeler WHERE kelime SIMILAR TO '%(at|ot|Ot|oT|At|aT|OT)%';
--LİKE ile
select * from kelimeler WHERE kelime ILIKE '%at%' or kelime ILIKE '%ot&';
select * from kelimeler WHERE kelime ~~* '%at%' or kelime ~~* '%ot%';
--REGEX ile
select * from kelimeler WHERE kelime ~* 'ot' or kelime ~* 'at';

-- : 'ho' veya 'hi' ile başlayan kelimeleri listeleyeniz
--LİKE ile
select * from kelimeler WHERE kelime ~~* 'ho%' or kelime ~~* 'hi%';
--SIMILAR TO ile
select * from kelimeler WHERE kelime similar to 'ho%|hi%';
--REGEX ile
select * from kelimeler WHERE kelime ~* 'h[oi](.*)';
--Regex te . (nokta) bir karakteri temsil eder
--Regex te ikinci karakter için köşeli parantez kullanılır 

--Sonu 't' veya 'm' ile bitenleri listeleyeniz
--LİKE ile
select * from kelimeler WHERE kelime ~~* '%t' or kelime ~~* '%m';
--REGEX ile
select * from kelimeler WHERE kelime ~*'(.*)[tm]$';--$ karakteri bitişi gösterir
--SIMILAR TO ile
select * from kelimeler WHERE kelime similar to '%t|%m';

-- h ile başlayıp t ile biten 3 harfli kelimeleri listeleyeniz
--LİKE ile
select * from kelimeler WHERE kelime ~~*'h_t';
--SIMILAR TO ile
select * from kelimeler WHERE kelime similar to 'h[a-z,A-Z,0-9]t'; 
--REGEX ile
select * from kelimeler WHERE kelime ~*  '[h|H][a-z,A-Z,0-9][t|T]';
SELECT * from kelimeler where kelime ~* 'h(.)t$';

--İlk karakteri 'h', son karakteri 't' ve ikinci karakteri 'a'dan
--'e'ye herhangi bir karakter olan “kelime" değerlerini çağırın.
--SIMILAR TO ile
select * from kelimeler WHERE kelime similar to 'h[a-e](.*)%t';
--REGEX ile
SELECT * from kelimeler where kelime ~* 'h[a-e](.*)t';
--like ile
--select * from kelimeler WHERE kelime ~~* 'h%t' & kelime ~~* '_a-e%';

--İlk karakteri 's', 'a' veya 'y' olan "kelime" değerlerini çağırın.
select * from kelimeler WHERE kelime ~* '^[say](.*)';--^başlangıç ı temsil eder
select * from kelimeler where kelime similar to '[s,a,y]%';

--Son karakteri 'm', 'a' veya 'f' olan "kelime" değerlerini çağırın.
select * from kelimeler where kelime similar to '%m|%a|%f';
select * from kelimeler WHERE kelime ~*'[maf]$';
SELECT * FROM kelimeler WHERE kelime ~* '(.*)[maf]$';--. tek bir karakter * tümü hepsi demek

--İlk harfi h, son harfi t olup 2.harfi a veya i olan 3 harfli 
--kelimelerin tüm bilgilerini sorgulayalım.
--SIMILAR TO ile
select * from kelimeler where kelime similar to  'h[a|i]t';
--REGEX ile
select * from kelimeler where kelime ~* 'h[a|i]t$';

--İlk harfi 'b' dan ‘s' ye bir karakter olan ve ikinci harfi herhangi bir 
--karakter olup üçüncü harfi ‘l' olan “kelime" değerlerini çağırın.
select * from kelimeler where kelime ~* '^[b-s].l(.*)';
select*from kelimeler where kelime similar to '[b-s]_l%';

--içerisinde en az 2 adet o o barıdıran 
--kelimelerin tüm bilgilerini listeleyiniz.
select*from kelimeler where kelime similar to '%[o]{2}%';--süslü parantez içerisinde belirttiğimiz rakam bir önceki 
                                                          --köşeli parantez içerisindeki karakterin kaç tane oldugunu belirtir
select*from kelimeler where kelime similar to '%[o][o]%';
select * from kelimeler where kelime ~* '(.*)[o][o](.*)';

--içerisinde en az 4 adet oooo barıdıran kelimelerin tüm bilgilerini listeleyiniz.
select * from kelimeler where kelime ~* '(.*)[o][o][o][o](.*)';
select*from kelimeler where kelime similar to '%[o]{4}%';
select * from kelimeler where kelime ~* '(.*)[o]{4}(.*)';

--'a', 's' yada 'y' ile başlayan VE 'm' yada 'f' ile biten "kelime" değerlerini çağırın.
select*from kelimeler where kelime similar to '[a,s,y]%[m,f]';
select * from kelimeler where kelime ~* '^[a|s|y](.*)[m|f]$';
