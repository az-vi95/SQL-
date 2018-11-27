USE entreprise;

CREATE VIEW vue_femme AS SELECT * FROM employes WHERE sexe = "f";

SHOW TABLES;
SELECT * FROM vue_femme;

-- UPDATE vue_femme SET prenom ='Marie' WHERE prenom = "emilie"; option

DROP VIEW vue_femme;

SELECT * FROM information_schema.views; -- pour voir les view du serveur

USE information_schema;
SELECT * FROM views;

-- ON construit une table virtuelle depuis des tables et données existantes
-- Les données d'origine sont les memes dans la table virtuelle ,si je change une donnée , la 
-- modification est répercutée sur la donnée d'origine !
-- Durée de vie tres longue,elle existe tant que le developpeur ne le supprime pas.