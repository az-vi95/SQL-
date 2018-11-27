-- * console mysql xampp :
-- Pour ouvrri la console MYSQL sur XAMPP
-- ouvrir le shell et taper les lignes suivantes
--Sur MAC,il faut rajouter -p root
cd c:\xampp\mysql\bin
mysql.exe -u root --password

-- commentaire sur une ligne sql
# commentaire sur une ligne sql

-- Pour créer un BDD
CREATE DATABASE entreprise;

-- Pour voir les BDD du serveur
SHOW DATABASES; -- SHOW TABLES;

-- pour se positionner sur une BDD et commernce à la manipuler
USE nom_de_la_bdd;

-- Pour supprimer une BDD
DROP DATABASE nom_de_la_bdd; -- DROP TABLE nom_de_la_table;

-- Pour vider les données d'une table sans supprimer sa structure
TRUNCATE nom_de_la_table;

-- Pour voir la structure d'une table
DESC nom_de_la_table;



--##############################################################
--##############################################################
--#  REQUETES DE SELECTION
--##############################################################
--##############################################################

-- Affichage complet des données de la table
SELECT id_employes, prenom, nom, sexe, service, date_embauche, salaire FROM employes;
SELECT * FROM employes; -- * caractère universel (ALL)

-- uniquement les nom et prénoms
SELECT nom, prenom FROM employes;

-- EXERCICE : afficher les différents services de la table employes
SELECT service FROM employes;

--afficher les DIFFERENTS services de la table employes
SELECT DISTINCT service FROM employes;

--### CONDITIONS
-- Affichage des employes du service informatique uniquement
SELECT nom, prenom, service, salaire FROM employes WHERE service = 'informatique';
--WHERE => à la condition que 

-- Affichage des employes ayant été recruté entre 2010 et aujourd'hui
SELECT nom, prenom, service, date_embauche FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND '2018-10-16';

-- CURDATE() est une fonction prédéfinie nous renvoyant la date du jour
SELECT CURDATE();
SELECT nom, prenom, service, date_embauche FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND CURDATE();

-- LIKE
-- like permet de ne pas préciser l'information complete.
SELECT prenom FROM employes WHERE prenom LIKE 's%'; -- les prénoms commençant par la lettre s
SELECT prenom FROM employes WHERE prenom LIKE '%s'; -- les prénoms finissaant par la lettre s
SELECT prenom FROM employes WHERE prenom LIKE '%ie%'; -- les prénoms contenant  les lettres ie

-- exclusion
-- Affichage de tous les employes sauf ceux du service informatique
SELECT nom, service FROM employes WHERE service != 'informatique';

-- OPERATEURS DE COMPARAISON
-- > strictement supérieur
-- < strictement inférieur
-- >= supérieur ou égal
-- <= inférieur ou égal
-- = égal à
-- != différent de 

-- Affichage de tous les employes ayant un salaire strictement supérieur à 3000
SELECT nom FROM employes WHERE salaire > 3000;
SELECT nom, salaire FROM employes WHERE salaire > 3000;

-- ORDER BY 
SELECT prenom, nom, salaire FROM employes ORDER BY prenom ASC; -- résultat ordonné en ordre ascendant (ASC par defaut)
SELECT prenom, nom, salaire FROM employes ORDER BY prenom DESC; -- résultat ordonnée en ordre descendant
SELECT prenom, nom, salaire FROM employes ORDER BY salaire DESC, prenom ASC;

-- LIMIT
-- affichage des employes 3 par 3 (pagination)
SELECT * FROM employes LIMIT 1;
SELECT * FROM employes ORDER BY prenom LIMIT 0, 3;
SELECT * FROM employes ORDER BY prenom LIMIT 3, 3;
SELECT * FROM employes ORDER BY prenom LIMIT 6, 3;

-- LIMIT 1 nous renvoi 1 seule ligne
-- LIMIT 0, 3 nous renvoi 3 ligne en partant de la position 0
-- LIMIT avec 2 valeurs: la premiere représente la position de départ, la deuxieme valeur représente le nombre de ligne 
-- à récupérer depuis cette position de départ.

