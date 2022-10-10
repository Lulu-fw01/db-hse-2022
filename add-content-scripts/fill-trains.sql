INSERT INTO public.cities (region, name)
VALUES ('Москвоская область'::text, 'Москва'::text);

INSERT INTO public.cities (region, name)
VALUES ('СПБ'::text, 'Санкт-Петербург'::text);

INSERT INTO public.cities (region, name)
VALUES ('Тверская область'::text, 'Тверь'::text);

INSERT INTO public.stations (name, region, city, tracks)
VALUES ('Москва-1'::text, 'Московская область'::text, 'Москва'::text, 8::integer);

INSERT INTO public.stations (name, region, city, tracks)
VALUES ('Москва-2'::text, 'Московская область'::text, 'Москва'::text, 7::integer);

INSERT INTO public.stations (name, region, city, tracks)
VALUES ('Москва-3'::text, 'Московская область'::text, 'Москва'::text, 6::integer);

INSERT INTO public.stations (name, region, city, tracks)
VALUES ('Тверь-1'::text, 'Тверская область'::text, 'Тверь'::text, 3::integer);

INSERT INTO public.stations (name, region, city, tracks)
VALUES ('Тверь-2'::text, 'Тверская область'::text, 'Тверь'::text, 2::integer);

INSERT INTO public.stations (name, region, city, tracks)
VALUES ('спб-1'::text, 'СПБ'::text, 'Санкт-Петербург'::text, 5::integer);

INSERT INTO public.stations (name, region, city, tracks)
VALUES ('спб-2'::text, 'СПБ'::text, 'Санкт-Петербург'::text, 7::integer)