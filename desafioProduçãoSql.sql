use desafio;
create schema producao;


create table producao.linha_producao(
	cd_linha_producao int primary key identity(1, 1)
);


alter table producao.linha_producao
add nm_linha_producao varchar (50) not null;


create table producao.tipo_produto(
	cd_tipo_produto int primary key identity(1, 1),
	nm_tipo_produto varchar(50) not null
);


create table producao.produto(
	cd_id_produto int primary key identity(1, 1),
	dt_produto date not null,
	cd_linha_producao int not null,
	cd_tipo_produto int not null,
	foreign key(cd_linha_producao) references producao.linha_producao(cd_linha_producao),
	foreign key(cd_tipo_produto) references producao.tipo_produto(cd_tipo_produto)
);

create table producao.avaliacao(
	sg_avaliacao char(10) primary key not null,
	ds_avaliacao varchar(50) not null
);

create table producao.inspetor(
	cd_matricula_inspetor int primary key identity(1, 1),
	nm_inspetor varchar(50) not null
);

create table producao.ficha(
	cd_numero_ficha int primary key identity(1, 1),
	dt_inspecao date not null,
	cd_matricula_inspetor int not null,
	foreign key(cd_matricula_inspetor) references producao.inspetor(cd_matricula_inspetor)
);

create table producao.item(
	cd_item int primary key identity(1, 1),
	hr_item time not null,
	cd_numero_ficha int not null,
	sg_avaliacao char(10) not null,
	cd_id_produto int not null,
	foreign key(cd_numero_ficha) references producao.ficha(cd_numero_ficha),
	foreign key(sg_avaliacao) references producao.avaliacao(sg_avaliacao),
	foreign key(cd_id_produto) references producao.produto(cd_id_produto)
);


begin transaction;
insert into producao.linha_producao(nm_linha_producao)
values('Aa'), ('Bb'), ('Cc'), ('Dd'), ('Ee')
commit;
select * from producao.linha_producao;


begin transaction;
insert into producao.tipo_produto(nm_tipo_produto)
values('Geladeira'), ('Máquina de lavar'), ('Fogão'), ('Freezer'), ('Frigobar')
commit;
select * from producao.tipo_produto;


begin transaction;
insert into producao.avaliacao(sg_avaliacao, ds_avaliacao)
values('OK', 'Liberado'), ('EL', 'Problema elétrico'), ('PT', 'Problema de pintura'),
	  ('PE', 'Problema na estrutura'), ('TR', 'Todo rejeitado')
commit;
select * from producao.avaliacao;


begin transaction;
insert into producao.inspetor(nm_inspetor)
values('Trancoso da Silva'), ('Pedro do Monte'), ('José Carmelo'), ('Júlio Cardoso'), ('Carlos Merinda')
commit;
select * from producao.inspetor;


begin transaction; 
insert into producao.ficha(dt_inspecao, cd_matricula_inspetor)
values('20230101', 3), ('20230101', 2), ('20230101', 3), ('20230101', 4), ('20230101', 5),
('20230101', 1), ('20230101', 2), ('20230101', 3), ('20230101', 4), ('20230101', 5),
('20230101', 1), ('20230101', 2), ('20230101', 3), ('20230101', 4), ('20230101', 5)
commit;
select * from producao.ficha;


begin transaction; 
insert into producao.produto(dt_produto, cd_linha_producao, cd_tipo_produto)
values('20050412', 1, 1), ('20050512', 2, 2), ('20050612', 3, 3), ('20051012', 4, 4), ('20051112', 5, 5)
commit;
select * from producao.produto;


begin transaction;
insert into producao.item(hr_item, cd_numero_ficha, sg_avaliacao, cd_id_produto)
values('9:05', 1, 'EL', 27), ('9:15', 2, 'OK', 28),('9:55', 3, 'PE', 29),('9:05', 4, 'PT', 30),('9:45', 5, 'TR', 31)
commit;
select * from producao.item;

