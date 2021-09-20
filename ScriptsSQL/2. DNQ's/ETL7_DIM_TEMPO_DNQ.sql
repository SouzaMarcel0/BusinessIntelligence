insert into dim_tempo
	(sk_tempo, 
	data, 
	nr_ano, 
	nr_mes, 
	nm_mes, 
	nr_dia_mes,
	nm_semana,
	etl_dt_inicio,
	etl_dt_fim)
	select
		0, -- sk_tempo (registro default no pdi)
		'01/01/1900 23:59:59', --data
		-1, --nr_ano
		-1, --nr_mes
		'*** não identificado ***', --nm_mes
		-1, --nr_dia_mes
		'*** não identificado ***', --nm_semana
		'01/01/1900 23:59:59', -- etl_dt_inicio
		'01/01/9999 23:59:59' -- etl_dt_final
	where not exists 
		(select 1 
		from dim_tempo
		where sk_tempo=0 );
		
select * from dim_tempo;
