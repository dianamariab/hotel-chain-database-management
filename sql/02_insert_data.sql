-- =========================================================
-- Hotel Chain Database Management System
-- File: 02_insert_data.sql
-- Purpose: Populate the database with sample data
-- Database: Oracle SQL
-- =========================================================


-- =========================================================
-- HOTELS
-- =========================================================

INSERT INTO HOTELURI (Id_hotel, Denumire, Capacitate, Locatie)
VALUES (1, 'Luxor Central Plaza', 350, 'Bucuresti, Sector 1');

INSERT INTO HOTELURI (Id_hotel, Denumire, Capacitate, Locatie)
VALUES (2, 'Luxor Riviera Palace', 200, 'Mamaia Nord, Constanta');

INSERT INTO HOTELURI (Id_hotel, Denumire, Capacitate, Locatie)
VALUES (3, 'Luxor Carpatica Retreat', 150, 'Poiana Brasov, Brasov');


-- =========================================================
-- ROOMS
-- =========================================================

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (101, 1, 'Single', 1, 101, 250);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (102, 1, 'Dubla', 2, 222, 350);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (103, 1, 'Dubla', 2, 213, 350);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (205, 1, 'Apartament', 3, 305, 700);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (206, 1, 'Twin', 2, 206, 300);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (301, 2, 'Dubla', 1, 122, 400);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (302, 2, 'Dubla cu vedere', 3, 302, 550);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (303, 2, 'Dubla cu vedere', 3, 349, 550);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (401, 2, 'Apartament', 4, 401, 850);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (402, 2, 'Single', 5, 502, 380);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (403, 2, 'Twin', 7, 704, 420);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (501, 3, 'Single', 2, 203, 300);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (502, 3, 'Dubla', 5, 402, 420);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (503, 3, 'Dubla', 5, 503, 420);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (601, 3, 'Apartament', 6, 601, 950);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (602, 3, 'Single', 6, 602, 300);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (603, 3, 'Dubla Superior', 6, 603, 500);

INSERT INTO CAMERE
(Id_camera, Id_hotel, Tip_camera, Etaj, Nr_camera, Pret_noapte)
VALUES (604, 3, 'Dubla Superior', 6, 604, 500);


-- =========================================================
-- CUSTOMERS
-- Sample / fictional data
-- =========================================================

INSERT INTO CLIENTI
(Id_client, Nume_client, Prenume_client, Nr_telefon, Email, Oras)
VALUES (1, 'Popescu', 'Andrei', 722123456, 'customer01@example.com', 'Bucuresti');

INSERT INTO CLIENTI
(Id_client, Nume_client, Prenume_client, Nr_telefon, Email, Oras)
VALUES (2, 'Ionescu', 'Maria', 744987654, 'customer02@example.com', 'Constanta');

INSERT INTO CLIENTI
(Id_client, Nume_client, Prenume_client, Nr_telefon, Email, Oras)
VALUES (3, 'Georgescu', 'Cristian', 766555444, 'customer03@example.com', 'Brasov');

INSERT INTO CLIENTI
(Id_client, Nume_client, Prenume_client, Nr_telefon, Email, Oras)
VALUES (4, 'Vasilescu', 'Elena', 733111222, 'customer04@example.com', 'Cluj');

INSERT INTO CLIENTI
(Id_client, Nume_client, Prenume_client, Nr_telefon, Email, Oras)
VALUES (5, 'Dumitrescu', 'Gabriel', 755999888, 'customer05@example.com', 'Iasi');

INSERT INTO CLIENTI
(Id_client, Nume_client, Prenume_client, Nr_telefon, Email, Oras)
VALUES (6, 'Petrescu', 'Ana', 777000111, 'customer06@example.com', 'Timisoara');

INSERT INTO CLIENTI
(Id_client, Nume_client, Prenume_client, Nr_telefon, Email, Oras)
VALUES (7, 'Marinescu', 'Vlad', 788333444, 'customer07@example.com', 'Bucuresti');

INSERT INTO CLIENTI
(Id_client, Nume_client, Prenume_client, Nr_telefon, Email, Oras)
VALUES (8, 'Stan', 'Laura', 799666777, 'customer08@example.com', 'Constanta');

INSERT INTO CLIENTI
(Id_client, Nume_client, Prenume_client, Nr_telefon, Email, Oras)
VALUES (9, 'Mihai', 'Bogdan', 700123987, 'customer09@example.com', 'Brasov');

INSERT INTO CLIENTI
(Id_client, Nume_client, Prenume_client, Nr_telefon, Email, Oras)
VALUES (10, 'Preda', 'Ioana', 711456321, 'customer10@example.com', 'Sibiu');


