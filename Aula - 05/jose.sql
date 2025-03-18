ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

SELECT id, nome, salario 
FROM hr.atleta
WHERE nome like 'Miquela Malloy';

SELECT * FROM hr.atleta WHERE id = 199;

SELECT * FROM hr.atleta WHERE nome = 'Rebeca Andrade';

SELECT salario
FROM hr.atleta WHERE nome = 'Lambert Taffs';

UPDATE hr.atleta SET salario = 9000 WHERE nome = 'Lambert Taffs';

-- 3. Abra uma nova sessão como JOSE e faça um DESC na tabela EMP_TEMP do
-- usuário HR. O usuário JOSE já enxerga a tabela EMP_TEMP? Por quê?
DESC hr.EMP_TEMP;
-- Sim, pois o comando que passa a permissão de select já passa um commit

-- 5. Como JOSE, você já enxerga os 2 registros inseridos? Por quê?
SELECT * FROM hr.EMP_TEMP;
-- Ainda não pois no momento os inserts ainda estão apenas na sessão do HR e não foram comitados

-- 10. Como JOSE, faça um SELECT na EMP_TEMP. Quantos registros aparecem? Por quê?
SELECT * FROM hr.EMP_TEMP;
-- Agora sim, pois criando uma tabela é realizado um commit

-- 13. Como JOSE, marque um SAVEPOINT chamado SP1. Apague 1 registro da tabela
-- HR.EMP_TEMP. Marque agora um novo SAVEPOINT chamado SP2. Apague outro
-- registro qualquer da tabela EMP_TEMP. Consulte a tabela EMP_TEMP como JOSE e
-- como HR. Quantos registros aparecem para cada um?

SAVEPOINT SP1;

DELETE FROM HR.EMP_TEMP WHERE nome = 'Joao';

SAVEPOINT SP2;

DELETE FROM HR.EMP_TEMP WHERE nome = 'Vinicius';

SELECT * FROM hr.EMP_TEMP;
-- Como Jose vejo apenas 2, como HR vejo todos os 4 pois não foi feito nenhum commit

-- 14. Como JOSE, execute o comando ROLLBACK. O que aconteceu? Por quê?
ROLLBACK;
-- Retornou tudo como estava antes das alterações e savepoints

-- 15. Execute novamente as instruções do item 13.
-- Feito

-- 16. Como JOSE, desfaça agora somente o último DELETE realizado. Consulte a tabela
-- EMP_TEMP como HR e como JOSE e veja quantos registros aparecem para cada um.
ROLLBACK TO SP2;
-- Como HR vejo todos os registros e como Jose vejo 3 registros

-- 17. Como JOSE, efetive todas as alterações pendentes. Consulte a tabela EMP_TEMP
-- como HR e como JOSE e veja quantos registros aparecem para cada um agora.
COMMIT;
SELECT * FROM hr.EMP_TEMP;
-- 3 registros em ambos os esquemas

-- 18. Como HR, faça um UPDATE no salário de algum dos registros da EMP_TEMP.
-- Como JOSE, faça um UPDATE no MESMO registro, modificando o salário para
-- outro valor. O que aconteceu em cada uma das sessões? Por quê?
UPDATE hr.EMP_TEMP SET sal = 9000 WHERE nome = 'Tony';

-- 20. Como JOSE, torne as alterações pendentes permanentes no banco. Faça um
-- SELECT no registro alterado nas duas sessões e compare.
COMMIT;
SELECT * FROM hr.EMP_TEMP;

