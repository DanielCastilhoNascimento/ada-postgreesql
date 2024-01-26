-- Projeto final do módulo Banco de Dados Postgres. Script para criação do banco de dados UniveriAda e suas tabelas.
-- Professor: Diego Rocha
-- Equipe: <DANIEL CASTILHO DO NASCIMENTO>

-- ===================================================================================================================
-- Cole abaixo seu código DDL

create table professores (
  	cod_prof integer primary key,
  	nome character varying(100),
  	endereco character varying(255),
  	cidade character varying(255)
);

create table disciplinas (
  	cod_disc character varying(10) primary key, 
  	nome_disc character varying(255),
	carga_horaria integer
);

create table turmas (
  cod_turma integer,
  cod_disc character varying(10),
  cod_prof integer,
  ano integer,
  horario character varying(50)
);

create table historicos (
  cod_hist integer primary key,
  mat integer,
  cod_disc character varying(10),
  cod_turma integer,
  cod_prof integer,
  ano integer,
  frequencia integer,
  nota integer
);

create table alunos (
  mat integer primary key,
  nome character varying(100),
  endereco character varying(255),
  cidade character varying(255)
);

-- CRIANDO OS RELACIONAMENTOS

alter table turmas
	add primary key(cod_turma, cod_disc);

alter table turmas
	add constraint fk_cod_disciplinas
	foreign key (cod_disc)
	references disciplinas(cod_disc);
	
alter table turmas
	add constraint fk_turmas_professores
	foreign key (cod_prof)
	references professores(cod_prof);

alter table historicos
  	add constraint fk_historicos_turmas_disc
  	foreign key (cod_turma, cod_disc)
  	references turmas (cod_turma, cod_disc);

alter table historicos
  	add constraint fk_historicos_professores
  	foreign key (cod_prof)
  	references professores (cod_prof);
  
alter table historicos
	add constraint fk_historicos_alunos
	foreign key(mat)
	references alunos(mat);

-- ===================================================================================================================
-- Cole abaixo seu código DML

insert into alunos (mat, nome, endereco, cidade)
values
	(2015010101, 'JOSE DE ALENCAR', 'RUA DAS ALMAS', 'NATAL'),
	(2015010102, 'JOÃO JOSÉ', 'AVENIDA RUY CARNEIRO', 'JOÃO PESSOA'),
	(2015010103, 'MARIA JOAQUINA', 'RUA CARROSSEL', 'RECIFE'),
	(2015010104, 'MARIA DAS DORES', 'RUA DAS LADEIRAS', 'FORTALEZA'),
	(2015010105, 'JOSUÉ CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL'),
	(2015010106, 'JOSUÉLISSON CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL');

insert into disciplinas (cod_disc, nome_disc, carga_horaria)
values
	('BD', 'BANCO DE DADOS', 100),
	('POO', 'PROGRAMAÇÃO COM ACESSO A BANCO DE DADOS', 100),
	('WEB', 'AUTORIA WEB', 50),
	('ENG', 'ENGENHARIA DE SOFTWARE', 80);


insert into professores(cod_prof, nome, endereco, cidade)
values
	(212131, 'NICKERSON FERREIRA', 'RUA MANAÍRA', 'JOÃO PESSOA'),
	(122135, 'ADORILSON BEZERRA', 'AVENIDA SALGADO FILHO', 'NATAL'),
	(192011, 'DIEGO OLIVEIRA', 'AVENIDA ROBERTO FREIRE', 'NATAL');


insert into turmas(cod_disc, cod_turma, cod_prof, ano, horario)
values
	('BD', 1, 212131, 2015, '11H-12H'),
	('BD', 2, 212131, 2015, '13H-14H'),
	('POO', 1, 192011, 2015, '08H-09H'),
	('WEB', 1, 192011, 2015, '07H-08H'),
	('ENG', 1, 122135, 2015, '10H-11H');

insert into historicos(cod_hist, mat, cod_turma, cod_disc, cod_prof, ano, frequencia, nota)
values
	(1, 2015010101, 1, 'BD', 212131, 2015, 100, 9),
	(2, 2015010101, 1, 'POO', 212131, 2015, 90, 7), 
	(3, 2015010101, 1, 'WEB', 192011, 2015, 100, 8),
	(4, 2015010101, 1, 'ENG', 122135, 2015, 90, 9),

	(5, 2015010102, 1, 'BD', 212131, 2015, 100, 4),
	(6, 2015010102, 1, 'POO', 212131, 2015, 100, 2),
	(7, 2015010102, 1, 'WEB', 192011, 2015, 80, 8), 
	(8, 2015010102, 1, 'ENG', 122135, 2015, 90, 10),
	
	(9, 2015010103, 1,'BD', 212131, 2015, 100, 7),
	(10, 2015010103, 1,'POO', 212131, 2015, 100, 9),
	(11, 2015010103, 1, 'WEB', 192011, 2015, 80, 7),
	(12, 2015010103, 1, 'ENG', 122135, 2015, 90, 7),
	
	(13, 2015010104, 2, 'BD', 212131, 2015, 100, 4),
	(14, 2015010104, 1, 'POO', 212131, 2015, 100, 7),
	(15, 2015010104, 1, 'WEB', 192011, 2015, 80, 6),
	(16, 2015010104, 1, 'ENG', 122135, 2015, 90, 8),

	(17, 2015010105, 2, 'BD', 212131, 2015, 100, 8),
	(18, 2015010105, 1, 'POO', 212131, 2015, 50, 4),
	(19, 2015010105, 1, 'WEB', 192011, 2015, 100, 7),
	(20, 2015010105, 1, 'ENG', 122135, 2015, 100, 10),

	(21, 2015010106, 1, 'BD', 212131, 2015, 100, 3),
	(22, 2015010106, 1, 'POO', 212131, 2015, 80, 4),
	(23, 2015010106, 1, 'WEB', 192011, 2015, 100, 10),
	(24, 2015010106, 1, 'ENG', 122135, 2015, 60, 3);

-- ===================================================================================================================
-- Cole abaixo seu código DQL

-- a) Encontre a MAT dos alunos com nota em BD em 2015 menor que 5 (obs: BD = código das disciplinas).

select 	mat as Matricula, 
		cod_disc as Disciplina,
		nota as Notas_Menor_que_5
from historicos
where nota < 5 
and ano = 2015;

-- b) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO em 2015.

select avg(nota) as media_dos_alunos_de_POO
from historicos
where cod_disc = 'POO'
and ano = 2015


-- c) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO em 2015 e que esta média seja superior 
-- a 6.

select mat as matricula, 
avg(nota) as medias_POO
from historicos
where ano = 2015
and cod_disc = 'POO'
group by mat
having avg(nota) > 6;

-- d) Encontre quantos alunos não são de Natal.

select count(*) as total_de_alunos_que_nao_sao_de_natal
from alunos
where cidade != 'NATAL'