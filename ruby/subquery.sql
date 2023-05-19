SELECT DISTINCT emp_no, MAX(salary) AS max_salary
FROM salaries
WHERE emp_no BETWEEN 10000 AND 10010
AND salary > (SELECT AVG(salary) FROM salaries)
GROUP BY emp_no;
