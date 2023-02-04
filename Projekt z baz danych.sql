--Baza danych ma zawierać minimum 5 tabel połączonych ze sobą relacjami (jedna z tabel musi łączyć się z minimum dwoma innymi).
--Tabela ma zawierać minimum 5 kolumn w tym klucz główny i obcy. 
--Tabele mają zawierać instrukcję `CHECK` lub `DEFAULT`.
--Kolumny muszą być zarówno typu tekstowego, jak i liczbowego.
--Do tabeli dodaj minimum 2-3 rekordy.

--Utwórz zapytanie wyświetlające rekordy z minimum dwóch tabel.
-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--TWORZENIE NOWEJ BAZY DANYCH
CREATE DATABASE Przychodnia

-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
--TWORZENIE 5 TABEL

----Pierwsza tabela: Spis_uslug
CREATE TABLE Spis_uslug
(
	UslugaID int primary key identity(1,1),
	Kod_swiadczenia char(8) unique check (Kod_swiadczenia LIKE '[0-9][0-9][0-9][0-9].[0-9][0-9][0-9]'),
	Nazwa_rodzaju_swiadczenia nvarchar(50) default 'Podstawowa Opieka Zdrowotna',
	Nazwa_swiadczenia nvarchar(200) unique not null,
	Cena_NFZ float null,
	Cena_Komercyjna float null,
	Usluga2_do_proponowania_klientowi int foreign key references Spis_uslug(UslugaID)

)
----Dane dodane do tabeli
INSERT INTO Spis_uslug VALUES ('2010.112', DEFAULT, 'ŚWIADCZENIA LEKARZA POZ UDZIELANE W STANACH NAGŁYCH ZACHOROWAŃ', 80, null, null)
INSERT INTO Spis_uslug VALUES ('1041.009', DEFAULT, 'ŚWIADCZENIA PIELĘGNIARKI SZKOLNEJ', 50, null, null)
INSERT INTO Spis_uslug VALUES ('9999.999', 'Świadczenia kosmetologiczne', 'ZABIEGI PIELĘGNACYJNE', null, 150, null)
INSERT INTO Spis_uslug VALUES ('1000.700', 'Leczenie stomatologiczne', 'ŚWIADCZENIA OGÓLNOSTOMATOLOGICZNE', 100, 140, 3)
INSERT INTO Spis_uslug VALUES ('9999.998', 'Świadczenia kosmetologiczne', 'ZABIEGI WSPOMAGAJĄCE LECZENIE DERMATOLOGICZNE', null, 300, 3)
INSERT INTO Spis_uslug VALUES ('1220.563', 'Ambulatoryjna opieka specjalistyczna', 'ŚWIADCZENIA W ZAKRESIE DERMATOLOGII', 150, 250, 5)
INSERT INTO Spis_uslug VALUES ('1310.247', 'Rehabilitacja Lecznicza', 'FIZJOTERAPIA AMBULATORYJNA', 70, 120, 3)
INSERT INTO Spis_uslug VALUES ('0010.094', DEFAULT, 'ŚWIADCZENIA LEKARZA POZ', 30, null, 7)
INSERT INTO Spis_uslug VALUES ('3010.098', DEFAULT, 'ŚWIADCZENIA PIELĘGNIARKI POZ', 50, null, 4)


