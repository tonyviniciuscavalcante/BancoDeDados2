CREATE TABLE teste_priv (
    cod NUMBER(1),
    texto CHAR(10));
    
INSERT INTO teste_priv VALUES (1, 'aaaa');

ALTER TABLE teste_priv MODIFY texto VARCHAR2(10);

DESC teste_priv;

DROP TABLE teste_priv;

CREATE TABLE teste_priv (
    cod NUMBER(1),
    texto VARCHAR2(10));
    
CREATE SEQUENCE teste_id_seq INCREMENT BY 1 START WITH 2 NOCACHE;

INSERT INTO teste_priv VALUES (teste_id_seq.NEXTVAL, 'asdas');

CREATE VIEW v_teste_priv AS SELECT texto FROM teste_priv;

CREATE TABLE HR.teste_priv2 (
    id NUMBER(1),
    descricao CHAR(1));
    
DROP TABLE HR.teste_priv2;

CREATE TABLE HR.teste_priv2 (
    id NUMBER(1),
    descricao CHAR(1));
    
CREATE VIEW HR.v_teste_priv2 AS SELECT descricao FROM HR.teste_priv2;

INSERT INTO HR.teste_priv2 VALUES (5, 'e');

GRANT select, insert
ON HR.clube
TO MARIA;

SELECT object_name, object_type, created, status
FROM user_objects
ORDER BY object_type;

DESCRIBE user_tables;

SELECT * FROM user_tab_columns;

DESCRIBE user_views;
SELECT DISTINCT view_name FROM user_views;
SELECT text FROM user_views
WHERE view_name = 'v_teste_priv';

DESCRIBE user_sequences;
SELECT * FROM user_sequences;

