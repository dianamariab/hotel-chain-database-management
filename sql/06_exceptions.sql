-- =========================================================
-- Hotel Chain Database Management System
-- File: 06_exceptions.sql
-- Purpose: Demonstrate PL/SQL exception handling
-- Database: Oracle SQL / PL/SQL
-- =========================================================

SET SERVEROUTPUT ON;


-- =========================================================
-- 1. Find customer by email
-- Demonstrates NO_DATA_FOUND and generic exception handling.
-- =========================================================

DECLARE
    v_customer_id CLIENTI.Id_client%TYPE;
    v_phone CLIENTI.Nr_telefon%TYPE;

    v_email CLIENTI.Email%TYPE := 'customer08@example.com';
BEGIN
    SELECT
        Id_client,
        Nr_telefon
    INTO
        v_customer_id,
        v_phone
    FROM CLIENTI
    WHERE Email = v_email;

    DBMS_OUTPUT.PUT_LINE(
        'Customer found | ID: ' || v_customer_id ||
        ' | Phone: ' || v_phone
    );

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'No customer was found with the specified email address.'
        );

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(
            'An unexpected error occurred: ' || SQLERRM
        );
END;
/


-- =========================================================
-- 2. Update invoice payment method
-- Demonstrates a user-defined exception.
-- =========================================================

DECLARE
    v_invoice_id FACTURI.Id_factura%TYPE := 5002;

    invoice_not_found EXCEPTION;
BEGIN
    UPDATE FACTURI
    SET Modalitate_plata = 'Card Bancar'
    WHERE Id_factura = v_invoice_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE invoice_not_found;
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'Payment method successfully updated for invoice ' ||
        v_invoice_id
    );

    ROLLBACK;

EXCEPTION
    WHEN invoice_not_found THEN
        DBMS_OUTPUT.PUT_LINE(
            'The specified invoice was not found. ' ||
            'The payment method could not be updated.'
        );
END;
/


-- =========================================================
-- 3. Validate room nightly rate
-- Handles both missing rooms and unusually low prices.
-- =========================================================

DECLARE
    v_room_id CAMERE.Id_camera%TYPE := 101;

    v_room_type CAMERE.Tip_camera%TYPE;
    v_hotel_name HOTELURI.Denumire%TYPE;
    v_nightly_rate CAMERE.Pret_noapte%TYPE;

    v_minimum_rate CONSTANT NUMBER := 300;

    low_room_rate EXCEPTION;
BEGIN
    SELECT
        c.Tip_camera,
        h.Denumire,
        c.Pret_noapte
    INTO
        v_room_type,
        v_hotel_name,
        v_nightly_rate
    FROM CAMERE c
    JOIN HOTELURI h
        ON c.Id_hotel = h.Id_hotel
    WHERE c.Id_camera = v_room_id;

    IF v_nightly_rate < v_minimum_rate THEN
        RAISE low_room_rate;
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'Room ' || v_room_id ||
        ' | Type: ' || v_room_type ||
        ' | Hotel: ' || v_hotel_name ||
        ' | Nightly rate: ' || v_nightly_rate || ' RON'
    );

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'The specified room does not exist.'
        );

    WHEN low_room_rate THEN
        DBMS_OUTPUT.PUT_LINE(
            'Alert: the room price is unusually low ' ||
            '(below ' || v_minimum_rate || ' RON).'
        );
END;
/


-- =========================================================
-- 4. Calculate invoice commission
-- Calculates an 8% commission and validates a minimum
-- commission threshold.
-- =========================================================

DECLARE
    v_invoice_id CONSTANT FACTURI.Id_factura%TYPE := 5006;
    v_commission_rate CONSTANT NUMBER := 0.08;
    v_minimum_commission CONSTANT NUMBER := 100;

    v_invoice_total FACTURI.Pret_total%TYPE;
    v_commission NUMBER(10, 2);

    insufficient_commission EXCEPTION;
BEGIN
    SELECT Pret_total
    INTO v_invoice_total
    FROM FACTURI
    WHERE Id_factura = v_invoice_id;

    v_commission := v_invoice_total * v_commission_rate;

    IF v_commission < v_minimum_commission THEN
        RAISE insufficient_commission;
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'Invoice ' || v_invoice_id ||
        ' | Total: ' || v_invoice_total ||
        ' RON | Commission: ' ||
        ROUND(v_commission, 2) || ' RON'
    );

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'The specified invoice was not found.'
        );

    WHEN insufficient_commission THEN
        DBMS_OUTPUT.PUT_LINE(
            'Commission is below the minimum threshold of ' ||
            v_minimum_commission || ' RON.'
        );

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(
            'An unexpected error occurred: ' || SQLERRM
        );
END;
/