-- =========================================================
-- RESERVATIONS
-- =========================================================

INSERT INTO REZERVARI
(Id_rezervare, Id_client, Id_hotel, Id_camera, Check_in, Check_out)
VALUES (1001, 1, 1, 102, DATE '2025-11-20', DATE '2025-11-23');

INSERT INTO REZERVARI
(Id_rezervare, Id_client, Id_hotel, Id_camera, Check_in, Check_out)
VALUES (1002, 2, 2, 301, DATE '2025-11-25', DATE '2025-11-29');

INSERT INTO REZERVARI
(Id_rezervare, Id_client, Id_hotel, Id_camera, Check_in, Check_out)
VALUES (1003, 3, 3, 502, DATE '2025-12-05', DATE '2025-12-10');

INSERT INTO REZERVARI
(Id_rezervare, Id_client, Id_hotel, Id_camera, Check_in, Check_out)
VALUES (1004, 4, 1, 205, DATE '2025-12-01', DATE '2025-12-03');

INSERT INTO REZERVARI
(Id_rezervare, Id_client, Id_hotel, Id_camera, Check_in, Check_out)
VALUES (1005, 5, 2, 302, DATE '2025-12-15', DATE '2025-12-18');

INSERT INTO REZERVARI
(Id_rezervare, Id_client, Id_hotel, Id_camera, Check_in, Check_out)
VALUES (1006, 6, 3, 601, DATE '2025-12-24', DATE '2025-12-28');

INSERT INTO REZERVARI
(Id_rezervare, Id_client, Id_hotel, Id_camera, Check_in, Check_out)
VALUES (1007, 7, 1, 101, DATE '2026-01-05', DATE '2026-01-06');

INSERT INTO REZERVARI
(Id_rezervare, Id_client, Id_hotel, Id_camera, Check_in, Check_out)
VALUES (1008, 8, 2, 401, DATE '2026-01-10', DATE '2026-01-15');

INSERT INTO REZERVARI
(Id_rezervare, Id_client, Id_hotel, Id_camera, Check_in, Check_out)
VALUES (1009, 9, 3, 503, DATE '2026-01-20', DATE '2026-01-22');

INSERT INTO REZERVARI
(Id_rezervare, Id_client, Id_hotel, Id_camera, Check_in, Check_out)
VALUES (1010, 10, 1, 103, DATE '2026-01-28', DATE '2026-01-31');


-- =========================================================
-- INVOICES
-- =========================================================

INSERT INTO FACTURI
(Id_factura, Id_rezervare, Nr_factura, Pret_total, Modalitate_plata)
VALUES (5001, 1001, 1000, 1050, 'Card Bancar');

INSERT INTO FACTURI
(Id_factura, Id_rezervare, Nr_factura, Pret_total, Modalitate_plata)
VALUES (5002, 1002, 1001, 1600, 'Numerar');

INSERT INTO FACTURI
(Id_factura, Id_rezervare, Nr_factura, Pret_total, Modalitate_plata)
VALUES (5003, 1003, 1002, 2100, 'Card Bancar');

INSERT INTO FACTURI
(Id_factura, Id_rezervare, Nr_factura, Pret_total, Modalitate_plata)
VALUES (5004, 1004, 1003, 1400, 'Transfer Bancar');

INSERT INTO FACTURI
(Id_factura, Id_rezervare, Nr_factura, Pret_total, Modalitate_plata)
VALUES (5005, 1005, 1004, 1650, 'Numerar');

INSERT INTO FACTURI
(Id_factura, Id_rezervare, Nr_factura, Pret_total, Modalitate_plata)
VALUES (5006, 1006, 1005, 3800, 'Card Bancar');

INSERT INTO FACTURI
(Id_factura, Id_rezervare, Nr_factura, Pret_total, Modalitate_plata)
VALUES (5007, 1007, 1006, 250, 'Card Bancar');

INSERT INTO FACTURI
(Id_factura, Id_rezervare, Nr_factura, Pret_total, Modalitate_plata)
VALUES (5008, 1008, 1007, 4250, 'Transfer Bancar');

INSERT INTO FACTURI
(Id_factura, Id_rezervare, Nr_factura, Pret_total, Modalitate_plata)
VALUES (5009, 1009, 1008, 840, 'Numerar');

INSERT INTO FACTURI
(Id_factura, Id_rezervare, Nr_factura, Pret_total, Modalitate_plata)
VALUES (5010, 1010, 1009, 1050, 'Card Bancar');


COMMIT;