--Affichage des employes avec leur salaire annuel
SELECT nom, prenom, service, salaire*12 FROM employes;
SELECT nom, prenom, service, salaire*12 AS salaire_annuel FROM employes;
SELECT nom, prenom, service, salaire*12 AS 'Salaire annuel' FROM employes;
SELECT nom AS 'Nom utilisateur', prenom AS 'Prenom utilisateur', service AS 'Profession', salaire*12 AS salaire_annuel FROM employes;

--# Quelle est la masse salariale annuelle des employes
-- SUM()
SELECT SUM(salaire*12) AS salaire_annuel FROM employes;
SELECT SUM(salaire)*12 FROM employes;


SELECT SUM(salaire)*12 
FROM employes 
WHERE service = 'informatique';

-- Affichage du salaire moyen
-- AVG()
SELECT AVG(salaire) FROM employes;

--Pour arrondir le résultat
-- ROUND()
SELECT ROUND(AVG(salaire)) FROM employes;
SELECT ROUND(AVG(salaire), 2) FROM employes;
-- un seul argument dans round() => arrondi à l'entier
-- deux arguments dans round() => le premier est l'information ,à arrondir et le deuxieme represente le nombre de décimale acceptées!

-- Le salaire minimum ou maximum
-- MIN() / MAX()
SELECT MIN(salaire) FROM employes;
--# Afficher le salaire minimum et le prénom de la personne ayant ce salaire
SELECT prenom, nom, MIN(salaire) FROM employes; -- INCORRECT !!!
SELECT prenom, nom, salaire FROM employes ORDER BY salaire LIMIT 1;
SELECT prenom, nom, salaire FROM employes WHERE salaire= (SELECT MIN(salaire) FROM employes);



-- Résultat : 
--+--------+--------+---------+
-- | prenom | nom    | salaire |
-- +--------+--------+---------+
-- | Julien | Cottet |    1390 |
-- +--------+--------+---------+
-- 1 row in set (0.00 sec)

-- Pour compter le nombre de ligne
-- COUNT()
-- combien d'emlpoyes:
SELECT COUNT(prenom) AS Nombre FROM employes;
SELECT COUNT(*) AS Nombre FROM employes;
-- il est préférable d'utiliser le caractere * car lorsque l'on met une colonne dans le COUNT(), si cette colonne contient la valeur 
-- NULL,le count() n'ajoutera pas la ligne avec la valeur NULL

--EXERCICE : afficher le nombre d'emlpoyes de sexe feminin
SELECT COUNT(*) AS Nombre FROM employes WHERE sexe = 'f';

-- IN
SELECT nom, prenom, service FROM employes WHERE service IN ('informatique','commercial','direction');

+----------+-------------+
| nom      | prenom      |
+----------+-------------+
| Laborde  | Jean-pierre |
| Gallet   | Clement     |
| Winter   | Thomas      |
| Collier  | Melanie     |
| Blanchet | Laura       |
| Miller   | Guillaume   |
| Perrin   | Celine      |
| Vignal   | Mathieu     |
| Durand   | Damien      |
| Chevel   | Daniel      |
| Sennard  | Emilie      |
+----------+-------------+
11 rows in set (0.00 sec)

-- INVERSE
-- NOT IN
SELECT nom, prenom, service FROM employes WHERE service NOT IN ('informatique','commercial','direction');

+---------+-----------+---------------+
| nom     | prenom    | service       |
+---------+-----------+---------------+
| Dubar   | Chloe     | production    |
| Fellier | Elodie    | secretariat   |
| Grand   | Fabrice   | comptabilite  |
| Cottet  | Julien    | secretariat   |
| Desprez | Thierry   | secretariat   |
| Thoyer  | Amandine  | communication |
| Martin  | Nathalie  | juridique     |
| Lagarde | Benoit    | production    |
| Lafaye  | Stephanie | assistant     |
+---------+-----------+---------------+

-- PLUSISEURS CONDITIONS

-- AND
-- affichage des commerciaux gagnant un salaire inférieur ou égal à 2000
SELECT * FROM employes WHERE service = 'commercial' AND salaire <= 2000;

-- OR
-- affichage des commerciaux ayant un salaire de 1500 ou 1900 
SELECT * FROM employes WHERE service = 'commercial' AND salaire = 1500 OR salaire = 1900; -- INCORRECT


SELECT * FROM employes WHERE service = 'commercial' AND (salaire = 1500 OR salaire = 1900); -- GOOD
SELECT * FROM employes WHERE service = 'commercial' AND salaire IN (1500, 1900);

