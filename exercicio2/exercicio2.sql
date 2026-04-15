
CREATE TABLE Curso (
    IDCurso INT PRIMARY KEY,
    nome NVARCHAR(100),
    departamento NVARCHAR(100),
    NumeroCurso INT 
);

CREATE TABLE Sala (
    IDSala INT PRIMARY KEY,
    NumeroSala INT,
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

INSERT INTO Curso VALUES (1, 'Banco de Dados', 'TI', 101),
(2, 'Algoritmos', 'TI', 102);

INSERT INTO Sala VALUES (1, 101, 40, 'Bloco A'),
(2, 202, 30, 'Bloco B');

INSERT INTO Secao VALUES (1, 1, 'Noturno', 1),
(2, 2, 'Diurno', 2);

INSERT INTO Exame VALUES (1, '2026-06-10 19:00', 1, 1),
(2, '2026-06-11 08:00', 2, 2);

SELECT 
	Exame.IDExame AS id_exame,
	Exame.horario AS horario_exame,
	Curso.nome AS nome_curso,
	Curso.departamento AS departamento,
	Secao.numero_secao AS numero_secao,
	Secao.programa AS programa,
	Sala.NumeroSala AS numero_sala,
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
	Sala.NumeroSala AS numero_sala,
	Sala.predio AS predio
FROM Secao
LEFT JOIN Curso ON Secao.IDCurso = Curso.IDCurso
LEFT JOIN Exame ON Exame.IDSecao = Secao.IDSecao
LEFT JOIN Sala ON Exame.IDSala = Sala.IDSala;
