CREATE DATABASE LABBD_T1A4EX1
GO
USE LABBD_T1A4EX1

CREATE TABLE Produto(
codigo		INT		NOT NULL,
nome		VARCHAR(100)	NOT NULL,
valor		DECIMAL(5,2)	NOT NULL,
PRIMARY KEY(codigo)
)
CREATE TABLE Entrada(
codigo_transacao	INT		NOT NULL,
codigo_produto		INT		NOT NULL,
quantidade			INT		NOT NULL,
valorTotal			DECIMAL(5,2) NOT NULL
PRIMARY KEY(codigo_transacao)
FOREIGN KEY(codigo_produto) REFERENCES Produto(codigo)
)
CREATE TABLE Saida(
codigo_transacao	INT		NOT NULL,
codigo_produto		INT		NOT NULL,
quantidade			INT		NOT NULL,
valorTotal			DECIMAL(5,2) NOT NULL
PRIMARY KEY(codigo_transacao)
FOREIGN KEY(codigo_produto) REFERENCES Produto(codigo)
)
CREATE PROCEDURE sp_insertProduto(@tp VARCHAR(1),@ct INT, @cp INT,@qtd INT)
AS
DECLARE @erro VARCHAR(100),
		@tabela VARCHAR(20),
		@valor DECIMAL(5,2),
		@vt	DECIMAL(5,2),
		@queryi VARCHAR(200)
IF(@tp != 'e' AND @tp != 's')
BEGIN
	PRINT(@tp)
	SET @erro = 'tipo de transação invalida'
	RAISERROR (@erro,16,1)
END
IF(@tp = 'e')
BEGIN
	SET @tabela = 'Entrada'
END
IF(@tp = 's')
BEGIN
	SET @tabela = 'Saida'
END
SET @valor = (SELECT valor FROM Produto WHERE codigo = @cp)
SET @vt = @valor*@qtd
BEGIN TRY
	PRINT(@tabela)
	PRINT(@ct) 
	PRINT(@cp) 
	PRINT(@qtd)
	PRINT(@vt)
	PRINT('TENTOU')
	SET @queryi = 'INSERT INTO '+@tabela+' VALUES ('+CAST(@ct AS VARCHAR(5))+','''+CAST(@cp AS VARCHAR(5))+''','''+CAST(@qtd AS VARCHAR(5))+''','''+CAST(@vt AS VARCHAR(5))+''')'
	EXEC(@queryi)
	PRINT (@queryi)
END TRY
BEGIN CATCH
	SET @erro = ERROR_MESSAGE()
	PRINT(@erro)
END CATCH
IF (@erro IS NOT NULL)
BEGIN
	IF (LOWER(@erro) LIKE '%primary%')
	BEGIN
		SET @erro = 'ID Duplicado'
	END
		PRINT (@erro)
		RAISERROR (@erro, 16, 1)
END

INSERT INTO Produto VALUES
(1,'Produto1',10.0),
(2,'Produto2',10.0),
(3,'Produto3',10.0),
(4,'Produto4',10.0),
(5,'Produto5',10.0)

--TESTE QUERY

EXEC sp_insertProduto 's',1,2,3

Select * from Entrada
Select * from Saida
Select * from Produto

