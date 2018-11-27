CREATE TABLE association_vehicule_conducteur (
  id_association int(3) NOT NULL auto_increment,
  id_vehicule int(3) default NULL,
  id_conducteur int(3) default NULL,
  PRIMARY KEY  (id_association),
  KEY id_vehicule (id_vehicule),
  KEY id_conducteur (id_conducteur)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

INSERT INTO association_vehicule_conducteur (id_association, id_vehicule, id_conducteur) VALUES
(1, 501, 1),
(2, 502, 2),
(3, 503, 3),
(4, 504, 4),
(5, 501, 3);


CREATE TABLE conducteur (
  id_conducteur int(3) NOT NULL auto_increment,
  prenom varchar(30) NOT NULL,
  nom varchar(30) NOT NULL,
  PRIMARY KEY  (id_conducteur)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

INSERT INTO conducteur (id_conducteur, prenom, nom) VALUES
(1, 'Julien', 'Avigny'),
(2, 'Morgane', 'Alamia'),
(3, 'Philippe', 'Pandre'),
(4, 'Amelie', 'Blondelle'),
(5, 'Alex', 'Richy');


CREATE TABLE vehicule (
  id_vehicule int(3) NOT NULL auto_increment,
  marque varchar(30) NOT NULL,
  modele varchar(30) NOT NULL,
  couleur varchar(30) NOT NULL,
  immatriculation varchar(9) NOT NULL,
  PRIMARY KEY  (id_vehicule)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;

INSERT INTO vehicule (id_vehicule, marque, modele, couleur, immatriculation) VALUES
(501, 'Peugeot', '807', 'noir', 'AB-355-CA'),
(502, 'Citroen', 'C8', 'bleu', 'CE-122-AE'),
(503, 'Mercedes', 'Cls', 'vert', 'FG-953-HI'),
(504, 'Volkswagen', 'Touran', 'noir', 'SO-322-NV'),
(505, 'Skoda', 'Octavia', 'gris', 'PB-631-TK'),
(506, 'Volkswagen', 'Passat', 'gris', 'XN-973-MM');


ALTER TABLE association_vehicule_conducteur
  ADD CONSTRAINT association_vehicule_conducteur_ibfk_2 FOREIGN KEY (id_conducteur) REFERENCES conducteur (id_conducteur) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT association_vehicule_conducteur_ibfk_1 FOREIGN KEY (id_vehicule) REFERENCES vehicule (id_vehicule) ON DELETE SET NULL ON UPDATE CASCADE;



  ------------------------------------------------------------------------------------------

-- exercice : Qui conduit la voiture 503 ?

-- SELECT c.prenom
-- FROM association_vehicule_conducteur a 
-- JOIN  conducteur c ON c.id_conducteur = a.id_conducteur
-- WHERE a.id_conducteur = 3;

-- SELECT c.prenom 
-- FROM association_vehicule_conducteur a
-- WHERE c.id_conducteur = a.id_conducteur
-- AND id_vehicule = 503;

-- FAUX

-- CORRECTION
SELECT c.prenom
FROM conducteur c,association_vehicule_conducteur a
WHERE a.id_vehicule = 503
AND a.id_conducteur = c.id_conducteur;


-- +----------+
-- | prenom   |
-- +----------+
-- | Philippe |
-- +----------+

------------------------------------------------------------------------------------------
-- exercice : Qui conduit quoi ?

SELECT c.prenom, v.modele
FROM conducteur c,association_vehicule_conducteur a,vehicule v
WHERE a.id_conducteur = c.id_conducteur
AND a.id_vehicule = v.id_vehicule;
-- +----------+--------+
-- | prenom   | modele |
-- +----------+--------+
-- | Julien   | 807    |
-- | Morgane  | C8     |
-- | Philippe | Cls    |
-- | Amelie   | Touran |
-- | Philippe | 807    |
-- +----------+--------+
------------------------------------------------------------------------------------------
-- exercice : Ajoutez vous dans la liste des conducteurs.
-- exercice : Afficher tous les conducteurs (meme ceux qui n'ont pas de correspondance) ainsi que les vehicules


-- +--------+----------+
-- | modele | prenom   |
-- +--------+----------+
-- | 807    | Julien   |
-- | C8     | Morgane  |
-- | Cls    | Philippe |
-- | 807    | Philippe |
-- | Touran | Amelie   |
-- | NULL   | Alex     |
-- +--------+----------+

INSERT INTO conducteur VALUES (NULL,'Mathieu','Quittard');

SELECT  c.prenom, v.modele
FROM conducteur c
LEFT JOIN association_vehicule_conducteur a ON a.id_conducteur = c.id_conducteur
LEFT JOIN vehicule v ON v.id_vehicule = a.id_vehicule;

-- +----------+--------+
-- | prenom   | modele |
-- +----------+--------+
-- | Julien   | 807    |
-- | Morgane  | C8     |
-- | Philippe | Cls    |
-- | Amelie   | Touran |
-- | Philippe | 807    |
-- | Alex     | NULL   |
-- | Mathieu  | NULL   |
-- +----------+--------+

------------------------------------------------------------------------------------------
-- exercice : Ajoutez un nouvel enregistrement dans la table des véhicules.
-- exercice : Afficher les conducteurs et tous les vehicules (meme ceux qui n'ont pas de correspondance)

-- +---------+----------+
-- | modele  | prenom   |
-- +---------+----------+
-- | 807     | Julien   |
-- | 807     | Philippe |
-- | C8      | Morgane  |
-- | Cls     | Philippe |
-- | Touran  | Amelie   |
-- | Octavia | NULL     |
-- +---------+----------+
------------------------------------------------------------------------------------------
-- exercice : Afficher tous les conducteurs et tous les vehicules, peut importe les correspondances (full outer, ne fonctionne pas)

SELECT  c.prenom, v.modele
FROM conducteur c
LEFT JOIN association_vehicule_conducteur a ON a.id_conducteur = c.id_conducteur
LEFT JOIN vehicule v ON v.id_vehicule = a.id_vehicule
UNION
SELECT  c.prenom, v.modele
FROM conducteur c
RIGHT JOIN association_vehicule_conducteur a ON a.id_conducteur = c.id_conducteur
RIGHT JOIN vehicule v ON v.id_vehicule = a.id_vehicule;

-- +---------+----------+
-- | modele  | prenom   |
-- +---------+----------+
-- | 807     | Julien   |
-- | C8      | Morgane  |
-- | Cls     | Philippe |
-- | 807     | Philippe |
-- | Touran  | Amelie   |
-- | NULL    | Alex     |
-- | Octavia | NULL     |
-- +---------+----------+












