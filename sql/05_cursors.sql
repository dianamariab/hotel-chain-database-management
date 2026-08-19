-- =========================================================
-- Hotel Chain Database Management System
-- File: 05_cursors.sql
-- Purpose: Demonstrate explicit cursors and cursor FOR loops
-- Database: Oracle SQL / PL/SQL
-- =========================================================

SET SERVEROUTPUT ON;


-- =========================================================
-- 1. Invoices below 1500 RON
-- Displays invoice number and total value.
-- =========================================================

DECLARE
    CURSOR c_invoices IS
        SELECT
            Nr_factura,
            Pret_total
        FROM FACTURI
        WHERE Pret_total < 1500
        ORDER BY Pret_total;
BEGIN
    FOR invoice_rec IN c_invoices LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Invoice ' || invoice_rec.Nr_factura ||
            ' has a total value of ' ||
            invoice_rec.Pret_total || ' RON'
        );

    END LOOP;
END;
/


-- =========================================================
-- 2. Customers checking in during December 2025
-- Displays customer name and check-in date.
-- =========================================================

DECLARE
    CURSOR c_december_customers IS
        SELECT
            c.Nume_client || ' ' || c.Prenume_client AS Full_name,
            r.Check_in
        FROM CLIENTI c
        JOIN REZERVARI r
            ON c.Id_client = r.Id_client
        WHERE EXTRACT(MONTH FROM r.Check_in) = 12
          AND EXTRACT(YEAR FROM r.Check_in) = 2025
        ORDER BY r.Check_in;
BEGIN
    FOR customer_rec IN c_december_customers LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Customer ' || customer_rec.Full_name ||
            ' checks in on ' ||
            TO_CHAR(customer_rec.Check_in, 'YYYY-MM-DD')
        );

    END LOOP;
END;
/


-- =========================================================
-- 3. Rooms above 700 RON per night
-- Displays room ID and nightly rate.
-- =========================================================

DECLARE
    CURSOR c_premium_rooms IS
        SELECT
            Id_camera,
            Pret_noapte
        FROM CAMERE
        WHERE Pret_noapte > 700
        ORDER BY Pret_noapte DESC;
BEGIN
    FOR room_rec IN c_premium_rooms LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Room ' || room_rec.Id_camera ||
            ' costs ' || room_rec.Pret_noapte ||
            ' RON per night'
        );

    END LOOP;
END;
/


-- =========================================================
-- 4. Reservation duration
-- Displays the number of nights for each reservation.
-- =========================================================

DECLARE
    CURSOR c_reservations IS
        SELECT
            Id_rezervare,
            Check_in,
            Check_out,
            (Check_out - Check_in) AS Number_of_nights
        FROM REZERVARI
        ORDER BY Id_rezervare;
BEGIN
    FOR reservation_rec IN c_reservations LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Reservation ' || reservation_rec.Id_rezervare ||
            ' | Stay: ' ||
            TO_CHAR(reservation_rec.Check_in, 'YYYY-MM-DD') ||
            ' to ' ||
            TO_CHAR(reservation_rec.Check_out, 'YYYY-MM-DD') ||
            ' | Nights: ' ||
            reservation_rec.Number_of_nights
        );

    END LOOP;
END;
/


-- =========================================================
-- 5. Manual cursor example
-- Demonstrates OPEN, FETCH and CLOSE explicitly.
-- =========================================================

DECLARE
    CURSOR c_hotels IS
        SELECT
            Id_hotel,
            Denumire,
            Capacitate
        FROM HOTELURI
        ORDER BY Id_hotel;

    v_hotel c_hotels%ROWTYPE;
BEGIN
    OPEN c_hotels;

    LOOP
        FETCH c_hotels INTO v_hotel;
        EXIT WHEN c_hotels%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Hotel ' || v_hotel.Id_hotel ||
            ': ' || v_hotel.Denumire ||
            ' | Capacity: ' || v_hotel.Capacitate
        );

    END LOOP;

    CLOSE c_hotels;
END;
/
