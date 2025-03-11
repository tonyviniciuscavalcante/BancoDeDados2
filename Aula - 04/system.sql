ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE USER JOSE
IDENTIFIED BY JOSE;

GRANT CREATE SESSION TO JOSE;
GRANT CREATE TABLE TO JOSE;
ALTER USER JOSE QUOTA UNLIMITED ON USERS;
GRANT CREATE SEQUENCE TO JOSE;
GRANT CREATE VIEW TO JOSE;

CREATE USER HR
IDENTIFIED BY HR;

ALTER USER HR QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW TO HR;

GRANT CREATE ANY TABLE TO JOSE;
GRANT DROP ANY TABLE TO JOSE;
GRANT CREATE ANY VIEW TO JOSE;
GRANT DROP ANY VIEW TO JOSE;

CREATE ROLE desenvolvedor;

GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW TO desenvolvedor;

CREATE USER MARIA
IDENTIFIED BY MARIA;

GRANT desenvolvedor TO MARIA;

REVOKE CREATE SESSION, CREATE TABLE 
FROM JOSE;

GRANT CREATE SESSION, CREATE TABLE TO JOSE;

ALTER USER HR IDENTIFIED BY employ;

ALTER USER HR ACCOUNT LOCK;
ALTER USER HR ACCOUNT UNLOCK;

GRANT select, insert 
ON HR.atleta
TO JOSE;

GRANT update (nome, salario)
ON HR.atleta
TO JOSE, desenvolvedor;

GRANT select, insert
ON HR.clube
TO JOSE
WITH GRANT OPTION;

GRANT select
ON HR.presidente
TO PUBLIC;

GRANT select, insert
ON HR.v_teste_priv2
TO PUBLIC;

GRANT select
ON JOSE.teste_id_seq
TO HR;

REVOKE select, insert
ON HR.clube
FROM JOSE;


-- 1. Crie um usuário chamado user01, colocando a senha user01.
CREATE USER user01
IDENTIFIED BY user01;

-- 2. TRAVE a conta do usuário user01. Tente conectar como user01.
ALTER USER user01 ACCOUNT LOCK;

-- 3. DESTRAVE a conta do usuário user01. Tente conectar como user01.
ALTER USER user01 ACCOUNT UNLOCK;

-- 4. Conceda o privilégio que permite ao user01 conectar-se no banco.
GRANT CREATE SESSION TO user01;

-- 5. Conceda os privilégios de sistema permitindo ao user01 criar tabelas, visões e sequences
-- em seu esquema.
GRANT CREATE TABLE, CREATE SEQUENCE, CREATE VIEW TO user01;

-- 7. Como user01, insira 3 registros na tabela e um por meio da visão (se assim for possível).
-- Utilize a sequence para popular a PK da tabela. Conceda os devidos privilégios para tornar
-- os inserts possíveis.
ALTER USER user01 QUOTA UNLIMITED ON USERS;

-- 8. Faça com que user01 tenha privilégio de criar e apagar tabelas e visões em qualquer
-- esquema do banco.
GRANT CREATE ANY TABLE TO user01;
GRANT DROP ANY TABLE TO user01;
GRANT CREATE ANY VIEW TO user01;
GRANT DROP ANY VIEW TO user01;

-- 9. Crie mais dois usuários chamados user02 e user03 no banco.
CREATE USER user02
IDENTIFIED BY user02;

CREATE USER user03
IDENTIFIED BY user03;

-- 10. Crie uma role chamada gerente. Conceda à role gerente os privilégios de se conectar e de
-- criar visões.
CREATE ROLE gerente;

GRANT CREATE SESSION, CREATE VIEW TO gerente;

-- 11. Crie uma role chamada analista. Conceda à role analista os privilégios de se conectar, de
-- criar tabelas e visões.
CREATE ROLE analista;

GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO gerente;

-- 12. Atribua a role gerente ao user02 e a role analista ao user03.
GRANT gerente TO user02;

GRANT analista TO user03;

-- 13. Faça os devidos testes e veja se está tudo ok.
-- TUDO OK

-- 14. Conceda privilégios de consulta, inserção, atualização e deleção na tabela EXERCICIO
-- criada no item 6 para o usuário user02 e para a role analista.
GRANT select, insert, update, delete
ON user01.exercicio
TO user02;

GRANT select, insert, update, delete
ON user01.exercicio
TO analista;

-- 15. Tanto o usuário user02, quanto o user03 acessarão a tabela? Por quê?
-- Sim, pois o user02 recebeu o privilégio de acesso diretamente e o user03 pela ROLE dele

-- 16. Revogue os privilégios concedidos no exercício 14.
REVOKE select, insert, update, delete
ON user01.exercicio
FROM user02;

REVOKE select, insert, update, delete
ON user01.exercicio
FROM analista;

-- 17. Conceda os privilégios de consulta e de atualização (somente das duas primeiras colunas)
-- na tabela EXERCICIO para o usuário user02 com a opção dele conceder os privilégios a
-- outros usuários.


-- 18. Conectado como user02, conceda o privilégio de consulta e atualização na tabela
-- EXERCICIO para o user03, sem que ele possa repassar a outros usuários.

-- 19. Conecte-se como user02 e veja se possui os devidos privilégios. Depois, conecte-se como
-- user03 e veja se possui os devidos privilégios.

-- 20. Conectado como system, revogue os privilégios concedidos ao user02 no exercício 17.

-- 21. Conecte-se como user02 e veja se ainda possui os privilégios sobre a tabela EXERCICIO.
-- Depois, conecte-se como user03 e também veja se possui os privilégios sobre a tabela EXERCICIO.