-- CREATE SCHEMA Stocks -- só se pode correr uma vez--
DROP TABLE IF EXISTS Stocks.Contem;
DROP TABLE IF EXISTS Stocks.Tipo_Fornecedor;
DROP TABLE IF EXISTS Stocks.Encomenda;
DROP TABLE IF EXISTS Stocks.Fornecedor;
DROP TABLE IF EXISTS Stocks.Armazem;
DROP TABLE IF EXISTS Stocks.Produto;

CREATE TABLE Stocks.Produto(
	Nome				VARCHAR(50)		NOT NULL,
	Preco				DECIMAL			NOT NULL,
	CodigoProd			VARCHAR(10)	NOT NULL, 
	TAXA_IVA			INT				NOT NULL, -- nº carta é só números, certo?
	N_Produtos_Armazem	INT, -- podem haver 0 produtos 
	
	PRIMARY KEY(CodigoProd),
);
GO

CREATE TABLE Stocks.Armazem(
	Codigo_Produto	VARCHAR(10)	NOT NULL, 
	Quantidade		INT, 
	
	PRIMARY KEY(Codigo_Produto),
	FOREIGN KEY (Codigo_Produto) REFERENCES Stocks.Produto(CodigoProd),
);
GO

CREATE TABLE Stocks.Fornecedor(
	Nome			VARCHAR(50)		NOT NULL,
	NIF				INT				NOT NULL, 
	Endereco		VARCHAR(100)	NOT NULL,
	Cond_Pagamento	VARCHAR(20)		NOT NULL,
	N_FAX			INT, -- não é obrigatorio 
	Tipo			VARCHAR(20)		NOT NULL, 
	
	PRIMARY KEY(NIF)); 
	GO 

CREATE TABLE Stocks.Encomenda(
	Numero		INT		NOT NULL, 
	DataE		DATE	NOT NULL, 
	NIF			INT, -- não é obrigatorio ter NIF
	
	PRIMARY KEY(Numero),
	FOREIGN KEY (NIF) REFERENCES Stocks.Fornecedor(NIF),
);
GO


CREATE TABLE Stocks.Tipo_Fornecedor(
	Designacao	VARCHAR(30)		NOT NULL,
	Cod_Interno	INT		NOT NULL,
	
	PRIMARY KEY (Cod_Interno),
	FOREIGN KEY (Cod_Interno) REFERENCES Stocks.Fornecedor(NIF),
);
GO

CREATE TABLE Stocks.Contem(
	Cod_Produto		VARCHAR(10) NOT NULL,
	Num_Encomenda	INT 		NOT NULL,

	PRIMARY KEY(Cod_Produto, Num_Encomenda),
	FOREIGN KEY (Num_Encomenda) REFERENCES Stocks.Encomenda(Numero),
	FOREIGN KEY (Cod_Produto) REFERENCES Stocks.Produto(CodigoProd),
);
GO