--Function oluşturma
--Intelijde {} suslu parantez kullanirdik SQL(pgadmin4) ise $$ isareti kullanilir acma kapatma islemi icin 


--1. Örnek: İki parametre ile çalışıp 
--bu parametreleri toplayarak return yapan bir fonksiyon oluşturun.
--oluştur  dediği için create
create or replace function toplamaF(x NUMERIC, y NUMERIC)
returns NUMERIC
LANGUAGE plpgsql
AS
$$
BEGIN


RETURN x+y;


END
$$

SELECT * FROM toplamaF(15,25) AS toplam;



--2. Örnek: Koninin hacmini hesaplayan bir function yazın.

create or replace function koniHacmi(r NUMERIC, h NUMERIC)
returns NUMERIC
LANGUAGE plpgsql
AS
$$
BEGIN


RETURN 3.14*r*r*h/3;


END
$$

SELECT * FROM koniHacmi(3,5) AS hacim;
