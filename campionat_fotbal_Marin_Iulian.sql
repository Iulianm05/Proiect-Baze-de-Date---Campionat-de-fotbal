CREATE TABLE IMPRESARI(
    impresar_id NUMBER(5,0)
        CONSTRAINT IMPRESARI_impresar_id_PK PRIMARY KEY,
    nume_impresar VARCHAR2(50)
        CONSTRAINT NUME_IMP_NN NOT NULL,
    prenume_impresar VARCHAR2(50)
        CONSTRAINT PRENUME_IMP_NN NOT NULL,
    nr_telefon VARCHAR2(10)
        CONSTRAINT NR_TEL_NN NOT NULL
        CONSTRAINT NR_TEL_U UNIQUE
        CONSTRAINT NR_TEL_L CHECK(LENGTH(nr_telefon)=10),
    email VARCHAR2(255)
        CONSTRAINT EMAIL_NN NOT NULL,
        CONSTRAINT EMAIL_C CHECK(REGEXP_LIKE(email, '[[:alnum:]]+@[[:alnum:]]+\.[[:alnum:]]'))
);

CREATE TABLE ARBITRI(
    arbitru_id NUMBER(5,0)
        CONSTRAINT ARBITRU_ID_PK PRIMARY KEY,
    nume_arbitru VARCHAR2(50)
        CONSTRAINT NUME_ARBITRU_NN NOT NULL,
    prenume_arbitru VARCHAR2(50)
        CONSTRAINT PRENUME_ARBITRU_NN NOT NULL,
    nr_cartonase_galbene NUMBER(3,0)
        CONSTRAINT NR_CART_G_C CHECK(nr_cartonase_galbene>0);
    nr_cartonase_rosii NUMBER(3,0)
        CONSTRAINT NR_CART_R_C CHECK(nr_cartonase_rosii>0)
    );

        
CREATE TABLE ECHIPE(
    echipa_id NUMBER(5,0)
        CONSTRAINT ECHIPA_ID_PK PRIMARY KEY,
    nume_echipa VARCHAR2(50)
        CONSTRAINT NUME_NN NOT NULL
        CONSTRAINT NUME_U UNIQUE,
    data_infiintare DATE
        CONSTRAINT DATA_INF_NN NOT NULL,
    oras varchar2(50)
        CONSTRAINT ORAS_NN NOT NULL,
    culoare_tricou varchar2(50)
        CONSTRAINT CUL_NN NOT NULL
        CONSTRAINT CUL_C CHECK (culoare_tricou in('rosu','alb','albastru','verde', 'negru', 'maro', 'galben', 'portocaliu','mov')),
    culoare_tricou_deplasare varchar2(50)
        CONSTRAINT CUL_D_NN NOT NULL
        CONSTRAINT CUL_D_C CHECK (culoare_tricou_deplasare in('rosu','alb','albastru','verde', 'negru', 'maro', 'galben', 'portocaliu','mov'))
  ); 

ALTER TABLE ECHIPE
ADD porecla VARCHAR2(50);
  
CREATE TABLE SPONSORI(
    sponsor_id number(5,0)
        CONSTRAINT SPONSOR_ID_PK PRIMARY KEY,
    nume_sponsor varchar2(50)
        CONSTRAINT NUME_SP_NN NOT NULL
        CONSTRAINT NUME_SP_U UNIQUE,
    telefon VARCHAR2(10)
        CONSTRAINT TEL_NN NOT NULL
        CONSTRAINT TEL_C CHECK(LENGTH(telefon)=10),
    email varchar2(50)
        CONSTRAINT EMAIL_S_C CHECK(REGEXP_LIKE(email, '[[:alnum:]]+@[[:alnum:]]+\.[[:alnum:]]')));
        
CREATE TABLE LOCATII(
    locatie_id number(5,0)
        CONSTRAINT LOCAT_PK PRIMARY KEY,
    nume_locatie varchar2(50)
        CONSTRAINT LOCAT_NN NOT NULL
        CONSTRAINT LOCAT_U UNIQUE,
    populatie number(10,0)
        constraint POPULATIE_NN NOT NULL);
  ALTER TABLE LOCATII
  ADD CONSTRAINT PUPULATIE_C CHECK (populatie>0);

