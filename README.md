# Pewlett_Hackard_Analysis

# Overview

determine the number of retiring employees per title, and identify employees who are eligible to participate in a mentorship program. Then, you’ll write a report that summarizes your analysis and helps prepare Bobby’s manager for the “silver tsunami” as many current employees reach retirement age.


## Process:
Reference the Employee_Database_challenge file (here)[].

Deliverable 1: Find the Number of Retiring Employees by Title
* Create a Retirement Titles table that holds all the titles of current employees who were born between January 1, 1952 and December 31, 1955. 
  1. Join employees and titles table
  2. Filter by birth date
  3. Order by employee number

* Create a Unique Titles table that contains the most recent title of each employee. 
  1. Use "DISTINCT ON" statement to find most recent title
  2. Order by employee number and date of most recent title

* Create a Retiring Titles table that has the number of retirement-age employees by most recent job title.
  1. Use "COUNT" statment to count number of employees per title
  2. Order by the count of employees

Deliverable 2: Find the Employees Eligible for the Mentorship Program
* Create a Mentorship Eligibility table that holds the current employees who were born between January 1, 1965 and December 31, 1965.
  1. Join employees, dept_employees, and titles tables to create a Mentorship Eligibility table
  2. Filter by birth date and most recent title
  3. Order by employee number

## Resources:
Data Sources: 

Database System: Postgres Version 12.7

Interface: PgAdmin Version 5.2

Language: SQL


# Results:



# Summary:
