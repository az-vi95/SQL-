CREATE DATABASE biblioteque;
USE bibliotheque;
--copier coller la totalité du fichier biliotheque.sql

--pour tester la valeur NULL, on utilise IS NULL ou IS NOT NULL
SELECT id_livre FROM emprunt WHERE date_rendu IS NULL;
+----------+
| id_livre |
+----------+
|      105 |
|      100 |
+----------+
--Les titres des livres qui n'ont pas été rendu

SELECT titre FROM livre WHERE id_livre IN (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL);
+-------------------------+
| titre                   |
+-------------------------+
| Une vie                 |
| Les Trois Mousquetaires |
+-------------------------+

-- Exo : Les prenoms des abonnés n'ayant pas encore rendu un livre à la bibliotheque

SELECT prenom FROM abonne WHERE id_abonne IN (SELECT id_abonne FROM emprunt WHERE date_rendu IS NULL);

-- Nous aimerions connaître le n° de(s) livre(s) que Chloé a déja emprunté à la bibliotheque.

SELECT id_livre FROM emprunt WHERE id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom = "Chloe");
+----------+
| id_livre |
+----------+
|      100 |
|      105 |
+----------+

-- Exo : Afficher les prénoms des abonnés ayant emprunté un livre le 19/12/2014.

SELECT prenom FROM abonne WHERE id_abonne IN (SELECT id_abonne FROM emprunt WHERE date_sortie = '2014-12-19');

+-----------+
| prenom    |
+-----------+
| Guillaume |
| Chloe     |
| Laura     |
+-----------+

-- Exo : Combien de livre Guillaume a emprunté à la bibliotheque:

SELECT COUNT(*) AS 'Nombre de livres empruntés' FROM emprunt WHERE id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom = 'Guillaume');

+------------------+
| Nombre de livres |
+------------------+
|                2 |
+------------------+

-- Afficher le(s) prénom(s) des abonnés ayant déja emprunté un livre d'Alphonse Daudet:

SELECT prenom AS "Abonné ayant emprunté un livre d'\Alphonse Daudet" FROM abonne WHERE id_abonne IN
    (SELECT id_abonne FROM emprunt WHERE id_livre IN 
        (SELECT id_livre FROM livre WHERE auteur = "ALPHONSE DAUDET"));

+--------------------------------------------------+
| Abonné ayant emprunté un livre d'Alphonse Daudet |
+--------------------------------------------------+
| Laura                                            |
+--------------------------------------------------+

--Nous aimerions connaître le(s) titre(s) des livres que Chloé a remprunté à la bibliotheque:

SELECT titre FROM livre WHERE id_livre IN 
    (SELECT id_livre FROM emprunt WHERE id_abonne IN 
        (SELECT id_abonne FROM abonne WHERE prenom = 'Chloe'));

+-------------------------+
| titre                   |
+-------------------------+
| Une vie                 |
| Les Trois Mousquetaires |
+-------------------------+

--Nous aimerions connaître le(s) titre(s) des livres que Chloé n'a pas emprunté à la bibliothque: 

SELECT titre FROM livre WHERE id_livre NOT IN 
    (SELECT id_livre FROM emprunt WHERE id_abonne IN 
        (SELECT id_abonne FROM abonne WHERE prenom = 'Chloe'));

+-----------------+
| titre           |
+-----------------+
| Bel-Ami         |
| Le p?re Goriot  |
| Le Petit chose  |
| La Reine Margot |
+-----------------+

--Nous aimeraions connaire les livre que Chloé n'a pas rendu.

SELECT titre FROM livre WHERE id_livre IN 
    (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL AND id_abonne IN 
        (SELECT id_abonne FROM abonne WHERE prenom = 'Chloe'));


--/!\ Qui a emprunté le plus de livre à la bibliotheque?--

SELECT id_abonne, COUNT(*) FROM emprunt GROUP BY id_abonne ORDER BY COUNT(id_abonne) DESC LIMIT 1;

+-----------+----------+
| id_abonne | COUNT(*) |
+-----------+----------+
|         2 |        3 |
+-----------+----------+

SELECT prenom FROM abonne WHERE id_abonne = (SELECT id_abonne FROM emprunt GROUP BY id_abonne ORDER BY COUNT(id_abonne) DESC LIMIT 1);