CREATE TABLE JUCATORI(
    jucator_id number(5,0)
        CONSTRAINT JUC_ID_PK PRIMARY KEY,
    nume VARCHAR2(50)
        CONSTRAINT NUME_J_NN NOT NULL,
    prenume VARCHAR2(50),
    echipa_id NUMBER(5,0)
        CONSTRAINT ECHIPA_ID_FK REFERENCES ECHIPE (echipa_id) ON DELETE SET NULL,
    impresar_id NUMBER(5,0)
        CONSTRAINT impresar_ID_FK REFERENCES IMPRESARI (impresar_id) ON DELETE SET NULL,
    salariu NUMBER(10,0)
        CONSTRAINT SALARIU_C CHECK (salariu>0),
    numar_tricou NUMBER(2,0)
        CONSTRAINT NR_TRICOU_C CHECK(numar_tricou>0),
    pozitie varchar2 (50)
        CONSTRAINT POZ_C CHECK(pozitie in ('Atacant','Mijlocas','Fundas','Portar'))
        CONSTRAINT POZ_NN NOT NULL);

ALTER TABLE JUCATORI
ADD data_nastere DATE
    CONSTRAINT DATA_NASTERE_J_NN NOT NULL;



        
CREATE TABLE ANTRENORI(
    antrenor_id NUMBER (5,0)
        CONSTRAINT ANTRENOR_ID_PK PRIMARY KEY,
    nume_antrenor VARCHAR2(50)
        CONSTRAINT NUME_ANTR_NN NOT NULL,
    prenume_antrenor VARCHAR2(50),
    echipa_id number(5,0)
        CONSTRAINT ECHIPA_ANT_FK REFERENCES ECHIPE (echipa_id) ON DELETE SET NULL,
    salariu number(10,0)
        CONSTRAINT salariu_ANT_C CHECK(salariu>0),
    data_nastere DATE
        CONSTRAINT DATA_NASTERE_ANT_NN NOT NULL,
    stil_de_joc VARCHAR2(50)
        CONSTRAINT STIL_JOC_ANT_C CHECK (stil_de_joc in ('Ofensiv','Defensiv','Posesie','Tiki Taka'))
);
ALTER TABLE ANTRENORI
    ADD CONSTRAINT ECHIPA_ANT_U  UNIQUE(echipa_id);

CREATE TABLE MEMBRI_STAFF_TEHNIC(
    id_membru NUMBER(5,0)
        CONSTRAINT ID_MEMBRU_PK PRIMARY KEY,
    echipa_id NUMBER(5,0)
        CONSTRAINT ECHIPA_ST_FK REFERENCES ECHIPE (echipa_id) ON DELETE SET NULL,
    nume VARCHAR2(50)
        CONSTRAINT NUME_STAFF_NN NOT NULL,
    prenume VARCHAR2(50),
    functie VARCHAR2(50)
        CONSTRAINT FUNCTIE_NN NOT NULL,
        CONSTRAINT FUNCTIE_C CHECK (functie in ('antrenor secund','preparator fizic', 'antrenor de portari', 'analist video')));
        
        
CREATE TABLE MECIURI(
    meci_id NUMBER(5,0)
        CONSTRAINT MECI_ID_PK PRIMARY KEY,
    echipa_gazda NUMBER(5,0)
        CONSTRAINT ECHIPA_GAZDA_FK REFERENCES ECHIPE(echipa_id) ON DELETE CASCADE
        CONSTRAINT ECHIPA_GAZDA_NN NOT NULL,
    echipa_oaspete NUMBER(5,0)
        CONSTRAINT ECHIPA_OASPETE_FK REFERENCES ECHIPE(echipa_id) ON DELETE CASCADE
        CONSTRAINT ECHIPA_OASPETE_NN NOT NULL,
    scor_echipa_gazda number(2,0)
        CONSTRAINT SCOR_1_NN NOT NULL
        CONSTRAINT SCOR_1_C CHECK(scor_echipa_gazda>=0),
    scor_echipa_oaspete number(2,0)
        CONSTRAINT SCOR_2_NN NOT NULL
        CONSTRAINT SCOR_2_C CHECK(scor_echipa_oaspete>=0),
    arbitru_id NUMBER(5,0)
        CONSTRAINT ARBITRU_FK REFERENCES ARBITRI (arbitru_id) on delete cascade
        CONSTRAINT ARBITRU_NN NOT NULL,
    stadion_id VARCHAR2(50)
        CONSTRAINT stadion_nn NOT NULL);
        
        ALTER TABLE MECIURI        
        ADD CONSTRAINT ECHIPA_OASPETE_C CHECK(echipa_gazda!=echipa_oaspete);

