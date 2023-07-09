DROP TABLE IF EXISTS Prescricao.Presc_Farmaco;
DROP TABLE IF EXISTS Prescricao.Prescricao;
DROP TABLE IF EXISTS Prescricao.Farmaco;
DROP TABLE IF EXISTS Prescricao.Farmaceutica;
DROP TABLE IF EXISTS Prescricao.Farmacia;
DROP TABLE IF EXISTS Prescricao.Paciente;
DROP TABLE IF EXISTS Prescricao.Medico;

DROP SCHEMA IF EXISTS Prescricao;
GO

CREATE SCHEMA Prescricao;
GO

CREATE TABLE Prescricao.Medico(
	numSNS		    INT             NOT NULL,
	nome		    VARCHAR(25)		NOT NULL,
    especialidade   VARCHAR(15)     NOT NULL,
	
	PRIMARY KEY (numSNS)	
);

CREATE TABLE Prescricao.Paciente(
	numUtente  INT          NOT NULL,
	nome	   VARCHAR(25)	NOT NULL,
    dataNasc   DATE,
    endereco   VARCHAR(30), 
	
	PRIMARY KEY (numUtente)
);

CREATE TABLE Prescricao.Farmacia(
	nome	   VARCHAR(25)	NOT NULL,
    telefone   INT,
    endereco   VARCHAR(30), 
	
	PRIMARY KEY (nome)
);

CREATE TABLE Prescricao.Farmaceutica(
	numReg	   INT	        NOT NULL,
    nome	   VARCHAR(25)	NOT NULL,
    endereco   VARCHAR(40), 
	
	PRIMARY KEY (numReg)
);

CREATE TABLE Prescricao.Farmaco(
	numRegFarm	   INT	        NOT NULL,
    nome	       VARCHAR(25)	NOT NULL,
    formula        VARCHAR(30)  NOT NULL, 
	
	PRIMARY KEY (numRegFarm, nome),
    FOREIGN KEY (numRegFarm) REFERENCES Prescricao.Farmaceutica(numReg)
);

CREATE TABLE Prescricao.Prescricao(
	numPresc	   INT	        NOT NULL,
    numUtente	   INT	        NOT NULL,
    numMedico	   INT	        NOT NULL,
    farmacia       VARCHAR(25),
    dataProc       DATE,
	
	PRIMARY KEY (numPresc),
    FOREIGN KEY (numUtente) REFERENCES Prescricao.Paciente(numUtente),
    FOREIGN KEY (numMedico) REFERENCES Prescricao.Medico(numSNS),
    FOREIGN KEY (farmacia) REFERENCES Prescricao.Farmacia(nome)
);

CREATE TABLE Prescricao.Presc_Farmaco(
	numPresc	   INT	        NOT NULL,
    numRegFarm	   INT	        NOT NULL,
    nomeFarmaco    VARCHAR(25)  NOT NULL,
	
	PRIMARY KEY (numPresc, numRegFarm, nomeFarmaco),
    FOREIGN KEY (numPresc) REFERENCES Prescricao.Prescricao(numPresc),
    FOREIGN KEY (numRegFarm, nomeFarmaco) REFERENCES Prescricao.Farmaco(numRegFarm, nome)
);











