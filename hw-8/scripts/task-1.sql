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