+--------+
| prenom |
+--------+
| Benoit |
+--------+

SELECT prenom
FROM abonne, emprunt
WHERE abonne.id_abonne = emprunt.id_abonne
GROUP BY emprunt.id_abonne
ORDER BY COUNT(emprunt.id_emprunt) DESC LIMIT 1; 

+--------+
| prenom |
+--------+
| Benoit |
+--------+
--------------------------------------------------------------------------------------------
----REQUETE DE JOINTURE
--------------------------------------------------------------------------------------------
--JOINTURE : possible dans tous les cas !
--IMBRIQUEE: possible uniquement si les champs obtenus ne proviennent que d'une seule table

-- Nous aimerions connaître les dates de rendu et les dates de sorties pour l'abonné Guillaume.

SELECT prenom, date_sortie, date_rendu 
FROM abonne, emprunt
WHERE prenom = 'Guillaume'
AND emprunt.id_abonne = abonne.id_abonne;

-- On peut donner déclarer un autre nom:
SELECT prenom, date_sortie, date_rendu 
FROM abonne a, emprunt e
WHERE prenom = 'Guillaume'
AND a.id_abonne = e.id_abonne;

--Exo : Nous aimerions connaître les dates de sortie et les dates de rendu pour les livres écrit par Alphonse Daudet:

SELECT auteur, titre, date_sortie, date_rendu
FROM emprunt, livre
WHERE auteur = 'Alphonse Daudet'
AND emprunt.id_livre = livre.id_livre;

-- Qui a emprunté le livre "une vie" sur l'année 2014?

SELECT prenom, titre, date_sortie
FROM emprunt, livre, abonne
WHERE titre = "une vie"
AND date_sortie LIKE "2014%"
AND livre.id_livre = emprunt.id_livre
AND emprunt.id_abonne = abonne.id_abonne;

-- Nous aimerions connaître le nombre de livre emprunté par chaques abonnés:

SELECT COUNT(id_livre), prenom
FROM emprunt, abonne
WHERE emprunt.id_abonne = abonne.id_abonne
GROUP BY prenom;


--Nous aimerions connaitre le nombre de livre à rendre pour chaque abonnés: 
SELECT prenom, COUNT(id_emprunt)
FROM emprunt, abonne
WHERE date_rendu IS NULL
AND emprunt.id_abonne = abonne.id_abonne
GROUP BY prenom;

-- Qui a emprunté Quoi et Quand ? (prenom | titre | date_sortie):

SELECT  prenom, titre, date_sortie
FROM emprunt, abonne, livre
WHERE livre.id_livre = emprunt.id_livre
AND emprunt.id_abonne = abonne.id_abonne;

SELECT a.*, e.*, l.*
FROM emprunt e, abonne a, livre l
WHERE l.id_livre = e.id_livre
AND e.id_abonne = a.id_abonne;


-- Rajouez vous dans la table abonné

INSERT INTO abonne(id_abonne, prenom)
VALUES (5, 'Thierry');

--AFficher tous les abonnés sans exception + les id des livres

SELECT prenom, id_livre
FROM abonne, emprunt
WHERE emprunt.id_abonne = abonne.id_abonne;

-- JOINTURE EXTERNE SANS CORRESPONDANCE EXIGEE
-- sens de la lecture de la requête 

SELECT a.prenom, e.id_livre
FROM abonne a
LEFT JOIN emprunt e
ON e.id_abonne = a.id_abonne;

+-----------+----------+
| prenom    | id_livre |
+-----------+----------+
| Guillaume |      100 |
| Benoit    |      101 |
| Chloe     |      100 |
| Laura     |      103 |
| Guillaume |      104 |
| Benoit    |      105 |
| Chloe     |      105 |
| Benoit    |      100 |
+-----------+----------+


SELECT a.prenom, e.id_livre
FROM abonne a
LEFT JOIN emprunt e
ON e.id_abonne = a.id_abonne WHERE prenom LIKE '%l%' ORDER BY prenom;

-- La clause LEFT JOIN permet de rapatrier toutes les donénes sans exception de la table considérée comme étant à gauche 'selon le sens de la lecture, dans notre exemple au dessus; c'est abonné qui est à gauche d'emprunt)

--Il est aussi possibhle d'utiliser RIGHT JOIN (qui donera la priorité à la table de droite du sens de lecture)

