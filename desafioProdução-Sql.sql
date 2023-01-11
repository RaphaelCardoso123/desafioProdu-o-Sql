use desafio;
create schema producao;


create table producao.linha_producao(
		cd_linha_producao    int         primary key    identity(1, 1)
	,	dt_linha_producao    date        not null
);

create table producao.tipo_produto(
		cd_tipo_produto     int          primary key    identity(1, 1)
	,	nm_tipo_produto     varchar(30)  not null
);

create table producao.produto(
		cd_id_produto       int          primary key    identity(1, 1)
	,	dt_produto          date         not null
	,	cd_linha_producao   int          not null
	,	cd_tipo_produto     int          not null
	,	foreign key(cd_linha_producao)   references producao.linha_producao(cd_linha_producao)
		on delete cascade
		on update cascade
	,	foreign key(cd_tipo_produto)     references producao.tipo_produto(cd_tipo_produto)
		on delete cascade
		on update cascade
);

create table producao.avaliacao(
		sg_avaliacao       char(2)       primary key    not null
	,	ds_avaliacao       varchar(30)                  not null
);

create table producao.inspetor(
		cd_matricula_inspetor      int          primary key     identity(1, 1)
	,	nm_inspetor                varchar(30)                  not null
	,	dt_trabalho                date                         not null
	,	hr_inicio_trabalho         time                         not null
	,	hr_fim_trabalho            time                         not null
);

create table producao.ficha(
		cd_numero_ficha            int          primary key      identity(1, 1)
	,	dt_inspecao                date                          not null
	,	cd_matricula_inspetor      int                           not null
	,	foreign key(cd_matricula_inspetor)			references producao.inspetor(cd_matricula_inspetor)
		on delete cascade
		on update cascade
);

create table producao.controle_qualidade( 
		cd_controle_qualidade          int       primary key    identity(1, 1)
	,	dt_controle_qualidade          date                                    not null
	,	hr_inicio_controle_qualidade   time                                    not null
	,	hr_fim_controle_qualidade      time                                    not null
	,	cd_numero_ficha                int                                     not null--foreign key
	,	cd_matricula_inspetor          int                                     not null--foreign key
	,	cd_id_produto                  int                                     not null--foreign key
	,	sg_avaliacao                   char(2)                                 not null--foreign key
	,	foreign key(cd_numero_ficha)             references producao.ficha(cd_numero_ficha)
	,	foreign key(cd_matricula_inspetor)       references producao.inspetor(cd_matricula_inspetor)
	,	foreign key(cd_id_produto)               references producao.produto(cd_id_produto)
	,	foreign key(sg_avaliacao)                references producao.avaliacao(sg_avaliacao)
);


begin transaction;
insert into producao.linha_producao(dt_linha_producao)
values      ('20221201'), ('20221205'), ('20221207'), ('20221209'), ('20221210') 
        ,   ('20221214'), ('20221216'), ('20221218'), ('20221220'), ('20221222')
commit;
select * from producao.linha_producao;


begin transaction;
insert into producao.tipo_produto(nm_tipo_produto)
values     ('Geladeira'), ('Máquina de lavar'), ('Fogão'), ('Freezer'), ('Frigobar')
commit;
select * from producao.tipo_produto;


begin transaction;
insert into producao.avaliacao(sg_avaliacao, ds_avaliacao)
values      ('OK', 'Liberado'), ('EL', 'Problema elétrico'), ('PT', 'Problema de pintura')
        ,   ('PE', 'Problema na estrutura'), ('TR', 'Todo rejeitado')
commit;
select * from producao.avaliacao;


begin transaction;
insert into producao.inspetor(nm_inspetor, dt_trabalho, hr_inicio_trabalho, hr_fim_trabalho)
values		('Trancoso da Silva', '20221201', '9:00', '11:00'), ('Trancoso da Silva', '20221205', '9:00', '11:00')
        ,	('Trancoso da Silva', '20221207', '9:00', '11:00'), ('Trancoso da Silva', '20221216', '9:00', '11:00')
        ,	('Pedro do Monte', '20221209', '9:00', '11:00'), ('Pedro do Monte', '20221210', '9:10', '11:10')
        ,	('José Carmelo', '20221214', '9:05', '11:05'), ('José Carmelo', '20221218', '9:15', '11:15')
        ,	('Júlio Cardoso', '20221220', '9:00', '11:00'), ('Júlio Cardoso', '20221222', '9:00', '11:00')
