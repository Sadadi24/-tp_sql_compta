

-- Utiliser la base de données compta
USE compta;

-- 2) Créer la table ARTICLE
CREATE TABLE ARTICLE (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    REF VARCHAR(50) NOT NULL,
    DESIGNATION VARCHAR(255) NOT NULL,
    PRIX DECIMAL(10, 2) NOT NULL,
    ID_FOU INT,
    FOREIGN KEY (ID_FOU) REFERENCES FOURNISSEUR(ID)
);

-- Créer la table FOURNISSEUR
CREATE TABLE FOURNISSEUR (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NOM VARCHAR(255) NOT NULL
);

-- Créer la table BON
CREATE TABLE BON (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NUMERO VARCHAR(50) NOT NULL,
    DATE_CMDE DATE NOT NULL,
    DELAI INT NOT NULL,
    ID_FOU INT,
    FOREIGN KEY (ID_FOU) REFERENCES FOURNISSEUR(ID)
);

-- Créer la table COMPO
CREATE TABLE COMPO (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    QTE INT NOT NULL,
    ID_ART INT,
    ID_BON INT,
    FOREIGN KEY (ID_ART) REFERENCES ARTICLE(ID),
    FOREIGN KEY (ID_BON) REFERENCES BON(ID)
);


-- inserer des données

INSERT INTO FOURNISSEUR  ( NOM)
VALUES
    ('Française d’Imports'),
    ( 'FDM SA'),
    ( 'Dubois & Fils');
   
   INSERT INTO ARTICLE  ( REF, Designation, Prix, ID_FOU)
VALUES
    ( 'A01', 'Perceuse P1', 74.99 , 1),
    ( 'F01', 'Boulon laiton 4 x 40 mm (sachet de 10)', 2.25 , 2),
    ('F02', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.45 , 2),
    ('D01', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.40 , 3),
    ('A02', 'Meuleuse 125mm', 37.85, 1),
    ( 'D03', 'Boulon acier zingué 4 x 40mm (sachet de 10)', 1.8 , 3),
    ( 'A03', 'Perceuse à colonne', 185.25 , 1),
    ( 'D04', 'Coffret mêches à bois', 12.25 , 1),
    ('F03', 'Coffret mêches plates', 6.25 , 1),
    ( 'F04', 'Fraises d’encastrement', 8.14 ,2);
   
   INSERT INTO  BON (NUMERO,DELAI,DATE_CMDE , ID_FOU) values ('3perceuses P1',3 ,NOW() , 1),
   ('4 meuleuses 125mm',3 ,NOW(), 1),('1 perceuse à colonne',3 ,NOW(), 1)

SELECT * FROM BON b     ;
