
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
    e.IDExame,
    e.horario,
    c.nome          AS curso,
    c.departamento,
    sec.numero_secao,
    sec.programa,
    s.NumeroSala,
    s.predio,
    s.capacidade
FROM Exame e
INNER JOIN Secao  sec ON e.IDSecao  = sec.IDSecao
INNER JOIN Curso  c   ON sec.IDCurso = c.IDCurso
INNER JOIN Sala   s   ON e.IDSala   = s.IDSala
ORDER BY e.horario;


SELECT
    c.nome          AS curso,
    c.NumeroCurso,
    sec.numero_secao,
    sec.programa,
    e.horario,
    s.NumeroSala,
    s.predio
FROM Secao sec
LEFT JOIN Curso c  ON sec.IDCurso = c.IDCurso
LEFT JOIN Exame e  ON e.IDSecao   = sec.IDSecao
LEFT JOIN Sala  s  ON e.IDSala    = s.IDSala
ORDER BY c.nome, sec.numero_secao;
