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