create
    or replace procedure upd_job_sal(
    target_job_id in jobs.job_id%type,
    new_min_sal in jobs.min_salary%type,
    new_max_sal in jobs.max_salary%type
)
    language plsql
as
$$
begin
    if (new_min_sal > new_max_sal) then
        RAISE EXCEPTION 'min salary > max salary';
    end if;

    update jobs set min_salary=new_min_sal, max_salary=new_max_sal where job_id = target_job_id;
exception
    when OTHERS
        then if (SQLSTATE = -54) then
            raise notice 'Locked error';
        end if;
end;
$$