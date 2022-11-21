create
or replace procedure add_job_hist (
    target_employee_id in job_history.employee_id%type,
    new_job_id in job_history.job_id%type
)
language plsql
as
$$
begin
insert into job_history(employee_id, job_id, start_date, end_date)
values (target_employee_id, (select job_id from employees where employee_id = target_employee_id limit 1)
     , (select hire_date from employees where employee_id = target_employee_id limit 1)
     , CURRENT_DATE);


IF
(
select COUNT(1)
from eployees
where employee_id = target_employee_id)
update employees
set job_id=new_job_id,
    hire_date=CURRENT_DATE,
    salary=(select min_salary from jobs where job_id = new_job_id limit 1) + 500
where employee_id = target_employee_id;
ELSE
insert into employees(employee_id, job_id, hire_date, salary)
    values(target_employee_id, new_job_id, CURRENT_DATE, (select min_salary from jobs where job_id = new_job_id limit 1) + 500);
end;
$$

