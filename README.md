# Payroll Management System

A SQL-based Payroll Management System designed to manage employees, salaries, attendance, and departmental information effectively. Built with Oracle SQL, this system demonstrates key database management and analytical capabilities.

---

## Features

- **Department Management**: Tracks departments and their employees.
- **Employee Information**: Maintains employee details, job roles, and hire dates.
- **Salary Management**: Handles basic salary, allowances, deductions, and net salary computation.
- **Attendance Tracking**: Logs employee attendance (`Present` or `Absent`).
- **Reporting**: Provides insights like salary expenses and attendance summaries.

---

## Database Schema

The project includes the following tables:
1. **`Dept_Info`**: Stores department details.
2. **`Emp_Info`**: Holds employee information with department references.
3. **`Salary_Info`**: Manages salary details with employee references.
4. **`Emp_Attendance`**: Tracks employee attendance.

### Table Relationships
- `Dept_Info` → `Emp_Info`: One-to-Many.
- `Emp_Info` → `Salary_Info`: One-to-One.
- `Emp_Info` → `Emp_Attendance`: One-to-Many.

---

## Key Queries

- **Net Salary Calculation**: Computes net salary by deducting allowances and deductions.
- **Department-wise Salary Report**: Summarizes total salary expenditure by department.
- **Attendance Summary**: Tracks attendance for employees on specific dates.
- **Top Earners**: Identifies employees with the highest salaries in each department.

---
