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