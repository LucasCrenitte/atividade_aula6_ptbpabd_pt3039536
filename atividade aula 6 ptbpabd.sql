-- QUESTÃO 1: O User_B poderá selecionar todos os atributos da relação INSTRUCTOR e TAKES, exceto salary e grade, respectivamente.
GRANT SELECT ON instructor TO  User_B;
DENY SELECT ON instructor(salary) TO User_B;

GRANT SELECT ON takes TO User_B;
DENY SELECT ON takes(grade) TO User_B;


-- QUESTÃO 2: O User_C poderá selecionar ou modificar a relação SECTION
-- mas só poderá recuperar e modificar os atributos course_id, sec_id, semester e year.
GRANT SELECT ON section (course_id, sec_id, semester, year) TO User_C;
GRANT UPDATE ON section (course_id, sec_id, semester, year) TO User_C;

-- QUESTÃO 3: O User_D poderá selecionar qualquer atributo das relações INSTRUCTOR e STUDENT
-- Poderá selecionar os atributos da view grade_points.
GRANT SELECT ON instructor TO User_D;
GRANT SELECT ON student TO User_D;
GRANT SELECT ON grade_points TO User_D;

-- QUESTÃO 4: O User_E poderá selecionar qualquer atributo de STUDENT
--mas somente para tuplas de STUDENT que tem dept_name = ‘Civil Eng.’.

--CREATE VIEW student_civil_eng AS
--SELECT * FROM student
--WHERE dept_name = 'Civil Eng.';

GRANT SELECT ON student_civil_eng TO User_E;


-- QUESTÃO 5: Revogue os privilégios do usuário User_E.
REVOKE SELECT ON student_civil_eng FROM User_E;

-- QUESTÃO 6: Mostre os privilégios concedidos aos usuários 'User_A', 'User_B', 'User_C', 'User_D' e 'User_E'.
SELECT 
    prin.name AS Nome_Conta_Usuario,
    dp.class_desc AS Categoria_Recurso, 
    ISNULL(o.name, 'Nível Banco/Esquema') AS Tabela_ou_View_Alvo,
    ISNULL(c.name, 'Acesso Integral') AS Campo_Especifico_Afetado,
    dp.permission_name AS Privilegio_Atribuido, 
    dp.state_desc AS Situacao_da_Regra
FROM sys.database_permissions dp
JOIN sys.database_principals prin 
    ON dp.grantee_principal_id = prin.principal_id
LEFT JOIN sys.objects o 
    ON dp.major_id = o.object_id
LEFT JOIN sys.columns c 
    ON dp.major_id = c.object_id AND dp.minor_id = c.column_id
WHERE prin.name IN ('User_A', 'User_B', 'User_C', 'User_D', 'User_E')
ORDER BY prin.name, o.name;
