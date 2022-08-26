--AGGREGATE METHOD KULLANIMI--
/*
Aggregate Methodları (SUM(Topla), COUNT(Say), MIN(En küçük deger), MAX (En büyük deger), AVG(ortalama))
-Subquery içinde de kullanılır
-Ancak sorgu tek bir değer döndürüyor olmalıdır
SYNTAX: sum() şeklinde olmalı sum() arasında boşluk olmamallı
*/
-- ALIAS (AS) --> Tabloda geçici isim vermek istersek koşuldan sonra AS sutun_isim olarak kullanılır.

select * from calisanlar2

--çalısanlar tablosundaki en yüksek maaş degerini listeleyiniz
select max(maas) from calisanlar2

--çalısanlar tablosundaki maasların toplamını listeleyiniz
select sum(maas) from calisanlar2

--çalısanlar tablosundaki maas ortalamalarını listeleyiniz
select avg(maas) from calisanlar2
select round(avg(maas)) from calisanlar2
select round(avg(maas),2) from calisanlar2

--çalısanlar tablosundaki en düşük  maasi listeleyiniz
select min(maas) from calisanlar2

--Calışanlar tablosundaki kaç kişinin maas aldığını listeleyiniz
select count(maas) from 

-- Her markanin ismini, calisan sayisini ve
--o markaya ait calisanlarin toplam maaşini listeleyiniz

select marka_isim,calisan_sayisi,(select sum(maas) from calisanlar2
where marka_isim=isyeri)AS toplam_maas from markalar


-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin 
--maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.

select marka_isim,calisan_sayisi,
(select max(maas) from calisanlar2 where marka_isim=isyeri)AS max_maas,
(select min(maas) from calisanlar2 where marka_isim=isyeri)AS min_maas
from markalar

--Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu 
--listeleyen bir SORGU yaziniz.Her markanin id’sini, ismini ve 
--toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
select marka_id,marka_isim,(select count(sehir) from calisanlar2 where marka_isim=isyeri)
AS sehir_sayisi from markalar

--Interview Question: En yüksek ikinci maas değerini çağırın.
select max(maas)AS enyuksek_ikinci_maas from calisanlar2
where maas<(select max(maas) from calisanlar2)

--Interview Question: En düşük ikinci maas değerini çağırın.
select min(maas) as en_dusuk_ikinci_maas from calisanlar2
where maas >(select min(maas) from calisanlar2)

--En yüksek 3.maas degerini bulunuz
select max(maas) as en_yuksek_ucuncu_maas from calisanlar2
where maas<(select max(maas) from calisanlar2 where maas<(select max(maas) from calisanlar2))

--ODEV en düşük üçüncü maas degerini bulunuz
select min(maas) as enDusukIkinciMaas from calisanlar2
where maas>(select min(maas) from calisanlar2 where maas>(select min(maas) from calisanlar2));


