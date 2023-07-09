--CREATE SCHEMA RentACar;

CREATE TABLE RentACar.Cliente(
	Nome			VARCHAR(50)		NOT NULL,
	Endereco		VARCHAR(100)	NOT NULL,
	Num_carta		INT		NOT NULL, -- nº carta é só números, certo?
	NIF				INT		NOT NULL, 
	PRIMARY KEY(NIF),
);

CREATE TABLE RentACar.Tipo_Veiculo(
	Designacao		VARCHAR(50)		NOT NULL,
	Arcondicionado	VARCHAR(20)	, -- Pode ser varchar se for tipo o nome do modelo, como pode ser booleano se for tem ou não tem ArCond.
	Codigo			VARCHAR(100)	NOT NULL,
	PRIMARY KEY(Codigo),
);

CREATE TABLE RentACar.Veiculo(
	Nome			VARCHAR(50)		NOT NULL,
	Matricula		INT		NOT NULL,
	Ano				INT		NOT NULL,
	TipoVeiculo		VARCHAR(100)	NOT NULL, -- isto não devia ter um tipo próprio
	PRIMARY KEY (Matricula),
	FOREIGN KEY (TipoVeiculo) REFERENCES RentACar.Tipo_Veiculo(Codigo),

);

CREATE TABLE RentACar.Balcao(
	Nome			VARCHAR(50)		NOT NULL,
	Numero			INT				NOT NULL,
	Endereco		VARCHAR(100)	NOT NULL,
	PRIMARY KEY (Numero),

);

CREATE TABLE RentACar.Aluguer(
	Numero			INT		NOT NULL,
	Duracao			INT		NOT NULL, -- acho que não pode ser nem TIME nem DATE
	DataA			DATE	NOT NULL	, -- Data ou data são palavras reservadas
	Num_Balcao		INT		NOT NULL,
	Matricula_V		INT		NOT NULL,
	NIF_Cliente		INT		NOT NULL,
	PRIMARY KEY(Numero),
	FOREIGN KEY (NIF_Cliente) REFERENCES RentACar.Cliente(NIF),
	FOREIGN KEY (Num_Balcao) REFERENCES RentACar.Balcao(Numero),
	FOREIGN KEY (Matricula_V) REFERENCES RentACar.Veiculo(Matricula),
);

CREATE TABLE RentACar.Ligeiro(
	Numlugares		TINYINT			NOT NULL,
	Portas			TINYINT			NOT NULL,
	Combustivel		DECIMAL			NOT NULL, -- porque o combustivel pode ter virgulas
	Codigo			VARCHAR(100)				NOT NULL,
	FOREIGN KEY (Codigo) REFERENCES RentACar.Tipo_Veiculo(Codigo),
);

CREATE TABLE RentACar.Pesado(
	Peso		INT		NOT NULL,
	Passageiros	TINYINT NOT NULL,
	Codigo		VARCHAR(100)		NOT NULL,
	FOREIGN KEY (Codigo) REFERENCES RentACar.Tipo_Veiculo(Codigo),
);

CREATE TABLE RentACar.Similaridade(
	Cod_Veiculo	VARCHAR(100)	NOT NULL,
	FOREIGN KEY (Cod_Veiculo) REFERENCES RentACar.Tipo_Veiculo(Codigo),
);
