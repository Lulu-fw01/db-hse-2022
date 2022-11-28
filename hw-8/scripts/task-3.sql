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