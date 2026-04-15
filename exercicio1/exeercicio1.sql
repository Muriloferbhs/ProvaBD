CREATE TABLE HOSPITAL (
    id_hospital INT PRIMARY KEY,
    nome NVARCHAR(200) NOT NULL,
    endereco NVARCHAR(200) NOT NULL,
    telefone NVARCHAR(8) NOT NULL,
    cnpj NVARCHAR(14) NOT NULL UNIQUE,
    email NVARCHAR(100),
    tipo NVARCHAR(6) NOT NULL
);

CREATE TABLE LABORATORIO (
    id_laboratorio INT PRIMARY KEY,
    nome NVARCHAR(200) NOT NULL,
    endereco NVARCHAR(200) NOT NULL,
    telefone NVARCHAR(6) NOT NULL,
    email NVARCHAR(100),
    cnpj NVARCHAR(14) NOT NULL UNIQUE,
    tipo NVARCHAR(6) NOT NULL
);

CREATE TABLE HOSPITAL_LABORATORIO (
    id_hospital INT NOT NULL,
    id_laboratorio INT NOT NULL,
    data_solicitacao DATE NOT NULL,
    status NVARCHAR(50)  NOT NULL,
    qtd_exames INT,
    PRIMARY KEY (id_hospital, id_laboratorio, data_solicitacao),
    FOREIGN KEY (id_hospital) REFERENCES HOSPITAL(id_hospital),
    FOREIGN KEY (id_laboratorio) REFERENCES LABORATORIO(id_laboratorio)
);

CREATE TABLE AMBULATORIO (
    id_ambulatorio INT PRIMARY KEY,
    id_hospital INT NOT NULL,
    nome NVARCHAR(100),
    capacidade INT NOT NULL,
    andar NCHAR(10) NOT NULL,
    FOREIGN KEY (id_hospital) REFERENCES HOSPITAL(id_hospital)
);

CREATE TABLE MEDICO (
    id_medico INT PRIMARY KEY,
    id_hospital INT NOT NULL,
    nome NVARCHAR(100) NOT NULL,
    especialidade NVARCHAR(100) NOT NULL,
    crm NVARCHAR(12) NOT NULL UNIQUE,
    telefone NVARCHAR(9),
    email NVARCHAR(100),
    FOREIGN KEY (id_hospital) REFERENCES HOSPITAL(id_hospital)
);

CREATE TABLE PACIENTE (
    id_paciente INT PRIMARY KEY,
    id_ambulatorio INT NOT NULL,
    nome NVARCHAR(250) NOT NULL,
    endereco NVARCHAR(250),
    cpf NVARCHAR(11) NOT NULL UNIQUE,
    data_nasc DATE NOT NULL,
    telefone NVARCHAR(9),
    email NVARCHAR(100),
    sexo NVARCHAR(1),
    FOREIGN KEY (id_ambulatorio) REFERENCES AMBULATORIO(id_ambulatorio)
);

CREATE TABLE PESSOAL_APOIO (
    id_pessoal INT PRIMARY KEY,
    id_ambulatorio INT NOT NULL,
    nome NVARCHAR(100) NOT NULL,
    cargo NVARCHAR(100),
    cpf NVARCHAR(14) NOT NULL UNIQUE,
    telefone NVARCHAR(9),
    FOREIGN KEY (id_ambulatorio) REFERENCES AMBULATORIO(id_ambulatorio)
);

CREATE TABLE CONSULTA (
    id_medico INT NOT NULL,
    id_paciente INT NOT NULL,
    data_consulta DATE NOT NULL,
    hora_consulta TIME NOT NULL,
    status NVARCHAR(50)  NOT NULL,
    PRIMARY KEY (id_medico, id_paciente, data_consulta, hora_consulta),
    FOREIGN KEY (id_medico) REFERENCES MEDICO(id_medico),
    FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente)
);