CREATE TABLE STADIOANE (
    id_stadion NUMBER (5,0)
        CONSTRAINT ID_STADION_PK PRIMARY KEY,
    nume_stadion VARCHAR2(50)
        CONSTRAINT NUME_STD_NN NOT NULL,
    capacitate NUMBER (7,0)
        CONSTRAINT CAPAC_C CHECK (capacitate>100)
        CONSTRAINT CAPAC_NN NOT NULL,
    locatie_id number(5,0)
        CONSTRAINT LOCATIE_FK REFERENCES LOCATII(locatie_id) ON DELETE CASCADE
        CONSTRAINT LOCATIE_NN NOT NULL);
        
CREATE TABLE SPONSORIZARI(
    echipa_id NUMBER(5,0)
        CONSTRAINT ECHIPA_SPONS_ID_FK REFERENCES ECHIPE(echipa_id) on delete cascade,
    sponsor_id NUMBER(5,0)
        CONSTRAINT SPONSOR_ID_FK REFERENCES SPONSORI (sponsor_id) ON DELETE CASCADE,
    inceput_sponsorizare DATE
        CONSTRAINT INCEPUT_SPONSORIZARE_NN NOT NULL,
    incetare_sponsorizare DATE
        CONSTRAINT INCETARE_SPONSORIZARE_NN NOT NULL);
        
    
 ALTER TABLE SPONSORIZARI
 ADD CONSTRAINT ECHIPA_ID_SPONSOR_ID PRIMARY KEY(echipa_id, sponsor_id);
  ALTER TABLE SPONSORIZARI
 ADD CONSTRAINT DATE_CHECK CHECK(inceput_sponsorizare<incetare_sponsorizare);
 
 
 CREATE SEQUENCE IMPRESARI_IMPRESARI_ID_SEQ MAXVALUE 999 INCREMENT BY 1
START WITH 1 NOCACHE ORDER NOCYCLE;

INSERT INTO IMPRESARI(impresar_id,nume_impresar,prenume_impresar,nr_telefon,email)
                values(IMPRESARI_IMPRESARI_ID_SEQ.nextval, 'Adrian','Tiberiu','0723505040','adyalexsport@yahoo.com');
 INSERT INTO IMPRESARI(impresar_id,nume_impresar,prenume_impresar,nr_telefon,email)
                values(IMPRESARI_IMPRESARI_ID_SEQ.nextval, 'Babutan','Aurelian','0723895040','babtusport@yahoo.com');    
 INSERT INTO IMPRESARI(impresar_id,nume_impresar,prenume_impresar,nr_telefon,email)
                values(IMPRESARI_IMPRESARI_ID_SEQ.nextval, 'Becali','Victor','0743565420','office@becalisport.ro');
INSERT INTO IMPRESARI(impresar_id,nume_impresar,prenume_impresar,nr_telefon,email)
                values(IMPRESARI_IMPRESARI_ID_SEQ.nextval, 'Chirila','Ion','0783569422','agentfifaion@yahoo.com');   
INSERT INTO IMPRESARI(impresar_id,nume_impresar,prenume_impresar,nr_telefon,email)
                values(IMPRESARI_IMPRESARI_ID_SEQ.nextval, 'Popescu','Valentin','0383569422','agentfifaval@yahoo.com'); 
                
 CREATE SEQUENCE LOCATII_ID_SEQ MAXVALUE 999 INCREMENT BY 1
START WITH 1 NOCACHE ORDER NOCYCLE;                

