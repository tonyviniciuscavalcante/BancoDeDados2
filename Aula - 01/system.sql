/*======================================================= AULA 01 =======================================================*/
ALTER SESSION SET "_ORACLE_SCRIPT" = true;

CREATE TABLE atleta (
    id       NUMBER(4) NOT NULL,
    cpf      VARCHAR2(14) NOT NULL,
    nome     VARCHAR2(60) NOT NULL,
    sexo     CHAR(1),
    datanasc DATE,
    endereco VARCHAR2(50),
    salario  NUMBER(8, 2) NOT NULL,
    id_clube NUMBER(4),
    CONSTRAINT atleta_pk PRIMARY KEY ( id ),
    CONSTRAINT atleta_uk UNIQUE ( cpf ),
    CONSTRAINT atleta_sexo_ck
        CHECK ( sexo IN ( 'M', 'F', 'm', 'f' ) ),
    CONSTRAINT atleta_salario_ck CHECK ( salario > 0 )
-- CONSTRAINT atleta_clube_fk FOREIGN KEY (id_clube) REFERENCES clube(id)
);
-- Como a tabela clube ainda não existe, precisa criar sem a FK referenciando Clube

CREATE TABLE presidente (
    id       NUMBER(4),
    cpf      VARCHAR2(14) NOT NULL,
    nome     VARCHAR2(14) NOT NULL,
    email    VARCHAR2(80),
    telefone VARCHAR2(20),
    CONSTRAINT presidente_pk PRIMARY KEY ( id ),
    CONSTRAINT presidente_cpf_uk UNIQUE ( cpf )
);

CREATE TABLE clube (
    id            NUMBER(4) NOT NULL,
    nome          VARCHAR2(40) NOT NULL,
    data_fundacao DATE,
    id_presidente NUMBER(4),
    CONSTRAINT clube_pk PRIMARY KEY ( id ),
    CONSTRAINT clube_nome_uk UNIQUE ( nome ),
    CONSTRAINT clube_presidente_fk FOREIGN KEY ( id_presidente )
        REFERENCES presidente ( id )
);

-- Adicionando a FK de clube na tabela ATLETA (se tabela ATLETA foi criada anteriormente à tabela CLUBE)
ALTER TABLE atleta
    ADD CONSTRAINT atleta_clube_fk FOREIGN KEY ( id_clube )
        REFERENCES clube ( id );

CREATE TABLE modalidade (
    id        NUMBER(3),
    descricao VARCHAR2(30),
    olimpica  CHAR(1) DEFAULT 'N',
    CONSTRAINT modalidade_pk PRIMARY KEY ( id ),
    CONSTRAINT modalidade_olimpica_ck
        CHECK ( olimpica IN ( 'S', 's', 'N', 'n' ) )
);

CREATE TABLE olimpico (
    id_atleta         NUMBER(4),
    incentivo_governo CHAR(1),
    CONSTRAINT olimpico_pk PRIMARY KEY ( id_atleta ),
    CONSTRAINT olimpico_incentivo_ck
        CHECK ( incentivo_governo IN ( 'S', 's', 'N', 'n' ) ),
    CONSTRAINT olimpico_atleta_fk FOREIGN KEY ( id_atleta )
        REFERENCES atleta ( id )
);

CREATE TABLE paraolimpico (
    id_atleta   NUMBER(4),
    deficiencia VARCHAR2(30),
    nivel       NUMBER,
    CONSTRAINT paraolimpico_pk PRIMARY KEY ( id_atleta ),
    CONSTRAINT paraolimpico_nivel_ck CHECK ( nivel BETWEEN 1 AND 5 ),
    CONSTRAINT paraolimpico_atleta_fk FOREIGN KEY ( id_atleta )
        REFERENCES atleta ( id )
);

CREATE TABLE campeonato (
    id          NUMBER(3),
    nome        VARCHAR2(70) NOT NULL,
    local       VARCHAR2(40),
    data_inicio DATE,
    data_fim    DATE,
    CONSTRAINT campeonato_pk PRIMARY KEY ( id )
);

