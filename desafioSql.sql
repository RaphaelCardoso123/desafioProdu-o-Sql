use desafio;
create schema producao;


create table producao.linha_producao(
	cd_linha_producao int primary key identity(1, 1),
	dt_linha_producao date not null
);

create table producao.tipo_produto(
	cd_tipo_produto int primary key identity(1, 1),
	nm_tipo_produto varchar(30) not null
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
	sg_avaliacao char(2) primary key not null,
	ds_avaliacao varchar(30) not null
);

create table producao.inspetor(
	cd_matricula_inspetor int primary key identity(1, 1),
	nm_inspetor varchar(30) not null
);

create table producao.ficha(
	cd_numero_ficha int primary key identity(1, 1),
	dt_inspecao date not null,
	cd_matricula_inspetor int not null,
	foreign key(cd_matricula_inspetor) references producao.inspetor(cd_matricula_inspetor)
);

create table producao.controle_qualidade(
	cd_controle_qualidade int primary key identity(1, 1),
	hr_controle_qualidade time not null,
	cd_numero_ficha int not null,--foreign key
	dt_inspecao date not null,
	nm_inspetor varchar(30) not null,
	cd_matricula_inspetor int not null,--foreign key
	cd_id_produto int not null,--foreign key
	cd_linha_producao int not null,--foreign key
	dt_linha_producao date not null,
	cd_tipo_produto int not null,--foreign key
	sg_avaliacao char(2) not null,--foreign key
	foreign key(cd_numero_ficha) references producao.ficha(cd_numero_ficha),
	foreign key(cd_matricula_inspetor) references producao.inspetor(cd_matricula_inspetor),
	foreign key(cd_id_produto) references producao.produto(cd_id_produto),
	foreign key(cd_linha_producao) references producao.linha_producao(cd_linha_producao),
	foreign key(cd_tipo_produto) references producao.tipo_produto(cd_tipo_produto),
	foreign key(sg_avaliacao) references producao.avaliacao(sg_avaliacao)
);


begin transaction;
insert into producao.linha_producao(dt_linha_producao)
values('20221201'), ('20221205'), ('20221216'), ('20221218'), ('20221222')
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
values('20221201', 3), ('20221202', 2), ('20221206', 3), ('20221207', 4), ('20221210', 5),
('20221215', 1), ('20221216', 2), ('20221217', 3), ('20221218', 4), ('20221219', 5),
('20221220', 3), ('20221221', 1), ('20221222', 5), ('20221223', 4), ('20221224', 5)
commit;
select * from producao.ficha;


begin transaction; 
insert into producao.produto(dt_produto, cd_linha_producao, cd_tipo_produto)
values('20221201', 1, 2), ('20221209', 2, 3), ('20221216', 1, 1), ('20221218', 4, 5), ('20221222', 5, 4)
commit;
select * from producao.produto;


begin transaction; 
insert into producao.controle_qualidade(cd_numero_ficha, dt_inspecao, nm_inspetor, cd_matricula_inspetor, cd_id_produto,
cd_linha_producao, dt_linha_producao, cd_tipo_produto, sg_avaliacao, hr_controle_qualidade)
values(15, '20221216', 'Trancoso da Silva', 1, 5, 1, '20221201', 4, 'EL', '9:05:15'), 
	  (15, '20221216', 'Trancoso da Silva', 1, 4, 4, '20221201', 1, 'OK', '9:20:10'),
	  (15, '20221216', 'Trancoso da Silva', 1, 2, 3, '20221201', 2, 'PT', '9:35:26'),
	  (15, '20221216', 'Trancoso da Silva', 1, 5, 3, '20221201', 3, 'OK', '9:50:40'), 
	  (15, '20221216', 'Trancoso da Silva', 1, 1, 1, '20221201', 4, 'OK', '10:00:00'),
	  (15, '20221216', 'Trancoso da Silva', 1, 3, 1, '20221201', 4, 'OK', '10:15:29')
commit;
select * from producao.controle_qualidade;