INSERT INTO LOCATII(locatie_id, nume_locatie ,populatie) values (LOCATII_ID_SEQ.nextval, 'Bucuresti', 1898425);
INSERT INTO LOCATII(locatie_id, nume_locatie ,populatie) values (LOCATII_ID_SEQ.nextval, 'Iasi', 318012);
INSERT INTO LOCATII(locatie_id, nume_locatie ,populatie) values (LOCATII_ID_SEQ.nextval, 'Cluj-Napoca', 309136);
INSERT INTO LOCATII(locatie_id, nume_locatie ,populatie) values (LOCATII_ID_SEQ.nextval, 'Timisoara', 306708);
INSERT INTO LOCATII(locatie_id, nume_locatie ,populatie) values (LOCATII_ID_SEQ.nextval, 'Constanta', 269012);
INSERT INTO LOCATII(locatie_id, nume_locatie ,populatie) values (LOCATII_ID_SEQ.nextval, 'Craiova', 269506);
INSERT INTO LOCATII(locatie_id, nume_locatie ,populatie) values (LOCATII_ID_SEQ.nextval, 'Sibiu', 229012);
INSERT INTO LOCATII(locatie_id, nume_locatie ,populatie) values (LOCATII_ID_SEQ.nextval, 'Pitesti', 155012);
INSERT INTO LOCATII(locatie_id, nume_locatie ,populatie) values (LOCATII_ID_SEQ.nextval, 'Arad', 147012);
INSERT INTO LOCATII(locatie_id, nume_locatie ,populatie) values (LOCATII_ID_SEQ.nextval, 'Ploiesti', 100012);
INSERT INTO LOCATII(locatie_id, nume_locatie ,populatie) values (LOCATII_ID_SEQ.nextval, 'Botosani', 91012);


 CREATE SEQUENCE SPONSORI_ID_SEQ MAXVALUE 999 INCREMENT BY 1
START WITH 1 NOCACHE ORDER NOCYCLE; 


INSERT INTO SPONSORI (SPONSOR_ID, NUME_SPONSOR, TELEFON, EMAIL)
                VALUES(SPONSORI_ID_SEQ.NEXTVAL,'OMV PETROM','0756345231','OMV@petrom.ro');
INSERT INTO SPONSORI (SPONSOR_ID, NUME_SPONSOR, TELEFON, EMAIL)
                VALUES(SPONSORI_ID_SEQ.NEXTVAL,'CITY INSURACE','0746335231','city@ins.ro');
INSERT INTO SPONSORI (SPONSOR_ID, NUME_SPONSOR, TELEFON, EMAIL)
                VALUES(SPONSORI_ID_SEQ.NEXTVAL,'BETANO','0756345301','BET@YAHOO.ro');
INSERT INTO SPONSORI (SPONSOR_ID, NUME_SPONSOR, TELEFON, EMAIL)
                VALUES(SPONSORI_ID_SEQ.NEXTVAL,'CASA PARIURILOR','0446345231','CASA@PARIU.ro');
INSERT INTO SPONSORI (SPONSOR_ID, NUME_SPONSOR, TELEFON, EMAIL)
                VALUES(SPONSORI_ID_SEQ.NEXTVAL,'OTP BANK','0759945231','otp@gmail.ro');
            
 CREATE SEQUENCE ARBITRII_ID_SEQ MAXVALUE 999 INCREMENT BY 1
START WITH 1 NOCACHE ORDER NOCYCLE; 

INSERT INTO ARBITRI (ARBITRU_ID, NUME_ARBITRU, PRENUME_ARBITRU, NR_CARTONASE_GALBENE, NR_CARTONASE_rosii)
                VALUES(ARBITRII_ID_SEQ.NEXTVAL,'Coltescu', 'Sebastian',50,2);
INSERT INTO ARBITRI (ARBITRU_ID, NUME_ARBITRU, PRENUME_ARBITRU, NR_CARTONASE_GALBENE, NR_CARTONASE_rosii)
                VALUES(ARBITRII_ID_SEQ.NEXTVAL,'Chivulete', 'Andrei',59,4);
INSERT INTO ARBITRI (ARBITRU_ID, NUME_ARBITRU, PRENUME_ARBITRU, NR_CARTONASE_GALBENE, NR_CARTONASE_rosii)
                VALUES(ARBITRII_ID_SEQ.NEXTVAL,'Barsan', 'Marcel',59,3);
INSERT INTO ARBITRI (ARBITRU_ID, NUME_ARBITRU, PRENUME_ARBITRU, NR_CARTONASE_GALBENE, NR_CARTONASE_rosii)
                VALUES(ARBITRII_ID_SEQ.NEXTVAL,'Kovacs', 'Istvan',48,3);
INSERT INTO ARBITRI (ARBITRU_ID, NUME_ARBITRU, PRENUME_ARBITRU, NR_CARTONASE_GALBENE, NR_CARTONASE_rosii)
                VALUES(ARBITRII_ID_SEQ.NEXTVAL,'Fesnic', 'Horatiu',33,3);
