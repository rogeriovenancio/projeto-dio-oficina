create database oficina;

use oficina;

-- criar tabela cliente
create table cliente(
	idCliente int auto_increment primary key,
    Nome varchar(255) not null,
    CPF char(11) not null,
    Telefone varchar(11) not null,
    Endereco varchar(255) not null,
    constraint unique_CPF unique (CPF)
);

-- criar tabela veiculo
create table veiculo(
	idVeiculo int auto_increment primary key,
    Identificacao_veiculo varchar(45)not null,
    idCliente int,
    constraint fk_veiculo_cliente foreign key (idCliente) references cliente(idCliente)
);

-- criar tabela Equipe Mecanicos
create table equipeMecanicos(
	idEquipeMecanicos int auto_increment primary key,
    servico varchar(45) not null
);

-- criar tabela mecanico
create table mecanico(
	idMecanicos int auto_increment primary key,
    CodigoMecanico int not null,
    Nome varchar(45)not null,
    Endereco varchar(45)not null,
    Especialidade varchar(45),
    EquipeMecanico int,
    constraint fk_mecanico_equipe foreign key (EquipeMecanico) references equipeMecanicos(idEquipeMecanicos)
);

-- criar tabela valor das peças
create table valorPecas(
	idValorPecas int auto_increment primary key,
    valorPecas varchar(255) not null
);

-- criar tabela mao de obra
create table maoObra(
	idMaoObra int auto_increment primary key,
    ValorMaoObra varchar(255)
);

-- criar tabela conserto e revisao
create table consertoRevisao(
	equipeMecanicos int,
    idVeiculo int,
    os int not null,
    idMaoObra int,
    idValorPecas int,
    dataOs varchar(45) not null,
    valorOs varchar(45)not null,
    statusOs varchar(45)not null,
    diasExecucao varchar(45)not null,
    constraint fk_conserto_equipe foreign key (equipeMecanicos) references equipeMecanicos(idEquipeMecanicos),
    constraint fk_conserto_veiculo foreign key (idVeiculo) references veiculo(idVeiculo),
    constraint fk_conserto_mao foreign key (idMaoObra) references maoObra(idMaoObra),
    constraint fk_conserto_pecas foreign key (idValorPecas) references valorPecas(idValorPecas)
);

-- criar tabela autorizar ou negar
create table autorizarNegar(
	idAutorizarNegar int auto_increment primary key,
    autorizacao varchar(45),
    negacao varchar(45),
    dataResposta date not null,
    idCliente int,
    idVeiculo int,
    idEquipeMecanicos int,
    constraint fk_autorizarnegar_cliente foreign key (idCliente) references cliente(idCliente),
    constraint fk_autorizarnegar_veiculo foreign key (idVeiculo) references veiculo(idVeiculo),
    constraint fk_autorizarnegar_equipe foreign key (idEquipeMecanicos) references equipeMecanicos(idEquipeMecanicos)
);

-- criar tabela servico autorizado
create table autorizado(
	idAutorizado int auto_increment primary key,
    dataconclusao varchar(45) not null,
    osautorizada int not null,
    dataosautorizada varchar(45) not null,
    statusosautorizada varchar(45) not null,
    idEquipeMecanicos int,
    idAutorizarNegar int,
    idCliente int,
    idVeiculo int,
    constraint fk_autorizado_equipe foreign key (idEquipeMecanicos) references equipeMecanicos(idEquipeMecanicos),
    constraint fk_autorizado_id foreign key (idAutorizarNegar) references autorizarNegar(idAutorizarNegar),
    constraint fk_autorizado_cliente foreign key (idCliente) references cliente(idCliente),
    constraint fk_autorizado_veiculo foreign key (idVeiculo) references veiculo(idVeiculo)
);

-- inserção de dados
insert into cliente(Nome, CPF, Telefone, Endereco) values
	('rogerio1','78965475491','04830007891','Rua bela vista 1'),
    ('helena2','45632178932','06240004562','Rua tiradentes 2'),
    ('josilene3','12345678903','01130001233','Rua bocaiuva 3');

insert into veiculo(Identificacao_veiculo, idCliente) values
	('1563456789','1'),
    ('1894567890','2'),
    ('1845678901','3');

insert into equipeMecanicos(servico) values
	('servico1'),
    ('servico2'),
    ('servico3');

insert into mecanico(CodigoMecanico, Nome, Endereco, Especialidade, EquipeMecanico) values
	('12345','mecanico1','Rua jonas alves  quadra a','especialidade1','1'),
    ('95252','mecanico2','Rua joao gualberto quadra b','especialidade2','2'),
    ('88853','mecanico3','Rua tradicional quadra c','especialidade3','3');

insert into valorPecas(valorPecas) values
	('300,00');

insert into maoObra(ValorMaoObra) values
	('250,00');

insert into consertoRevisao (os, dataOs, valorOs, statusOs, diasExecucao) values
	('123',20220101,'250,00','Em andamento','15 dias');

insert into autorizarNegar(autorizacao, negacao, dataResposta) values
	('sim',null,'20220102'),
    (null,'sim','20220103');

insert into autorizado(dataconclusao, osautorizada, dataosautorizada, statusosautorizada) values
	('20220104','0147','20220105','Concluida');

-- queries
select * from cliente;
select count(*) from cliente;

select * from cliente c,veiculo v where c.idCliente=v.idCliente;

select Nome,Telefone,idVeiculo from cliente c,veiculo v where c.idCliente=v.idCliente group by idVeiculo;