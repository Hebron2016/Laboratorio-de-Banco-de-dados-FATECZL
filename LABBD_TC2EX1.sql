--a) Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles
DECLARE @vlr INT,
		@calc INT,
		@count INT
SET @count = 0
SET @vlr = 7
SET @calc = @vlr % 2
	IF (@calc = 0)
	BEGIN
		PRINT('É multiplo de 2')
		SET @count = @count + 1
	END
SET @calc = @vlr % 3
	IF (@calc = 0)
	BEGIN
		PRINT('É multiplo de 3')
		SET @count = @count + 1
	END
SET @calc = @vlr % 5
	IF (@calc = 0)
	BEGIN
		PRINT('É multiplo de 5')
		SET @count = @count + 1
	END
	IF (@count = 0)
	BEGIN
		PRINT('Não é multiplo de 2,3,5')
	END



--b) Fazer um algoritmo que leia 3 números e mostre o maior e o menor
DECLARE @n1	INT,
		@n2 INT,
		@n3	INT
SET @n1 = 1
SET @n2 = 2
SET @n3 = 3
	IF(@n1 > @n2 AND @n1 > @n3)
	BEGIN
		PRINT('O maior é o @n1')
	END
	IF(@n2 > @n1 AND @n2 > @n3)
	BEGIN
		PRINT('O maior é o@n2')
	END
	IF (@n3 > @n1 AND @n3 > @n2)
	BEGIN
		PRINT('O maior é o@n3')
	END
	IF(@n1 < @n2 AND @n1 < @n3)
	BEGIN
		PRINT('O menor é o @n1')
	END
	IF(@n2 < @n1 AND @n2 < @n3)
	BEGIN
		PRINT('O menor é o @n2')
	END
	IF(@n3 < @n1 AND @n3 < @n2)
	BEGIN
		PRINT('O menor é o @n3')
	END


--c) Fazer um algoritmo que calcule os 15 primeiros termos da série
DECLARE @rs INT,
		@v1	INT,
		@v2 INT, 
		@contad INT,
		@soma INT
SET @soma = 0
SET @rs = 0
SET @v1 = 1
SET @v2 = 1
SET @contad = 2
WHILE (@contad <= 15)
BEGIN
	IF (@v1 = 1 and @v2 = 1)
	BEGIN
	PRINT(@v1)
	PRINT(@v2)
	SET @soma = @v1 + @v2
	END
	SET @rs = @v1 + @v2
	SET @soma = @rs + @soma
	SET @v2 = @v1
	SET @v1 = @rs
	SET @contad = @contad + 1
	PRINT (@rs)
END
IF (@contad > 15)
BEGIN
	PRINT('A SOMA É')
	PRINT(@soma)
END



--d) Fazer um algoritmo que separa uma frase, colocando todas as letras em maiúsculo e em
--minúsculo (Usar funções UPPER e LOWER)
DECLARE @frase VARCHAR(100),
		@Sep   VARCHAR (50),
		@at1   INT,
		@at2   INT
SET @frase = 'Fatec Zona Leste tem o melhor ADS de São Paulo'
SET @at1 = 0
SET @at2 = LEN(@frase)/2
SET @sep = SUBSTRING(@frase, @at1, @at2) 
IF(@at1 = 0)
BEGIN
	SET @sep = UPPER(@sep)
	PRINT (@sep)
	SET @at1 = @at2
	SET @at2 = LEN(@frase)
END
SET @sep = SUBSTRING(@frase,@at1,@at2)
SET @sep = LOWER(@sep)
PRINT (@sep)
IF (@at2 = LEN(@frase))
BEGIN
	SET @sep = null
END


--e) Fazer um algoritmo que inverta uma palavra (Usar a função SUBSTRING)
DECLARE @oracao VARCHAR(100),
		@inv   VARCHAR (100),
		@num   INT,
		@num2   INT,
		@co		INT
SET @co = 0
SET @oracao ='Fatec Zona Leste tem o melhor ADS de São Paulo'
SET @num2 = LEN(@oracao)
SET @num = 0
SET @inv = ''
PRINT (@inv)
WHILE (@co <= LEN(@oracao)+1)
BEGIN
	SET @num = @num2
	SET @inv = @inv + SUBSTRING(@oracao, @num,1)
	SET @num2 = @num2 - 1
	SET @co = @co +1
END
PRINT(@inv)


--f) Considerando a tabela abaixo, gere uma massa de dados, com 100 registros, para fins de teste
--com as regras estabelecidas (Não usar constraints na criação da tabela)
CREATE DATABASE LABBD_TC2EX1f
GO
USE LABBD_TC2EX1f

CREATE TABLE Computador (
ID		INT		NOT NULL,
marca   VARCHAR(40)	NOT NULL,
qtdRAM	INT		NOT NULL,
tipoHD	VARCHAR(10) NOT NULL,
qtdHD	INT		NOT NULL,
freqCPU DECIMAL(7,2) NOT NULL
PRIMARY KEY (ID)
)

DECLARE @id	INT,
		@nm VARCHAR(10),
		@marca INT,
		@ram INT,
		@tphd VARCHAR(7),
		@hd	INT,
		@freq DECIMAL(4,2)
SET @id = 10001
SET @marca = 1
WHILE (@id <= 10100)
BEGIN
	SET @ram = RAND()*16
	IF (@ram <=2)
	BEGIN
		SET @ram = 2
	END
	ELSE
	BEGIN
		IF(@ram <=4)
		BEGIN 
			SET @ram = 4
		END
		ELSE
		BEGIN
			IF(@ram <= 8)
			BEGIN
				SET @ram = 8
			END
			ELSE
			BEGIN
				IF(@ram <= 16)
				BEGIN 
					SET @ram = 16
				END
			END
		END
	END
	IF(@id%3 = 0)
	BEGIN
		SET @tphd = 'HDD'
		SET @hd = RAND()*2000
		IF(@hd <=500)
		BEGIN
			SET @hd=500
		END
		ELSE
		BEGIN
			IF(@hd <= 1000)
			BEGIN
				SET @hd=1000
			END
			ELSE
			BEGIN
				IF(@hd <= 2000)
				BEGIN
					SET @hd = 2000
				END
			END
		END
	END
	IF(@id%3 = 1)
	BEGIN
		SET @tphd = 'SSD'
		SET @hd = RAND()*512
		IF(@hd <=128)
		BEGIN
			SET @hd = 128
		END
		ELSE
		BEGIN
			IF(@hd <= 256)
			BEGIN
				SET @hd = 256
			END
			ELSE
			BEGIN
				IF (@hd = 512)
				BEGIN
					SET @hd = 512
				END
			END
		END
	END
	IF(@id%3 = 2)
	BEGIN
		SET @tphd = 'M2 NVME'
		SET @hd = 0
	END
	SET @freq = RAND()*1.5 + 1.7
	SET @nm = 'Marca ' + CAST(@marca AS VARCHAR (3))
	INSERT INTO Computador VALUES
	(@id,@nm,@ram,@tphd,@hd,@freq)
	SET @id = @id +1
	SET @marca = @marca + 1
END 

SELECT * FROM Computador


	






