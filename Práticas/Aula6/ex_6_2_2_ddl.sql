ALTER TABLE Stocks.fornecedor DROP CONSTRAINT IF EXISTS cod_tip_fornecedor;
ALTER TABLE Stocks.encomenda DROP CONSTRAINT IF EXISTS cod_fornecedor; 
ALTER TABLE Stocks.item DROP CONSTRAINT IF EXISTS cod_produto;
ALTER TABLE Stocks.item DROP CONSTRAINT IF EXISTS itemEncom;
DROP TABLE IF EXISTS Stocks.tipo_fornecedor;
DROP TABLE IF EXISTS Stocks.fornecedor;
DROP TABLE IF EXISTS Stocks.produto;
DROP TABLE IF EXISTS Stocks.encomenda;
DROP TABLE IF EXISTS Stocks.item;

DROP SCHEMA IF EXISTS Stocks;
GO

CREATE SCHEMA Stocks;
GO

CREATE TABLE Stocks.tipo_fornecedor(
	codigoTipo		int		not null,
	designacao	varchar(35) not null,

	PRIMARY KEY (codigoTipo)
	);	


CREATE TABLE Stocks.fornecedor(
	nif			int			not null,
	nome		varchar(30) 	not null,
	fax			int			not null,
	endereco	varchar(45),
	condpag		int			not null,	
	tipo		int			not null,

	PRIMARY KEY (nif)
	);	

CREATE TABLE Stocks.produto(
	codigo		int				not null,
	nome		varchar(45) 	not null,
	preco		decimal(6,2) 	not null,
	iva			int				not null,
	unidades	int				not null,

	PRIMARY KEY (codigo)
	);

CREATE TABLE Stocks.encomenda(
	numeroID		int			not null,
	[data]		date 		not null,
	fornecedor	int			not null,

	PRIMARY KEY (numeroID)
	);

CREATE TABLE Stocks.item(
	numero		int			not null,
	codProd		int	 		not null,
	unidades	int			not null,

	PRIMARY KEY (numero,codProd)
	);

ALTER TABLE Stocks.fornecedor ADD CONSTRAINT cod_tip_fornecedor	FOREIGN KEY (tipo) REFERENCES Stocks.tipo_fornecedor(codigoTipo)
ALTER TABLE Stocks.encomenda ADD CONSTRAINT cod_fornecedor 		FOREIGN KEY (fornecedor) REFERENCES Stocks.fornecedor(nif)
ALTER TABLE Stocks.item ADD CONSTRAINT cod_produto				FOREIGN KEY (codProd) REFERENCES Stocks.produto(codigo)
ALTER Table Stocks.item ADD CONSTRAINT itemEncom 				FOREIGN KEY (numero) REFERENCES Stocks.encomenda (numeroID);