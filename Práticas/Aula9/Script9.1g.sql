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