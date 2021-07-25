# Pewlett Hackard Retirement Analysis

# Overview

As baby boomers continue to retire at a rapid rate, Pewlett Hackard needs to look ahead and begin thinking about which positions will be open in the near future. We are performing an employee research analysis to determine the number of retiring employees per title, and identifying employees who are eligible to participate in a mentorship program.

## Process:
Reference the Employee Database Challenge file [here](https://github.com/corispade/Pewlett_Hackard_Analysis/blob/main/Queries/Employee_Database_challenge.sql) for the below process.

### Deliverable 1 - Find the Number of Retiring Employees by Title:
Create a [Retirement Titles](https://github.com/corispade/Pewlett_Hackard_Analysis/blob/main/Data/retirement_titles.csv) table that holds all the titles of current employees who were born between January 1, 1952 and December 31, 1955. 
 1. Join the Employees and Titles tables
 2. Filter by birth date
 3. Order by employee number

Create a [Unique Titles](https://github.com/corispade/Pewlett_Hackard_Analysis/blob/main/Data/unique_titles.csv) table that contains the most recent title of each employee. 
 1. Use "DISTINCT ON" statement from the above Retirements Table to find most recent title for each employee
 2. Order by employee number and date of most recent title

Create a [Retiring Titles](https://github.com/corispade/Pewlett_Hackard_Analysis/blob/main/Data/retiring_titles.csv) table that has the number of retirement-age employees by most recent job title.
 1. Use "COUNT" statment to count number of employees per title from the above Unique Titles table
 2. Order by the count of employees

### Deliverable 2 - Find the Employees Eligible for the Mentorship Program:
Create a [Mentorship Eligibility](https://github.com/corispade/Pewlett_Hackard_Analysis/blob/main/Data/mentorship_eligibility.csv) table that holds the current employees who were born between January 1, 1965 and December 31, 1965.
 1. Join the Employees, Dept_Employees, and Titles tables to create a Mentorship Eligibility table
 2. Filter by birth date and most recent title
 3. Order by employee number

## Resources:
CSV Data Sources: [Employees](https://github.com/corispade/Pewlett_Hackard_Analysis/blob/main/Data/employees.csv), [Dept_Employees](https://github.com/corispade/Pewlett_Hackard_Analysis/blob/main/Data/dept_emp.csv), [Titles](https://github.com/corispade/Pewlett_Hackard_Analysis/blob/main/Data/titles.csv)

Database System: Postgres Version 12.7

Interface: PgAdmin Version 5.2

Language: SQL


# Results:

There is a bulleted list with four major points from the two analysis deliverables. (6 pt)

* Based on the Unique Titles table, there are 90,398 employees retiring

* Based on the Retiring Titles table, the following positions will be open after employees retire:

![picture](https://github.com/corispade/Pewlett_Hackard_Analysis/blob/main/count_retiring_titles.png)

* Based on the Mentorship Eligibility table, there are 1,549 employees eligible for mentorship

# Summary:
Provide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."

How many roles will need to be filled as the "silver tsunami" begins to make an impact?
90,398 roles will need to be filled as the "silver tsunami" begins to make an impact. 

Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
There are 