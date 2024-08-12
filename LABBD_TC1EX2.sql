CREATE DATABASE LABBD_TC1EX2v1
GO
USE LABBD_TC1EX2v1

CREATE TABLE Motorista (
codigo			INT			NOT NULL,
nome			VARCHAR(40) NOT NULL,
naturalidade	VARCHAR(40) NOT NULL,
PRIMARY KEY(codigo)
)
GO
CREATE TABLE Onibus(
placa			CHAR(7)		NOT NULL,
marca			VARCHAR(15) NOT NULL,
ano				INT			NOT NULL,
descricao		VARCHAR(20) NOT NULL
PRIMARY KEY(placa)
)
GO
CREATE TABLE Viagem(
codigo			INT			NOT NULL,
onibus			CHAR(7)		NOT NULL,
motorista		INT			NOT NULL,
hora_saida		INT			NOT NULL CHECK (hora_saida>= 0),
hora_chegada	INT			NOT NULL CHECK (hora_chegada>= 0),
partida			VARCHAR(40) NOT NULL,
destino			VARCHAR(40) NOT NULL
PRIMARY KEY(codigo)
FOREIGN KEY(motorista) REFERENCES Motorista(codigo),
FOREIGN KEY(onibus)	REFERENCES	Onibus(placa)
)

INSERT INTO Motorista VALUES
(12341,'Julio Cesar','São Paulo'),
(12342,'Mario Carmo','Americana'),
(12343,'Lucio Castro','Campinas'),
(12344,'André Figueiredo','São Paulo'),
(12345,'Luiz Carlos','São Paulo'),
(12346,'Carlos Robeto','Campinas'),
(12347,'João Paulo','São Paulo')

INSERT INTO Onibus VALUES
('adf0965','Mercedes',2009,'Leito'),
('bhg7654','Mercedes',2012,'Sem Banheiro'),
('dtr2093','Mercedes',2017,'Ar Condicionado'),
('gui7625','Volvo',2014,'Ar Condicionado'),
('jhy9425','Volvo',2018,'Leito'),
('lmk7485','Mercedes',2015,'Ar Condicionado'),
('aqw2374','Volvo',2014,'Leito')

INSERT INTO Viagem VALUES
(101,'adf0965',12343,10,12,'São Paulo','Campinas'),
(102,'gui7625',12341,7,12,'São Paulo','Araraquara'),
(103,'bhg7654',12345,14,22,'São Paulo','Rio de Janeiro'),
(104,'dtr2093',12344,18,21,'São Paulo','Sorocaba'),
(105,'aqw2374',12342,11,17,'São Paulo','Ribeirão Preto'),
(106,'jhy9425',12347,10,19,'São Paulo','São José do Rio Preto'),
(107,'lmk7485',12346,13,20,'São Paulo','Curitiba'),
(108,'adf0965',12343,14,16,'Campinas','São Paulo'),
(109,'gui7625',12341,14,19,'Araraquara','São Paulo'),
(110,'bhg7654',12345,0,8,'Rio de Janeiro','São Paulo'),
(111,'dtr2093',12344,22,1,'Sorocaba','São Paulo'),
(112,'aqw2374',12342,19,5,'Ribeirão Preto','São Paulo'),
(113,'jhy9425',12347,22,7,'São José do Rio Preto','São Paulo'),
(114,'lmk7485',12346,0,7,'Curitiba','São Paulo')

--1) Criar um Union das tabelas Motorista e ônibus, com as colunas ID (Código e Placa) e Nome (Nome e Marca)		
SELECT CAST(codigo AS CHAR(7)) AS ID, nome AS Nome
FROM Motorista		
UNION
SELECT placa AS ID, marca AS Nome
FROM Onibus			
--2) Criar uma View (Chamada v_motorista_onibus) do Union acima
CREATE VIEW v_motorista_onibus
AS
	SELECT CAST(codigo AS CHAR(7)) AS ID, nome AS Nome
	FROM Motorista		
	UNION
	SELECT placa AS ID, marca AS Nome
	FROM Onibus
/*3) Criar uma View (Chamada v_descricao_onibus) que mostre o Código da Viagem, 
o Nome do motorista, a placa do ônibus (Formato XXX-0000), a Marca do ônibus, 
o Ano do ônibus e a descrição do onibus*/
CREATE VIEW v_descricao_onibus
AS
	SELECT vg.codigo, mt.nome, SUBSTRING(os.placa, 1, 3) +'-'+SUBSTRING(os.placa, 4, 7) AS Placa, os.marca,os.ano, os.descricao
	FROM Motorista mt, Viagem vg, Onibus os
	WHERE mt.codigo = vg.motorista
	AND vg.onibus = os.placa

/*4) Criar uma View (Chamada v_descricao_viagem) que mostre o Código da viagem, 
a placa do ônibus(Formato XXX-0000), a Hora da Saída da viagem (Formato HH:00), 
a Hora da Chegada da viagem (Formato HH:00), partida e destino*/
CREATE VIEW v_descricao_viagem
AS
	SELECT vg.codigo, mt.nome, SUBSTRING(os.placa, 1, 3) +'-'+SUBSTRING(os.placa, 4, 7) AS Placa,
			CAST(vg.hora_saida AS CHAR(2)) + ':00' AS Hora_de_saida, 
			CAST(vg.hora_chegada AS CHAR(2)) + ':00' AS Hora_de_chegada, vg.partida, vg.destino
	FROM Motorista mt, Viagem vg, Onibus os
	WHERE mt.codigo = vg.motorista
		AND vg.onibus = os.placa

SELECT * FROM v_motorista_onibus
SELECT * FROM v_descricao_onibus
SELECT * FROM v_descricao_viagem