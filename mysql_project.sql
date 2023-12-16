CREATE DATABASE library;
use library;

CREATE TABLE Branch(
Branch_no varchar(12) PRIMARY KEY,
Manager_Id varchar(12),
Branch_address VARCHAR(25),
Contact_no varchar(12));

CREATE TABLE Employee(
Emp_Id varchar(12) PRIMARY KEY,
Emp_name VARCHAR(15),
Position varchar(50),
Branch_no varchar(12),
Salary float);


CREATE TABLE Customer(
Customer_Id varchar(10) PRIMARY KEY,
Customer_name VARCHAR(15),
Customer_address VARCHAR(20),
Reg_date DATE);

CREATE TABLE Books(
Isbn varchar(12)  primary key,
Book_title varchar(40),
Category varchar(30),
Rental_Price float,
status varchar(3) check(status in("yes","no")),
 Author varchar(40),
 Publisher varchar(25));


CREATE TABLE IssueStatus(
Issue_Id int primary key,
Issued_cust  varchar(10) ,
Issued_book_name varchar(50),
Issue_date Date,
Isbn_book varchar(12),
foreign key(Issued_cust)references Customer(Customer_Id),
foreign key(Isbn_book) references Books(Isbn));


CREATE  TABLE ReturnStatus(
Return_Id  int primary key,
 Return_cust varchar(10),
 Return_book_name varchar(50),
 Return_date date,
 Isbn_book2 varchar(25),
 foreign key (Isbn_book2) references Books(Isbn));


 insert into Branch
 Values("bn001","mn000","edakkara","9807654323"),
 ("bn002","mn001","mannarkkad","9807654325"),
 ("bn003","mn002","edakkar","9807654329"),
  ("bn004","mn003","chengannur","9807654328");
 
 insert into Employee
 values
 ("e001", "sara", "librarian", "bn001", 50000),
 ("e002", "sarayu", "technology and application leader", "bn001", 50000),
 ("e003", "ajo", "Assistant", "bn002",80000),
 ("e004","varatha","clerk","bn001",90000),
 ("e005","vishal","information provider","bn003",10000),
 ("e006","merin","project manager","bn001",50000),
 ("e007","kia","maintenance staff","bn001",60000);
 
 insert into Customer
 values
 ("c001","merlin","ala",'2011-01-21'),
 ("c002","manoj","alappuzha",'2011-05-20'),
 ("c003","kiara","uduppi",'2012-07-12'),
 ("c004","mary","chengannur",'2014-09-18'),
 ("c005","katy","ala",'2014-01-14'),
 ("c006","joshua","ala",'2011-01-11'),
 ("c007","catherin","alappuzha",'2011-01-11'),
 ("c008","jo","ala",'2011-05-08'),
 ("c009","riya","chengannur",'2011-06-01'),
 ("c010","nira","ala",'2011-03-15');
 

 insert into Books
 values
 ("isbn001","Two States","Novel",700.45,"yes","Chetan Baghath","RupaPublications"),
 ("isbn002","Wings OF Fire","autobiography",1000,"yes","Dr. A.P.J Abdul Kalam","Universities Press"),
 ("isbn003","When Heaven Invades Earth","theology",1000,"no","bill johnson","Destiny Image Publishers"),
 ("isbn004","Pride and Prejudice","Novel",500.50,"yes","jane austen","T. Egerton, Whitehall"),
 ("isbn005","Killers of the Flower Moon","non-fiction",450.90,"no","David grann","doubleday"),
 ("isbn006","The 3 Mistakes of My Life","novel",800,"yes","chetan bhagat","RupaPublications");
 
 

insert into  IssueStatus
values
(1001,"c001","Two States",'2023-06-21',"isbn001"),
(1002,"c005","Wings OF Fire",'2014-03-24',"isbn002"),
(1003,"c003","Pride and Prejudice",'2012-09-12',"isbn004"),
(1004,"c006","Killers of the Flower Moon",'2011-05-19',"isbn005"),
(1005,"c002","The 3 Mistakes of My Life",'2011-08-20',"isbn006");

 
  insert into ReturnStatus
  values
  (001,"c001","Two States",'2023-11-21',"isbn001"),
(002,"c005","Wings OF Fire",'2014-09-24',"isbn002"),
(003,"c003","Pride and Prejudice",'2012-12-12',"isbn004"),
(004,"c006","Killers of the Flower Moon",'2011-12-19',"isbn005"),
(005,"c002","The 3 Mistakes of My Life",'2012-02-20',"isbn006");


-- Retrieve the book title, category, and rental price of all available book
select Book_title ,
Category ,
Rental_Price from Books where status="yes";

-- List the employee names and their respective salaries in descending 
-- order of salary.

select Emp_name ,
Salary  from Employee order by Salary desc;

-- Retrieve the book titles and the corresponding customers who have issued those books.

 select Issued_book_name,Customer_name  from IssueStatus join
 Customer on IssueStatus.Issued_cust = Customer.Customer_Id;
 
 -- Display the total count of books in each category
 SELECT Category, count(*) as TotalBooks from Books group by Category;
 
-- Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
select Emp_name,Position from Employee where Salary>50000;

-- List the customer names who registered before 2022-01-01 and have  not issued any books yet.

select Customer_name from Customer  where  Reg_date<'2022-01-01' and
 Customer_Id NOT IN(select distinct( Issued_cust) FROM  IssueStatus );
 
 
 -- Display the branch numbers and the total count of employees in each branch
 select  Branch_no,count(*) as totalemployees from Employee group by Branch_no;
 
 -- Display the names of customers who have issued books in the month  of June 2023.
 select  Customer_name from  Customer where Customer_id in
 (select Issued_cust  from  IssueStatus where  Issue_date between '2023-06-01' and '2023-06-30');
 
 --  Retrieve book_title from book table containing history.
 select Book_title from Books where Book_title like '%history%';

-- Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
select Branch_no,count(*) as totalemployees from Employee group by Branch_no having totalemployees>5;

 

 
 
 


