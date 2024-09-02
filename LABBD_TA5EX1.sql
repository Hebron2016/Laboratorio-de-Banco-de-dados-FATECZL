CREATE DATABASE LABBD_TA5EX1
GO
USE LABBD_TA5EX1

CREATE TABLE Funcionario (
codigo		int				NOT NULL,
nome		varchar(100)	NOT NULL,
salario		DECIMAL(5,2)	NOT NULL,
PRIMARY KEY (Codigo)
)
GO
CREATE TABLE Dependente (
codigo_dep	int				NOT NULL,
codigo_func	int				NOT NULL,
nome_dep	VARCHAR(100)	NOT NULL,
salario_dep DECIMAL(5,2)	NOT NULL,
PRIMARY KEY (codigo_dep),
FOREIGN KEY (codigo_func) REFERENCES Funcionario(codigo)


--a) Código no Github ou Pastebin de uma Function que Retorne uma tabela:
--(Nome_Funcionário, Nome_Dependente, Salário_Funcionário, Salário_Dependente)
CREATE FUNCTION fn_tbla()
RETURNS @tabelaA TABLE(
nome_funcionario VARCHAR(100),
nome_dependente	 VARCHAR(100),
salario_funcionario DECIMAL(5,2),
salario_dependente DECIMAL(5,2)
)
AS
BEGIN
RETURN
END

--b) Código no Github ou Pastebin de uma Scalar Function que Retorne a soma dos Salários dos
--dependentes, mais a do funcionário.
CREATE FUNCTION fn_soma_salario(@codFunc INT)
RETURNS DECIMAL(6,2)
AS
BEGIN
	DECLARE @salarioFunc DECIMAL (5,2),
					@salarioDep DECIMAL(5,2),
					@soma DECIMAL(6,2)
	SELECT @salarioFunc = salario FROM Funcionario WHERE codigo = @codFunc 
	SELECT @salarioDep =  salario_dep FROM Dependente WHERE codigo_func = @codFunc
	SET @soma = @salarioDep + @salarioFunc
	RETURN @soma
END

--a) a partir da tabela Produtos (codigo, nome, valor unitário e qtd estoque), quantos produtos
--estão com estoque abaixo de um valor de entrada

CREATE TABLE Produtos (
codigo			int		NOT NULL,
nome			VARCHAR(100) NOT NULL,
valor_unitario	DECIMAL (5,2) NOT NULL,
qtd_estoque		INT			NOT NULL
)

CREATE FUNCTION fn_estoque (@entrada INT)
RETURNS INT
AS
BEGIN 
	DECLARE @countQtd int,
			@contador int
	SET	@contador = 0
	SELECT @contador = COUNT(codigo) FROM Produtos WHERE qtd_estoque < @entrada
	RETURN @contador
END

--b) Uma tabela com o código, o nome e a quantidade dos produtos que estão com o estoque
--abaixo de um valor de entrada
CREATE FUNCTION fn_tbProduto (@tbentra INT)
RETURNS @tb_produto TABLE(
codigo		INT			NOT NULL,
nome		VARCHAR(100) NOT NULL,
qtd_pd		INT			NOT NULL
)
AS
BEGIN
	DECLARE @cdpd	INT,
			@nome	VARCHAR(100),
			@qtd_pd	INT
	INSERT INTO @tb_produto (codigo, nome, qtd_pd)
	SELECT codigo, nome, qtd_estoque FROM Produtos WHERE qtd_estoque < @tbentra
	RETURN
END

/*Criar, uma UDF, que baseada nas tabelas abaixo, retorne
Nome do Cliente, Nome do Produto, Quantidade e Valor Total, Data de hoje
Tabelas iniciais:
Cliente (Codigo, nome)
Produto (Codigo, nome, valor)*/
CREATE TABLE Cliente(
codigo		INT,
nome		VARCHAR(100),
PRIMARY KEY(codigo)
)
CREATE TABLE Produto(
codigo		INT NOT NULL,
codigoCliente INT	NOT NULL,
nome		VARCHAR(100) NOT NULL,
valor		DECIMAL(5,2) NOT NULL
PRIMARY KEY(codigo)
FOREIGN KEY(codigoCliente) REFERENCES Cliente(codigo)
)

CREATE FUNCTION fn_clienteProduto(@codClient int,@codPd int,@qtd INT)
RETURNS @tabCP TABLE(
nome_Cliente	VARCHAR(100),
nome_Produto	VARCHAR(100),
qtd				INT,
valor_total		DECIMAL(5,2),
datahoje		DATE
)
AS
BEGIN
		DECLARE @vt DECIMAL(5,2),
				@data DATE,
				@valor DECIMAL(5,2),
				@nc	VARCHAR(100),
				@np VARCHAR(100)

		SELECT @valor = valor FROM Produto WHERE @codPd = codigo
		SET @vt = @qtd*@valor
		SET @data = GETDATE()
		SELECT @nc = cl.nome, @np = pr.nome FROM Cliente cl, Produto pr WHERE @codPd = pr.codigo 
												AND @codClient = cl.codigo
												AND cl.codigo = pr.codigoCliente

		INSERT INTO @tabCP (nome_Cliente, nome_Produto, qtd, valor_total,datahoje) VALUES
		(@nc, @np,@qtd,@vt,@data)
END