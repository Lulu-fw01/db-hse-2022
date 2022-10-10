SELECT tr.train_nr
FROM trains tr
WHERE (SELECT st.city FROM stations st WHERE st.name = tr.start_station) = 'Москва'
  AND (SELECT st.city FROM stations st WHERE st.name = tr.end_station) = 'Тверь'