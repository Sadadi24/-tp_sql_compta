
-- Listez les articles dans l’ordre alphabétique des désignations
SELECT *FROM ARTICLE order by DESIGNATION asc ;

-- Listez les articles dans l’ordre des prix du plus élevé au moins élevé
SELECT * FROM  ARTICLE a order by PRIX DESC ;

--- Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant

SELECT * FROM ARTICLE a WHERE DESIGNATION  LIKE '%boulon%'
ORDER by PRIX ASC ;

--- Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse 
SELECT *
FROM ARTICLE a 
WHERE  DESIGNATION  LIKE '%sachet%';

--- Listez les articles avec les informations fournisseur correspondantes, triées dans l’ordre alphabétique des fournisseurs et par prix décroissant

SELECT a.*, f.NOM  FROM ARTICLE a join FOURNISSEUR f on a.ID_FOU = f.ID  ORDER by f.NOM ASC ,PRIX DESC ;

-- Listez les articles de la société « Dubois & Fils »
SELECT * FROM ARTICLE  WHERE ID_FOU = 3;

--- Calculez la moyenne des prix des articles de la société « Dubois & Fils »

SELECT AVG(a.PRIX) as moyenne_des_prix from ARTICLE a WHERE ID_FOU = 3;

---Calculez la moyenne des prix des articles de chaque fournisseur

SELECT f.NOM as fourniseur, AVG(a.PRIX) as moyenne FROM ARTICLE a   join FOURNISSEUR f ON a.ID_FOU = f.ID GROUP BY f.NOM ;

--- Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00

SELECT * FROM BON   WHERE DATE_CMDE  BETWEEN '2019-03-01' AND '2019-04-05 12:00:00';

--- Sélectionnez les divers bons de commande qui contiennent des boulons

SELECT a.DESIGNATION ,b.*
FROM BON b 
JOIN COMPO c  ON c.ID_BON = b.ID 
JOIN ARTICLE a ON c.ID_ART  = a.ID 
WHERE a.DESIGNATION  LIKE '%boulon%';

-- Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.

SELECT f.NOM ,a.*
FROM BON b 
JOIN COMPO c  ON c.ID_BON = b.ID 
JOIN ARTICLE a ON c.ID_ART  = a.ID 
join FOURNISSEUR f on b.ID_FOU = f.ID 
WHERE a.DESIGNATION  LIKE '%boulon%';

--- . Comptez le nombre d’articles de chaque bon de commande
SELECT b.*,SUM(c.QTE) as quantité  FROM BON b 
 join COMPO c on b.ID = c.ID_BON 
 JOIN ARTICLE a on c.ID_ART = a.ID 
 GROUP BY b.ID
 
 --- Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d’articles de chacun de ces bons de commande
 
 
 SELECT b.NUMERO as num_commande, SUM(c.QTE) FROM BON b 
 join COMPO c on b.ID = c.ID_BON 
 JOIN ARTICLE a on c.ID_ART = a.ID 
 GROUP BY b.ID
 HAVING SUM(c.QTE) >=25;



-- Calculez le coût total des commandes effectuées sur le mois d’avril 

SELECT  SUM(c.QTE * a.PRIX)  FROM BON b 
join COMPO c on b.ID = c.ID_BON 
JOIN ARTICLE a on b.ID = c.ID_BON 
WHERE MONTH(b.DATE_CMDE)= 4

 --- 3) Requêtes plus difficiles :
 
 
 -- a. Sélectionnez les articles qui ont une désignation identique mais des fournisseurs différents (indice : 
 -- réaliser une auto-jointure i.e. de la table avec elle-même)
 
SELECT a.*
FROM ARTICLE a
JOIN ARTICLE a2 ON a.DESIGNATION = a2.DESIGNATION
WHERE a.ID_FOU != a2.ID_FOU ;

-- b-Calculez les dépenses en commandes mois par mois (indice : utilisation des fonctions MONTH et YEAR)

SELECT
	YEAR(DATE_CMDE) AS Annee,
	MONTH(DATE_CMDE) AS Mois,
	SUM(PRIX * QTE) AS Depenses
FROM
	BON
JOIN COMPO ON
	BON.ID = COMPO.ID_BON
JOIN ARTICLE ON
	COMPO.ID_ART = ARTICLE.ID
GROUP BY
	YEAR(DATE_CMDE),
	MONTH(DATE_CMDE)
ORDER BY
	Annee,
	Mois;


--  C-Sélectionnez les bons de commandes sans article (indice : utilisation de EXISTS)

SELECT *
FROM BON
WHERE NOT EXISTS (
    SELECT *
    FROM COMPO
    WHERE COMPO.ID_BON = BON.ID
);

-- d. Calculez le prix moyen des bons de commande par fournisseur.

SELECT F.NOM AS Fournisseur,
       COUNT(PRIX_TOTAL) AS nombreCommande,
        SUM(PRIX_TOTAL) AS PrixTOtal,
         AVG(PRIX_TOTAL) AS PrixMoyen
         
FROM (
    SELECT BON.ID_FOU,
           SUM(ARTICLE.PRIX * COMPO.QTE) AS PRIX_TOTAL
    FROM BON
    JOIN COMPO ON BON.ID = COMPO.ID_BON
    JOIN ARTICLE ON COMPO.ID_ART = ARTICLE.ID
    GROUP BY BON.ID
) AS B
JOIN FOURNISSEUR F ON B.ID_FOU = F.ID
GROUP BY F.NOM;







