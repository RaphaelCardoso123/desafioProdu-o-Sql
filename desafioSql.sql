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
	nm_tipo_produto varchar(30) not null,
	foreign key(cd_linha_producao) references producao.linha_producao(cd_linha_producao),
	foreign key(cd_tipo_produto) references producao.tipo_produto(cd_tipo_produto)
);

create table producao.avaliacao(
	sg_avaliacao char(2) primary key not null,
	ds_avaliacao varchar(30) not null
);

--não pode ser identity (1, 1) auto incrementavel pq é um código único para cada inspetor
create table producao.inspetor(
	cd_matricula_inspetor int primary key identity(1, 1),
	nm_inspetor varchar(30) not null,
	dt_trabalho date not null,
	hr_inicio_trabalho time not null,
	hr_fim_trabalho time not null,
);

create table producao.ficha(
	cd_numero_ficha int primary key identity(1, 1),
	dt_inspecao date not null,
	cd_matricula_inspetor int not null,
	nm_inspetor varchar(30) not null,
	foreign key(cd_matricula_inspetor) references producao.inspetor(cd_matricula_inspetor)
);

--talvez não precise fazer essa tabela tão cheia pq no fim vou usar comandos que vai unir tabelas diferentes
create table producao.controle_qualidade( 
	cd_controle_qualidade int primary key identity(1, 1),
	dt_controle_qualidade date not null,
	hr_inicio_controle_qualidade time not null,
	hr_fim_controle_qualidade time not null,
	cd_numero_ficha int not null,--foreign key
	dt_inspecao date not null,
	cd_matricula_inspetor int not null,--foreign key
	nm_inspetor varchar(30) not null,
	dt_trabalho date not null,
	hr_inicio_trabalho time not null,
	hr_fim_trabalho time not null,
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
values('20221201'), ('20221205'), ('20221207'), ('20221209'), ('20221210'), 
	  ('20221214'), ('20221216'), ('20221218'), ('20221220'), ('20221222')
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

--não pode ser identity (1, 1) auto incrementavel pq é um código único para cada inspetor
begin transaction;
insert into producao.inspetor(nm_inspetor, dt_trabalho, hr_inicio_trabalho, hr_fim_trabalho)
values('Trancoso da Silva', '20221201', '9:05', '11:05'), ('Trancoso da Silva', '20221205', '9:00', '11:00'),
	  ('Trancoso da Silva', '20221207', '9:10', '11:10'), ('Trancoso da Silva', '20221216', '9:00', '11:10'),
	  ('Pedro do Monte', '20221209', '9:00', '11:00'), ('Pedro do Monte', '20221210', '9:10', '11:10'),
	  ('José Carmelo', '20221214', '9:05', '11:05'), ('José Carmelo', '20221218', '9:15', '11:15'),
	  ('Júlio Cardoso', '20221220', '9:00', '11:15'), ('Júlio Cardoso', '20221222', '9:00', '11:00')
commit;
select * from producao.inspetor;

begin transaction; 
insert into producao.ficha(dt_inspecao, cd_matricula_inspetor, nm_inspetor)
values('20221201', 1, 'Trancoso da Silva'), ('20221205', 2, 'Trancoso da Silva'),
	  ('20221207', 3, 'Trancoso da Silva'), ('20221216', 4, 'Trancoso da Silva'), 
	  ('20221209', 5, 'Pedro do Monte'), ('20221210', 6, 'Pedro do Monte'),
	  ('20221214', 7, 'José Carmelo'), ('20221218', 8, 'José Carmelo'),
	  ('20221220', 9, 'Júlio Cardoso'), ('20221222', 10, 'Júlio Cardoso'),
	  ('20221224', 7, 'José Carmelo'), ('20221225', 7, 'José Carmelo'),
	  ('20221226', 9, 'Júlio Cardoso'), ('20221227', 10, 'Júlio Cardoso'), ('20221228', 10, 'Júlio Cardoso')
commit;
select * from producao.ficha;

begin transaction;
insert into producao.produto(dt_produto, cd_linha_producao, cd_tipo_produto, nm_tipo_produto)
values('20221201', 1, 2, 'Máquina de lavar'), ('20221209', 2, 3, 'Fogão'), ('20221216', 1, 1, 'Geladeira'),
	  ('20221218', 4, 5, 'Frigobar'), ('20221222', 5, 4, 'Freezer')
commit;
select * from producao.produto;