CREATE TABLE EXAME (
    id_exame INT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_laboratorio INT NOT NULL,
    tipo NVARCHAR(100) NOT NULL,
    data_realizacao DATE NOT NULL,
    resultado NVARCHAR(100),
    status NVARCHAR(50) NOT NULL,
    observacao NVARCHAR(200),
    FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente),
    FOREIGN KEY (id_laboratorio) REFERENCES LABORATORIO(id_laboratorio)
);

CREATE TABLE DIAGNOSTICO (
    id_diagnostico INT PRIMARY KEY,
    id_paciente INT NOT NULL,
    descricao NVARCHAR(200) NOT NULL,
    data DATE NOT NULL,
    medico_responsavel NVARCHAR(100),
    gravidade NVARCHAR(50),
    FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente)
);

-- hospital
INSERT INTO HOSPITAL (id_hospital, nome, endereco, telefone, cnpj, email, tipo)
VALUES 
(1, 'Hospital 1', 'Av. 1, 255 - SP', '11330010', '60975198000112', 'email@exemplo.com',  'public'),
(2, 'Hospital 2', 'Av. 2, 627 - SP', '21519000', '53153643000101', 'email2@exemplo.com', 'privad'),
(3, 'Hospital 3', 'Rua 3, 91 - SP',  '31550100', '61585865000101', 'email3@exemplo.com', 'privad'),
(4, 'Hospital 4', 'Rua 4, 400 - SP', '11444200', '89543210000156', 'email4@exemplo.com', 'public');

-- laboratorios
INSERT INTO LABORATORIO (id_laboratorio, nome, endereco, telefone, email, cnpj, tipo)
VALUES 
(1, 'Laboratorio1', 'Rua 1, 100 - SP', '110001', 'email1@exemplo.com', '12345678000199', 'public'),
(2, 'Laboratorio2', 'Av. 1, 500 - SP', '110002', 'email2@exemplo.com', '98765432000155', 'privad'),
(3, 'Laboratorio3', 'Rua 2, 340 - SP', '110003', 'email3@exemplo.com', '11223344000177', 'public'),
(4, 'Laboratorio4', 'Rua 3, 20 - MG',  '310001', 'email4@exemplo.com', '55667788000133', 'privad');

-- hospital_laboratorios
INSERT INTO HOSPITAL_LABORATORIO (id_hospital, id_laboratorio, data_solicitacao, status, qtd_exames)
VALUES
(1, 1, '2024-01-10', 'Concluído',    50),
(1, 2, GETDATE(),    'Em andamento', 30),
(2, 3, '2024-03-01', 'Concluído',    80),
(3, 4, GETDATE(),    'Pendente',     10),
(4, 1, '2024-04-05', 'Concluído',    25);

-- ambulatorios
INSERT INTO AMBULATORIO (id_ambulatorio, id_hospital, nome, capacidade, andar)
VALUES
(1, 1, 'Ambulatório 1', 100, '1° andar'),
(2, 1, 'Ambulatório 2',  60, '2° andar'),
(3, 2, 'Ambulatório 3',  50, '3° andar'),
(4, 3, 'Ambulatório 4',  40, '2° andar'),
(5, 4, 'Ambulatório 5',  80, 'Térreo');

-- medicos
INSERT INTO MEDICO (id_medico, id_hospital, nome, especialidade, crm, telefone, email)
VALUES 
(1, 1, 'Dr. Carlos',    'Cardiologia',   'CRM/SP-12345', '119887766', 'carlos@exemplo.com'),
(2, 1, 'Dra. Ana',      'Clínica Geral', 'CRM/SP-23456', '119776655', 'ana@exemplo.com'),
(3, 2, 'Dr. Roberto',   'Oncologia',     'CRM/SP-34567', '119665544', 'roberto@exemplo.com'),
(4, 3, 'Dra. Patrícia', 'Neurologia',    'CRM/SP-45678', '119554433', 'patricia@exemplo.com'),
(5, 4, 'Dr. Marcos',    'Emergência',    'CRM/SP-56789', '119443322', 'marcos@exemplo.com'),
(6, 1, 'Dra. Juliana',  'Pediatria',     'CRM/SP-67890', '119332211', 'juliana@exemplo.com');

