CREATE DATABASE LABBD_TC3EX1
GO
USE LABBD_TC3EX1

CREATE TABLE Aluno(
codigo_aluno	INT NOT NULL,
nome			VARCHAR(80) NOT NULL
PRIMARY KEY (codigo_aluno)
)
GO
CREATE TABLE Atividade(
codigo			INT	NOT NULL,
descricao		VARCHAR(MAX) NOT NULL,
imc				DECIMAL(5,2) NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE Aluno_atividade(
codigo_aluno	INT	NOT NULL,
atividade		INT NOT NULL,
altura			DECIMAL (5,2) NOT NULL,
peso			DECIMAL (5,2) NOT NULL,
imc				DECIMAL(10,2) NOT NULL
PRIMARY KEY (codigo_aluno, atividade)
FOREIGN KEY (codigo_aluno) REFERENCES Aluno(codigo_aluno),
FOREIGN KEY (atividade) REFERENCES atividade(codigo)
)

INSERT INTO Atividade VALUES
(1,'Corrida + step', 18.5),
(2,' Biceps + Costas + Pernas', 24.9),
(3,' Esteira + Biceps + Costas + Pernas', 29.9),
(4,' Bicicleta + Biceps + Costas + Pernas', 34.9),
(5,'Esteira + Bicicleta', 39.9)



/*Atividade: Buscar a PRIMEIRA atividade referente ao IMC imediatamente acima do calculado.
Exemplo, se o IMC for igual a 27, deve-se fazer a atividade para IMC = 29.9
* Caso o IMC seja maior que 40, utilizar o código 5.
*/
DECLARE @id INT,
		@nome VARCHAR(80),
		@alt DECIMAL(5,2),
		@peso DECIMAL (5,2),
		@imc DECIMAL (10,2),
		@idatv INT
SET @id = 1
SET @nome = 'Hebron'
SET @alt = 1.75
SET @peso = 95.00

CREATE PROCEDURE sp_cadTableAlunoAtividade (@peso DECIMAL (5,2), @alt DECIMAL(5,2), 
									@imc DECIMAL (10,2) OUTPUT, @idatv INT OUTPUT)
AS
SET @imc = @peso/(@alt*@alt)
PRINT (@imc)
IF(@imc <= 18.5)
BEGIN
	SET @idatv = 1
END
ELSE
BEGIN
	IF(@imc <= 24.9)
	BEGIN
		SET @idatv = 2
	END
	ELSE
	BEGIN
		IF(@imc <= 29.9)
		BEGIN
			SET @idatv = 3
		END
		ELSE
		BEGIN
			IF(@imc <= 34.9)
			BEGIN
				SET @idatv = 4
			END
			ELSE
			BEGIN
				IF(@imc <= 39.9 OR @imc > 39.9)
				BEGIN
					SET @idatv = 5
				END
			END
		END
	END
END
SELECT * FROM Aluno_atividade

/*Criar uma Stored Procedure (sp_alunoatividades), com as seguintes regras:
- Se, dos dados inseridos, o código for nulo, mas, existirem nome, altura, peso, deve-se inserir um
novo registro nas tabelas aluno e aluno atividade com o imc calculado e as atividades pelas
regras estabelecidas acima.*/

CREATE PROCEDURE sp_alunoCodigoNulo (@idcn INT,@name VARCHAR(80),@altura DECIMAL(5,2),@peso1 DECIMAL(5,2),
									@imcn DECIMAL (10,2), @idatv INT,
																						 @valcn BIT OUTPUT)
AS
	IF(@idcn IS NULL AND @name IS NOT NULL AND @altura IS NOT NULL AND @peso1 IS NOT NULL)
	BEGIN
					EXEC sp_cadTableAlunoAtividade @peso1, @altura, @imcn OUTPUT, @idatv OUTPUT
					INSERT INTO Aluno VALUES
					(@name)
					INSERT INTO Aluno_atividade VALUES
					(@idcn, @altura, @peso1, @imcn)
					SET @valcn = 1
	END




/*- Se, dos dados inseridos, o nome for (ou não nulo), mas, existirem código, altura, peso, deve-se
verificar se aquele código existe na base de dados e atualizar a altura, o peso, o imc calculado e
as atividades pelas regras estabelecidas acima.*/
CREATE PROCEDURE sp_alunoNomeNulo (@idnn INT,@nm VARCHAR(80),@altura2 DECIMAL(5,2),@peso2 DECIMAL(5,2),
																		@imc2 DECIMAL (10,2),@idatv2 INT,
																						 @valcn BIT OUTPUT)
AS
IF(@nm IS NULL OR @nm IS NOT NULL AND @idnn IS NOT NULL AND @altura2 IS NOT NULL AND @peso2 IS NOT NULL)
BEGIN
					EXEC sp_cadTableAlunoAtividade @peso2, @altura2, @imc2 OUTPUT, @idatv2 OUTPUT
					INSERT INTO Aluno VALUES
					(@idnn)
					INSERT INTO Aluno_atividade VALUES
					(@idatv2, @altura2, @peso2, @imc2)
					SET @valcn = 1
END

/*- Fazer a Stored Procedure atomizada, ou seja, chamando outras Stored Procedures com
responsabilidades específicas.*/
CREATE PROCEDURE sp_atomcnnn (@ida INT, @nma VARCHAR(80), @alta DECIMAL(5,2),@pa DECIMAL(5,2), @imca DECIMAL (10,2),
																										 @idatva INT, 
																										@vala BIT OUTPUT)
AS	
	EXEC sp_alunoNomeNulo @ida, @nma,@alta,@pa,@imca,@idatva,@vala
	IF (@vala != 1)
	BEGIN
		EXEC sp_alunoCodigoNulo @ida, @nma,@alta,@pa,@imca,@idatva,@vala
	END

--TESTE DE QUERY
/*Ao enviar a massa de dados com um código */
EXEC sp_alunoCodigoNulo