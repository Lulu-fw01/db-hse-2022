create
    or replace function GET_JOB_COUNT(
    emp_id in job_history.employee_id%type) returns integer
    language plpgsql
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