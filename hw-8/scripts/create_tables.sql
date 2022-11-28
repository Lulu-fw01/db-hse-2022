CREATE TABLE IF NOT EXISTS jobs
(
    job_id     TEXT PRIMARY KEY NOT NULL,
    job_title  TEXT             NOT NUll,
    min_salary INTEGER,
    max_salary INTEGER
)