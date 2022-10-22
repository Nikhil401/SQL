--EXCEPTION HANDLING
use TE
--Exception handling in a procedure
alter procedure sp_DivideByZero
@num1 int,
@num2 int
as
BEGIN	
	Declare @Result int
	SET @Result = 0
	IF(@num2=0)
	BEGIN
		RAISERROR('Cannot Divide By Zero',16,127) -- ASSUME LIKE THROW
	END
	ELSE
	BEGIN
		SET @Result=@num1/@num2
		PRINT 'Value is:' + CAST(@Result as varchar)
	END
END
--execute a procedure
EXEC sp_DivideByZero 10,5 --Value is:2

EXEC sp_DivideByZero 10,0

--RAISERROR -> 3 PARAMETERS
--1. MESSAGE - ''
--2. SEVERITY - 0 TO 24
--	0-9 ->  Not severe -> error status information
--	11-16 -> Runtime errors - error messages are created by the user
--	17-19 -> errors that cannot be rectified by the developer and redirected to the system administrator
--	20-24 -> Fatal errors - Most severe 
--3. STATE - 0-127

-- TRY/CATCH WITH RAISERROR

alter procedure sp_DivideByZeroTryCatch
@num1 int,
@num2 int
as
BEGIN	
	Declare @Result int
	SET @Result = 0
	BEGIN TRY
		BEGIN
			IF(@num2=0)
			--RAISERROR('Cannot Divide By Zero',16,127) -- We can either use ERROR_NUMBER() or ERROR_MESSAGE()
			THROW 50001,'Cannot Divide By Zero',1 -- ERROR_NUMBER() & ERROR_MESSAGE() & ERROR_STATE() & ERROR_SEVERITY() is 16 by default
			SET @Result=@num1/@num2
			PRINT 'Value is:' + CAST(@Result as varchar)
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_NUMBER()
		PRINT ERROR_MESSAGE()
		PRINT ERROR_SEVERITY()
		PRINT ERROR_STATE()		
	END CATCH
END

execute sp_DivideByZeroTryCatch 10,10 --Value is:1

execute sp_DivideByZeroTryCatch 10,0
--50000 ERROR_NUMBER() - default
--Cannot Divide By Zero
--16
--127