-- GROUP BY
-- le nombre d'employes par service
SELECT service, COUNT(*)  AS nombre FROM employes GROUP BY service;

-- resultat :

+---------------+--------+
| service       | nombre |
+---------------+--------+
| assistant     |      1 |
| commercial    |      6 |
| communication |      1 |
| comptabilite  |      1 |
| direction     |      2 |
| informatique  |      3 |
| juridique     |      1 |
| production    |      2 |
| secretariat   |      3 |
+---------------+--------+

-- Mettre une condition sur un GROUP BY => HAVING
-- ayant plus de 2 employes
SELECT service, COUNT(*)  AS nombre FROM employes GROUP BY service HAVING nombre > 2;
SELECT service, COUNT(*)  AS nombre FROM employes GROUP BY service HAVING COUNT(*) > 2;


#######################################
#######################################
# REQUETES D'INSERTION (enregistrement)
#######################################
#######################################

INSERT INTO employes (id_employes, nom, prenom, sexe, service, date_embauche, salaire) VALUES (991, 'Rio', 'Mat', 'm', 'informatique', CURDATE(), 2000);

INSERT INTO employes (id_employes, nom, prenom, sexe, service, date_embauche, salaire) 
VALUES (NULL, 'Rio', 'Mat', 'm', 'informatique', CURDATE(), 2000);

INSERT INTO employes (nom, prenom, sexe, service, date_embauche, salaire) 
VALUES ( 'Rio', 'Mat', 'm', 'informatique', CURDATE(), 2000);

INSERT INTO employes VALUES (NULL, 'Rio', 'Mat', 'm', 'informatique', CURDATE(), 2000);



#######################################
#######################################
# REQUETES DE MODIFICATION
#######################################
#######################################


SELECT * FROM employes;
UPDATE employes SET salaire = 4500 WHERE id_employes = 350;

SELECT * FROM employes;
UPDATE employes SET salaire = 5000, date_embauche = CURDATE() WHERE id_employes = 350;
SELECT * FROM employes;


UPDATE employes SET salaire = 5000, date_embauche = CURDATE(); -- /!\ modifie toute la table


#######################################
#######################################
# REQUETES DE SUPPRESSION
#######################################
#######################################


DELETE FROM employes; -- equivaut à TRUNCATE

DELETE FROM employes WHERE id_employes = 991;
DELETE FROM employes WHERE service = 'informatique' AND sexe='m';
DELETE FROM employes WHERE id_employes = 64 OR id_employes = 98;


######################################
--EXERCICES

-- 01 - Afficher la profession de l'employé 547

SELECT service FROM employes WHERE id_employes = 547;

+------------+
| service    |
+------------+
| commercial |
+------------+

-- 02 - Afficher la date d'embauche d'Amandine

SELECT date_embauche FROM employes WHERE prenom = 'Amandine'; 

+---------------+
| date_embauche |
+---------------+
| 2010-01-23    |
+---------------+

-- 03 - Afficher le nom de famille de Guillaume

SELECT nom FROM employes WHERE prenom = 'Guillaume';

+--------+
| nom    |
+--------+
| Miller |
+--------+

-- 04 - Afficher le nombre de personne ayant un id_employes commançant par le chiffre 5

SELECT COUNT(*) FROM employes WHERE id_employes LIKE '5%';

+----------+
| COUNT(*) |
+----------+
|        3 |
+----------+

-- 05 - Afficher le nombre de commerciaux

SELECT COUNT(*) FROM employes WHERE service = 'commercial';

+----------+
| COUNT(*) |
+----------+
|        6 |
+----------+

-- 06 - Afficher le salaire moyen des informaticiens

SELECT AVG(salaire) FROM employes WHERE service = 'informatique';

+--------------+
| AVG(salaire) |
+--------------+
|    1983.3333 |
+--------------+
-- 07 - Afficher les 5 premiers employes apres avoir classé leur nom de famille par alphabétique

SELECT nom FROM employes ORDER BY nom ASC LIMIT 0, 5;

+----------+
| nom      |
+----------+
| Blanchet |
| Chevel   |
| Collier  |
| Cottet   |
| Desprez  |
+----------+
-- 08 - Afficher le cout des commerciaux sur l'année

