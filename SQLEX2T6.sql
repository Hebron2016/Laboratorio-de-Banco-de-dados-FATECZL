CREATE DATABASE LABBD_TC1EX1v5
GO
USE LABBD_TC1EX1v5

CREATE TABLE Aluno (
RA		INT			NOT NULL,
nome	VARCHAR(100)NOT NULL,
idade	INT			NOT NULL CHECK(idade>0)
PRIMARY KEY (RA)
)
GO
CREATE TABLE Disciplina(
codigo	INT			NOT NULL,
nome	VARCHAR(80) NOT NULL,
carga_horaria INT	NOT NULL CHECK(carga_horaria > 32),
PRIMARY KEY  (codigo)
)
GO
CREATE TABLE Curso(
codigo	INT			NOT NULL,
nome	VARCHAR(50) NOT NULL,
Area	VARCHAR(100)NOT NULL
PRIMARY KEY (codigo)	
)
GO
CREATE TABLE Titulacao(
codigo	INT			NOT NULL,
titulo	VARCHAR(40)	NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE Professor(
registro	INT		NOT NULL,
nome		VARCHAR(100)	NOT NULL,
titulacao	INT		NOT NULL
PRIMARY KEY (registro)
FOREIGN KEY (titulacao) REFERENCES Titulacao(codigo)
)
GO
CREATE TABLE Aluno_Disciplina (
disciplinaCodigo INT NOT NULL,
aluno_RA		INT	NOT NULL
PRIMARY KEY (aluno_RA, disciplinaCodigo)
FOREIGN KEY (aluno_RA) REFERENCES Aluno(RA),
FOREIGN KEY (disciplinaCodigo) REFERENCES Disciplina(codigo)
)
GO
CREATE TABLE Curso_Disciplina(
disciplinaCodigo INT NOT NULL,
cursoCodigo		INT	NOT NULL
PRIMARY KEY (cursoCodigo, disciplinaCodigo)
FOREIGN KEY (cursoCodigo) REFERENCES Curso(codigo),
FOREIGN KEY (disciplinaCodigo) REFERENCES Disciplina(codigo)
)
GO
CREATE TABLE Disciplina_Professor(
disciplinaCodigo	INT	NOT NULL,
professorRegistro	INT NOT NULL
PRIMARY KEY (disciplinaCodigo,professorRegistro)
FOREIGN KEY (disciplinaCodigo) REFERENCES Disciplina(codigo),
FOREIGN KEY (professorRegistro) REFERENCES Professor(registro)
)

INSERT INTO Aluno VALUES
(3416,'DIEGO PIOVESAN DE RAMOS',18),
(3423,'LEONARDO MAGALHÃES DA ROSA',17),
(3434,'LUIZA CRISTINA DE LIMA MARTINELI',20),
(3440,'IVO ANDRÉ FIGUEIRA DA SILVA',25),
(3443,'BRUNA LUISA SIMIONI',37),
(3448,'THAÍS NICOLINI DE MELLO',17),
(3457,'LÚCIO DANIEL TÂMARA ALVES',29),
(3459,'LEONARDO RODRIGUES',25),
(3465,'ÉDERSON RAFAEL VIEIRA',19),
(3466,'DAIANA ZANROSSO DE OLIVEIRA',21),
(3467,'DANIELA MAURER',23),
(3470,'ALEX SALVADORI PALUDO',42),
(3471,'VINÍCIUS SCHVARTZ',19),
(3472,'MARIANA CHIES ZAMPIERI',18),
(3482,'EDUARDO CAINAN GAVSKI',19),
(3483,'REDNALDO ORTIZ DONEDA',20),
(3499,'MAYELEN ZAMPIERON',22)

INSERT INTO Disciplina VALUES
(1,'Laboratório de Banco de Dados',80),
(2,'Laboratório de Engenharia de Software',80),
(3,'Programação Linear e Aplicações',80),
(4,'Redes de Computadores',80),
(5,'Segurança da informação',40),
(6,'Teste de Software',80),
(7,'Custos e Tarifas Logísticas',80),
(8,'Gestão de Estoques',40),
(9,'Fundamentos de Marketing',40),
(10,'Métodos Quantitativos de Gestão',80),
(11,'Gestão do Tráfego Urbano',80),
(12,'Sistemas de Movimentação e Transporte'	,40)

INSERT INTO Curso VALUES
(1,'ADS','Ciências da Computação'),
(2,'Logística','Engenharia Civil')

INSERT INTO Titulacao VALUES
(1,'Especialista'),
(2,'Mestre'),
(3,'Doutor')

INSERT INTO Professor VALUES
(1111,'Leandro',2),
(1112,'Antonio',2),
(1113,'Alexandre',3),
(1114,'Wellington',2),
(1115,'Luciano',1),
(1116,'Edson',2),
(1117,'Ana',2),
(1118,'Alfredo',1),
(1119,'Celio',2),
(1120,'Dewar',3),
(1121,'Julio',1)

INSERT INTO Aluno_Disciplina VALUES
(1,3416),
(4,3416),
(1,3423),
(2,3423),
(5,3423),
(6,3423),
(2,3434),
(5,3434),
(6,3434),
(1,3440),
(5,3443),
(6,3443),
(4,3448),
(5,3448),
(6,3448),
(2,3457),
(4,3457),
(5,3457),
(6,3457),
(1,3459),
(6,3459),
(7,3465),
(11,3465),
(8,3466),
(11,3466),
(8,3467),
(12,3467),
(8,3470),
(9,3470),
(11,3470),
(12,3470),
(7,3471),
(7,3472),
(12,3472),
(9,3482),
(11,3482),
(8,3483),
(11,3483),
(12,3483),
(8,3499)

INSERT INTO Disciplina_Professor VALUES
(1,1111),
(2,1112),
(3,1113),
(4,1114),
(5,1115),
(6,1116),
(7,1117),
(8,1118),
(9,1117),
(10,1119),
(11,1120),
(12,1121)

INSERT INTO Curso_Disciplina VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,2),
(8,2),
(9,2),
(10,2),
(11,2),
(12,2)

