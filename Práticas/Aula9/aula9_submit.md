# BD: Guião 9


## ​9.1
 
### *a)*

```
DROP PROCEDURE IF EXISTS Company.SPDeleteEmployee
GO

CREATE PROCEDURE Company.SPDeleteEmployee
	@ssn	CHAR(9)
AS
	BEGIN
		DELETE FROM Company.[Works_on] WHERE Essn=@ssn
		DELETE FROM dbo.[Company.Dependent] WHERE Essn=@ssn
		UPDATE Company.[Department] SET Mgr_ssn=NULL WHERE Mgr_ssn=@ssn
		UPDATE Company.[Employee] SET Super_ssn=NULL WHERE Super_ssn=@ssn
		DELETE FROM Company.[Employee] WHERE Ssn=@ssn
	END
GO

DECLARE @ssn CHAR(9)
EXEC Company.SPDeleteEmployee @ssn='183623612'
GO

SELECT * FROM Company.Employee

```

### *b)* 

```
DROP PROCEDURE IF EXISTS Company.SPGestores
GO

CREATE PROCEDURE Company.SPGestores
	@ssn CHAR(9) OUTPUT, 
    @numberYears INT OUTPUT
AS
    BEGIN
        SELECT * FROM Company.Employee
        JOIN Company.Department ON Company.Employee.Ssn = Company.Department.Mgr_Ssn

        SELECT @ssn = Mgr_Ssn, @numberYears=max(DATEDIFF(year, Mgr_start_date, getdate())) 
        FROM Company.Department
        WHERE Mgr_Ssn IS NOT NULL
        GROUP BY Mgr_Ssn, Mgr_start_date
        ORDER BY Mgr_start_date DESC, Mgr_Ssn ASC
    END
    
GO

DECLARE @ssn CHAR(9)
DECLARE @numberYears INT

EXEC Company.SPGestores
    @ssn = @ssn OUTPUT,
    @numberYears = @numberYears OUTPUT

PRINT @ssn
PRINT @numberYears
GO


```

### *c)* 

```
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
```

### *d)* 

```
DROP TRIGGER IF EXISTS Company.TRVencimento
GO

CREATE TRIGGER Company.TRVencimento ON Company.Employee
AFTER INSERT, UPDATE
AS
    BEGIN
        SET NOCOUNT ON

        DECLARE @mgr_salary INT
        DECLARE @emp_salary INT
        DECLARE @ssn CHAR(9)
        DECLARE @dno INT

        SELECT @dno = Dno, @emp_salary = Salary, @ssn = Ssn FROM inserted

        SELECT @mgr_salary = Salary
        FROM Company.Department JOIN Company.Employee ON Mgr_ssn = Ssn
        WHERE Dnumber = @dno

        IF (@emp_salary > @mgr_salary)
        BEGIN
            UPDATE Company.Employee
            SET Salary = @mgr_salary - 1
            WHERE Ssn = @ssn
        END
    END
GO

INSERT INTO Company.Employee VALUES ('João', 'J', 'Silva', '111111111', '01-03-1999', 'Rua do João', 'M', '3000', null, 2)
GO

SELECT * FROM Company.Employee

```

### *e)* 

```
GO
CREATE FUNCTION Company.func_name_location_from_project (@func_ssn INT) RETURNS @table
TABLE([name] VARCHAR(45), [location] VARCHAR(15))
AS
    BEGIN
        INSERT @table
        SELECT  Company.Project.Pname, Company.Project.Plocation FROM Company.Project
        INNER JOIN Company.Works_on ON Company.Works_on.Pno = Company.Project.Pnumber
        WHERE Works_on.Essn=@func_ssn
		RETURN;
    END
GO
-- Test
SELECT * FROM Company.Works_on;
SELECT * FROM Company.Project;
SELECT * FROM Company.func_name_location_from_project(21312332);
SELECT * FROM Company.func_name_location_from_project(183623612); -- este Essn não está no Works_on
SELECT * From Company.func_name_location_from_project(41124234);
```

### *f)* 

```
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
```

### *g)* 

