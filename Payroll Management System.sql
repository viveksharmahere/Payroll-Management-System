-- Create Departments Table
CREATE TABLE Dept_Info (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50) NOT NULL
);

-- Create Employees Table
CREATE TABLE Emp_Info (
    Emp_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Dept_ID INT,
    Job_Title VARCHAR(50),
    Hire_Date DATE,
    FOREIGN KEY (Dept_ID) REFERENCES Dept_Info(Dept_ID)
);

-- Create Salaries Table
CREATE TABLE Salary_Info (
    Salary_ID INT PRIMARY KEY,
    Emp_ID INT,
    Basic_Pay DECIMAL(10, 2),
    Allowances DECIMAL(10, 2),
    Deductions DECIMAL(10, 2),
    Payment_Date DATE,
    FOREIGN KEY (Emp_ID) REFERENCES Emp_Info(Emp_ID)
);

-- Create Attendance Table
CREATE TABLE Emp_Attendance (
    Attendance_ID INT PRIMARY KEY,
    Emp_ID INT,
    Work_Date DATE,
    Status VARCHAR(10), -- e.g., 'Present', 'Absent'
    FOREIGN KEY (Emp_ID) REFERENCES Emp_Info(Emp_ID)
);

-- Insert Data into Departments Table
INSERT INTO Dept_Info (Dept_ID, Dept_Name)
VALUES (1, 'HR'); 

INSERT INTO Dept_Info (Dept_ID, Dept_Name)
VALUES (2, 'Finance');

INSERT INTO Dept_Info (Dept_ID, Dept_Name)
VALUES (3, 'IT');
 
INSERT INTO Dept_Info (Dept_ID, Dept_Name)
VALUES (4, 'Sales');

-- Insert Data into Employees Table
INSERT INTO Emp_Info (Emp_ID, First_Name, Last_Name, Dept_ID, Job_Title, Hire_Date)
VALUES (101, 'Rohit', 'Panday', 3, 'Software Engineer', TO_DATE('2021-06-15', 'YYYY-MM-DD'));

INSERT INTO Emp_Info (Emp_ID, First_Name, Last_Name, Dept_ID, Job_Title, Hire_Date)
VALUES (102, 'Jay', 'Jain', 1, 'HR Manager', TO_DATE('2020-03-12', 'YYYY-MM-DD'));

INSERT INTO Emp_Info (Emp_ID, First_Name, Last_Name, Dept_ID, Job_Title, Hire_Date)
VALUES (103, 'Virat', 'Mehta', 4, 'Sales Executive', TO_DATE('2022-01-10', 'YYYY-MM-DD'));

INSERT INTO Emp_Info (Emp_ID, First_Name, Last_Name, Dept_ID, Job_Title, Hire_Date)
VALUES (104, 'Shruti', 'Sharma', 2, 'Accountant', TO_DATE('2019-09-30', 'YYYY-MM-DD'));

-- Insert Data into Salaries Table
INSERT INTO Salary_Info (Salary_ID, Emp_ID, Basic_Pay, Allowances, Deductions, Payment_Date)
VALUES (1, 101, 50000, 10000, 5000, TO_DATE('2023-11-01', 'YYYY-MM-DD'));

INSERT INTO Salary_Info (Salary_ID, Emp_ID, Basic_Pay, Allowances, Deductions, Payment_Date)
VALUES (2, 102, 60000, 12000, 6000, TO_DATE('2023-11-01', 'YYYY-MM-DD'));

INSERT INTO Salary_Info (Salary_ID, Emp_ID, Basic_Pay, Allowances, Deductions, Payment_Date)
VALUES (3, 103, 40000, 8000, 4000, TO_DATE('2023-11-01', 'YYYY-MM-DD'));

INSERT INTO Salary_Info (Salary_ID, Emp_ID, Basic_Pay, Allowances, Deductions, Payment_Date)
VALUES (4, 104, 55000, 11000, 5500, TO_DATE('2023-11-01', 'YYYY-MM-DD'));

-- Insert Data into Attendance Table
INSERT INTO Emp_Attendance (Attendance_ID, Emp_ID, Work_Date, Status)
VALUES (1, 101, TO_DATE('2023-11-29', 'YYYY-MM-DD'), 'Present');