CREATE TABLE centro_treinamento (
    id_clube  NUMBER(4),
    id_centro NUMBER(4),
    fone      VARCHAR2(20),
    rua       VARCHAR2(50),
    nro       NUMBER,
    bairro    VARCHAR2(50),
    cep       VARCHAR2(9),
    cidade    VARCHAR2(50),
    uf        CHAR(2),
    CONSTRAINT ct_pk PRIMARY KEY ( id_clube,
                                   id_centro ),
    CONSTRAINT ct_clube_fk FOREIGN KEY ( id_clube )
        REFERENCES clube ( id )
);

CREATE TABLE atleta_contato (
    id_atleta NUMBER(4),
    contato   VARCHAR2(20),
    CONSTRAINT atleta_contato_pk PRIMARY KEY ( id_atleta,
                                               contato ),
    CONSTRAINT atleta_contato_fk FOREIGN KEY ( id_atleta )
        REFERENCES atleta ( id )
);

CREATE TABLE pratica (
    id_atleta     NUMBER(4),
    id_modalidade NUMBER(3),
    data_inicio   DATE,
    experiencia   NUMBER,
    CONSTRAINT pratica_pk PRIMARY KEY ( id_atleta,
                                        id_modalidade ),
    CONSTRAINT pratica_atleta_fk FOREIGN KEY ( id_atleta )
        REFERENCES atleta ( id ),
    CONSTRAINT pratica_modalidade_fk FOREIGN KEY ( id_modalidade )
        REFERENCES modalidade ( id )
);

CREATE TABLE esporte (
    registro_atleta NUMBER(8),
    id_atleta       NUMBER(4),
    id_modalidade   NUMBER(3),
    CONSTRAINT esporte_pk PRIMARY KEY ( registro_atleta ),
    CONSTRAINT esporte_fk
        FOREIGN KEY ( id_atleta,
                      id_modalidade )
            REFERENCES pratica ( id_atleta,
                                 id_modalidade )
);

CREATE TABLE participa (
    registro_atleta NUMBER(8),
    id_campeonato   NUMBER(3),
    colocacao       NUMBER(5),
    valor_preciacao NUMBER(10, 2) DEFAULT 0,
    CONSTRAINT participa_pk PRIMARY KEY ( registro_atleta,
                                          id_campeonato ),
    CONSTRAINT participa_registro_fk FOREIGN KEY ( registro_atleta )
        REFERENCES esporte ( registro_atleta ),
    CONSTRAINT participa_campeonato_fk FOREIGN KEY ( id_campeonato )
        REFERENCES campeonato ( id )
);

DESC atleta;

SELECT
    table_name
FROM
    user_tables;

ALTER TABLE atleta ADD idade DATE;

ALTER TABLE atleta MODIFY
    idade NUMBER(3);

ALTER TABLE atleta RENAME COLUMN idade TO idd;

ALTER TABLE atleta DROP COLUMN idd;

INSERT INTO presidente (
    id,
    nome,
    cpf,
    email,
    telefone
) VALUES ( 1,
           'Godofred Silva',
           '195.819.624-70',
           'gsilva@gmail.com',
           '(16) 3411-9878' );

INSERT INTO presidente (
    id,
    nome,
    cpf,
    email,
    telefone
) VALUES ( 2,
           'Maria Sincera',
           '876.987.345-66',
           'marias@globo.com',
           '(19) 99876-8764' );

INSERT INTO presidente (
    id,
    nome,
    cpf,
    email,
    telefone
) VALUES ( 3,
           'Patrício Dias',
           '100.200.300-44',
           'padias@outlook.com',
           '(11) 991254-8756' );

INSERT INTO clube (
    id,
    nome,
    data_fundacao,
    id_presidente
) VALUES ( 10,
           'Pinheiros',
           TO_DATE('11/04/1965', 'DD/MM/YYYY'),
           1 );

INSERT INTO clube (
    id,
    nome,
    data_fundacao,
    id_presidente
) VALUES ( 20,
           'Flamengo',
           TO_DATE('21/07/2010', 'DD/MM/YYYY'),
           3 );

INSERT INTO clube (
    id,
    nome,
    data_fundacao,
    id_presidente
) VALUES ( 30,
           'Clube da Luta',
           TO_DATE('03/08/1977', 'DD/MM/YYYY'),
           2 );

INSERT INTO clube (
    id,
    nome,
    data_fundacao,
    id_presidente
) VALUES ( 40,
           'Santos',
           TO_DATE('04/09/1921', 'DD/MM/YYYY'),
           NULL );

