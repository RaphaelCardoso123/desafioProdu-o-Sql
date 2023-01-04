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

--n�o pode ser identity(1, 1) auto increment�vel pq � um c�digo �nico para cada inspetor, 
--mas de outra forma n�o se pode repetir o c�digo por ser primary key
--como fazer???
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

--talvez n�o precise fazer essa tabela t�o cheia pq no fim vou usar comandos que vai unir tabelas diferentes
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
values('Geladeira'), ('M�quina de lavar'), ('Fog�o'), ('Freezer'), ('Frigobar')
commit;
select * from producao.tipo_produto;


begin transaction;
insert into producao.avaliacao(sg_avaliacao, ds_avaliacao)
values('OK', 'Liberado'), ('EL', 'Problema el�trico'), ('PT', 'Problema de pintura'),
	  ('PE', 'Problema na estrutura'), ('TR', 'Todo rejeitado')
commit;
select * from producao.avaliacao;

begin transaction;
insert into producao.inspetor(nm_inspetor, dt_trabalho, hr_inicio_trabalho, hr_fim_trabalho)
values('Trancoso da Silva', '20221201', '9:05', '11:05'), ('Trancoso da Silva', '20221205', '9:00', '11:00'),
	  ('Trancoso da Silva', '20221207', '9:10', '11:10'), ('Trancoso da Silva', '20221216', '9:00', '11:10'),
	  ('Pedro do Monte', '20221209', '9:00', '11:00'), ('Pedro do Monte', '20221210', '9:10', '11:10'),
	  ('Jos� Carmelo', '20221214', '9:05', '11:05'), ('Jos� Carmelo', '20221218', '9:15', '11:15'),
	  ('J�lio Cardoso', '20221220', '9:00', '11:15'), ('J�lio Cardoso', '20221222', '9:00', '11:00')
commit;
select * from producao.inspetor;

--ainda n�o est� feito, s� foi copiado e colado do antigo
begin transaction; 
insert into producao.ficha(dt_inspecao, cd_matricula_inspetor, nm_inspetor)
values('20221201', 3), ('20221202', 2), ('20221206', 3), ('20221207', 4), ('20221210', 5),
('20221215', 1), ('20221216', 2), ('20221217', 3), ('20221218', 4), ('20221219', 5),
('20221220', 3), ('20221221', 1), ('20221222', 5), ('20221223', 4), ('20221224', 5)
commit;
select * from producao.ficha;