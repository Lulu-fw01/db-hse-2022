SELECT *
FROM connections con
WHERE (SELECT st.city FROM stations st WHERE st.name = con.start_station) = 'Москва'
  AND (SELECT st.city FROM stations st WHERE st.name = con.end_station) = 'Санкт-Петербург'
  AND con.departure::timestamp::date = con.arrival::timestamp::date
  AND (SELECT COUNT(*)
       FROM connections cp
       WHERE cp.train_nr = con.train_nr
         AND cp.departure = con.departure
         AND cp.start_station = con.start_station
         AND cp.end_station != con.end_station) != 0