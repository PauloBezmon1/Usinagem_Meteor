DROP TABLE peca;
DROP TABLE maquina;
DROP TABLE operador;
DROP TABLE materia_prima;
DROP TABLE fornecedor;
DROP TABLE ordem_producao;
DROP TABLE equipamento;
DROP TABLE hist_producao;
DROP TABLE inspecao;
DROP TABLE rejeicao;
DROP TABLE aceitacao;
DROP TABLE mp;
DROP TABLE hist_manutencao;

DROP DATABASE usinagem_meteor;
CREATE DATABASE usinagem_meteor;
USE usinagem_meteor;

-- Desabilita as verificações de Fks
set foreign_key_checks = 0;
-- Altera o tipo de dado da Fk da Tabela BankCard
set foreign_key_checks = 1;

CREATE TABLE materia_prima(
	pk_materiaID            INT auto_increment,
    ultima_compra           date not null,
    quantidade              int not null,
    descricao               varchar(200),
	Primary key(pk_materiaID)
);

CREATE TABLE peca(
	pk_pecaID       int auto_increment,
    fk_materiaID    int not null,
    material        varchar(50) not null,
    peso            decimal(6,2) not null,
    dimensoes       varchar(50) not null,
    descricao       varchar(100), 
	PRIMARY KEY(pk_pecaID),
    FOREIGN KEY(fk_materiaID) references materia_prima(pk_materiaID)
);

CREATE TABLE fornecedor(
	pk_fornecedorID         INT AUTO_INCREMENT,
	fk_materiaID            INT not null,
    nome                    varchar(100) not null,
    contato                 varchar(16) not null,
    endereço                varchar(300) not null,
    avaliacao               float,
    primary key(pk_fornecedorID),
	foreign key(fk_materiaID) references materia_prima(pk_materiaID)
);

CREATE TABLE equipamento(
	pk_equipamentoID           int auto_increment,
    nome                       varchar(250) not null,
    vida_util                  varchar(250) not null,
    data_compra                date not null,
    descricao                  varchar(250),
    PRIMARY KEY(pk_equipamentoID)
);

CREATE TABLE maquina(
	pk_maquinaID           int auto_increment,
    fk_equipamentoID       int not null,
    nome                   varchar(100) not null,
    cap_max                int not null,
    ult_manu               date not null,
    descricao              varchar(200),
    PRIMARY KEY(pk_maquinaID),
	foreign key(fk_equipamentoID) references equipamento(pk_equipamentoID)
); 

CREATE TABLE ordem_producao(
	pk_ordemID            int auto_increment,
    fk_pecaID             int not null,
	fk_maquinaID          int Not null,
    qtd_produzida         int not null,
    status                varchar(30) not null,
    data_inicio           date,
    data_conclusao        date,
	primary key(pk_ordemID),
	foreign key(fk_pecaID) references peca(pk_pecaID),
	foreign key(fk_maquinaID) references maquina(pk_maquinaID)
);

CREATE TABLE operador(
	pk_operadorID           int auto_increment,
    fk_maquinaID            int not null,
	nome                    varchar(60) not null,
    especializacao          varchar(50) not null,
    historico               varchar(100) not null,
    disponibilidade         varchar(50)not null,
    PRIMARY KEY(pk_operadorID),
    FOREIGN KEY(fk_maquinaID) references maquina(pk_maquinaID)
);

CREATE TABLE mp(
	pk_manutencaoID           int auto_increment,
    fk_maquinaID              int not null,
    tipo                      varchar(40) not null,
    data_programada           date not null,
    responsavel               varchar(50) not null,
    primary key(pk_manutencaoID),
    foreign key(fk_maquinaID) references maquina(pk_maquinaID)
);

CREATE TABLE hist_manutencao(
	pk_manutencaoID           int auto_increment,
    fk_maquinaID              int not null,
    tipo                      varchar(50) not null,
	data_manutencao           date not null,
    custos                    decimal(7,2) not null,
    primary key(pk_manutencaoID),
    foreign key(pk_manutencaoID) references mp(pk_manutencaoID),
    foreign key(fk_maquinaID) references maquina(pk_maquinaID)
);

CREATE TABLE inspecao(
	pk_inspecaoID             INT AUTO_INCREMENT,
    resultado                  VARCHAR(50) not null,
    data_inspecao             DATE NOT NULL,
    observacoes                VARCHAR(250),
	Primary key(pk_inspecaoID)
);

CREATE TABLE rejeicao(
	pk_rejeicaoID              int auto_increment,
    fk_inspecaoID              INT NOT NULL,
    acoes_corretivas           VARCHAR(250) NOT NULL,
    data_rejeicao              date not null,
    motivo                     VARCHAR(250) NOT NULL,
	PRIMARY KEY(pk_rejeicaoID),
    FOREIGN KEY(fk_inspecaoID) references inspecao(pk_inspecaoID)
);

CREATE TABLE aceitacao(
	pk_aceitacaoID             int auto_increment,
    fk_inspecaoID              INT NOT NULL,
    destino                    VARCHAR(250) NOT NULL,
    data_aceitacao             date not null,
    observacoes                VARCHAR(250) NOT NULL,
	PRIMARY KEY(pk_aceitacaoID),
    FOREIGN KEY(fk_inspecaoID) references inspecao(pk_inspecaoID)
);  

CREATE TABLE hist_producao(
	fk_ordemID          int not null,
    fk_maquinaID        INT NOT NULL,
    fk_operadorID       INT NOT NULL,
    fk_inspecao         INT NOT NULL,
    lote                VARCHAR(10) NOT NULL,
    primary key(fk_ordemID,fk_maquinaID,fk_operadorID),
    foreign key(fk_ordemID) references ordem_producao(pk_ordemID),
    foreign key(fk_maquinaID) references maquina(pk_maquinaID),
    foreign key(fk_operadorID) references operador(pk_operadorID),
    foreign key(fk_inspecao) references inspecao(pk_inspecaoID)
);