-- pacientes  ← cpf e telefone estavam trocados na lista de colunas
INSERT INTO PACIENTE (id_paciente, id_ambulatorio, nome, endereco, cpf, data_nasc, telefone, email, sexo)
VALUES 
(1, 1, 'João',     'Rua A, 10 - SP', '12345678901', '1980-05-12', '119111111', 'joao@exemplo.com',     'M'),
(2, 1, 'Maria',    'Rua B, 20 - SP', '23456789012', '1990-08-25', '119222222', 'maria@exemplo.com',    'F'),
(3, 2, 'Pedro',    'Rua C, 30 - SP', '34567890123', '1975-11-30', '119333333', 'pedro@exemplo.com',    'M'),
(4, 3, 'Lucia',    'Rua D, 40 - SP', '45678901234', '2000-02-14', '119444444', 'lucia@exemplo.com',    'F'),
(5, 4, 'Carlos',   'Rua E, 50 - SP', '56789012345', '1965-07-19', '119555555', 'carlos@exemplo.com',   'M'),
(6, 5, 'Ana',      'Rua F, 60 - SP', '67890123456', '1998-03-08', '119666666', 'anapaula@exemplo.com', 'F'),
(7, 1, 'Roberto',  'Rua G, 70 - SP', '78901234567', '1988-09-22', '119777777', 'roberto@exemplo.com',  'M'),
(8, 2, 'Fernanda', 'Rua H, 80 - SP', '89012345678', '1972-12-01', '119888888', 'fernanda@exemplo.com', 'F');

-- pessoal de apoio
INSERT INTO PESSOAL_APOIO (id_pessoal, id_ambulatorio, nome, cargo, cpf, telefone)
VALUES 
(1, 1, 'Marcos', 'Enfermeiro',      '11122233300', '119100001'),
(2, 1, 'Renata', 'Técnico Lab.',    '22233344401', '119100002'),
(3, 2, 'Paulo',  'Recepcionista',   '33344455502', '119100003'),
(4, 3, 'Carla',  'Auxiliar Admin.', '44455566603', '119100004'),
(5, 4, 'Bruno',  'Enfermeiro',      '55566677704', '119100005'),
(6, 5, 'Silvia', 'Recepcionista',   '66677788805', '119100006');

-- consultas
INSERT INTO CONSULTA (id_medico, id_paciente, data_consulta, hora_consulta, status)
VALUES 
(1, 1, '2024-01-15', '08:00', 'Realizada'),
(1, 2, '2024-01-15', '09:00', 'Realizada'),
(2, 3, '2024-02-10', '10:30', 'Realizada'),
(3, 4, '2024-02-20', '14:00', 'Realizada'),
(4, 5, '2024-03-05', '11:00', 'Cancelada'),
(5, 6, '2024-03-12', '16:00', 'Realizada'),
(6, 7, '2024-04-01', '08:30', 'Agendada'),
(1, 8, '2024-04-02', '09:30', 'Agendada'),
(2, 1, '2024-04-10', '10:00', 'Realizada'),
(3, 2, '2024-04-15', '15:00', 'Realizada');

