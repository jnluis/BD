-- 9.1 c
-- DROP PROC IF EXISTS Company.RecordSet_Managers
-- GO
-- CREATE PROC Company.RecordSet_Managers @
DROP TRIGGER IF EXISTS alineaC ON Company.Department
GO
CREATE TRIGGER alineaC ON Company.Department INSTEAD OF INSERT, UPDATE
AS 
    BEGIN 
        DECLARE @Emp_SSN as char(9)
        SELECT @Emp_SSN = Mgr_ssn FROM inserted;
            IF( SELECT count(Dnumber) FROM Company.Department WHERE Mgr_ssn=@Emp_SSN) >=1
			    RAISERROR('Employee cant manage more than one department', 16, 1);	
		    ELSE
		        INSERT INTO Company.Department SELECT * FROM inserted;
    END

SELECT * FROM Company.Department;
SELECT * FROM Company.Employee;
INSERT INTO Company.Department VALUES ('Teste1', 6, 21312332, '2023-05-9');
INSERT INTO Company.Department VALUES ('Teste2', 7, NULL, '2023-05-9');
INSERT INTO Company.Department VALUES ('Teste3', 8, 123456789, '2023-05-9');