SELECT SUM(salaire*12) AS salaire_annuel FROM employes WHERE service ='commercial';

+----------------+
| salaire_annuel |
+----------------+
|         184200 |
+----------------+


-- 09 - Afficher le salaire moyen par service ( service + salaire moyen)

SELECT service, ROUND(AVG(salaire)) FROM employes GROUP BY service;

+---------------+---------------------+
| service       | ROUND(AVG(salaire)) |
+---------------+---------------------+
| assistant     |                1775 |
| commercial    |                2558 |
| communication |                1500 |
| comptabilite  |                1900 |
| direction     |                4750 |
| informatique  |                1983 |
| juridique     |                3200 |
| production    |                2225 |
| secretariat   |                1497 |
+---------------+---------------------+

-- 10 - Afficher le nombre de recrutement sur l'année 2010

SELECT date_embauche FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND '2010-12-31';

+---------------+
| date_embauche |
+---------------+
| 2010-01-23    |
| 2010-07-05    |
+---------------+

-- 11 - Afficher le salaire moyen appliqué lors des recrutements sur la période allant de 2005 à 2007

SELECT AVG(salaire) FROM employes WHERE date_embauche BETWEEN '2005-01-01' AND '2007-12-31';

+--------------+
| AVG(salaire) |
+--------------+
|    2622.5000 |
+--------------+

-- 12 - Afficher le nombre de service différent

SELECT COUNT(DISTINCT service) FROM employes;

+-------------------------+
| COUNT(DISTINCT service) |
+-------------------------+
|                       9 |
+-------------------------+

-- 13 - Afficher tous les employés sauf ceux du service production et secrétariat

SELECT * FROM employes WHERE service NOT IN ('production', 'secretariat');

+-------------+-------------+----------+------+---------------+---------------+---------+
| id_employes | prenom      | nom      | sexe | service       | date_embauche | salaire |
+-------------+-------------+----------+------+---------------+---------------+---------+
|         350 | Jean-pierre | Laborde  | m    | direction     | 1999-12-09    |    5000 |
|         388 | Clement     | Gallet   | m    | commercial    | 2000-01-15    |    2300 |
|         415 | Thomas      | Winter   | m    | commercial    | 2000-05-03    |    3550 |
|         509 | Fabrice     | Grand    | m    | comptabilite  | 2003-02-20    |    1900 |
|         547 | Melanie     | Collier  | f    | commercial    | 2004-09-08    |    3100 |
|         592 | Laura       | Blanchet | f    | direction     | 2005-06-09    |    4500 |
|         627 | Guillaume   | Miller   | m    | commercial    | 2006-07-02    |    1900 |
|         655 | Celine      | Perrin   | f    | commercial    | 2006-09-10    |    2700 |
|         701 | Mathieu     | Vignal   | m    | informatique  | 2008-12-03    |    2000 |
|         780 | Amandine    | Thoyer   | f    | communication | 2010-01-23    |    1500 |
|         802 | Damien      | Durand   | m    | informatique  | 2010-07-05    |    2250 |
|         854 | Daniel      | Chevel   | m    | informatique  | 2011-09-28    |    1700 |
|         876 | Nathalie    | Martin   | f    | juridique     | 2012-01-12    |    3200 |
|         933 | Emilie      | Sennard  | f    | commercial    | 2014-09-11    |    1800 |
|         990 | Stephanie   | Lafaye   | f    | assistant     | 2015-06-02    |    1775 |
+-------------+-------------+----------+------+---------------+---------------+---------+

-- 14 - Afficher conjointement le nombre de femme et d'homme dans l'entreprise 

-- 15 - Afficher les commerciaux ayant été recruté avant 2005 de sexe masculin et gagnant un salaire supérieur à 2500€

SELECT *
FROM employes
WHERE service = 'commercial'
GROUP BY date_embauche < '2005-01-01'
HAVING salaire => 2500;

-- 16 - Qui a été embauché en dernier?

SELECT * FROM employes WHERE date_embauche = (SELECT max(date_embauche) FROM employes);

+-------------+-----------+--------+------+-----------+---------------+---------+
| id_employes | prenom    | nom    | sexe | service   | date_embauche | salaire |
+-------------+-----------+--------+------+-----------+---------------+---------+
|         990 | Stephanie | Lafaye | f    | assistant | 2015-06-02    |    1775 |
+-------------+-----------+--------+------+-----------+---------------+---------+

