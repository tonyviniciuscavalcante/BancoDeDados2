ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE USER JOSE
IDENTIFIED BY JOSE;

ALTER USER JOSE QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW TO JOSE;

CREATE USER HR
IDENTIFIED BY HR;

ALTER USER HR QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW TO HR;

GRANT select, insert, update, delete
ON hr.atleta
TO JOSE;
