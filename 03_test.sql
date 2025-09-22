-- =========================================================================
/*
	Plik do zadania 4 i 5: 03_test.sql
	Tytuł: Skrypt instrukcji DML dla danych tstowych.
	Data: 2025-08-31

*/
-- =========================================================================



INSERT INTO Regiony (id_region, nazwa) VALUES (1, 'Mazowsze');
INSERT INTO Regiony (id_region, nazwa) VALUES (2, 'Wielkopolska');
INSERT INTO Regiony (id_region, nazwa) VALUES (3, 'Małopolska');
INSERT INTO Regiony (id_region, nazwa) VALUES (4, 'Dolnoląskie');
INSERT INTO Regiony (id_region, nazwa) VALUES (5, 'Pomorskie');
INSERT INTO Regiony (id_region, nazwa) VALUES (6, 'Łódzkie');
INSERT INTO Regiony (id_region, nazwa) VALUES (7, 'Zachodniopomorskie');
INSERT INTO Regiony (id_region, nazwa) VALUES (8, 'Lubeskie');
INSERT INTO Regiony (id_region, nazwa) VALUES (9, 'Śląsk');
INSERT INTO Regiony (id_region, nazwa) VALUES (10,'Kujawsko-Pomorskie');

INSERT INTO Pracownicy (id_pracownika, imie, nazwisko, id_region) VALUES (1, 'Jan', 'Kowalski', 1);
INSERT INTO Pracownicy (id_pracownika, imie, nazwisko, id_region) VALUES (2, 'Anna', 'Nowak', 2);
INSERT INTO Pracownicy (id_pracownika, imie, nazwisko, id_region) VALUES (3, 'Piotr', 'Zieliński', 3);
INSERT INTO Pracownicy (id_pracownika, imie, nazwisko, id_region) VALUES (4, 'Ewa', 'Wiśniewska', 4);
INSERT INTO Pracownicy (id_pracownika, imie, nazwisko, id_region) VALUES (5, 'Tomasz', 'Wójcik', 5);
INSERT INTO Pracownicy (id_pracownika, imie, nazwisko, id_region) VALUES (6, 'Katarzyna', 'Kowalczyk', 1);
INSERT INTO Pracownicy (id_pracownika, imie, nazwisko, id_region) VALUES (7, 'Michał', 'Kaczmarek', 6);
INSERT INTO Pracownicy (id_pracownika, imie, nazwisko, id_region) VALUES (8, 'Agnieszka', 'Mazur', 7);
INSERT INTO Pracownicy (id_pracownika, imie, nazwisko, id_region) VALUES (9, 'Robert', 'Sikora', 8);
INSERT INTO Pracownicy (id_pracownika, imie, nazwisko, id_region) VALUES (10,'Paweł', 'Kamiński', 9);

INSERT INTO Sprzedaz (id_sprzedazy, data_sprzedazy, id_pracownika, wartosc) VALUES (1, TO_DATE('2024-09-05','YYYY-MM-DD'), 1, 1200.50);
INSERT INTO Sprzedaz (id_sprzedazy, data_sprzedazy, id_pracownika, wartosc) VALUES (2, TO_DATE('2024-11-20','YYYY-MM-DD'), 2, 350.00);
INSERT INTO Sprzedaz (id_sprzedazy, data_sprzedazy, id_pracownika, wartosc) VALUES (3, TO_DATE('2025-01-15','YYYY-MM-DD'), 3, 7800.00);
INSERT INTO Sprzedaz (id_sprzedazy, data_sprzedazy, id_pracownika, wartosc) VALUES (4, TO_DATE('2025-02-10','YYYY-MM-DD'), 1, 150.75);
INSERT INTO Sprzedaz (id_sprzedazy, data_sprzedazy, id_pracownika, wartosc) VALUES (5, TO_DATE('2025-03-23','YYYY-MM-DD'), 5, 432.00);
INSERT INTO Sprzedaz (id_sprzedazy, data_sprzedazy, id_pracownika, wartosc) VALUES (6, TO_DATE('2025-04-30','YYYY-MM-DD'), 7, 9999.99);
INSERT INTO Sprzedaz (id_sprzedazy, data_sprzedazy, id_pracownika, wartosc) VALUES (7, TO_DATE('2025-05-12','YYYY-MM-DD'), 4, 1250.00);
INSERT INTO Sprzedaz (id_sprzedazy, data_sprzedazy, id_pracownika, wartosc) VALUES (8, TO_DATE('2025-06-18','YYYY-MM-DD'), 2, 60.00);
INSERT INTO Sprzedaz (id_sprzedazy, data_sprzedazy, id_pracownika, wartosc) VALUES (9, TO_DATE('2025-07-07','YYYY-MM-DD'), 9, 2500.00);
INSERT INTO Sprzedaz (id_sprzedazy, data_sprzedazy, id_pracownika, wartosc) VALUES (10,TO_DATE('2025-08-25','YYYY-MM-DD'),10, 10.00);

COMMIT;


