
--- a. Mettez en minuscules la désignation de l’article dont l’identifiant est 2

UPDATE ARTICLE
SET DESIGNATION = LOWER(DESIGNATION)
WHERE ID = 2;



--- b.Mettez en majuscules les désignations de tous les articles dont le prix est strictement supérieur à 10€

UPDATE
	ARTICLE a
SET
	DESIGNATION = UPPER(DESIGNATION)
WHERE
	a.PRIX >10;


--- c. Baissez de 10% le prix de tous les articles qui n’ont pas fait l’objet d’une commande.

UPDATE ARTICLE a
SET a.PRIX = (a.PRIX *0.90)
WHERE a.ID NOT  IN (SELECT  ID_ART from COMPO );



--- d. Une erreur s’est glissée dans les commandes concernant Française d’imports. Les chiffres en base ne sont pas bons. Il faut doubler les quantités de tous les articles
 -- commandés à cette société.

UPDATE
	COMPO c
SET
	c.QTE = c.QTE * 2
WHERE
	EXISTS (
	SELECT *
	FROM
		BON b
	join FOURNISSEUR f on
		b.ID_FOU = f.ID 
	WHERE
		f.ID = 1
		AND b.ID = c.ID_BON);
	

SELECT *FROM ARTICLE a ;

