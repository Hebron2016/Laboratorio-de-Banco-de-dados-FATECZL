CREATE DATABASE LABBD_T1A2
GO
USE LABBD_T1A2

--a) Dado um número inteiro. Calcule e mostre o seu fatorial. (Não usar entrada superior a 12)
DECLARE @vlr	INT,
		@cont	INT
SET @vlr = 5
SET @cont = @vlr - 1
WHILE (@cont != 1)
BEGIN
	SET @vlr = @vlr * @cont
	SET @cont = @cont - 1
	PRINT(@vlr)
END
--b) Dados A, B, e C de uma equação do 2o grau da fórmula AX2+BX+C=0. Verifique e mostre a
--existência de raízes reais e se caso exista, calcule e mostre. Caso não existam, exibir mensagem.
DECLARE @a	INT,
		@b	INT,
		@c  INT,
		@delta INT,
		@x1	INT,
		@x2 INT
SET @a = 1
SET @b = 5
SET @c = 2
SET @delta = (@b*@b)-4*@a*@c
print(@delta)
IF (@delta >= 0)
BEGIN
	SET @x1 = (-@b+SQRT(@delta))/2*@a
	SET @x2 = (-@b-SQRT(@delta))/2*@a
	PRINT ('A raizes são reais')
	PRINT (@x1)
	PRINT (@x2)
END
ELSE
BEGIN
	PRINT('DELTA É NEGATIVO')
END

--c) Calcule e mostre quantos anos serão necessários para que Ana seja maior que Maria sabendo
--que Ana tem 1,10 m e cresce 3 cm ao ano e Maria tem 1,5 m e cresce 2 cm ao ano.
DECLARE @Ana FLOAT,
		@Maria FLOAT,
		@Ano  INT
SET @Ana = 1.10
SET @Maria = 1.5
SET @Ano = 0
WHILE (@Ana < @Maria)
BEGIN
	SET @Ana = @Ana +0.03
	SET @Maria = @Maria + 0.02
	SET @Ano = @Ano + 1
END
PRINT(@Ano)

--d) Seja a seguinte série: 1, 4, 4, 2, 5, 5, 3, 6, 6, 4, 7, 7, ...
DECLARE @N INT,
		@calc INT
		SET @N = 1
		SET @CALC = 3
WHILE (@N < 10)
BEGIN
	PRINT (@N)
	SET @calc= @N + 3
	PRINT (@calc)
	PRINT (@calc)
	SET @N = @N +1
END

/*e) Considerando a tabela abaixo, gere uma database, a tabela e crie um algoritmo para inserir
uma massa de dados, com 50 registros, para fins de teste, com as regras estabelecidas (Não
usar constraints na criação da tabela)*/
CREATE TABLE Teste (
	codigo INT NOT NULL,
	nome   VARCHAR(30) NOT NULL,
	valor  DECIMAL (4,2) NOT NULL,
	vencimento DATE NOT NULL
PRIMARY KEY (codigo)
)

DECLARE @cod		INT,
		@nome	VARCHAR(13),
		@valor	DECIMAL (7,2),
		@vencimento DATE
SET @cod = 50001
WHILE (@cod <= 50050)
BEGIN
	SET @valor = RAND()*91.0 + 10.0
	SET @vencimento = DATEADD(DAY,(RAND()*3+5),GETDATE())
	SET @nome = 'Produto '+CAST(@cod AS VARCHAR(6))
	INSERT INTO Teste VALUES
	(@cod, @nome, @valor, @vencimento )
	SET @cod = @cod + 1
END

--f) Considerando a tabela abaixo, gere uma database, a tabela e crie um algoritmo para inserir
--uma massa de dados, com 50 registros, para fins de teste, com as regras estabelecidas (Não
--usar constraints na criação da tabela)
CREATE TABLE Test2(
	id		INT		NOT NULL,
	nome	VARCHAR(30) NOT NULL,
	qtd_paginas	INT NOT NULL,
	qtd_estoque INT NOT NULL
	PRIMARY KEY (id)
)

DECLARE @livID	INT,
		@titulo VARCHAR(30),
		@qtdp	INT,
		@qtde	INT
SET @livID = 981101
WHILE (@livID <= 981150)
BEGIN
		SET @titulo = 'Livro '+CAST(@livID AS VARCHAR(6))
		SET @qtdp = RAND()*300 + 100
		SET @qtde = RAND()*18 + 2
		INSERT INTO Test2 VALUES
		(@livID, @titulo, @qtdp, @qtde)
		SET @livID = @livID+1
END