-- 17 - Afficher les informations sur l'employé du service commercial  gagnant le salaire le plus élevé

SELECT * 
FROM employes
WHERE service = 'commercial'
ORDER BY salaire DESC
LIMIT 1;

+-------------+--------+--------+------+------------+---------------+---------+
| id_employes | prenom | nom    | sexe | service    | date_embauche | salaire |
+-------------+--------+--------+------+------------+---------------+---------+
|         415 | Thomas | Winter | m    | commercial | 2000-05-03    |    3650 |
+-------------+--------+--------+------+------------+---------------+---------+

-- 18 - Afficher le prenom du comptable gagnant le meilleur salaire

SELECT *
FROM employes
WHERE service = 'comptabilite'
ORDER BY salaire DESC
LIMIT 1;

+-------------+---------+-------+------+--------------+---------------+---------+
| id_employes | prenom  | nom   | sexe | service      | date_embauche | salaire |
+-------------+---------+-------+------+--------------+---------------+---------+
|         509 | Fabrice | Grand | m    | comptabilite | 2003-02-20    |    2000 |
+-------------+---------+-------+------+--------------+---------------+---------+

-- 19 - Afficher le prénom de l'informaticien ayant été recruté en premier

SELECT *
FROM employes
WHERE service = 'informatique'
ORDER BY date_embauche ASC
LIMIT 1;

+-------------+---------+--------+------+--------------+---------------+---------+
| id_employes | prenom  | nom    | sexe | service      | date_embauche | salaire |
+-------------+---------+--------+------+--------------+---------------+---------+
|         701 | Mathieu | Vignal | m    | informatique | 2008-12-03    |    2100 |
+-------------+---------+--------+------+--------------+---------------+---------+

-- 20 - Augmenter chaque employé de 100€
 UPDATE employes SET salaire = salaire + 100;

 +-------------+-------------+----------+------+---------------+---------------+---------+
| id_employes | prenom      | nom      | sexe | service       | date_embauche | salaire |
+-------------+-------------+----------+------+---------------+---------------+---------+
|         350 | Jean-pierre | Laborde  | m    | direction     | 1999-12-09    |    5100 |
|         388 | Clement     | Gallet   | m    | commercial    | 2000-01-15    |    2400 |
|         415 | Thomas      | Winter   | m    | commercial    | 2000-05-03    |    3650 |
|         417 | Chloe       | Dubar    | f    | production    | 2001-09-05    |    2000 |
|         491 | Elodie      | Fellier  | f    | secretariat   | 2002-02-22    |    1700 |
|         509 | Fabrice     | Grand    | m    | comptabilite  | 2003-02-20    |    2000 |
|         547 | Melanie     | Collier  | f    | commercial    | 2004-09-08    |    3200 |
|         592 | Laura       | Blanchet | f    | direction     | 2005-06-09    |    4600 |
|         627 | Guillaume   | Miller   | m    | commercial    | 2006-07-02    |    2000 |
|         655 | Celine      | Perrin   | f    | commercial    | 2006-09-10    |    2800 |
|         699 | Julien      | Cottet   | m    | secretariat   | 2007-01-18    |    1490 |
|         701 | Mathieu     | Vignal   | m    | informatique  | 2008-12-03    |    2100 |
|         739 | Thierry     | Desprez  | m    | secretariat   | 2009-11-17    |    1600 |
|         780 | Amandine    | Thoyer   | f    | communication | 2010-01-23    |    1600 |
|         802 | Damien      | Durand   | m    | informatique  | 2010-07-05    |    2350 |
|         854 | Daniel      | Chevel   | m    | informatique  | 2011-09-28    |    1800 |
|         876 | Nathalie    | Martin   | f    | juridique     | 2012-01-12    |    3300 |
|         900 | Benoit      | Lagarde  | m    | production    | 2013-01-03    |    2650 |
|         933 | Emilie      | Sennard  | f    | commercial    | 2014-09-11    |    1900 |
|         990 | Stephanie   | Lafaye   | f    | assistant     | 2015-06-02    |    1875 |
+-------------+-------------+----------+------+---------------+---------------+---------+
-- 21 - Supprimer les employés du service secrétariat


