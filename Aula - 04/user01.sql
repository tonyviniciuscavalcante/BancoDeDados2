-- 6. Crie uma tabela chamada EXERCICIO com 4 colunas (sendo a PK um inteiro), uma visão
-- sobre a tabela criada e uma sequence no esquema user01.
CREATE TABLE exercicio (
    id NUMBER(1),
    nome VARCHAR2(50),
    cpf VARCHAR2(20),
    email VARCHAR2(40),
    CONSTRAINT exercicio_pk PRIMARY KEY (id)
    );
    
CREATE SEQUENCE id_seq INCREMENT BY 1 START WITH 2 NOCACHE;

CREATE VIEW exercicio_priv AS SELECT nome FROM exercicio;

-- 7. Como user01, insira 3 registros na tabela e um por meio da visão (se assim for possível).
-- Utilize a sequence para popular a PK da tabela. Conceda os devidos privilégios para tornar
-- os inserts possíveis.
INSERT INTO exercicio VALUES (id_seq.NEXTVAL, 'João', null, null);
INSERT INTO exercicio VALUES (id_seq.NEXTVAL, 'Tony', null, 'tony@aluno.com');
INSERT INTO exercicio VALUES (id_seq.NEXTVAL, 'Silvana', '123.456.789-99', null);

