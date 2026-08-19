-- =========================================================
-- Hotel Chain Database Management System
-- File: 07_functions_procedures.sql
-- Purpose: Stored functions and procedures for hotel
--          reservation and financial operations
-- Database: Oracle SQL / PL/SQL
-- =========================================================

SET SERVEROUTPUT ON;


-- =========================================================
-- 1. Annual hotel revenue report
-- Calculates total invoiced revenue for a selected hotel
-- and year.
-- =========================================================

CREATE OR REPLACE PROCEDURE annual_hotel_revenue (
    p_hotel_id IN HOTELURI.Id_hotel%TYPE,
    p_year     IN NUMBER
)
AS
    v_total NUMBER;
BEGIN
    SELECT SUM(f.Pret_total)
    INTO v_total
    FROM REZERVARI r
    JOIN FACTURI f
        ON r.Id_rezervare = f.Id_rezervare
    WHERE r.Id_hotel = p_hotel_id
      AND EXTRACT(YEAR FROM r.Check_in) = p_year;

    IF v_total IS NULL THEN
        DBMS_OUTPUT.PUT_LINE(
            'Hotel ' || p_hotel_id ||
            ' has no invoices for ' || p_year || '.'
        );
    ELSE
        DBMS_OUTPUT.PUT_LINE(
            'Hotel ' || p_hotel_id ||
            ' generated ' || v_total ||
            ' RON in invoiced revenue in ' || p_year || '.'
        );
    END IF;
END;
/


-- Example
BEGIN
    annual_hotel_revenue(1, 2025);
END;
/


-- =========================================================
-- 2. Calculate reservation nights
-- Returns:
--   number of nights = valid reservation
--   -1 = reservation does not exist
--   -2 = invalid dates
-- =========================================================

CREATE OR REPLACE FUNCTION calculate_reservation_nights (
    p_reservation_id IN REZERVARI.Id_rezervare%TYPE
)
RETURN NUMBER
AS
    v_check_in  REZERVARI.Check_in%TYPE;
    v_check_out REZERVARI.Check_out%TYPE;
BEGIN
    SELECT
        Check_in,
        Check_out
    INTO
        v_check_in,
        v_check_out
    FROM REZERVARI
    WHERE Id_rezervare = p_reservation_id;

    IF v_check_out <= v_check_in THEN
        RETURN -2;
    END IF;

    RETURN v_check_out - v_check_in;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN -1;
END;
/


-- Example
DECLARE
    v_nights NUMBER;
BEGIN
    v_nights := calculate_reservation_nights(1003);

    IF v_nights = -1 THEN
        DBMS_OUTPUT.PUT_LINE('Reservation does not exist.');
    ELSIF v_nights = -2 THEN
        DBMS_OUTPUT.PUT_LINE('Reservation dates are invalid.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(
            'Reservation duration: ' || v_nights || ' nights.'
        );
    END IF;
END;
/


-- =========================================================
-- 3. Reservation report
-- Uses calculate_reservation_nights() inside a procedure.
-- =========================================================

CREATE OR REPLACE PROCEDURE display_reservation_report
AS
    CURSOR c_reservations IS
        SELECT
            Id_rezervare,
            Check_in,
            Check_out
        FROM REZERVARI
        ORDER BY Id_rezervare;
BEGIN
    FOR reservation_rec IN c_reservations LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Reservation ' ||
            reservation_rec.Id_rezervare ||
            ' | Stay: ' ||
            TO_CHAR(reservation_rec.Check_in, 'YYYY-MM-DD') ||
            ' to ' ||
            TO_CHAR(reservation_rec.Check_out, 'YYYY-MM-DD') ||
            ' | Nights: ' ||
            calculate_reservation_nights(
                reservation_rec.Id_rezervare
            )
        );

    END LOOP;
END;
/


-- Example
BEGIN
    display_reservation_report;
END;
/


-- =========================================================
-- 4. Update room nightly rate
-- Demonstrates procedure parameters and exception handling.
-- =========================================================

CREATE OR REPLACE PROCEDURE update_room_rate (
    p_room_id IN CAMERE.Id_camera%TYPE,
    p_amount  IN NUMBER
)
AS
    v_old_rate CAMERE.Pret_noapte%TYPE;
    room_not_found EXCEPTION;
BEGIN
    SELECT Pret_noapte
    INTO v_old_rate
    FROM CAMERE
    WHERE Id_camera = p_room_id;

    UPDATE CAMERE
    SET Pret_noapte = Pret_noapte + p_amount
    WHERE Id_camera = p_room_id;

    DBMS_OUTPUT.PUT_LINE(
        'Room ' || p_room_id ||
        ' | Previous rate: ' || v_old_rate ||
        ' RON | New rate: ' ||
        (v_old_rate + p_amount) || ' RON'
    );

    ROLLBACK;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'The specified room does not exist.'
        );
END;
/


-- Example
BEGIN
    update_room_rate(101, 50);
