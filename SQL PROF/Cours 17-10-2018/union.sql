-- UNION permet de fusionner plusieurs requêtes en un seul resultat

SELECT auteur AS "liste des personnes" FROM livre
UNION
SELECT prenom FROM abonne;

+---------------------+
| liste des personnes |
+---------------------+
| GUY DE MAUPASSANT   |
| HONORE DE BALZAC    |
| ALPHONSE DAUDET     |
| ALEXANDRE DUMAS     |
| Guillaume           |
| Benoit              |
| Chloe               |
| Laura               |
| Thierry             |
+---------------------+

--ATTENTION! UNION applique un distinct par default.
--Pour avoir l'intégralité des informations : UNION ALL

SELECT auteur AS "liste des personnes" FROM livre
UNION ALL
SELECT prenom FROM abonne;

+---------------------+
| liste des personnes |
+---------------------+
| GUY DE MAUPASSANT   |
| GUY DE MAUPASSANT   |
| HONORE DE BALZAC    |
| ALPHONSE DAUDET     |
| ALEXANDRE DUMAS     |
| ALEXANDRE DUMAS     |
| Guillaume           |
| Benoit              |
| Chloe               |
| Laura               |
| Thierry             |
+---------------------+