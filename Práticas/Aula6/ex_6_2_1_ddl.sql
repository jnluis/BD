ALTER TABLE Company.Employee DROP CONSTRAINT IF EXISTS employeeDept;
ALTER TABLE Company.Employee DROP CONSTRAINT IF EXISTS employeeSuper;
DROP TABLE IF EXISTS [Company.Dependent];
DROP TABLE IF EXISTS Company.Works_on;
DROP TABLE IF EXISTS Company.Project;
DROP TABLE IF EXISTS Company.Dept_locations;
DROP TABLE IF EXISTS Company.Department;
DROP TABLE IF EXISTS Company.Employee;

DROP SCHEMA IF EXISTS Company;
GO

CREATE SCHEMA Company;
GO

CREATE TABLE Company.Employee(
	Fname		varchar(15)		not null,
	Minit		char(1)					,
	Lname		varchar(15)		not null,
	Ssn			char(9)			not null,
	Bdate		date,
	[Address]	varchar(30),
	Sex			char(1)			not null,
	Salary		decimal(6,2)	not null,
	Super_ssn	char(9),
	Dno			int				not null,
	
	primary key (Ssn)	
);

CREATE TABLE Company.Department(
	Dname			varchar(30)		not null,
	Dnumber			int				not null,
	Mgr_Ssn			char(9)					,
	Mgr_start_date	date,

	primary key (Dnumber),
    FOREIGN KEY (Mgr_Ssn) REFERENCES Company.Employee(Ssn)
);

create table Company.Dept_locations(
	Dnumber		int			not null,
	Dlocation	varchar(15)	not null,

	primary key (Dnumber,Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES Company.Department(Dnumber)
);

create table Company.Project(
	Pname		varchar(30)		not null,
	Pnumber		int				not null,
	Plocation	varchar(15)		not null,
	Dnum		int				not null,

	primary key (Pnumber),
    FOREIGN KEY (Dnum) REFERENCES Company.Department(Dnumber)
);

create table Company.Works_on(
	Essn	char(9)			not null,
	Pno		int				not null,
	[Hours]	decimal(3,1)	not null,

	primary key (Essn,Pno),
    FOREIGN KEY (Essn) REFERENCES Company.Employee(Ssn),
    FOREIGN KEY (Pno) REFERENCES Company.Project(Pnumber)
);

create table [Company.Dependent](
	Essn			char(9)		not null,
	Dependent_name	varchar(30)	not null,
	Sex				char(1)		not null,
	Bdate			date				,
	Relationship	varchar(15)	not null,

	primary key (Essn,Dependent_name),
    FOREIGN KEY (Essn) REFERENCES Company.Employee(Ssn)
);

ALTER TABLE Company.Employee ADD CONSTRAINT employeeSuper FOREIGN KEY (Super_ssn) REFERENCES Company.Employee(Ssn);
ALTER TABLE Company.Employee ADD CONSTRAINT employeeDept FOREIGN KEY (Dno) REFERENCES Company.Department(Dnumber);