----Druga tabela: Spis_personelu
CREATE TABLE Spis_personelu
(
	PersonelID int primary key identity(1,1),
	Zawod varchar(20) check (Zawod IN ('LEKARZ', 'PIELĘGNIARKA', 'FIZJOTERAPEUTA', 'KOSMETOLOG')),
	Imie nvarchar(50) not null,
	Nazwisko nvarchar (50) not null,
	Pesel_personelu char(11) unique check (Pesel_personelu LIKE '[0-9][0-9][0-1][0-9][0-3][0-9][0-9][0-9][0-9][0-9][0-9]'),
	Kod_pocztowy char(6) default '42-610' check (Kod_pocztowy LIKE '[0-9][0-9]-[0-9][0-9][0-9]'),
	Miasto nvarchar(30) default 'Miasteczko Śląskie',
	Ulica nvarchar(50) not null,
	Telefon_komorkowy char(11) check (Telefon_komorkowy LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]') unique,
	PodstawoweSwiadczenie char(8) not null foreign key references Spis_uslug(Kod_swiadczenia)
)
----Dane dodane do tabeli
INSERT INTO Spis_personelu VALUES ('LEKARZ','Dariusz', 'Iksiński', '70050512335', '42-600', 'Tarnowskie Góry', 'Kopalniana 2', '111-456-789', '0010.094')
INSERT INTO Spis_personelu VALUES ('LEKARZ','Marek', 'Kapusta', '69050512335', DEFAULT, DEFAULT, 'Kopalna 52', '121-456-789', '0010.094')
INSERT INTO Spis_personelu VALUES ('LEKARZ','Katarzyna', 'Wierzba', '80050512345', '42-600', 'Tarnowskie Góry', 'Skowronków 15/1', '999-456-789', '0010.094')
INSERT INTO Spis_personelu VALUES ('LEKARZ','Izabela', 'Iksińska', '74050512345', '42-600', 'Tarnowskie Góry', 'Kopalniana 2', '112-456-789', '1000.700')
INSERT INTO Spis_personelu VALUES ('LEKARZ','Patryk', 'Kowalski', '84050512335', DEFAULT, DEFAULT, 'Kapryśna', '112-456-689', '1220.563')
INSERT INTO Spis_personelu VALUES ('PIELĘGNIARKA','Lucyna', 'Nowak', '80010112369', DEFAULT, DEFAULT, 'Orzechowa 2/3', '222-456-780', '3010.098')
INSERT INTO Spis_personelu VALUES ('PIELĘGNIARKA','Janina', 'Kapeć', '88110112369', DEFAULT, DEFAULT, 'Marcowa 5', '882-456-780', '3010.098')
INSERT INTO Spis_personelu VALUES ('PIELĘGNIARKA','Anna', 'Mazurek', '75020232165', DEFAULT, DEFAULT, 'Morska 1', '333-456-780', '1041.009')
INSERT INTO Spis_personelu VALUES ('FIZJOTERAPEUTA','Adam', 'Nowicki', '90121298755', DEFAULT, DEFAULT, 'Złota 5', '444-456-700', '1310.247')
INSERT INTO Spis_personelu VALUES ('KOSMETOLOG','Adrianna', 'Marcinkowska', '90101298765', DEFAULT, DEFAULT, 'Piękna 8', '555-456-700', '9999.999')


----Trzecia tabela: Spis_Klientow
CREATE TABLE Spis_Klientow
(
	KlientID int primary key identity(1,1),
	Imie nvarchar(50) not null,
	Nazwisko nvarchar (50) not null,
	Pesel_Klienta char(11) unique check (Pesel_Klienta LIKE '[0-9][0-9][0-3][0-9][0-3][0-9][0-9][0-9][0-9][0-9][0-9]'),
	Kod_pocztowy char(6) default '42-610' check (Kod_pocztowy LIKE '[0-9][0-9]-[0-9][0-9][0-9]'),
	Miasto nvarchar(30) default 'Miasteczko Śląskie',
	Ulica nvarchar(50) not null,
	Telefon_komorkowy char(11) check (Telefon_komorkowy LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]') unique,
	Lekarz_glowny int not null foreign key references Spis_personelu(PersonelID)
)
----Dane dodane do tabeli
INSERT INTO Spis_Klientow VALUES ('Justyna', 'Mazur', '14021836961', DEFAULT, DEFAULT, 'Kanarkowa 1', '123-456-789', 1)
INSERT INTO Spis_Klientow VALUES ('Adam', 'Mazur', '36012281471', DEFAULT, DEFAULT, 'Kanarkowa 1', '123-456-780', 3)
INSERT INTO Spis_Klientow VALUES ('Adam', 'Kowalski', '25110736911', '42-600', 'Tarnowskie Góry', 'Złota 5', '123-456-700', 1)
INSERT INTO Spis_Klientow VALUES ('Józef', 'Kowalski', '74100296311', '42-610', 'Tarnowskie Góry', 'Złota 9', '123-456-701', 2)
INSERT INTO Spis_Klientow VALUES ('Agnieszka', 'Nowacka', '45012378921', DEFAULT, DEFAULT, 'Kanarkowa 50', '223-456-701', 2)
INSERT INTO Spis_Klientow VALUES ('Denis', 'Nowacki', '15122378911', DEFAULT, DEFAULT, 'Kanarkowa 50', '223-456-123', 3)


