--CREATE SCHEMA RentACar;

CREATE TABLE RentACar.cliente(
	Nome			VARCHAR(50)		NOT NULL,
	Endereco		VARCHAR(100)	NOT NULL,
	Num_carta		INT		NOT NULL, -- nº carta é só números, certo?
	NIF				INT		NOT NULL, 

	PRIMARY KEY(NIF),
);

CREATE TABLE RentACar.Aluguer(
	Numero			INT		NOT NULL,
	Duracao			INT		NOT NULL, -- acho que não pode ser nem TIME nem DATE
	DataA			DATE	NOT NULL	, -- Data ou data são palavras reservadas
	Num_Balcao		INT		NOT NULL,
	Matricula_V		INT		NOT NULL,

	PRIMARY KEY(Numero),
);

CREATE TABLE RentACar.Balcao(
	Nome			VARCHAR(50)		NOT NULL,
	Numero			INT				NOT NULL,
	Endereco		VARCHAR(100)	NOT NULL,

);

CREATE TABLE RentACar.Veiculo(
	Nome			VARCHAR(50)		NOT NULL,
	Matricula		INT		NOT NULL,
	Ano				INT		NOT NULL,
	TipoVeiculo		VARCHAR(100)	NOT NULL, -- isto não devia ter um tipo próprio

);

CREATE TABLE RentACar.Tipo_Veiculo(
	Designacao		VARCHAR(50)		NOT NULL,
	Arcondicionado	VARCHAR(20)	, -- Pode ser varchar se for tipo o nome do modelo, como pode ser booleano se for tem ou não tem ArCond.
	Codigo			VARCHAR(100)	NOT NULL,

	PRIMARY KEY(Codigo)
);

CREATE TABLE RentACar.Ligeiro(
	Numlugares		TINYINT			NOT NULL,
	Portas			TINYINT			NOT NULL,
	Combustivel		DECIMAL			NOT NULL, -- porque o combustivel pode ter virgulas
);

CREATE TABLE RentACar.Pesado(
	Peso		INT		NOT NULL,
	Passageiros	TINYINT NOT NULL,

);

--- Adicionar Fk's --
-- Como tornar algumas destas Fk's em PK's ??
ALTER TABLE RentACar.Aluguer ADD CONSTRAINT NIF FOREIGN KEY REFERENCES RentACar.Cliente(NIF)

ALTER TABLE RentACar.Aluguer ADD CONSTRAINT Numero FOREIGN KEY REFERENCES RentACar.Balcao(Numero)

ALTER TABLE RentACar.Aluguer ADD CONSTRAINT Matricula_V FOREIGN KEY REFERENCES RentACar.Veiculo(Matricula)

-- FALTA FAZER AS FK's para o codigo do tipo de veiculo

/* CREATE TABLE RentACar.Similaridade(
	FOREIGN KEY (Codigo) REFERENCES RentACar.Tipo_Veiculo(Codigo),
);*/ 