-- =========================================================
-- Hotel Chain Database Management System
-- File: 04_plsql_blocks.sql
-- Purpose: Demonstrate PL/SQL control structures
-- Database: Oracle SQL / PL/SQL
-- =========================================================

SET SERVEROUTPUT ON;


-- =========================================================
-- 1. Classify hotel financial performance
-- Calculates the total invoiced revenue for Hotel 1 and
-- assigns a performance category.
-- =========================================================

DECLARE
    v_total_revenue FACTURI.Pret_total%TYPE;
    v_hotel_id CONSTANT NUMBER := 1;
    v_performance VARCHAR2(50);
BEGIN
    SELECT NVL(SUM(f.Pret_total), 0)
    INTO v_total_revenue
    FROM FACTURI f
    JOIN REZERVARI r
        ON f.Id_rezervare = r.Id_rezervare
    WHERE r.Id_hotel = v_hotel_id;

    IF v_total_revenue > 5000 THEN
        v_performance := 'Excellent';
    ELSIF v_total_revenue >= 2000 THEN
        v_performance := 'Good';
    ELSE
        v_performance := 'Needs improvement';
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'Hotel ' || v_hotel_id ||
        ' generated ' || v_total_revenue ||
        ' RON in invoiced revenue. Performance: ' ||
        v_performance
    );
END;
/


-- =========================================================
-- 2. Iterate through selected rooms
-- Uses a FOR loop to display room type and nightly price.
-- =========================================================

DECLARE
    v_room_type CAMERE.Tip_camera%TYPE;
    v_nightly_rate CAMERE.Pret_noapte%TYPE;
BEGIN
    FOR i IN 301..303 LOOP

        SELECT Tip_camera, Pret_noapte
        INTO v_room_type, v_nightly_rate
        FROM CAMERE
        WHERE Id_camera = i
          AND Id_hotel = 2;

        DBMS_OUTPUT.PUT_LINE(
            'Room ' || i ||
            ' | Type: ' || v_room_type ||
            ' | Nightly rate: ' || v_nightly_rate || ' RON'
        );

    END LOOP;
END;
/


-- =========================================================
-- 3. Find customer by last name
-- Demonstrates a basic LOOP and EXIT condition.
-- =========================================================

DECLARE
    v_target_name CONSTANT VARCHAR2(30) := 'Stan';
    v_max_id CONSTANT NUMBER := 10;

    v_current_id CLIENTI.Id_client%TYPE := 1;
    v_current_name CLIENTI.Nume_client%TYPE;
    v_first_name CLIENTI.Prenume_client%TYPE;
    v_email CLIENTI.Email%TYPE;
BEGIN
    LOOP
        EXIT WHEN v_current_id > v_max_id;

        SELECT
            Nume_client,
            Prenume_client,
            Email
        INTO
            v_current_name,
            v_first_name,
            v_email
        FROM CLIENTI
        WHERE Id_client = v_current_id;

        IF v_current_name = v_target_name THEN

            DBMS_OUTPUT.PUT_LINE(
                'Customer found: ' ||
                v_first_name || ' ' || v_current_name ||
                ' | Email: ' || v_email
            );

            EXIT;
        END IF;

        v_current_id := v_current_id + 1;

    END LOOP;
END;
/


-- =========================================================
-- 4. Incremental room price reduction
-- Demonstrates a WHILE loop.
-- =========================================================

DECLARE
    v_initial_price CONSTANT NUMBER := 950;
    v_min_price CONSTANT NUMBER := 800;
    v_reduction CONSTANT NUMBER := 50;

    v_current_price NUMBER := v_initial_price;
    v_step NUMBER := 0;
BEGIN
    WHILE v_current_price > v_min_price LOOP

        v_current_price := v_current_price - v_reduction;
        v_step := v_step + 1;

        DBMS_OUTPUT.PUT_LINE(
            'Step ' || v_step ||
            ': price reduced to ' ||
            v_current_price || ' RON'
        );

    END LOOP;

    DBMS_OUTPUT.PUT_LINE(
        'Final price: ' || v_current_price || ' RON'
    );
END;
/


-- =========================================================
-- 5. Increase invoices below a threshold
-- Demonstrates FOR loop, IF condition and UPDATE.
-- =========================================================

DECLARE
    v_increase CONSTANT NUMBER := 0.15;
    v_threshold CONSTANT NUMBER := 1500;
    v_updated_count NUMBER := 0;
BEGIN

    FOR invoice_rec IN (
        SELECT Id_factura, Pret_total
        FROM FACTURI
    )
    LOOP

        IF invoice_rec.Pret_total < v_threshold THEN

            UPDATE FACTURI
            SET Pret_total =
                invoice_rec.Pret_total * (1 + v_increase)
            WHERE Id_factura = invoice_rec.Id_factura;

            v_updated_count := v_updated_count + 1;

            DBMS_OUTPUT.PUT_LINE(
                'Invoice ' || invoice_rec.Id_factura ||
                ': updated from ' ||
                invoice_rec.Pret_total ||
                ' RON to ' ||
                ROUND(invoice_rec.Pret_total * (1 + v_increase), 2) ||
                ' RON'
            );

        END IF;

    END LOOP;

    DBMS_OUTPUT.PUT_LINE(
        'Total invoices updated: ' || v_updated_count
    );
END;
/

ROLLBACK;


-- =========================================================
-- 6. Cleaning time based on room type
-- Demonstrates CASE logic.
-- =========================================================

DECLARE
    v_room_id CONSTANT NUMBER := 501;
    v_room_type CAMERE.Tip_camera%TYPE;
BEGIN

    SELECT Tip_camera
    INTO v_room_type
    FROM CAMERE
    WHERE Id_camera = v_room_id;

    CASE v_room_type
        WHEN 'Apartament' THEN
            DBMS_OUTPUT.PUT_LINE('Cleaning time: 3 hours');
        WHEN 'Single' THEN
            DBMS_OUTPUT.PUT_LINE('Cleaning time: 1 hour');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Cleaning time: 2 hours');
    END CASE;

END;
/