----Czwarta tabela: Zrealizowane_uslugi
CREATE TABLE Zrealizowane_uslugi
(
	Zrealizowane_uslugi_ID int primary key identity(1,1),
	KlientID int not null foreign key references Spis_Klientow(KlientID),
	Typ_swiadczenia varchar(10) default 'NFZ' check (Typ_swiadczenia IN ('NFZ', 'KOMERCYJNE')),
	Kod_swiadczenia char(8) not null foreign key references Spis_uslug(Kod_swiadczenia),
	PersonelID int not null foreign key references Spis_personelu(PersonelID),
	Data_realizacji_od date,
	Data_realizacji_do date,
)
----Dane dodane do tabeli
INSERT INTO Zrealizowane_uslugi VALUES (1, DEFAULT, '0010.094', 1, '2022-10-02', '2022-10-02')
INSERT INTO Zrealizowane_uslugi VALUES (1, DEFAULT, '1310.247', 9, '2022-10-10', '2022-10-20')
INSERT INTO Zrealizowane_uslugi VALUES (1, 'KOMERCYJNE', '1310.247', 9, '2022-10-21', '2022-11-10')
INSERT INTO Zrealizowane_uslugi VALUES (2, DEFAULT, '0010.094', 2, '2022-12-01', '2022-12-01')
INSERT INTO Zrealizowane_uslugi VALUES (3, DEFAULT, '1000.700', 4, '2022-12-06','2022-12-06')
INSERT INTO Zrealizowane_uslugi VALUES (3, 'KOMERCYJNE', '1000.700', 4, '2022-12-06','2022-12-06')
INSERT INTO Zrealizowane_uslugi VALUES (4, DEFAULT, '0010.094', 1, '2022-12-01', '2022-10-01')
INSERT INTO Zrealizowane_uslugi VALUES (4, DEFAULT, '1220.563', 5, '2022-12-20', '2022-10-20')
INSERT INTO Zrealizowane_uslugi VALUES (4, DEFAULT, '1310.247', 9, '2022-12-25', '2023-01-10')
INSERT INTO Zrealizowane_uslugi VALUES (5, DEFAULT, '3010.098', 4, '2022-12-25', '2022-12-25')
INSERT INTO Zrealizowane_uslugi VALUES (6, DEFAULT, '1041.009', 8, '2023-01-02', '2023-01-02')
INSERT INTO Zrealizowane_uslugi VALUES (1, 'KOMERCYJNE', '9999.999', 10, '2023-01-02', '2023-01-02')
INSERT INTO Zrealizowane_uslugi VALUES (5, 'KOMERCYJNE', '9999.998', 10, '2023-01-05', '2023-01-05')


----Piąta tabela: Uslugi_oczekujace
CREATE TABLE Uslugi_oczekujace
(
	Uslugi_oczekujace_ID int primary key identity(1,1),
	KlientID int not null foreign key references Spis_Klientow(KlientID),
	Typ_swiadczenia varchar(10) default 'NFZ' check (Typ_swiadczenia IN ('NFZ', 'KOMERCYJNE')),
	Kod_swiadczenia char(8) not null foreign key references Spis_uslug(Kod_swiadczenia),
	PersonelID int not null foreign key references Spis_personelu(PersonelID),
	Data_zapisania_Klienta date,
)
----Dane dodane do tabeli
INSERT INTO Uslugi_oczekujace VALUES (1, DEFAULT, '1220.563', 3, '2022-12-27')
INSERT INTO Uslugi_oczekujace VALUES (1, DEFAULT, '1220.563', 3, '2022-12-30')
INSERT INTO Uslugi_oczekujace VALUES (1, 'KOMERCYJNE', '1000.700', 2, '2023-01-02')
INSERT INTO Uslugi_oczekujace VALUES (2, DEFAULT, '1310.247', 6, '2022-12-23')
INSERT INTO Uslugi_oczekujace VALUES (3, DEFAULT, '1310.247', 6, '2022-12-30')
INSERT INTO Uslugi_oczekujace VALUES (3, 'KOMERCYJNE', '1220.563', 3, '2023-01-02')
INSERT INTO Uslugi_oczekujace VALUES (5, 'KOMERCYJNE', '1000.700', 2, '2023-01-02')
INSERT INTO Uslugi_oczekujace VALUES (6, DEFAULT, '1000.700', 2, '2022-12-23')

---- Wyświetlanie utworzonych tabel.

SELECT * FROM Spis_uslug
SELECT * FROM Spis_personelu
SELECT * FROM Spis_Klientow
SELECT * FROM Zrealizowane_uslugi
SELECT * FROM Uslugi_oczekujace

----Zapytanie wyświetlające rekordy z minimum dwóch tabel.

SELECT sk.Imie,
	sk.Nazwisko,
	sk.Pesel_Klienta,
	su.Nazwa_swiadczenia,
	zu.Typ_swiadczenia,
	zu.Data_realizacji_od,
	zu.Data_realizacji_do
FROM Spis_Klientow sk
	INNER JOIN Zrealizowane_uslugi zu ON sk.KlientID = zu.KlientID
	INNER JOIN Spis_uslug su ON su.Kod_swiadczenia = zu.Kod_swiadczenia


