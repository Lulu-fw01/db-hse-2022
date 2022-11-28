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
```postgresql
create
    or replace procedure upd_job_sal(
    target_job_id in jobs.job_id%type,
    new_min_sal in jobs.min_salary%type,
    new_max_sal in jobs.max_salary%type
)
    language plpgsql
as
$$
begin
    IF (new_max_sal::INTEGER) < (new_min_sal::INTEGER) THEN
        RAISE EXCEPTION 'ERROR: min salary > max salary';
    ELSE
        UPDATE jobs SET min_salary=new_min_sal, max_salary=new_max_sal WHERE job_id = target_job_id;
    END IF;
exception
    when OTHERS
        then
            IF (SQLSTATE = -54) THEN
                raise notice 'Locked error';
            END IF;
end
$$
```
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

