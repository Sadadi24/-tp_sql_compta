
--- Listez toutes les données concernant les articles

SELECT * FROM ARTICLE ;

--  Listez uniquement les références et désignations des articles de plus de 2 euro

SELECT REF , DESIGNATION  from ARTICLE a  WHERE a.PRIX > 2 ;

---  En utilisant les opérateurs de comparaison, listez tous les articles dont le prix est compris entre 2 et 6.25 euros


--- En utilisant les opérateurs de comparaison, listez tous les articles dont le prix est compris entre 2 et 6.25 euros
SELECT * FROM ARTICLE a WHERE a.PRIX >2 AND a.PRIX <=6.25;


---En utilisant l’opérateur BETWEEN, listez tous les articles dont le prix est compris entre 2 et 6.25 euros

SELECT * FROM ARTICLE a WHERE a.PRIX  BETWEEN 2 AND 6.25;

--- Listez tous les articles, dans l’ordre des prix descendants
--- et dont le prix n’est pas compris entre 2 et 6.25 euros et dont le fournisseur est Française d’Imports.

SELECT a.* FROM 
ARTICLE a 
WHERE ID_FOU = (SELECT ID FROM FOURNISSEUR  WHERE  ID  = 1 )
order by a.PRIX ASC ;

SELECT * FROM FOURNISSEUR f WHERE f.ID  = 1;

SELECT
	*
FROM
	ARTICLE a
WHERE
	ID_FOU = 1
	OR ID_FOU = 3;

-
-- En utilisant l’opérateur IN, réalisez la même requête que précédemment

SELECT *
FROM ARTICLE a 
WHERE ID_FOU  IN (3 , 1);

--- En utilisant les opérateurs NOT et IN, listez tous les articles dont les fournisseurs ne sont ni Française d’Imports, ni Dubois et Fils.

SELECT * FROM  ARTICLE a WHERE ID_FOU  NOT  IN (3,1)


--- Listez tous les bons de commande dont la date de commande est entre le 01/02/2019 et le 30/04/2019.
SELECT *
FROM BON b  
WHERE DATE_CMDE  BETWEEN '2019-02-01' AND '2019-04-30';

