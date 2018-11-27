USE entreprise;

CREATE TEMPORARY TABLE commerciaux AS SELECT * FROM employes WHERE service = "commercial";

SHOW TABLES;

SELECT * FROM commerciaux;

USE bibliotheque
CREATE TEMPORARY TABLE liste_emprunt AS SELECT a.prenom, e.date_sortie, l.titre
FROM abonne a, emprunt e, livre l
WHERE a.id_abonne = e.id_abonne
AND e.id_abonne = l.id_abonne

SHOW TABLES;

SELECT * FROM liste_emprunt;
DROP TABLE liste_emprunt;

-- Une table temporaire se construit à partir de table et données existantes!
-- Les données sont sauvegardées et ne sont donc plus les memes que celles d'origine.
-- Si je modifie une donnée dans la table temporaire, cela , n'impacte pas les données d'origine.
-- Durée de vie tres courte,si je ferme la session,les tables temporaires sont supprimées.