--Fazer uma pesquisa que permita gerar as listas de chamadas, com RA e nome por disciplina ?	
SELECT al.nome, al.RA, di.nome
FROM Aluno al, Disciplina di, Aluno_Disciplina ad
WHERE al.RA = ad.aluno_RA
AND di.codigo = ad.disciplinaCodigo		
ORDER BY di.nome	
									
--Fazer uma pesquisa que liste o nome das disciplinas e o nome dos professores que as ministram		
SELECT di.nome, pr.nome
FROM Professor pr, Disciplina_Professor dp, Disciplina di
WHERE pr.registro = dp.professorRegistro
AND dp.disciplinaCodigo = di.codigo
ORDER BY pr.nome
											
--Fazer uma pesquisa que , dado o nome de uma disciplina, retorne o nome do curso	
SELECT cu.nome
FROM Disciplina di, Curso_Disciplina cd, Curso cu	
WHERE di.nome = 'Gestão de Estoques'
AND di.codigo = cd.disciplinaCodigo
AND cd.cursoCodigo = cu.codigo		
							
--Fazer uma pesquisa que , dado o nome de uma disciplina, retorne sua área													
SELECT cu.Area
FROM Disciplina di, Curso_Disciplina cd, Curso cu
WHERE di.nome = 'Teste de Software'
AND di.codigo = cd.disciplinaCodigo
AND cd.cursoCodigo = cu.codigo	

--Fazer uma pesquisa que , dado o nome de uma disciplina, retorne o título do professor que a ministra
SELECT pr.nome, ti.titulo
FROM Professor pr, Disciplina_Professor dp, Disciplina di, Titulacao ti
WHERE di.nome = 'Segurança da informação'
AND pr.registro = dp.professorRegistro
AND pr.titulacao = ti.codigo
AND dp.disciplinaCodigo = di.codigo
ORDER BY pr.nome													

--Fazer uma pesquisa que retorne o nome da disciplina e quantos alunos estão matriculados em cada uma delas
SELECT di.nome, COUNT(al.ra) AS NumeroAlunos
FROM Disciplina di, Aluno_Disciplina ad, Aluno al
WHERE di.codigo = ad.disciplinaCodigo
AND ad.aluno_RA = al.RA
AND al.RA IN
(
	SELECT al.ra
	FROM Aluno al
)		
GROUP BY di.nome			
							
--Fazer uma pesquisa que, dado o nome de uma disciplina, retorne o nome do professor.  Só deve retornar de disciplinas que tenham, no mínimo, 5 alunos matriculados		
SELECT pr.nome
FROM Professor pr, Disciplina_Professor dp , Disciplina di, Aluno al, Aluno_Disciplina ad
WHERE di.nome = 'Segurança da informação'
AND di.codigo = dp.disciplinaCodigo
AND dp.professorRegistro = pr.registro
AND al.RA = ad.aluno_RA
AND ad.disciplinaCodigo = di.codigo
GROUP BY pr.nome
HAVING COUNT(al.RA) >= 5

--Fazer uma pesquisa que retorne o nome do curso e a quatidade de professores cadastrados que ministram aula nele. A coluna de ve se chamar quantidade	
SELECT cu.nome, COUNT(pr.registro) AS quantidade
FROM Curso cu, Curso_Disciplina cd, Disciplina di, Disciplina_Professor dp, Professor pr
WHERE cu.codigo = cd.cursoCodigo
AND cd.disciplinaCodigo = di.codigo
AND dp.disciplinaCodigo = di.codigo
AND dp.professorRegistro = pr.registro
AND pr.registro IN 
(
	SELECT pr.registro
	FROM Professor pr
)	
GROUP BY cu.nome										