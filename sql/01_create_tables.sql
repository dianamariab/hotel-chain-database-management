-- =========================================================
-- Hotel Chain Database Management System
-- File: 01_create_tables.sql
-- Purpose: Create the relational database structure
-- Database: Oracle SQL
-- =========================================================

-- HOTELURI
CREATE TABLE HOTELURI (
    Id_hotel NUMBER(6) PRIMARY KEY,
    Denumire VARCHAR2(50) NOT NULL,
    Capacitate NUMBER(4),
    Locatie VARCHAR2(50)
);

-- CAMERE
CREATE TABLE CAMERE (
    Id_camera NUMBER(6) PRIMARY KEY,
    Id_hotel NUMBER(6),
    Tip_camera VARCHAR2(50),
    Etaj NUMBER(2),
    Nr_camera NUMBER(4) UNIQUE,
    Pret_noapte NUMBER(10),

    CONSTRAINT FK_CAMERE_HOTEL
        FOREIGN KEY (Id_hotel)
        REFERENCES HOTELURI(Id_hotel)
);

-- CLIENTI
CREATE TABLE CLIENTI (
    Id_client NUMBER(6) PRIMARY KEY,
    Nume_client VARCHAR2(30) NOT NULL,
    Prenume_client VARCHAR2(30) NOT NULL,
    Nr_telefon NUMBER(10),
    Email VARCHAR2(50),
    Oras VARCHAR2(50)
);

-- REZERVARI
CREATE TABLE REZERVARI (
    Id_rezervare NUMBER(6) PRIMARY KEY,
    Id_hotel NUMBER(6),
    Id_camera NUMBER(6),
    Id_client NUMBER(6),
    Check_in DATE NOT NULL,
    Check_out DATE NOT NULL,

    CONSTRAINT FK_REZERVARI_HOTEL
        FOREIGN KEY (Id_hotel)
        REFERENCES HOTELURI(Id_hotel),

    CONSTRAINT FK_REZERVARI_CAMERA
        FOREIGN KEY (Id_camera)
        REFERENCES CAMERE(Id_camera),

    CONSTRAINT FK_REZERVARI_CLIENT
        FOREIGN KEY (Id_client)
        REFERENCES CLIENTI(Id_client)
);

-- FACTURI
CREATE TABLE FACTURI (
    Id_factura NUMBER(6) PRIMARY KEY,
    Id_rezervare NUMBER(6),
    Nr_factura NUMBER(10),
    Pret_total NUMBER(20) NOT NULL,
    Modalitate_plata VARCHAR2(50),

    CONSTRAINT FK_FACTURI_REZERVARE
        FOREIGN KEY (Id_rezervare)
        REFERENCES REZERVARI(Id_rezervare)
);
