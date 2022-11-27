# HW 8
Выполнил Марков Л.И. БПИ205

## 1

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

