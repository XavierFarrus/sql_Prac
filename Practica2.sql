
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

-- 7 
SELECT COUNT(*) AS AsientosVip
FROM zone
WHERE ArenaName = 'Madison Square Garden' 
AND IsVip = 1;

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

-- 10 Retorna els entrenadors principals amb el seu rendiment segons el salari (rendiment = (VictoryPercentage / 100) * (Salary / 1000)), tallant els decimals que resultin. Quin és el rendiment de l'entrenador 100000004?


SELECT p.Name, ROUND((VictoryPercentage / 100) * (Salary / 1000)) AS Rendimiento 
FROM person AS p 
JOIN headcoach AS h ON p.IDCard = h.IDCard 
WHERE h.IDCard = 100000004;

-- 11 Per cada equip retorna quantes vegades ha guanyat. Sempre que siguin 3 vegades o més. Quantes files retorna el select?

SELECT f.Name, COUNT(*)
FROM franchise AS f 
JOIN franchise_season AS fs ON fs.FranchiseName = f.Name 
WHERE fs.IsWinner = 1
GROUP BY f.Name
HAVING COUNT(*) >= 3; 


-- 12 Retorna amb el país i any els equips nacionals amb el nom i cognom del seu entrenador. Fes-ho pels anys del 2010 al 2015 i pels països que comencin per A. Quants entrenadors retorna la consulta?

--13 Per un any específic retorna per cada equip la suma dels salaris dels seus jugadors. Asumeix que tots els jugadors que tenen un contracte en qualsevol data de l'any 2007 s'ha de contabilitzar. Quin és el presupost dels Houston Rockets?
SELECT pf.FranchiseName, SUM(pf.Salary) AS total_salary
FROM player_franchise pf
WHERE pf.FranchiseName = 'Houston Rockets'
AND (
    pf.StartContract <= '2007-12-31' 
    AND pf.EndContract >= '2007-01-01'
)
GROUP BY pf.FranchiseName;

--15Crea un informe amb tots els jugadors que no son dels Estats Units ni d'Espanya. Inclou-ne tota la seva informació personal completa. Ordena els resultats per nacionalitat i data de naixement ascendent. Quina és la ID del terncer juador retornat?


--16 Mostra un informe amb el nom, cognom i data de naixement de tots els caps d'entrenadors assistents de l'especialitat de psicologia sense repetits i que tenen una data de naixement registrada. Ordena per cognom i nom. Quin és l'any de naixement del tercer resultat?
SELECT DISTINCT Name, Surname, YEAR(p.BirthDate) AS BirthYear
FROM assistantcoach AS asis
JOIN person AS p ON asis.IDCard = p.IDCard
WHERE asis.Especiality = 'Psychologist' 
AND p.BirthDate IS NOT NULL
ORDER BY p.Name ASC, p.Surname ASC
LIMIT 1 OFFSET 2;