INSERT INTO Emp_Attendance (Attendance_ID, Emp_ID, Work_Date, Status)
VALUES (2, 102, TO_DATE('2023-11-29', 'YYYY-MM-DD'), 'Absent');

INSERT INTO Emp_Attendance (Attendance_ID, Emp_ID, Work_Date, Status)
VALUES (3, 103, TO_DATE('2023-11-29', 'YYYY-MM-DD'), 'Present');

INSERT INTO Emp_Attendance (Attendance_ID, Emp_ID, Work_Date, Status)
VALUES (4, 104, TO_DATE('2023-11-29', 'YYYY-MM-DD'), 'Present');


-- View All Employees and Their Departments

SELECT e.Emp_ID, e.First_Name, e.Last_Name, d.Dept_Name, e.Job_Title, e.Hire_Date
FROM Emp_Info e
JOIN Dept_Info d ON e.Dept_ID = d.Dept_ID;

-- Calculate Net Salary for All Employees

SELECT e.Emp_ID, e.First_Name, e.Last_Name, 
       s.Basic_Pay, s.Allowances, s.Deductions, 
       (s.Basic_Pay + s.Allowances - s.Deductions) AS Net_Salary, 
       s.Payment_Date
FROM Salary_Info s
JOIN Emp_Info e ON s.Emp_ID = e.Emp_ID;

-- Find Employees with Attendance Status 'Absent'

SELECT e.Emp_ID, e.First_Name, e.Last_Name, a.Work_Date, a.Status
FROM Emp_Attendance a
JOIN Emp_Info e ON a.Emp_ID = e.Emp_ID
WHERE a.Status = 'Absent';

-- List Employees Hired After a Specific Date

SELECT Emp_ID, First_Name, Last_Name, Job_Title, Hire_Date
FROM Emp_Info
WHERE Hire_Date > TO_DATE('2021-01-01', 'YYYY-MM-DD');

-- Department-Wise Employee Count

SELECT d.Dept_Name, COUNT(e.Emp_ID) AS Employee_Count
FROM Dept_Info d
LEFT JOIN Emp_Info e ON d.Dept_ID = e.Dept_ID
GROUP BY d.Dept_Name;

-- Total Salary Expense Per Department

SELECT d.Dept_Name, SUM(s.Basic_Pay + s.Allowances - s.Deductions) AS Total_Expense
FROM Salary_Info s
JOIN Emp_Info e ON s.Emp_ID = e.Emp_ID
JOIN Dept_Info d ON e.Dept_ID = d.Dept_ID
GROUP BY d.Dept_Name;

-- Employees with the Highest Salary in Each Department

SELECT d.Dept_Name, e.Emp_ID, e.First_Name, e.Last_Name, 
       MAX(s.Basic_Pay + s.Allowances - s.Deductions) AS Max_Salary
FROM Salary_Info s
JOIN Emp_Info e ON s.Emp_ID = e.Emp_ID
JOIN Dept_Info d ON e.Dept_ID = d.Dept_ID
GROUP BY d.Dept_Name, e.Emp_ID, e.First_Name, e.Last_Name;

-- Attendance Summary for Each Employee

SELECT e.Emp_ID, e.First_Name, e.Last_Name, 
       COUNT(CASE WHEN a.Status = 'Present' THEN 1 END) AS Total_Present, 
       COUNT(CASE WHEN a.Status = 'Absent' THEN 1 END) AS Total_Absent
FROM Emp_Attendance a
JOIN Emp_Info e ON a.Emp_ID = e.Emp_ID
GROUP BY e.Emp_ID, e.First_Name, e.Last_Name;

-- Employees Without a Salary Record

SELECT e.Emp_ID, e.First_Name, e.Last_Name
FROM Emp_Info e
LEFT JOIN Salary_Info s ON e.Emp_ID = s.Emp_ID
WHERE s.Salary_ID IS NULL;

-- List All Employees and Their Salary Payment History

SELECT e.Emp_ID, e.First_Name, e.Last_Name, s.Basic_Pay, s.Allowances, s.Deductions, 
       (s.Basic_Pay + s.Allowances - s.Deductions) AS Net_Salary, s.Payment_Date
FROM Salary_Info s
JOIN Emp_Info e ON s.Emp_ID = e.Emp_ID
ORDER BY s.Payment_Date DESC;



