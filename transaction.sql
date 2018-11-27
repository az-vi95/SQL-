-- TRANSACTION
-- Habituellement, toute action est définitive.Avec les transactions , on peut mettre en place un espace
-- de travail puis ensuite valider ou annuler la transaction.

USE entreprise;

-- Pour lancer une transaction 
START TRANSACTION; -- "demarre la zone de mise en tampon"
SELECT * FROM employes;
UPDATE employes SET salaire = 100;
SELECT * FROM employes;

ROLLBACK; -- # permet d'annuler toutes les opérations et de revenir à l'état de la BDD
-- lors du start transaction.

-- Pour valider une transaction
COMMIT;
-- Après un rollback ou un commit, la transaction est terminée !


-- TRANSACTION AVANCEE & SAVEFONT

START TRANSACTION;
SELECT * FROM employes;

SAVEPOINT point1; -- mise en place d'un point de sauvegarde.

UPDATE employes SET service = 'informatique';
SELECT * FROM employes;

SAVEPOINT point2;

INSERT INTO employes (nom, prenom, salaire, sexe, date_embauche) VALUES ('Test', 'test', 5000, 'm', CURDATE());
SELECT * FROM employes;

SAVEPOINT point3;

DELETE FROM employes;
SELECT * FROM employes;

ROLLBACK to point2; -- # annuler toutes les opérations depuis le point 2
ROLLBACK to point3; -- # ERREUR
ROLLBACK to point1; -- # OK

COMMIT;

-- Si la session(console) est fermée alors qu'une transaction est active, c'est un ROLLBACK par défaut!
