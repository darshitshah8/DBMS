-- particular column
select ItemType from dbo.item

-- all column
Select * from dbo.ItemName

-- No dublicate value
Select Distinct Name 
from dbo.ItemName
-- Count 
Select Count(Distinct Name) 
from dbo.ItemName

-- Where Clause
Select * from dbo.ItemName
select * from dbo.ItemName where Name = 'LG' --Equal
select * from dbo.ItemName where ItemId = 4 --Equal
select * from dbo.ItemName where Warranty > 5 -- Greater than
select * from dbo.ItemName where Price < 20000 -- less than
select * from dbo.ItemName where Price <= 14000 -- less than or equal to
select * from dbo.ItemName where Warranty >= 8 -- Greater than or equal to
select * from dbo.ItemName where ItemId <> 4 -- Not Equal
select * from dbo.ItemName where ItemId != 4 -- Not Equal
select * from dbo.ItemName where ItemId Between 4 AND 6 -- Between
select * from dbo.ItemName where Name like '%g' -- Like
select * from dbo.ItemName where Warranty in ('5','10','8') -- In

-- AND,OR,NOT
Select * From Dbo.ItemName where ItemId = 1 and price < 20000
Select * From Dbo.ItemName where Name = 'RealMe' Or Name = 'Oppo'
Select * From Dbo.ItemName where Not Name = 'LG'
Select * From Dbo.ItemName where Name = 'LG' and (warranty = 1 or warranty = 10)
Select * From Dbo.ItemName where ItemId = 3 and Not Name = 'LG'

-- Order By
select * from dbo.ItemName order by Warranty -- /price/name/itemid
select * from dbo.ItemName order by Name DESC -- Dessending Order
select * from dbo.ItemName order by Warranty,name
select * from dbo.ItemName order by Name ASC , Warranty DESC

-- Insert
insert into dbo.ItemName (Id,ItemId,Name,Warranty,Price)
Values (8,4,'Dell',1,45000)

-- NULL
select * from dbo.ItemName
where name is null

select * from dbo.ItemName
where name is not null

-- Update 
update dbo.ItemName
Set Warranty = 7 
where Name= 'Lg' and  ItemId = 3 and price = 35000

-- Delete 
Delete from dbo.ItemName where Name = 'Dell' and Price = 56000 -- specific row
--Delete FROM dbo.ItemName -- Delete all data

-- Select top
SELECT TOP 3 * FROM ItemName;

SELECT TOP 50 PERCENT * FROM ItemName;

SELECT TOP 2 * FROM ItemName
WHERE ItemId=1;


--Min & Max
Select Max(price) as Maximum, Min(Price) as Minimum 
From ItemName

-- Count , avg , sum
Select Count(ItemId)
from ItemName
where ItemId = 3 --with where condition

Select AVG(price)
From ItemName
where ItemId = 1 --with where condition

Select Sum(price)
from ItemName
where ItemId = 3 --with where condition

-- Like
select * from ItemName
Where Name Like 'l%';

select * from ItemName
Where Name Like 'l%o';

select * from ItemName
Where Name Like '%pp%';

select * from ItemName
Where Name Like '_a%';

select * from ItemName
Where Name not Like '%g';

--In
select * from ItemName
where name In  (Select Name from ItemName where ItemId = 1)

--Joins
select * from Country
left join State on Country.CountryId = State.CountryId

select * from State
right join Country on State.CountryId = Country.CountryId
left join City on State.StateId = city.StateId

select * from State
right join City on State.StateId = City.StateId

select CountryName,StateName,CityName from Country
full join State on Country.CountryId = state.CountryId
full join City on State.StateId = City.StateId
where CityName is not null

select StateName , CityName from city
left join State on city.StateId = State.StateId

Select ItemId from dbo.ItemName
Union
Select ItemId from dbo.Item

--Group By
select Count(Name),i.Name
From ItemName i 
Group by i.Name
order by Count(Name) 

-- Having
select Count(Name),i.Name
From ItemName i 
Group by i.Name
having Count(Name) > 1

--EXISTS
select i.Name 
from ItemName i  
Where Exists (select * from ItemName where ItemId = 10)


---------------------------User Define Function---------------------------------
Create function GetTotal(@rollno int)
returns int 
as
begin
Declare @total int 
select @total = (maths + english + science ) from Marks Where @RollNo = Rollno;
return @total
end

Create function GetAvg(@rollno int)
returns int 
as
begin
Declare @avg int 
select @avg = (maths + english + science )/ 3 from Marks Where @RollNo = Rollno;
return @avg
end

select rollno, maths, english, science, dbo.GetTotal(2) as total from Marks where rollno = '2'
select rollno, maths, english, science, dbo.GetTotal(rollno) as total , dbo.GetAvg(rollNo) as avg from Marks 

-- ONlY for select statement can't use End and Begin
CREATE FUNCTION GETSTUDENTLIST(@total int)
returns table
as
return select * from Marks where (maths + english + science ) > @total;

select * from dbo.GETSTUDENTLIST(150)

-- multi statement

CREATE FUNCTION Student_Marksheet(@RollNo int)
returns @marksheet Table (Rollno int , maths int ,english int, science int ,per decimal(4,2))
as
begin
declare @per decimal(4,2);
select @RollNo = rollno from Marks where RollNo = @RollNo
select @per =((maths + english + science )/3) From Marks where RollNo = @RollNo

