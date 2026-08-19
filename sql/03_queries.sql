-- =========================================================
-- Hotel Chain Database Management System
-- File: 03_queries.sql
-- Purpose: Business-oriented SQL queries
-- Database: Oracle SQL
-- =========================================================


-- =========================================================
-- 1. Complete reservation overview
-- Shows the customer, hotel, room, stay period and invoice
-- for each reservation.
-- =========================================================

SELECT
    r.Id_rezervare,
    c.Nume_client || ' ' || c.Prenume_client AS Client,
    h.Denumire AS Hotel,
    cam.Nr_camera,
    cam.Tip_camera,
    r.Check_in,
    r.Check_out,
    (r.Check_out - r.Check_in) AS Numar_nopti,
    f.Pret_total,
    f.Modalitate_plata
FROM REZERVARI r
JOIN CLIENTI c
    ON r.Id_client = c.Id_client
JOIN HOTELURI h
    ON r.Id_hotel = h.Id_hotel
JOIN CAMERE cam
    ON r.Id_camera = cam.Id_camera
LEFT JOIN FACTURI f
    ON r.Id_rezervare = f.Id_rezervare
ORDER BY r.Check_in;


-- =========================================================
-- 2. Revenue by hotel
-- Calculates total invoiced revenue for each hotel.
-- =========================================================

SELECT
    h.Id_hotel,
    h.Denumire,
    SUM(f.Pret_total) AS Venit_total
FROM HOTELURI h
JOIN REZERVARI r
    ON h.Id_hotel = r.Id_hotel
JOIN FACTURI f
    ON r.Id_rezervare = f.Id_rezervare
GROUP BY
    h.Id_hotel,
    h.Denumire
ORDER BY Venit_total DESC;


-- =========================================================
-- 3. Number of reservations by hotel
-- Shows which hotel has the highest number of bookings.
-- =========================================================

SELECT
    h.Denumire,
    COUNT(r.Id_rezervare) AS Numar_rezervari
FROM HOTELURI h
LEFT JOIN REZERVARI r
    ON h.Id_hotel = r.Id_hotel
GROUP BY h.Denumire
ORDER BY Numar_rezervari DESC;


-- =========================================================
-- 4. Total booked nights by hotel
-- Measures the total number of nights booked at each hotel.
-- =========================================================

SELECT
    h.Denumire,
    SUM(r.Check_out - r.Check_in) AS Total_nopti_rezervate
FROM HOTELURI h
JOIN REZERVARI r
    ON h.Id_hotel = r.Id_hotel
GROUP BY h.Denumire
ORDER BY Total_nopti_rezervate DESC;


-- =========================================================
-- 5. Average room price by hotel
-- Compares the average nightly room rate across hotels.
-- =========================================================

SELECT
    h.Denumire,
    ROUND(AVG(c.Pret_noapte), 2) AS Pret_mediu_noapte
FROM HOTELURI h
JOIN CAMERE c
    ON h.Id_hotel = c.Id_hotel
GROUP BY h.Denumire
ORDER BY Pret_mediu_noapte DESC;


-- =========================================================
-- 6. Premium rooms
-- Identifies rooms with a nightly rate above 700 RON.
-- =========================================================

SELECT
    h.Denumire,
    c.Id_camera,
    c.Nr_camera,
    c.Tip_camera,
    c.Pret_noapte
FROM CAMERE c
JOIN HOTELURI h
    ON c.Id_hotel = h.Id_hotel
WHERE c.Pret_noapte > 700
ORDER BY c.Pret_noapte DESC;


-- =========================================================
-- 7. Customers checking in during December 2025
-- =========================================================

SELECT
    c.Nume_client || ' ' || c.Prenume_client AS Client,
    h.Denumire AS Hotel,
    r.Check_in
FROM CLIENTI c
JOIN REZERVARI r
    ON c.Id_client = r.Id_client
JOIN HOTELURI h
    ON r.Id_hotel = h.Id_hotel
WHERE EXTRACT(MONTH FROM r.Check_in) = 12
  AND EXTRACT(YEAR FROM r.Check_in) = 2025
ORDER BY r.Check_in;


-- =========================================================
-- 8. Invoices below 1500 RON
-- =========================================================

SELECT
    f.Nr_factura,
    f.Pret_total,
    f.Modalitate_plata
FROM FACTURI f
WHERE f.Pret_total < 1500
ORDER BY f.Pret_total;


-- =========================================================
-- 9. Revenue by payment method
-- Shows how invoiced revenue is distributed across
-- payment methods.
-- =========================================================

SELECT
    Modalitate_plata,
    COUNT(*) AS Numar_facturi,
    SUM(Pret_total) AS Valoare_totala
FROM FACTURI
GROUP BY Modalitate_plata
ORDER BY Valoare_totala DESC;


-- =========================================================
-- 10. Highest-value reservations
-- Identifies the reservations generating the most revenue.
-- =========================================================

SELECT
    r.Id_rezervare,
    c.Nume_client || ' ' || c.Prenume_client AS Client,
    h.Denumire AS Hotel,
    f.Pret_total
FROM REZERVARI r
JOIN CLIENTI c
    ON r.Id_client = c.Id_client
JOIN HOTELURI h
    ON r.Id_hotel = h.Id_hotel
JOIN FACTURI f
    ON r.Id_rezervare = f.Id_rezervare
ORDER BY f.Pret_total DESC;
