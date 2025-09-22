-- =========================================================================
/*
	Plik do zadania 4 i 5: 02_raporty.sql
	Tytuł: Skrypt sql do wygenerowania dwóch raportów sprzedazowych.
	Data: 2025-09-03
*/
-- =========================================================================



--========================================
-- Raport nr 1
--======================================== 

WITH mies_startowy AS (
  /*
      Wybiera poczatek miesiaca  (bez bieżacego miesiaca)
      CTE start_mies - troche jak tymczasowa zmienna/parametr do ktorej bede sie odwoywal w innych czesciach zapytania
  */
  SELECT TRUNC(ADD_MONTHS(SYSDATE, -1), 'MM') AS p_dzien_ost_mies FROM DUAL
),
list_mies AS (
  /* 
      Polecenie z CONNECT generuje 12 miesięcy wstecz od
      ostatniego miesiąca (bez bieżącego), w kolejności rosnącej
  */
  SELECT ADD_MONTHS((SELECT p_dzien_ost_mies FROM mies_startowy), - (12 - LEVEL)) AS start_mies FROM DUAL
  CONNECT BY LEVEL <= 12
),
  /*
    Agreguje sprzeaż per pracownik i miesiąc (ostatnie 12 miesięcy bez bieżcego).
    Logika:
      - doklejam pocątek ostatniego miesiąca (CROSS JOIN)
      - w WHERE wybieam transakcje z ostatnich 12 miesięcy wstecz
      - na koniec grupuję po pracowniku i miesiącu
    Zwracam kolumny:
      - id_pracownika
      - począek miesiąca
      - liczba transakcji
      - łączna wartość sprzedaży
      - średnia warość transakcji
      - maksymalna wartość transkcji
*/

sprzedaz_per_prac_mies AS (
  SELECT
    s.id_pracownika,
    TRUNC(s.data_sprzedazy,'MM') AS start_miesiaca,
    COUNT(*) AS liczba_trans,
    SUM(s.wartosc) AS calk_wart,
    AVG(s.wartosc) AS srednia,
    MAX(s.wartosc) AS maksymalna_wart
  FROM Sprzedaz s
  cross JOIN mies_startowy p  
  WHERE s.data_sprzedazy >= ADD_MONTHS(p.p_dzien_ost_mies, -11)
    AND s.data_sprzedazy <  ADD_MONTHS(p.p_dzien_ost_mies, 1)
  GROUP BY s.id_pracownika, TRUNC(s.data_sprzedazy,'MM')
)
  /*
    Glowny select – sprzedaż pracowników w podziale na mies.
      - iloczyn kartenzjanski: każdy pracownik zesawiony z listą 12 miesięcy
      - LEFT JOI: dołązone dane sprzedżowe (jeśli brak – wstawiane zera)
      - FORMAT: miesiąc jako YYYY-MM, wartości zaokrąglone do 2 miejsc
      - SORTOWAIE: po nazwisku, imieniu, a nastęnie miesiącu
  */

SELECT
  pr.id_pracownika,
  pr.imie || ' ' || pr.nazwisko                       AS pracownik,
  TO_CHAR(m.start_mies,'YYYY-MM')                     AS miesiac,
  NVL(sa.liczba_trans,0)                              AS liczba_transakcji,
  NVL(ROUND(sa.calk_wart,2),0)                        AS wartosc_miesieczna,
  NVL(ROUND(sa.srednia,2),0)                          AS srednia_transakcji,
  NVL(ROUND(sa.maksymalna_wart,2),0)                  AS max_transakcja
FROM Pracownicy pr
CROSS JOIN list_mies m
LEFT JOIN sprzedaz_per_prac_mies sa
  ON sa.id_pracownika = pr.id_pracownika
 AND sa.start_miesiaca = m.start_mies
ORDER BY pr.nazwisko, pr.imie, m.start_mies;


--========================================
-- Raport nr 2
--======================================== 

WITH sprzedaz_luty AS (
  /*
    Wyliczam sumę sprzedaży za luty 2024 per pracownik i reion.
    Uwaga wydajnościowa: rozważ użycie zakresu dat zamiast TRUNC() (patrz komentarz poniżej).
    (!) Korzysta z indeksu na kolumnie data i uzywam zakresu dat.
  */
  
  SELECT 
    p.id_region,
    r.nazwa AS region,
    p.id_pracownika,
    p.imie || ' ' || p.nazwisko AS pracownik,
    SUM(s.wartosc) AS sum_luty
  FROM Sprzedaz s
  JOIN Pracownicy p ON s.id_pracownika = p.id_pracownika
  JOIN Regiony r ON p.id_region = r.id_region
  WHERE s.data_sprzedazy >= TO_DATE('2024-02-01','YYYY-MM-DD') AND s.data_sprzedazy <  TO_DATE('2024-03-01','YYYY-MM-DD')
  GROUP BY p.id_region, r.nazwa, p.id_pracownika, p.imie, p.nazwisko
)
    /* 
      Nadaje ranking w każdym regionie wg sumy sprzeday (najwyższa = 1) 
      Wybieram tylko zwycięzców (obsługując remisy)
      Sortuję po reionie i pracowniku    
    */
SELECT id_region, region, id_pracownika, pracownik, sum_luty
FROM (
  SELECT sl.*,
         RANK() OVER (PARTITION BY id_region ORDER BY sum_luty DESC) AS pozycja_rank
  FROM sprzedaz_luty sl
) t
WHERE pozycja_rank = 1
ORDER BY region, pracownik;















