-- =========================================================================
/*
	Plik do zadania 4 i 5: 01_ddl.sql
	Tytuł: Tworzy strukturę tabel.
	Data: 2025-09-03
*/
-- =========================================================================


CREATE TABLE Regiony (
    id_region   NUMBER PRIMARY KEY,
    nazwa       VARCHAR2(100) NOT NULL
);

CREATE TABLE Pracownicy (
    id_pracownika   NUMBER PRIMARY KEY,
    imie            VARCHAR2(50) NOT NULL,
    nazwisko        VARCHAR2(50) NOT NULL,
    id_region       NUMBER,
    CONSTRAINT fk_pracownicy_regiony FOREIGN KEY (id_region)
        REFERENCES Regiony(id_region)
);

CREATE TABLE Sprzedaz (
    id_sprzedazy    NUMBER PRIMARY KEY,
    data_sprzedazy  DATE NOT NULL,
    id_pracownika   NUMBER,
    wartosc         NUMBER(10,2),
    CONSTRAINT fk_sprzedaz_pracownicy FOREIGN KEY (id_pracownika)
        REFERENCES Pracownicy(id_pracownika)
);

CREATE INDEX idx_sprzedaz_data ON Sprzedaz(data_sprzedazy);