INSERT INTO ARBITRI (ARBITRU_ID, NUME_ARBITRU, PRENUME_ARBITRU, NR_CARTONASE_GALBENE, NR_CARTONASE_rosii)
                VALUES(ARBITRII_ID_SEQ.NEXTVAL,'Hategan', 'Ovidiu',70,5);
INSERT INTO ARBITRI (ARBITRU_ID, NUME_ARBITRU, PRENUME_ARBITRU, NR_CARTONASE_GALBENE, NR_CARTONASE_rosii)
                VALUES(ARBITRII_ID_SEQ.NEXTVAL,'Dima', 'Iulian',50,2);
                

 INSERT INTO ECHIPE( echipa_id, nume_echipa, data_infiintare, oras, culoare_tricou, culoare_tricou_deplasare, porecla)
                values(3, 'FCSB', TO_DATE('07-JUN-1947','DD-MON-YYYY'), 'Bucuresti','rosu','albastru','Ros-albastrii');

INSERT INTO ECHIPE( echipa_id, nume_echipa, data_infiintare, oras, culoare_tricou, culoare_tricou_deplasare, porecla)
                values(4, 'FC ARGES', TO_DATE('06-AUG-1953','DD-MON-YYYY'), 'ARGES','mov','alb','Trupa din Trivale');

INSERT INTO ECHIPE( echipa_id, nume_echipa, data_infiintare, oras, culoare_tricou, culoare_tricou_deplasare, porecla)
                values(5, 'CFR CLUJ', TO_DATE('10-NOV-1907','DD-MON-YYYY'), 'CLUJ','maro','alb','Ceferistii');

INSERT INTO ECHIPE( echipa_id, nume_echipa, data_infiintare, oras, culoare_tricou, culoare_tricou_deplasare, porecla)
                values(6, 'FC BOTOSANI', TO_DATE('07-JUN-2001','DD-MON-YYYY'), 'BOTOSANI','rosu','albastru','Botosanenii');

INSERT INTO ECHIPE( echipa_id, nume_echipa, data_infiintare, oras, culoare_tricou, culoare_tricou_deplasare, porecla)
                values(7, 'AFC Chindia Targoviste', TO_DATE('11-AUG-1950','DD-MON-YYYY'), 'Targoviste','rosu','albastru','Micul Ajax');

INSERT INTO ECHIPE( echipa_id, nume_echipa, data_infiintare, oras, culoare_tricou, culoare_tricou_deplasare, porecla)
                values(8, 'Farul Constanta', TO_DATE('11-JUN-2009','DD-MON-YYYY'), 'Constanta','alb','albastru','Pustii lui Hagi');

INSERT INTO ECHIPE( echipa_id, nume_echipa, data_infiintare, oras, culoare_tricou, culoare_tricou_deplasare, porecla)
                values(9, 'FCU CRAIOVA 1948', TO_DATE('17-JAN-1991','DD-MON-YYYY'), 'Craiova','alb','albastru','Alb-Albastrii');

INSERT INTO ECHIPE( echipa_id, nume_echipa, data_infiintare, oras, culoare_tricou, culoare_tricou_deplasare, porecla)
                values(10, 'Universitatea Craiova', TO_DATE('07-JUL-2013','DD-MON-YYYY'), 'Craiova','albastru','alb','Leii din Banie');

INSERT INTO ECHIPE( echipa_id, nume_echipa, data_infiintare, oras, culoare_tricou, culoare_tricou_deplasare, porecla)
                values(11, 'FC Hermannstadt', TO_DATE('29-JUL-2015','DD-MON-YYYY'), 'Sibiu','rosu','negru','Sibienii');

INSERT INTO ECHIPE( echipa_id, nume_echipa, data_infiintare, oras, culoare_tricou, culoare_tricou_deplasare, porecla)
                values(12, 'FC RAPID', TO_DATE('25-JUN-1923','DD-MON-YYYY'), 'Bucuresti','maro','alb','Giulestenii');

                
                

INSERT INTO SPONSORIZARI (echipa_id, sponsor_id, inceput_sponsorizare, incetare_sponsorizare)
                    values(3, 1,  TO_DATE('11-JUN-2010','DD-MON-YYYY'),  TO_DATE('11-JUN-2024','DD-MON-YYYY'));
