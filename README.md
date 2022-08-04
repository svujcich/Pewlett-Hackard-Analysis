## Overview
Pewlett-Hackard is a large company that employs roughly 240,000 individuals and has been in operation since 1985. Given the number of employees and the length of time the company has been in operation, it is reasonable to expect a number of individuals will be retiring. The goal of this analysis is to identify how many individuals will be retiring, and what roles will need to be filled in the upcoming future.  As a solutionto this "silver tsunami", Pewlett-Hackard plans to implement a mentorship program aimed at supporting up-and-coming employees to successfully step into the roles of their predecessors. This analysis also aims to create a table which identifies the individuals who are eligible to participate in the mentorship program.

## Results
The analysis shows that:
- 240,124 individuals are currently employed at Pewlett-Hackard
- 72,458 individuals are eligible for retirement
	- 25,916 are Senior Engineers
	- 24,926 are Senior Staff 
  - 9,285 are Engineers
  - 7,636 are Staff
  - 3,603 are Technique Leaders
  - 1,090 are Assistant Engineers
  - 2 are Managers
- 1,549 employees are eligible to participate in the mentorship program
	- 268 are Senior Engineers
	- 408 are Senior Staff
- 419 are Engineers
	- 316 are Staff
	- 77 are Technique Leaders
	- 61 are Assistant engineers
- 30.17% of the workforce is expected to retire 

## Summary
The results show that Pewlett-Hackard is expected to lose nearly 1/3 of the workforce, and of those jobs vacancies, “senior” ranking positions account for roughly 70%. The results also show that of the jobs that are left vacant, the majority of the positions that will need to be filled are related to engineering or staffing:
- about 50% of the vacant positions will be related to engineering, 
- about 45% of the vacant positions will be related to general staffing, 
- about 5% of the vacant positions will be related to technique leading, 
- 	less than 1% of vacant positions will be managers. 

Given the circumstance, Pewlett-Hackard should to proceed with caution; Many experienced roles will need to be filled and there are disproportionally few people eligible to participate in the mentorship program.  The results show that compared to the number of people retiring from each title, the mentorship program candidates make up:

- 1% of the Senior engineers who will retire
-	1% of Senior Staff who will retire
-	4% engineers who will retire
-	4% of staff who will retire
-	2% of technique leaders who will retire
-	5% of Assistant Engineers who will retire

In order explore options for solutions, the first action Pewlett-Hackard might consider taking would be to create a complete table of all remaining employees using the following code:

```
--1a.find complete list of remaining employees
SELECT DISTINCT ON(e.emp_no)e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	t.title,
	t.from_date,
	t.to_date
INTO remaining_employees 
FROM employees AS e
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date NOT BETWEEN '1952-01-01' AND '1955-12-31')
	AND (t.to_date = '9999-01-01')
ORDER BY e.emp_no ASC;
```

Creating this table adds a valuable set of information that can be queried to provide deeper insght into the workforce that will remain following the mass exit of retirees. For example, the titles in this remaining_employee table can be queried to show only engineering related job titles, organized by title and start date, to begin painting a picture of which employees have respectively worked their current positions the longest. 

![Screenshot (76)](https://user-images.githubusercontent.com/106559768/182764228-1170e24b-c432-4f47-aa6f-3938b095a64b.png)

The results might highlight some engineers who might not be eligible for the mentorship program, but have over a decade of engineering experience with Pewlett-Hackard, which may qualify them to be eligible for a promotion to a senior ranking engineer position (depending on Pewlett-Hackard's criteria for "senior" employees). This is an important consideration because even though they might only be around for another couple years, long standing employees possess domain knowledge about Pwelett-Hackard which makes them valuable assets to the team, and should not be overlooked. this table might also show several hundred assistant engineers are now eligible to become engineers. By exploring possibilities surrounding hiring within, Pewlett-Hackard would be able to fill in the gaps with company-specific experience, leaving more availability to hire more entry level positions externally.

Another table that might be useful is a complete work history table of remaining employees. Perhaps someone has had 25 years of experience in engineering, and within the last year they were promoted to a manager. In the previous example, the 25 years of engineering experience would be completely overlooked becuase only the most recent job title was joined into the remaining_employee table. In the current situation, It is important to identify every individual with Pewlett-Hackard domain knowledge. In this example, perhaps the manager would take on new responsibility of mentoring up-and-coming engineering employees or managing part of the engineering mentorship program, and acquire an assistant manager to fill in the gaps from his or her current position.

A final option for bridging the gap between retiring employees and individuals eligible for the mentorship program would involve modifying the birth date criteria for the mentorship program. Perhaps it would be advantageous to widen the scope of the mentorship program to those who have an estimated 7 years left in their working careers instead of 10 years using the following format:

```
SELECT COUNT(emp_no) FROM remaining_employees
WHERE (birth_date BETWEEN '1962-01-01' AND '1965-12-31')
```

By selecting the and counting employee numbers form the remaining_employees table and adjusting the where statement to show different birth date criteria, it is possible to quickly query how many individuals would qualify for the mentorship program if the birth date criteria was modified:

- 10 years: 1,549 employees would qualify for the mentorship program
- 9 years: 19,905 employees would qualify for the mentorship program
- 8 years: 38,401 employees would qualify for the mentorship program
- 7 years: 56,859 employees would qualify for the mentorship program

By reconsidering the criteria for employees who qualify for the mentorship program, the ratio of individuals retiring to individuals in the mentorship program might become more balanced. This would allow for more individuals to comfortably move into more skilled positions, and further fill in the anticipated skill related gaps in employment as individuals begin to retire. 
