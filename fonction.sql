SELECT DATABASE();

-- quelle est la bdd actuellement utilisée

SELECT VERSION();

-- Donne la version de mySLQ


INSERT INTO abonne VALUES (NULL,"Sylviane");
SELECT LAST_INSERT_ID();

--le dernier id inséré dans la BDD

SELECT DATE_ADD('2018-10-17', INTERVAL 31 DAY);
SELECT DATE_ADD('2018-10-17 16:54:35', INTERVAL 5 HOUR);

SELECT ADD_DATE('2021-05-07', 31); --31 jours plus tard

SELECT CURDATE(); -- la date du jour
SELECT NOW(); -- la date et l'heure

SELECT DAYNAME('2018-10-17');
SELECT DAYNAME(CURDATE());
-- le nom du jour correspondant

SELECT DAYOFYEAR('2018-10-17');
-- le numero du jour dans une année

SELECT PASSWORD("mon_mot_de_passe"); 
-- pour crypter le mdp avec un algorythme AES

SELECT CONCAT("a","b","c"); 
-- Concaténation => abc

SELECT CONCAT_WS(' - ', 'un', 'deux', 'trois');
-- avec separateur (le premier argument fourni) => Un - Deux - Trois

SELECT LENGTH('bonjour');
-- compte le nombre de caractère

SELECT LOCATE('@','mail@mail.fr');
-- Repère sa première place dans la ligne de caractère /!\ Démarre par 1 != JS

SELECT REPLACE('www.monsite.fr','w','W');
-- Permet de remplacer des éléments ()

SELECT TRIM('          HELLO          ');
-- retire tous les espaces avant et après /!\ mais pas entre 2 éléments

SELECT UPPER("hello"); --mettre en majuscule
SELECT LOWER("WORLD"); --mettre en minuscule
