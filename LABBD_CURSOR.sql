CREATE DATABASE LABBDA10
GO
USE LABBDA10

CREATE TABLE curso(
codigo		INT		NOT NULL,
nome		VARCHAR(100) NOT NULL,
duracao		INT		NOT NULL
PRIMARY KEY (codigo)
)
go
CREATE TABLE disciplina(
codigo VARCHAR(6) NOT NULL,
nome VARCHAR (100) NOT NULL,
cargaHoraria INT	NOT NULL
PRIMARY KEY (codigo)
)
go
CREATE TABLE disciplina_curso(
codigo_disciplina	VARCHAR(6) NOT NULL,
codigo_curso	INT		NOT NULL,
PRIMARY KEY(codigo_disciplina, codigo_curso),
FOREIGN KEY(codigo_disciplina) REFERENCES disciplina(codigo),
FOREIGN KEY(codigo_curso)	REFERENCES curso(codigo),
)

INSERT INTO curso VALUES
(48, 'Análise e Desenvolvimento de Sistemas', 2880),
(51, 'Logistica',2880),
(67, 'Polímeros',2880),
(73, 'Comércio Exterior',2600),
(94, 'Gestão Empresarial',2600)
GO
INSERT INTO disciplina VALUES
('ALG001','Algoritmos',80),
('ADM001','Administração',80),
('LHW010','Laboratório de Hardware',40),
('LPO001','Pesquisa Operacional',80),
('FIS003','Física I',80),
('FIS007','Físico Química',80),
('CMX001','Comércio Exterior',80),
('MKT002','Fundamentos de Marketing',80),
('INF001','Informática',40),
('ASI001','Sistemas de Informação',80)
GO
INSERT INTO disciplina_curso VALUES
('ALG001', 48),
('ADM001', 48),
('ADM001', 51),
('ADM001', 73),
('ADM001', 94),
('LHW010', 48),
('LPO001', 51),
('FIS003', 67),
('FIS007', 67),
('CMX001', 51),
('CMX001', 73),
('MKT002', 51),
('MKT002', 94),
('INF001', 51),
('INF001', 73),
('ASI001', 48),
('ASI001', 94)

CREATE FUNCTION fn_cursoDetalhe (@codigoCurso INT)
RETURNS @tabela TABLE(
codigoDisciplina	VARCHAR(6) NOT NULL,
nomeDisciplina		VARCHAR(100) NOT NULL,
cargaHorariaDisciplina INT	NOT NULL,
nomeCurso	VARCHAR(100) NOT NULL
)
AS 
BEGIN
	DECLARE @codigoDisciplina VARCHAR(6),
			@nomeDisciplina VARCHAR(100),
			@cargaHorariaDisciplina INT,
			@nomeCurso VARCHAR(100)
	DECLARE c CURSOR FOR SELECT d.codigo, c.nome, d.cargaHoraria, c.nome FROM curso c, disciplina_curso dc, disciplina d 
							WHERE c.codigo = @codigoCurso
							AND c.codigo = dc.codigo_curso
							AND	dc.codigo_disciplina = d.codigo
	OPEN c
	FETCH NEXT FROM c INTO @codigoDisciplina, @nomeDisciplina, @cargaHorariaDisciplina, @nomeCurso
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO @tabela VALUES (@codigoDisciplina, @nomeDisciplina, @cargaHorariaDisciplina, @nomeCurso)
		FETCH NEXT FROM c INTO @codigoDisciplina, @nomeDisciplina, @cargaHorariaDisciplina, @nomeCurso
	END
	CLOSE c
	DEALLOCATE c
	RETURN 
END

SELECT * FROM fn_cursoDetalhe(48)
