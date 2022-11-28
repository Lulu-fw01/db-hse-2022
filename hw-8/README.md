# HW 8
Выполнил Марков Л.И. БПИ205

## 1
```postgresql
create or replace procedure new_job(
    id in jobs.job_id%type,
    title in jobs.job_title%type,
    min_sal in jobs.min_salary%type
)
    language plpgsql
as
$$
declare
    max_sal jobs.max_salary%type := 2 * min_sal;
begin
    insert into jobs(job_id, job_title, min_salary, max_salary)
    values (id, title, min_sal, max_sal);
end;
$$
```


## 2

## 3

## 4

## 5

```postgresql
create
    or replace function GET_JOB_COUNT(
    emp_id in job_history.employee_id%type) returns integer
    language plsql
as
$$
declare
    jobs_count int;
begin
    SELECT DISTINCT count(*)
    INTO jobs_count
    FROM job_history
    WHERE employee_id = emp_id;

    return jobs_count;
end;
$$
```

## 6