commit;
select * from producao.inspetor;


begin transaction; 
insert into producao.ficha(dt_inspecao, cd_matricula_inspetor)
values		('20221201', 3), ('20221205', 3)
        ,	('20221207', 3), ('20221216', 3) 
        ,	('20221209', 1), ('20221210', 1)
        ,	('20221214', 2), ('20221218', 2)
        ,	('20221220', 4), ('20221222', 4)
        ,	('20221224', 2), ('20221225', 2)
        ,	('20221226', 4), ('20221227', 4)
		,	('20221228', 4)
commit;
select * from producao.ficha;


begin transaction;
insert into producao.produto(dt_produto, cd_linha_producao, cd_tipo_produto)
values		('20221201', 1, 2), ('20221209', 2, 3), ('20221216', 1, 1)
        ,	('20221218', 4, 5), ('20221222', 5, 4)
commit;
select * from producao.produto;


begin transaction; 
insert into producao.controle_qualidade	
			(dt_controle_qualidade, hr_inicio_controle_qualidade,  hr_fim_controle_qualidade,
			 cd_id_produto,         cd_numero_ficha,               cd_matricula_inspetor,      sg_avaliacao)
values		('20221201', '8:00', '12:00', 1, 1, 2, 'TR')
        ,	('20221205', '8:00', '12:00', 2, 5, 3, 'TR')
        ,	('20221207', '8:00', '12:00', 3, 3, 3, 'OK')
        ,	('20221216', '8:00', '12:00', 4, 1, 1, 'TR') 
        ,	('20221209', '8:00', '12:00', 6, 2, 5, 'EL')
        ,	('20221220', '8:00', '12:00', 9, 4, 4, 'PE')
commit;
select * from producao.controle_qualidade;


--------------------------------------------------------------------------------------------------------------------------------
--1. Quantas horas de controle de qualidade o inspetor Trancoso da Silva fez no dia 16/12/2022 ?
--R: Ele fez 2 horas de trabalho nessa data.

select     i.nm_inspetor, i.dt_trabalho, datediff(hour, i.hr_inicio_trabalho, i.hr_fim_trabalho) as Total_Horas_Trabalhadas
from       producao.inspetor as i, producao.controle_qualidade as cq
where      i.nm_inspetor = 'Trancoso da Silva' and i.dt_trabalho = '20221216' and i.cd_matricula_inspetor  = cq.cd_matricula_inspetor


--------------------------------------------------------------------------------------------------------------------------------
--2. Quantas horas o inspetor Trancoso da Silva trabalhou no período de 01/12/2022 à 22/12/2022?
--R: Ele trabalhou 8 horas nesse periodo.

select sum(datediff(HOUR, hr_inicio_trabalho, hr_fim_trabalho)) as Total_Horas_Trabalhadas_Mes
from   producao.inspetor 
where  nm_inspetor = 'Trancoso da Silva' and dt_trabalho between '20221201' and '20221222';


--------------------------------------------------------------------------------------------------------------------------------
--3. Quais os tipos de defeito mais recorrentes no período de 01/12/2022 à 22/12/2022?
--R: O erro mais recorrente nesse periodo foi TR.

select a.sg_avaliacao, count(1) as Tipos_Defeitos_Recorrentes
from producao.avaliacao as a
left join producao.controle_qualidade as b on b.sg_avaliacao = a.sg_avaliacao
left join producao.ficha as c on c.cd_numero_ficha = b.cd_numero_ficha
where c.dt_inspecao between '20221201' and '20221222'
and a.sg_avaliacao != 'OK'
group by a.sg_avaliacao
order by 2 desc


--------------------------------------------------------------------------------------------------------------------------------
--4. Quais inspetores atestam mais produtos com avaliação TR, todo rejeitado?
--R: O inspetor que atestou mais avaliação TR foi o Trancoso da Silva.
select i.nm_inspetor, COUNT(1) as Avaliacao_TR
from producao.inspetor as i
left join producao.ficha as f on f.cd_matricula_inspetor = i.cd_matricula_inspetor
left join producao.controle_qualidade as cq on cq.cd_matricula_inspetor = i.cd_matricula_inspetor
where cq.sg_avaliacao = 'TR'
group by i.nm_inspetor
order by 2 desc

	
--------------------------------------------------------------------------------------------------------------------------------
--5. Quais produtos que só foram liberados depois da detecção de algum problema?
