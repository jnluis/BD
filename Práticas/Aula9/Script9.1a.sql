
-- 9.1 a
-- Criação do Stored Procedure remove_employee
DROP PROCEDURE IF EXISTS Company.SPDeleteEmployee
GO

CREATE PROCEDURE Company.SPDeleteEmployee
    @ssn    CHAR(9) -- parâmetro de entrada é o Ssn
AS
    BEGIN
        DELETE FROM Company.[Works_on] WHERE Essn=@ssn -- Remover da tabela works_on
        -- Remover dependentes
        DELETE FROM dbo.[Company.Dependent] WHERE Essn=@ssn
        UPDATE Company.[Department] SET Mgr_ssn=NULL WHERE Mgr_ssn=@ssn  -- Remover da tabela Department
        UPDATE Company.[Employee] SET Super_ssn=NULL WHERE Super_ssn=@ssn -- Remover da tabela Employee porque o Super_ssn é chave estrangeira do Ssn
        DELETE FROM Company.[Employee] WHERE Ssn=@ssn -- Remover da lista de funcionários
    END
GO

DECLARE @ssn CHAR(9)
EXEC Company.SPDeleteEmployee @ssn='183623612' -- Ssn da empregada Paula A Sousa
GO

SELECT * FROM Company.Employee

-- Ver Slide 39 do Programming SQL para ver como fazer este EXEC mas de uma variável


-- 9.1 b
-- DROP PROC IF EXISTS Company.RecordSet_Managers
-- GO
-- CREATE PROC Company.RecordSet_Managers @