-- exames
INSERT INTO EXAME (id_exame, id_paciente, id_laboratorio, tipo, data_realizacao, resultado, status, observacao)
VALUES
(1, 1, 1, 'exame 1', '2024-01-20', 'Normal',   'Concluído',    NULL),
(2, 2, 2, 'exame 2', '2024-01-22', 'Alterado', 'Concluído',    'Glicemia em jejum alta'),
(3, 3, 1, 'exame 3', '2024-02-12', 'Normal',   'Concluído',    NULL),
(4, 4, 3, 'exame 4', '2024-02-25', 'Negativo', 'Concluído',    NULL),
(5, 5, 4, 'exame 5', '2024-03-10', NULL,        'Em andamento', 'Aguardando laudo'),
(6, 6, 2, 'exame 6', '2024-03-15', 'Normal',   'Concluído',    NULL),
(7, 7, 1, 'exame 7', '2024-04-02', 'Elevado',  'Concluído',    'Provável infecção'),
(8, 8, 3, 'exame 8', '2024-04-05', 'Normal',   'Concluído',    NULL);

-- diagnostico
INSERT INTO DIAGNOSTICO (id_diagnostico, id_paciente, descricao, data, medico_responsavel, gravidade)
VALUES
(1, 1, 'Diagnostico 1', '2024-01-16', 'Dr. Carloss',    'Moderada'),
(2, 2, 'Diagnostico 2', '2024-01-23', 'Dra. Ana',       'Alta'),
(3, 3, 'Diagnostico 3', '2024-02-13', 'Dr. Roberto',    'Moderada'),
(4, 4, 'Diagnostico 4', '2024-02-26', 'Dr. Roberto',    'Baixa'),
(5, 6, 'Diagnostico 5', '2024-03-16', 'Dr. Marcos',     'Baixa'),
(6, 7, 'Diagnostico 6', '2024-04-03', 'Dra. Ana',       'Moderada'),
(7, 8, 'Diagnostico 7', '2024-04-06', 'Dr. Carlos',     'Alta'),
(8, 5, 'Diagnostico 8', '2024-03-08', 'Dra. Patrícia',  'Baixa');


SELECT
    P.nome AS Paciente,
    P.cpf,
    A.nome AS Ambulatorio,
    H.nome AS Hospital,
    M.nome AS Medico,
    M.especialidade,
    C.data_consulta,
    C.hora_consulta,
    C.status AS Status_Consulta,
    D.descricao AS Diagnostico,
    D.gravidade
FROM PACIENTE P
    INNER JOIN AMBULATORIO A ON P.id_ambulatorio = A.id_ambulatorio
    INNER JOIN HOSPITAL H ON A.id_hospital = H.id_hospital
    INNER JOIN CONSULTA C ON P.id_paciente = C.id_paciente
    INNER JOIN MEDICO M ON C.id_medico = M.id_medico
    LEFT  JOIN DIAGNOSTICO D ON P.id_paciente = D.id_paciente
ORDER BY P.nome, C.data_consulta;

SELECT
    L.nome AS Laboratorio,
    L.tipo AS Tipo_Lab,
    HL.data_solicitacao,
    HL.status AS Status_Solicitacao,
    HL.qtd_exames AS Qtd_Exames_Solicitados,
    H.nome AS Hospital_Solicitante,
    P.nome AS Paciente,
    E.tipo AS Tipo_Exame,
    E.data_realizacao,
    E.resultado,
    E.status AS Status_Exame,
    E.observacao
FROM LABORATORIO L
    INNER JOIN EXAME E ON L.id_laboratorio = E.id_laboratorio
    INNER JOIN PACIENTE P ON E.id_paciente = P.id_paciente
    LEFT  JOIN HOSPITAL_LABORATORIO HL ON L.id_laboratorio = HL.id_laboratorio
    LEFT  JOIN HOSPITAL H  ON HL.id_hospital = H.id_hospital
ORDER BY L.nome, E.data_realizacao;

SELECT
    H.nome AS Hospital,
    H.tipo AS Tipo_Hospital,
    M.especialidade,
    COUNT(DISTINCT C.id_paciente) AS Total_Pacientes_Atendidos,
    COUNT(C.id_medico) AS Total_Consultas,
    SUM(CASE WHEN C.status = 'Realizada' THEN 1 ELSE 0 END) AS Consultas_Realizadas,
    SUM(CASE WHEN C.status = 'Cancelada' THEN 1 ELSE 0 END) AS Consultas_Canceladas,
    COUNT(DISTINCT E.id_exame) AS Total_Exames_Solicitados,
    COUNT(DISTINCT D.id_diagnostico) AS Total_Diagnosticos