INSERT INTO atleta (
    id,
    nome,
    cpf,
    sexo,
    datanasc,
    endereco,
    salario,
    id_clube
) VALUES ( 1,
           'Jade Barbosa',
           '112.356.757-34',
           'F',
           TO_DATE('27/10/1990', 'dd/mm/yyyy'),
           'Rua das Artes, 132',
           10500,
           NULL );

INSERT INTO atleta (
    id,
    nome,
    cpf,
    sexo,
    datanasc,
    endereco,
    salario,
    id_clube
) VALUES ( 2,
           'Gustavo Borges',
           '231.423.574-11',
           'M',
           TO_DATE('10/05/1985', 'dd/mm/yyyy'),
           'Rua das Águas, 365',
           48300.55,
           NULL );

INSERT INTO atleta (
    id,
    nome,
    cpf,
    sexo,
    datanasc,
    endereco,
    salario,
    id_clube
) VALUES ( 3,
           'Anderson Silva',
           '358.967.111-21',
           'M',
           TO_DATE('1982-02-15', 'yyyy-mm-dd'),
           'Av. Spider, 12',
           7200.50,
           30 );

INSERT INTO atleta (
    id,
    nome,
    cpf,
    sexo,
    datanasc,
    endereco,
    salario,
    id_clube
) VALUES ( 4,
           'Marta',
           '987.654.321-00',
           'F',
           TO_DATE('1988-07-07', 'yyyy-mm-dd'),
           'Rua da Bola, 1437',
           125000,
           40 );

UPDATE atleta
SET
    id_clube = 10
WHERE
    nome = 'Jade Barbosa';

UPDATE atleta
SET
    id_clube = 20
WHERE
    nome = 'Gustavo Borges';

DELETE FROM clube
WHERE
    nome = 'Flamengo';
-- Não vai ser possível pois existe um atrelamento entre as tabelas, que vamos testar após quebrar este laço abaixo..

ALTER TABLE atleta DROP CONSTRAINT atleta_clube_fk;

ALTER TABLE atleta
    ADD CONSTRAINT atleta_clube_fk
        FOREIGN KEY ( id_clube )
            REFERENCES clube ( id )
                ON DELETE CASCADE;

DELETE FROM clube
WHERE
    nome = 'Flamengo';

UPDATE clube
SET
    id_presidente = NULL
WHERE
    id_presidente = 1;

DELETE FROM presidente
WHERE
    nome = 'Godofred Silva';
    
/*1. Recuperar todas as colunas e os registros da tabela atleta:*/
SELECT
    *
FROM
    atleta;

/*2. Recuperar o id, data de nascimento, endereço e salário dos atletas:*/
SELECT
    id,
    datanasc,
    endereco,
    salario
FROM
    atleta;

/*3. Recuperar o id, nome e id do presidente dos clubes, exibindo os ơtulos das
colunas como ID_CLUBE, NOME_CLUBE e PRESIDENTE:*/
SELECT
    id            id_clube,
    nome          nome_clube,
    id_presidente presidente
FROM
    clube;

/*4. Recuperar o nome e o salário dos atletas cujos nomes comecem com a letra
“R”:*/
SELECT
    nome,
    salario
FROM
    atleta
WHERE
    nome LIKE 'R%';

/*5. Recuperar o nome e o sexo dos atletas cuja penúlƟma letra do nome seja
“t”:*/
SELECT
    nome,
    sexo
FROM
    atleta
WHERE
    nome LIKE 't_';

/*6. Recuperar o nome e o salário dos atletas que ganhem entre 15000 e
25000:*/
SELECT
    nome,
    salario
FROM
    atleta
WHERE
    salario BETWEEN 15000 AND 25000;

/*7. Recuperar CPF e nome dos atletas que não possuem clube. Ordene a lista
alfabeƟcamente:*/
SELECT
    cpf,
    nome
FROM
    atleta
WHERE
    id_clube IS NULL
ORDER BY
    nome DESC;

/*8. Recuperar o id, nome e salário dos atletas que ganham menos que
10.000,00. Ordene o resultado do maior para o menor salário:*/
SELECT
    id,
    nome,
    salario
FROM
    atleta
WHERE
    salario < 10000
ORDER BY
    salario ASC;