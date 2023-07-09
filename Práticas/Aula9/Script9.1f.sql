GO
CREATE FUNCTION Company.dep_emplo_better_paid_ (@dno INT) RETURNS @table
TABLE([ssn] INT, [f_name] VARCHAR(15),[l_name] VARCHAR(15))
AS
    BEGIN
        INSERT @table
        SELECT  Company.employee.Ssn, Company.employee.Fname, Company.employee.lname FROM Company.employee
        JOIN (SELECT Dno, AVG(salary) AS avg_sal
            FROM Company.Department, Company.employee
            WHERE Dno= Dnumber
            GROUP BY Dno) AS dept_avg_sal
        ON dept_avg_sal.Dno=Company.Employee.Dno AND salary > avg_sal AND Company.Employee.Dno = @dno;
		RETURN;
    END
GO

-- avg_sal = 1316 no Departamento 2, e por isso o valor é o da funcionária Ana Silva
-- Os departamentos 1 e 3 só têm um funcionário, e por isso nada é retornado na UDF
SELECT * FROM Company.Employee;
SELECT * FROM Company.dep_emplo_better_paid_(1);
SELECT * FROM Company.dep_emplo_better_paid_(2);
SELECT * FROM Company.dep_emplo_better_paid_(3);