FROM HOSPITAL H
    INNER JOIN MEDICO M ON H.id_hospital = M.id_hospital
    LEFT JOIN CONSULTA C ON M.id_medico = C.id_medico
    LEFT JOIN PACIENTE P ON C.id_paciente = P.id_paciente
    LEFT JOIN EXAME E ON P.id_paciente = E.id_paciente
    LEFT JOIN DIAGNOSTICO D ON P.id_paciente = D.id_paciente
GROUP BY H.nome, H.tipo, M.especialidade
ORDER BY H.nome, Total_Consultas DESC;

SELECT
    P.nome AS Paciente,
    P.cpf,
    P.data_nasc,
    P.sexo,
    A.nome AS Ambulatorio,
    H.nome AS Hospital,
    'CONSULTA' AS Tipo_Registro,
    CAST(C.data_consulta AS NVARCHAR) AS Data_Evento,
    M.nome AS Profissional,
    M.especialidade AS Detalhe_1,
    C.status AS Detalhe_2,
    NULL AS Detalhe_3
FROM PACIENTE P
    INNER JOIN AMBULATORIO A ON P.id_ambulatorio = A.id_ambulatorio
    INNER JOIN HOSPITAL H ON A.id_hospital = H.id_hospital
    INNER JOIN CONSULTA C ON P.id_paciente = C.id_paciente
    INNER JOIN MEDICO M ON C.id_medico = M.id_medico
WHERE P.id_paciente = 1   

UNION ALL

SELECT
    P.nome, P.cpf, P.data_nasc, P.sexo,
    A.nome, H.nome,
    'EXAME' AS Tipo_Registro,
    CAST(E.data_realizacao AS NVARCHAR) AS Data_Evento,
    L.nome AS Profissional,
    E.tipo AS Detalhe_1,
    E.resultado AS Detalhe_2,
    E.observacao AS Detalhe_3
FROM PACIENTE P
    INNER JOIN AMBULATORIO A ON P.id_ambulatorio = A.id_ambulatorio
    INNER JOIN HOSPITAL H ON A.id_hospital = H.id_hospital
    INNER JOIN EXAME E ON P.id_paciente = E.id_paciente
    INNER JOIN LABORATORIO L ON E.id_laboratorio = L.id_laboratorio
WHERE P.id_paciente = 1

UNION ALL

SELECT
    P.nome, P.cpf, P.data_nasc, P.sexo,
    A.nome, H.nome,
    'DIAGNOSTICO' AS Tipo_Registro,
    CAST(D.data AS NVARCHAR) AS Data_Evento,
    D.medico_responsavel AS Profissional,
    D.descricao AS Detalhe_1,
    D.gravidade AS Detalhe_2,
    NULL AS Detalhe_3
FROM PACIENTE P
    INNER JOIN AMBULATORIO A ON P.id_ambulatorio = A.id_ambulatorio
    INNER JOIN HOSPITAL H ON A.id_hospital = H.id_hospital
    INNER JOIN DIAGNOSTICO D ON P.id_paciente = D.id_paciente
WHERE P.id_paciente = 1

ORDER BY Data_Evento;


DROP TABLE CONSULTA;
DROP TABLE EXAME;
DROP TABLE DIAGNOSTICO;
DROP TABLE PESSOAL_APOIO;
DROP TABLE HOSPITAL_LABORATORIO;
DROP TABLE PACIENTE;
DROP TABLE MEDICO;
DROP TABLE AMBULATORIO;
DROP TABLE LABORATORIO;
DROP TABLE HOSPITAL;
