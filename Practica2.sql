
SELECT *
FROM question q
WHERE q.is_solved=FALSE;
--Pregunta 1: Quants estadis hi ha? ERIK

SELECT COUNT(*) 
FROM arena AS a; 

-- 2
SELECT p.name, p.surname
FROM person p
JOIN headcoach h ON p.idcard = h.idcard;

SELECT p.surname
FROM person p
JOIN franquicia f ON p.idcard = f.idcardcoach
WHERE f.name = 'Utah Jazz';

-- 3 Troba el nom de la franquícia amb el pressupost més gran.
SELECT f.name FROM franchise ORDER BY f.budget DESC LIMIT 1;



-- 4 Llista les arenes (noms i ciutats) de les franquícies de la conferència oest. Quin és el nom de la 5a ciutat? ERIK

SELECT a.name, a.city
FROM arena AS a 
JOIN franchise AS f ON a.name = f.ArenaName
JOIN conference AS c ON c.name = f.ConferenceName
WHERE c.name = 'Western Conference';

SELECT a.city 
FROM arena AS a 
JOIN franchise AS f ON a.name = f.ArenaName
JOIN conference AS c ON c.name = f.ConferenceName
WHERE c.name = 'Western Conference' 
ORDER BY a.city LIMIT 1 OFFSET 4; 


-- 5 Llista els noms dels jugadors que han estat seleccionats en el draft en primera, segona o tercera posició al draft del 2020.
-- Ordena pel cognom i nom del jugador (Z-A).
-- Quin és el nom del jugador mostrat en la primera fila


INSERT INTO answer (IDquestion, answer_value, sql_query_used) VALUES ('5', 'Evan', 'SELECT p.name, p. surname
FROM person AS p 
JOIN player AS pl ON p.IDCard = pl.IDCard 
JOIN draft_player_franchise AS dpf ON dpf.IDCardPlayer = pl.IDCard
WHERE dpf.position IN (1,2,3) AND DraftYear = 2020
ORDER BY p.surname DESC LIMIT 1;');

SELECT p.name, p. surname
FROM person AS p 
JOIN player AS pl ON p.IDCard = pl.IDCard 
JOIN draft_player_franchise AS dpf ON dpf.IDCardPlayer = pl.IDCard
WHERE dpf.position IN (1,2,3) AND DraftYear = 2020
ORDER BY p.surname DESC LIMIT 1;


-- 6
SELECT p.Name
FROM person p
JOIN player pl ON p.IDCard  = pl.IDCard 
WHERE p.BirthDate <= '1980-03-01' AND p.Surname = 'Lue'
ORDER BY p.BirthDate DESC
LIMIT 1;


-- 8 Tenim guardat els colors dels seients de tots els estadis. Retorna quants seients blaus hi ha en total.

INSERT INTO answer (IDquestion, answer_value, sql_query_used) VALUES ('8', '36402', 'SELECT COUNT(*) 
FROM seat AS s 
WHERE Color = 'blue'');

SELECT COUNT(*) 
FROM seat AS s 
WHERE Color = 'blue';


-- 9 Retorna la mitjana de seients (arrodonint sense decimals) per color d’entre tots els estadis. Quina es la mitjana dels platejats? 

SELECT s.Color, ROUND(COUNT(*) / COUNT(DISTINCT s.ArenaName)) AS average_seats
FROM seat AS s
GROUP BY s.Color;

-- 10 Quin és el nom de l’equip que ha guanyat més partits com a visitant?