INSERT INTO SPONSORIZARI (echipa_id, sponsor_id, inceput_sponsorizare, incetare_sponsorizare)
                    values(3, 2,  TO_DATE('11-JUN-2010','DD-MON-YYYY'),  TO_DATE('11-JUN-2024','DD-MON-YYYY'));
INSERT INTO SPONSORIZARI (echipa_id, sponsor_id, inceput_sponsorizare, incetare_sponsorizare)
                    values(10, 3,  TO_DATE('11-JUN-2010','DD-MON-YYYY'),  TO_DATE('11-JUN-2024','DD-MON-YYYY'));
INSERT INTO SPONSORIZARI (echipa_id, sponsor_id, inceput_sponsorizare, incetare_sponsorizare)
                    values(9, 4, TO_DATE('11-JUN-2010','DD-MON-YYYY'),  TO_DATE('11-JUN-2024','DD-MON-YYYY'));
INSERT INTO SPONSORIZARI (echipa_id, sponsor_id, inceput_sponsorizare, incetare_sponsorizare)
                    values(8, 1,  TO_DATE('11-JUN-2010','DD-MON-YYYY'),  TO_DATE('11-JUN-2024','DD-MON-YYYY'));
            

CREATE SEQUENCE JUCATOR_ID_SEQ MAXVALUE 9999 INCREMENT BY 1
START WITH 1 NOCACHE ORDER NOCYCLE;    

INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Olaru', 'Darius',3, 1, 10000, 8, 'Mijlocas', TO_DATE('11-JUN-2000','DD-MON-YYYY'));
INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Octavian', 'Popescu',3, 1, 12000, 10, 'Atacant', TO_DATE('15-JAN-2000','DD-MON-YYYY'));            
INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Compagno', 'Andrea',3, 2, 9000, 9, 'Atacant', TO_DATE('20-JUL-1997','DD-MON-YYYY'));
INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Burca', 'Andrei',5, 2, 10500, 3, 'Fundas', TO_DATE('11-JUN-1996','DD-MON-YYYY'));
INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Rondon', 'Mario',5, 5, 8000, 9, 'Atacant', TO_DATE('11-JUN-1990','DD-MON-YYYY'));
INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Julio', 'Donisa',4, 1, 10000, 8, 'Mijlocas', TO_DATE('11-JUN-2000','DD-MON-YYYY'));
INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Andreias', 'Calcan',4, 2, 10000, 8, 'Mijlocas', TO_DATE('30-JUN-2000','DD-MON-YYYY'));
INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Antoni', 'Ivanov',6, 1, 8000, 11, 'Mijlocas', TO_DATE('11-JUN-2000','DD-MON-YYYY'));
INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Mihai', 'Roman',6, 4, 7000, 10, 'Atacant', TO_DATE('30-JUN-1990','DD-MON-YYYY'));
 INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Cabuz', 'Catalin',7, 1, 8000, 1, 'Portar', TO_DATE('11-JUN-2000','DD-MON-YYYY'));
INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Cherchez', 'Cristian',7, 4, 7000, 10, 'Atacant', TO_DATE('25-AUG-1990','DD-MON-YYYY'));
 INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Alibec', 'Denis',8, 1, 8000, 9, 'Atacant', TO_DATE('11-JUN-1995','DD-MON-YYYY'));
INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Sali', 'Enes',8, 4, 7000, 13, 'Atacant', TO_DATE('25-AUG-2002','DD-MON-YYYY'));
 INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Achim', 'Vlad',9, 5, 7000, 6, 'Mijlocas', TO_DATE('11-JUN-1996','DD-MON-YYYY'));
INSERT INTO JUCATORI ( jucator_id, nume, prenume, echipa_id, impresar_id, salariu, numar_tricou, pozitie, data_nastere )
            values(JUCATOR_ID_SEQ.nextval, 'Albu', 'Catalin',9, 4, 7000, 15, 'Atacant', TO_DATE('25-AUG-2002','DD-MON-YYYY'));  
            
CREATE SEQUENCE STADIOANE_SEQ MAXVALUE 100 INCREMENT BY 1
START WITH 1 NOCACHE ORDER NOCYCLE;

INSERT INTO STADIOANE( id_stadion, nume_stadion, capacitate, locatie_id)
            values(STADIOANE_SEQ.nextval, 'Arena Nationala', 55000, 1);
