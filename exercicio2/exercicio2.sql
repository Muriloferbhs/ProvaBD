CREATE TABLE Curso (
IDCurso INT PRIMARY KEY,
nome NVARCHAR(100),
departamento NVARCHAR(100),
NumeroCurso INT
);

CREATE TABLE Sala (
IDSala INT PRIMARY KEY,
numero_sala INT,
capacidade INT,
predio NVARCHAR(100)
);

CREATE TABLE Secao (
IDSecao INT PRIMARY KEY,
numero_secao INT,
programa NVARCHAR(100),
IDCurso INT,
FOREIGN KEY (IDCurso) REFERENCES Curso(IDCurso)
);

CREATE TABLE Exame (
IDExame INT PRIMARY KEY,
horario DATETIME,
IDSecao INT,
IDSala INT,
FOREIGN KEY (IDSecao) REFERENCES Secao(IDSecao),
FOREIGN KEY (IDSala) REFERENCES Sala(IDSala)
);

INSERT INTO Curso VALUES
(1, 'Banco de Dados', 'TI', 101),
(2, 'Algoritmos', 'TI', 102),
(3, 'Engenharia de Software', 'TI', 103),
(4, 'Redes de Computadores', 'TI', 104),
(5, 'Inteligência Artificial', 'TI', 105),
(6, 'Segurança da Informação', 'TI', 106),
(7, 'Computação em Nuvem', 'TI', 107);

INSERT INTO Sala VALUES
(1, 101, 40, 'Bloco A'),
(2, 202, 30, 'Bloco B'),
(3, 303, 50, 'Bloco C'),
(4, 404, 35, 'Bloco D'),
(5, 505, 60, 'Bloco E'),
(6, 606, 45, 'Bloco F');

INSERT INTO Secao VALUES
(1, 1, 'Noturno', 1),
(2, 2, 'Diurno', 2),
(3, 1, 'Noturno', 3),
(4, 2, 'Diurno', 3),
(5, 1, 'Noturno', 4),
(6, 2, 'Diurno', 5),
(7, 1, 'Noturno', 6),
(8, 2, 'Diurno', 7);

SET DATEFORMAT ymd;

INSERT INTO Exame VALUES
(1, '2026-06-10 19:00', 1, 1),
(2, '2026-06-11 08:00', 2, 2),
(3, '2026-06-12 19:00', 3, 3),
(4, '2026-06-13 08:00', 4, 4),
(5, '2026-06-14 19:00', 5, 5),
(6, '2026-06-15 08:00', 6, 3),
(7, '2026-06-16 19:00', 7, 6),
(8, '2026-06-17 08:00', 8, 2),
(9, '2026-06-18 19:00', 1, 4),
(10, '2026-06-19 08:00', 3, 5);

SELECT
	Exame.IDExame AS id_exame,
	Exame.horario AS horario_exame,
	Curso.nome AS nome_curso,
	Curso.departamento AS departamento,
	Secao.numero_secao AS numero_secao,
	Secao.programa AS programa,
	Sala.numero_sala AS numero_sala,
	Sala.predio AS predio,
	Sala.capacidade AS capacidade_sala
FROM Exame
INNER JOIN Secao ON Exame.IDSecao = Secao.IDSecao
INNER JOIN Curso ON Secao.IDCurso = Curso.IDCurso
INNER JOIN Sala ON Exame.IDSala = Sala.IDSala;

SELECT
	Curso.nome AS nome_curso,
	Curso.NumeroCurso AS numero_curso,
	Secao.numero_secao AS numero_secao,
	Secao.programa AS programa,
	Exame.horario AS horario_exame,
	Sala.numero_sala AS numero_sala,
	Sala.predio AS predio
FROM Secao
LEFT JOIN Curso ON Secao.IDCurso = Curso.IDCurso
LEFT JOIN Exame ON Exame.IDSecao = Secao.IDSecao
LEFT JOIN Sala ON Exame.IDSala = Sala.IDSala;

DROP TABLE Exame;
DROP TABLE Secao;
DROP TABLE Curso;
DROP TABLE Sala;
