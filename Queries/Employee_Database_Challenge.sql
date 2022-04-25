-- retirement_titles
select
  yee.emp_no,
  yee.first_name,
  yee.last_name,
  les.title,
  les.from_date,
  les.to_date into retirement_titles
from
  employees as yee
  join titles as les on (yee.emp_no = les.emp_no)
where
  (
    yee.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
  )
order by
  yee.emp_no;

-- unique_titles
-- Use Dictinct with Orderby to remove duplicate rows
SELECT
  DISTINCT ON (emp_no) emp_no,
  first_name,
  last_name,
  title INTO unique_titles
FROM
  retirement_titles
WHERE
  to_date = '9999-01-01'
ORDER BY
  emp_no asc,
  to_date desc;

-- retiring_titles
select
  count(title),
  title into retiring_titles
from
  unique_titles
group by
  title
order by
  count(title) desc;

-- mentorship_eligibility (not mentioned to be needed but included just incase.)
select
  distinct on (emp_no) e.emp_no,
  e.first_name,
  e.last_name,
  e.birth_date,
  d.from_date,
  d.to_date,
  ti.title into mentorship_eligibility
from
  employees as e
  join dept_emp as d on d.emp_no = e.emp_no
  join titles as ti on e.emp_no = ti.emp_no
where
  (
    d.to_date = '9999-01-01'
    and e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
  )
order by
  e.emp_no
--
-- drop table retiring_salary;
-- create retiring_salary
select
  ti.salary,
  u.emp_no,
  tit.title
  into retiring_salary
from
  unique_titles as u
  join salaries as ti on u.emp_no = ti.emp_no
  join titles as tit on ti.emp_no = tit.emp_no;
--
select * from retiring_salary;
-- create retiring_salary
select AVG(salary), title
into retiring_avg_by_title
from retiring_salary
group by title
order by title;

--
select * from retiring_avg_by_title;