INSERT INTO STADIOANE( id_stadion, nume_stadion, capacitate, locatie_id)
            values(STADIOANE_SEQ.nextval, 'Cluj Arena', 35000, 7);
INSERT INTO STADIOANE( id_stadion, nume_stadion, capacitate, locatie_id)
            values(STADIOANE_SEQ.nextval, 'Oblemenco', 44000, 5);

            
CREATE SEQUENCE MECIURI_ID_SEQ MAXVALUE 100 INCREMENT BY 1
START WITH 1 NOCACHE ORDER NOCYCLE;   

INSERT INTO MECIURI (meci_id, echipa_gazda, echipa_oaspete,scor_echipa_gazda, scor_echipa_oaspete, arbitru_id, stadion_id)
            VALUES(MECIURI_ID_SEQ.nextval, 3, 4, 0, 0, 1,1);
INSERT INTO MECIURI (meci_id, echipa_gazda, echipa_oaspete,scor_echipa_gazda, scor_echipa_oaspete, arbitru_id, stadion_id)
            VALUES(MECIURI_ID_SEQ.nextval, 3, 5, 1, 2, 2,1);
INSERT INTO MECIURI (meci_id, echipa_gazda, echipa_oaspete,scor_echipa_gazda, scor_echipa_oaspete, arbitru_id, stadion_id)
            VALUES(MECIURI_ID_SEQ.nextval, 8, 4, 3, 0, 3,2);
INSERT INTO MECIURI (meci_id, echipa_gazda, echipa_oaspete,scor_echipa_gazda, scor_echipa_oaspete, arbitru_id, stadion_id)
            VALUES(MECIURI_ID_SEQ.nextval, 4, 6, 1, 1, 1,3);
            


Insert into ANTRENORI (ANTRENOR_ID,NUME_ANTRENOR,PRENUME_ANTRENOR,ECHIPA_ID,SALARIU,DATA_NASTERE,STIL_DE_JOC) values (1,'Dica','Nicolae',3,11000,to_date('11-JUN-80','DD-MON-RR'),'Posesie');
Insert into ANTRENORI (ANTRENOR_ID,NUME_ANTRENOR,PRENUME_ANTRENOR,ECHIPA_ID,SALARIU,DATA_NASTERE,STIL_DE_JOC) values (2,'Hagi','Gheorghe',8,20000,to_date('12-AUG-68','DD-MON-RR'),'Tiki Taka');
Insert into ANTRENORI (ANTRENOR_ID,NUME_ANTRENOR,PRENUME_ANTRENOR,ECHIPA_ID,SALARIU,DATA_NASTERE,STIL_DE_JOC) values (3,'Petrea','Anton',7,1000,to_date('30-NOV-78','DD-MON-RR'),null);
Insert into ANTRENORI (ANTRENOR_ID,NUME_ANTRENOR,PRENUME_ANTRENOR,ECHIPA_ID,SALARIU,DATA_NASTERE,STIL_DE_JOC) values (4,'Mutu','Adrian',12,15000,to_date('15-DEC-77','DD-MON-RR'),'Ofensiv');
Insert into ANTRENORI (ANTRENOR_ID,NUME_ANTRENOR,PRENUME_ANTRENOR,ECHIPA_ID,SALARIU,DATA_NASTERE,STIL_DE_JOC) values (5,'Petrescu','Dan',5,9000,to_date('16-SEP-70','DD-MON-RR'),'Defensiv');


INSERT INTO MEMBRI_STAFF_TEHNIC(id_membru, echipa_id, nume, prenume, functie) values (1, 3, 'Adrian', 'Ilie','preparator fizic');
INSERT INTO MEMBRI_STAFF_TEHNIC(id_membru, echipa_id, nume, prenume, functie) values (2, 3, 'Adrian', 'Claudiu','antrenor secund');
INSERT INTO MEMBRI_STAFF_TEHNIC(id_membru, echipa_id, nume, prenume, functie) values (3, 5, 'Rares', 'Paun','antrenor secund');
INSERT INTO MEMBRI_STAFF_TEHNIC(id_membru, echipa_id, nume, prenume, functie) values (4, 7, 'Tanase', 'Ilie','analist video');
INSERT INTO MEMBRI_STAFF_TEHNIC(id_membru, echipa_id, nume, prenume, functie) values (5, 8, 'Adrian', 'Nastase','antrenor de portari');

commit;