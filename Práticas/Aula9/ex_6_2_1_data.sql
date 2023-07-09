
insert into Company.Department values ('Investigacao',1,NULL,'2010-08-02');
insert into Company.Department values ('Comercial',2,NULL,'2013-05-16');
insert into Company.Department values ('Logistica',3,NULL,'2013-05-16');
insert into Company.Department values ('Recursos Humanos',4,NULL,'2014-04-02');
insert into Company.Department values ('Desporto',5,NULL,NULL);

insert into Company.Employee values ('Paula','A','Sousa','183623612','2001-08-11','Rua da FRENTE','F',1450.00,NULL,3);
insert into Company.Employee values ('Carlos','D','Gomes','21312332','2000-01-01','Rua XPTO','M',1200.00,NULL,1);
insert into Company.Employee values ('Juliana','A','Amaral','321233765','1980-08-11','Rua BZZZZ','F',1350.00,NULL,3);
insert into Company.Employee values ('Maria','I','Pereira','342343434','2001-05-01','Rua JANOTA','F',1250.00,'21312332',2);
insert into Company.Employee values ('Joao','G','Costa','41124234','2001-01-01','Rua YGZ','M',1300.00,'21312332',2);
insert into Company.Employee values ('Ana','L','Silva','12652121','1990-03-03','Rua ZIG ZAG','F',1400.00,'21312332',2);

insert into [Company.Dependent] values ('21312332' ,'Joana Costa','F','2008-04-01', 'Filho');
insert into [Company.Dependent] values ('21312332' ,'Maria Costa','F','1990-10-05', 'Neto');
insert into [Company.Dependent] values ('21312332' ,'Rui Costa','M','2000-08-04','Neto');
insert into [Company.Dependent] values ('321233765','Filho Lindo','M','2001-02-22','Filho');
insert into [Company.Dependent] values ('342343434','Rosa Lima','F','2006-03-11','Filho');
insert into [Company.Dependent] values ('41124234' ,'Ana Sousa','F','2007-04-13','Neto');
insert into [Company.Dependent] values ('41124234' ,'Gaspar Pinto','M','2006-02-08','Sobrinho');

insert into Company.Dept_locations values (2,'Aveiro');
insert into Company.Dept_locations values (3,'Coimbra');

insert into Company.Project values ('Aveiro Digital',1,'Aveiro',3);
insert into Company.Project values ('BD Open Day',2,'Espinho',2);
insert into Company.Project values ('Dicoogle',3,'Aveiro',3);
insert into Company.Project values ('GOPACS',4,'Aveiro',3);

insert into Company.Works_on values ('183623612',1,20.0);
insert into Company.Works_on values ('183623612',3,10.0);
insert into Company.Works_on values ('21312332' ,1,20.0);
insert into Company.Works_on values ('321233765',1,25.0);
insert into Company.Works_on values ('342343434',1,20.0);
insert into Company.Works_on values ('342343434',4,25.0);
insert into Company.Works_on values ('41124234' ,2,20.0);
insert into Company.Works_on values ('41124234' ,3,30.0);

UPDATE Company.Department SET Mgr_ssn = '21312332' WHERE Dname = 'Investigacao';
UPDATE Company.Department SET Mgr_ssn = '321233765' WHERE Dname = 'Comercial';
UPDATE Company.Department SET Mgr_Ssn = '41124234' WHERE Dname = 'Logistica';
UPDATE Company.Department SET Mgr_Ssn = '12652121' WHERE Dname = 'Recursos Humanos';