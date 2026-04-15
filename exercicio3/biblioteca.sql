
CREATE TABLE usuario ( 
  id_us INT PRIMARY KEY IDENTITY(1,1),
  nome_us NVARCHAR(100),
  telefone_us NVARCHAR(13),
  email_us NVARCHAR(50)
)

CREATE TABLE livro (
  id_li INT PRIMARY KEY IDENTITY(1,1),
  titulo_li NVARCHAR(50),
  descricao_li NVARCHAR(MAX)
)
CREATE TABLE autor (
  id_au INT PRIMARY KEY IDENTITY(1,1),
  nome_au NVARCHAR(80)
)
 
CREATE TABLE livro_autor (
  id_li INT,
  id_au INT,
  PRIMARY KEY (id_li, id_au)
  
)
CREATE TABLE exemplar (
  id_ex INT PRIMARY KEY IDENTITY(1,1),
  id_li INT,
  disponibilidade_ex BIT
)

CREATE TABLE emprestimo (
    id_emp INT PRIMARY KEY IDENTITY(1,1),
    id_us INT,
    id_ex INT,
    dt_em DATE,
    dt_prev DATE,
    ativo BIT
)

ALTER TABLE livro_autor
ADD CONSTRAINT fk_livro_autor_livro1
FOREIGN KEY (id_li)
REFERENCES livro(id_li)

ALTER TABLE livro_autor
ADD CONSTRAINT fk_livro_autor_autor1
FOREIGN KEY (id_au)
REFERENCES autor(id_au)

ALTER TABLE exemplar
ADD CONSTRAINT fk_exemplar_livro1
FOREIGN KEY (id_li)
REFERENCES livro(id_li)

ALTER TABLE emprestimo
ADD CONSTRAINT fk_emprestimo_exemplar1
FOREIGN KEY (id_ex)
REFERENCES exemplar(id_ex)

ALTER TABLE emprestimo
ADD CONSTRAINT fk_emprestimo_usuario1
FOREIGN KEY (id_us)
REFERENCES usuario(id_us)

ALTER TABLE emprestimo
ADD dt_dev date

INSERT INTO usuario (nome_us, telefone_us, email_us) VALUES
('Ana Paula Silva', '12999991111', 'ana.silva@email.com'),
('Bruno Souza', '12988882222', 'bruno.souza@email.com'),
('Camila Lima', '12977773333', 'camila.lima@email.com'),
('Diego Oliveira', '12999665544', 'diego.oli@email.com'),
('Fernanda Rocha', '12988774433', 'fer.rocha@email.com'),
('Gabriel Santos', '12977553322', 'gabriel.santos@email.com');

INSERT INTO livro (titulo_li, descricao_li) VALUES
('Clean Code: Código Limpo', 'Guia clássico sobre como escrever códigos legíveis e manuteníveis.'),
('Sistemas de Banco de Dados', 'Fundamentos, modelagem e projetos de bancos de dados relacionais.'),
('Engenharia de Software', 'Conceitos avançados sobre o ciclo de vida e requisitos do software.'),
('Design Patterns', 'Padrões de soluções para problemas comuns no desenvolvimento de software.'),
('Algoritmos: Teoria e Prática', 'A bíblia dos algoritmos, cobrindo desde fundamentos até estruturas complexas.'),
('The Pragmatic Programmer', 'Dicas e estratégias para se tornar um desenvolvedor mais eficiente.');

INSERT INTO autor (nome_au) VALUES
('Robert C. Martin'),
('Ramez Elmasri'),
('Ian Sommerville'),
('Shamkant B. Navathe'),
('Erich Gamma'),
('Richard Helm'),
('Thomas H. Cormen'),
('Andrew Hunt');

INSERT INTO livro_autor (id_li, id_au) VALUES
(1, 1),
(1, 6),
(2, 2),
(2, 4),
(3, 3),
(4, 5), 
(4, 7),
(6, 8);

INSERT INTO exemplar (id_li, disponibilidade_ex) VALUES
(1, 0),
(1, 1),
(2, 1),
(3, 1),
(3, 0),
(4, 1),
(5, 1),
(6, 0),
(6, 1);

INSERT INTO emprestimo (id_us, id_ex, dt_em, dt_prev, ativo) VALUES
(1, 1, '2026-04-10', '2026-04-17', 1),
(2, 3, '2026-04-12', '2026-04-19', 1),
(3, 2, '2026-03-20', '2026-03-27', 0),
(4, 8, '2026-04-13', '2026-04-20', 1),
(5, 6, '2026-04-14', '2026-04-21', 1),
(6, 7, '2026-04-01', '2026-04-08', 0);

SELECT 
	emprestimo.id_emp AS id_emprestimo,
	usuario.nome_us AS nome_usuario,
	livro.titulo_li AS titulo_livro,
	emprestimo.dt_em AS data_emprestimo,
	emprestimo.dt_prev AS data_devolução_prevista
FROM emprestimo
INNER JOIN usuario ON emprestimo.id_us = usuario.id_us
INNER JOIN exemplar ON emprestimo.id_ex = exemplar.id_ex
INNER JOIN livro ON exemplar.id_li = livro.id_li
WHERE emprestimo.ativo = 1;


SELECT 
	livro.titulo_li AS titulo_livro, 
	autor.nome_au AS nome_autor
FROM livro
JOIN livro_autor ON livro.id_li = livro_autor.id_li
RIGHT JOIN autor ON livro_autor.id_au = autor.id_au
ORDER BY livro.titulo_li;

SELECT 
    livro.titulo_li          AS titulo_livro,
    COUNT(exemplar.id_ex)    AS total_exemplares,
    SUM(CASE WHEN exemplar.disponibilidade_ex = 1 THEN 1 ELSE 0 END) AS disponiveis,
    SUM(CASE WHEN exemplar.disponibilidade_ex = 0 THEN 1 ELSE 0 END) AS emprestados
FROM livro
INNER JOIN exemplar ON livro.id_li = exemplar.id_li
GROUP BY livro.titulo_li
ORDER BY livro.titulo_li;



DROP TABLE IF EXISTS emprestimo;
DROP TABLE IF EXISTS livro_autor;
DROP TABLE IF EXISTS exemplar;

DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS livro;
DROP TABLE IF EXISTS autor;