```
create function Company.employeeDeptHighAverage (@dnumber int) returns @ProjBudget Table
	(pName varchar(30), pnumber int not null, plocation varchar(15), dnum int, budget decimal, totalbudget decimal)
as
	begin
		declare @pName as varchar(30), @pnumber as int, @prevPnumber as int, @plocation as varchar(15),
				@dnum as int, @budget as decimal, @totalbudget as decimal, @hours as decimal, @salary as decimal;
		
		declare c cursor fast_forward
		for select Pname, Pnumber, Plocation, Dnum, [Hours], Salary
		from (Company.Project join Works_on on Pnumber=Pno) join Company.Employee on Essn=Ssn
		where Dnum=@dnumber;

		open c;

		fetch c into @pName, @pnumber, @plocation, @dnum, @hours, @salary;

		select @prevPnumber = @pnumber, @budget = 0, @totalbudget = 0;

		while @@fetch_status = 0
			begin
				if @prevPnumber <> @pnumber
					begin
						insert @ProjBudget values (@pName,@prevPnumber,@plocation,@dnum,@budget,@totalbudget);
						select @prevPnumber = @pnumber, @budget = 0;
					end

					set @budget += @salary*@hours/40;
					set @totalbudget += @salary*@hours/40;

					fetch c into @pName, @pnumber, @plocation, @dnum, @hours, @salary;
			end

		close c;
		deallocate c;

		return;
	end
GO
select * from Company.employeeDeptHighAverage(3)
```

### *h)* 
Usando o trigger after
```
drop trigger IF EXISTS Company.deleteDepartmentAfter
go

go
create trigger Company.deleteDepartmentAfter on Company.[Department]
after delete
as
begin
	-- begin transaction
	begin transaction
		
		-- get department number
		declare @dNumber int
		select @dNumber=Dnumber from deleted;

		--check if exists a table for the deleted departments
        --if not, create it
		if (not exists( select * from information_schema.tables where table_schema='Company' and table_name='department_deleted'))
		begin
			create table Company.department_deleted 
            (
                Dname			varchar(30) not null,
                Dnumber			int			not null,
                Mgr_ssn			char(9)			null,
                Mgr_start_date	date			null,
                
				primary key(Dnumber)
            )
			alter table Company.department_deleted add constraint deptDeletedEmp foreign key (Mgr_ssn) references Company.Employee (Ssn);
		end

		begin try
			-- insert into the deleted department table
			insert into Company.department_deleted 
			select * from deleted
		end try

        begin catch
            raiserror ('Error deleting department', 16, 1)   
        end catch

	commit transaction
end
go

select * from Company.department_deleted
delete from Company.Department where Dnumber=8
```

### *i)* 

```
As vantagens das stored-procedures são:
Extensabilidade, pois promove abstração e baixo acoplamento com a base de dados;
Performance, pois, um stored procedure bem escrito é a forma mais rápida de interagir no SQL Server;
Usabilidade;
Integridade dos dados, já que as sp's têm menor probabilidade de conter erros na integridade dos dados, o que também torna unit test's mais fáceis;
Segurança, porque estamos apenas a aceder às tabelas pela forma com o stored-procedure está definido, e não com total liberdade sobre os dados das tabelas.

Os UDF's gozam dos mesmos benefícios dos stored-procedures, sendo que estas podem ser utilizadas para incorporar lógica complexa numa consulta à BD.

As principais diferenças entre UDF's e SP's são:
A sua chamada, pois SP's usam o comando EXEC, enquanto as UDF's são chamadas iguais às funções, dentro da Query SQL;
As UDF's retornam valores (ou tabelas conforme o tipo de UDF que está a ser usado), enquanto as SP's não retornam valores diretamente;
Por último o seu propósito, já que as SP's servem para executar operações de modificação de dados na BD, enquanto as UDF's são usadas para retornar valores desses mesmos dados.

Como exemplos em que se deve utilizar cada uma das ferramentas, temos (exemplos para a base de dados deste guião):
UDF- Cálculo do  número médio de dependentes dos funcionários, por departamento;
SP- Inserir um novo dependente na tabela, com todos os parâmetros a ela asociados.
```