Insert into @marksheet (Rollno , Maths , english , Science ,per)
select RollNo , Maths ,  English , Science , @per From Marks Where RollNo = @RollNo
return 
end

select * from dbo.Student_Marksheet(3)
-----------------------------------------------------------------------------------------
FUNCTIONS

--Aggregate Functions:
-- SUM: Calculates the sum of values in a column.
Example: SELECT SUM(Maths) FROM Marks;
-- AVG: Calculates the average of values in a column.
Example: SELECT AVG(Maths) FROM marks;
-- COUNT: Counts the number of rows in a column.
Example: SELECT COUNT(*) FROM Marks;
-- MAX: Returns the maximum value in a column.
Example: SELECT MAX(Maths) FROM marks;
-- MIN: Returns the minimum value in a column.
Example: SELECT MIN(Maths) FROM Marks;


-- String Functions:
-- LEN: Returns the length of a string.
Example: SELECT Name, LEN(Name) FROM ItemName;
-- UPPER: Converts a string to uppercase.
Example: SELECT Name, UPPER(Name) FROM ItemName;
-- LOWER: Converts a string to lowercase.
Example: SELECT Name, LOWER(Name) FROM ItemName;
-- LEFT: Returns a specified number of characters from the start of a string.
Example: SELECT Name, LEFT(Name, 3) FROM ItemName;
-- RIGHT: Returns a specified number of characters from the end of a string.
Example: SELECT Name, RIGHT(Name, 2) FROM ItemName;


-- Date and Time Functions:
-- GETDATE: Returns the current date and time.
Example: SELECT GETDATE();
-- DATEPART: Returns a specified part of a date.
Example: SELECT DATEPART(YEAR, OrderDate) FROM Orders;
-- DATEADD: Adds or subtracts a specified time interval from a date.
Example: SELECT DATEADD(MONTH, 3, OrderDate) FROM Orders;
-- DATEDIFF: Returns the difference between two dates.
Example: SELECT DATEDIFF(DAY, OrderDate, ShippedDate) FROM Orders;

-- Mathematical Functions:

-- ROUND: Rounds a number to a specified precision.
Example: SELECT Price, ROUND(Price, 3) FROM ItemName;
-- ABS: Returns the absolute value of a number.
Example: SELECT Price, ABS(Price) FROM ItemName;
-- POWER: Returns the value of a number raised to a specified power.
Example: SELECT Name, Price, Warranty, POWER(2, 3) as Specific FROM ItemName;
-- SQRT: Returns the square root of a number.
Example: SELECT SQRT(16) FROM ItemName;
-- RAND: Returns a random number between 0 and 1.
Example: SELECT RAND() FROM ItemName;

------------------------------Group by / Order By----------------------------------
SELECT ItemId, SUM(Price) AS TotalPriceAmount
FROM ItemName
GROUP BY ItemId
ORDER BY TotalPriceAmount DESC;

SELECT ItemId, Sum(Price) as Totalprice ,Count(ItemId) AS TotalCountAmount
FROM ItemName 
GROUP BY ItemId
ORDER BY TotalCountAmount DESC;

SELECT ItemId, Avg(Price) as Totalprice ,Count(ItemId) AS TotalCountAmount
FROM ItemName 
GROUP BY ItemId
ORDER BY TotalCountAmount DESC;

Select * from Item 
Order by ItemId

----------------------------clause like where-----------------------------------
Select Name, Price , Warranty from [ItemName] where ItemId = '4' and Price > '56090'
Select Count(ItemId) from [ItemName] where ItemId = '4'

----------------------------clause like Having-----------------------------------
SELECT ItemId,SUM(Price) AS TotalOrderAmount
FROM ItemName
GROUP BY ItemId
HAVING SUM(Price) > 1200
ORDER BY TotalOrderAmount DESC;

SELECT ItemId,Count(ItemId) AS TotalOrderAmount
FROM ItemName
GROUP BY ItemId
HAVING Count(ItemId) > 2
ORDER BY TotalOrderAmount DESC;
-------------------------------Trigger---------------------------------
CREATE TRIGGER UpdateDatabase
ON Marks
AFTER INSERT, UPDATE , DELETE
AS
BEGIN
   UPDATE Marks
   SET TotalMarks = Maths + English + Science
   WHERE RollNo IN (SELECT RollNo FROM inserted);
	IF EXISTS(SELECT * FROM deleted)
		BEGIN
			UPDATE Marks
			SET TotalMarks = Maths + English + Science
			WHERE RollNo IN (SELECT RollNo FROM deleted);
		END;
END;

INSERT INTO Marks (RollNo, Maths, English, Science)
VALUES (1, 65, 76, 87);

UPDATE Marks
SET Maths = 90, English = 88, Science = 95
WHERE RollNo = 1;

DELETE FROM Marks WHERE RollNo = 1;

DROP TRIGGER dbo.UpdateTotalMarks;  ----For Delete Triggers

Select * from marks


------------------------View ------------------------------------
CREATE VIEW vw_AllItems
AS
SELECT i.ItemId ,i.ItemType, it.Name , Price , Warranty
FROM Item i
left join ItemName it on i.ItemId = it.ItemId


Select itemtype , name , Warranty from vw_AllItems 



