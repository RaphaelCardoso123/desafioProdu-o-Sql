use desafio;
create schema producao;

create table producao.linha_producao(
	cd_linha_producao int primary key identity(1, 1)
);

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