END;
/


-- =========================================================
-- 5. Calculate reservation cost
-- Total cost = number of nights × nightly room rate.
-- =========================================================

CREATE OR REPLACE FUNCTION calculate_reservation_cost (
    p_reservation_id IN REZERVARI.Id_rezervare%TYPE
)
RETURN NUMBER
AS
    v_check_in    REZERVARI.Check_in%TYPE;
    v_check_out   REZERVARI.Check_out%TYPE;
    v_nightly_rate CAMERE.Pret_noapte%TYPE;
BEGIN
    SELECT
        r.Check_in,
        r.Check_out,
        c.Pret_noapte
    INTO
        v_check_in,
        v_check_out,
        v_nightly_rate
    FROM REZERVARI r
    JOIN CAMERE c
        ON r.Id_camera = c.Id_camera
    WHERE r.Id_rezervare = p_reservation_id;

    RETURN
        (v_check_out - v_check_in) * v_nightly_rate;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN -1;
END;
/


-- Example
DECLARE
    v_total NUMBER;
BEGIN
    v_total := calculate_reservation_cost(1001);

    IF v_total = -1 THEN
        DBMS_OUTPUT.PUT_LINE(
            'Reservation does not exist.'
        );
    ELSE
        DBMS_OUTPUT.PUT_LINE(
            'Total reservation cost: ' ||
            v_total || ' RON'
        );
    END IF;
END;
/


-- =========================================================
-- 6. Check whether a reservation has an invoice
-- Returns:
--   1  = invoice exists
--   0  = reservation exists but has no invoice
--   -1 = reservation does not exist
-- =========================================================

CREATE OR REPLACE FUNCTION reservation_has_invoice (
    p_reservation_id IN REZERVARI.Id_rezervare%TYPE
)
RETURN NUMBER
AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM REZERVARI
    WHERE Id_rezervare = p_reservation_id;

    IF v_count = 0 THEN
        RETURN -1;
    END IF;

    SELECT COUNT(*)
    INTO v_count
    FROM FACTURI
    WHERE Id_rezervare = p_reservation_id;

    IF v_count > 0 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END;
/


-- Example
DECLARE
    v_result NUMBER;
BEGIN
    v_result := reservation_has_invoice(1003);

    IF v_result = -1 THEN
        DBMS_OUTPUT.PUT_LINE(
            'Reservation does not exist.'
        );
    ELSIF v_result = 1 THEN
        DBMS_OUTPUT.PUT_LINE(
            'Reservation has an associated invoice.'
        );
    ELSE
        DBMS_OUTPUT.PUT_LINE(
            'Reservation does not have an invoice.'
        );
    END IF;
END;
/


-- =========================================================
-- 7. Update hotel capacity
-- =========================================================

CREATE OR REPLACE PROCEDURE update_hotel_capacity (
    p_hotel_id IN HOTELURI.Id_hotel%TYPE,
    p_amount   IN NUMBER
)
AS
    v_old_capacity HOTELURI.Capacitate%TYPE;
BEGIN
    SELECT Capacitate
    INTO v_old_capacity
    FROM HOTELURI
    WHERE Id_hotel = p_hotel_id;

    UPDATE HOTELURI
    SET Capacitate = Capacitate + p_amount
    WHERE Id_hotel = p_hotel_id;

    DBMS_OUTPUT.PUT_LINE(
        'Hotel ' || p_hotel_id ||
        ' | Previous capacity: ' ||
        v_old_capacity ||
        ' | New capacity: ' ||
        (v_old_capacity + p_amount)
    );

    ROLLBACK;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'The specified hotel does not exist.'
        );
END;
/


-- Example
BEGIN
    update_hotel_capacity(1, 50);
END;
/


-- =========================================================
-- 8. Count rooms belonging to a hotel
-- Returns NULL when the hotel does not exist or has no rooms.
-- =========================================================

CREATE OR REPLACE FUNCTION count_hotel_rooms (
    p_hotel_id IN HOTELURI.Id_hotel%TYPE
)
RETURN NUMBER
AS
    v_room_count NUMBER;
BEGIN
    SELECT COUNT(c.Id_camera)
    INTO v_room_count
    FROM HOTELURI h
    LEFT JOIN CAMERE c
        ON h.Id_hotel = c.Id_hotel
    WHERE h.Id_hotel = p_hotel_id
    GROUP BY h.Id_hotel;

    IF v_room_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE(
            'Hotel ' || p_hotel_id ||
            ' has no associated rooms.'
        );

        RETURN NULL;
    END IF;

    RETURN v_room_count;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'Hotel ' || p_hotel_id ||
            ' does not exist.'
        );

        RETURN NULL;
END;
/


-- Example
DECLARE
    v_room_count NUMBER;
BEGIN
    v_room_count := count_hotel_rooms(1);

    IF v_room_count IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE(
            'Number of rooms: ' || v_room_count
        );
    END IF;
END;
/
