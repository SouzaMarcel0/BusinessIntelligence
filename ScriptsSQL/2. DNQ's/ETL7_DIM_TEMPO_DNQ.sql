insert into dim_data

	(sk_data, 
	data, 
	nr_ano, 
	nr_mes, 
	nm_mes, 
	nr_dia_mes,
	nm_dia_semana,
	nm_trimestre,
	nr_ano_trimestre,
	etl_data_in,
	etl_data_fim,
	dt_carga)
	select
		 0,                            -- sk_tempo (registro default no pdi)
		'01/01/1900 23:59:59',         --data
		-1,                            --nr_ano
		-1,                            --nr_mes
		'*** Não identificado ***',    --nm_mes
		-1,                            --nr_dia_mes
		'*** Não identificado ***',    --nm_semana
		'*** Não identificado ***',    --nm_trimestre
		-1,                            --nr_ano_trimestre
		'01/01/1900 23:59:59',         -- etl_dt_inicio
		'01/01/9999 23:59:59',         -- etl_dt_final
         current_timestamp		
	where not exists 
		(select 1 
		from dim_data
		where sk_data=0 );
-------------------------------------------------------
---------------------------------------------------------
insert into dim_data
	select
		to_char(datum, 'yyyymmdd')::int as sk_data,
		datum as data_completa,
		extract(year from datum) as nr_ano,
		extract(month from datum) as nr_mes,
		to_char(datum, 'TMmonth') as nm_mes,
		extract(day from datum) as nr_dia_mes,
		to_char(datum, 'TMday') as nm_dia_semana,
		--extract(doy from datum) as nr_dia_ano,
		--extract(week from datum) as nr_semana,
		--to_char(datum, 'dd/mm/yyyy') as data_formatada,
		'T' || to_char(datum, 'Q') as nm_trimestre,
		to_char(datum, 'yyyy/"T"Q') as nr_ano_trimestre
		--to_char(datum, 'yyyy/mm') as nr_ano_nr_mes,
		--to_char(datum, 'iyyy/IW') as nr_ano_nr_semana ,
		/*case when extract(isodow from datum) in (6, 7) then 'Fim de Semana' else 'Dia de Semana' end as flag_tipo_dia_semana,
	--feriados fixos
	        case when to_char(datum, 'mmdd') in ('0101', '1225', '1115', '1102', '1012', '0907', '0611', '0501', '0421', '0410', '0225', '0224')
	        then 'Feriado' else 'Não Feriado' end
	        as flag_feriado_fixo	
		-- periodos importantes para o negócio
		case when to_char(datum, 'mmdd') between '0601' and '0831' then 'Temporada de Inverno'
		     when to_char(datum, 'mmdd') between '1115' and '1225' then 'Temporada de Natal'
		     when to_char(datum, 'mmdd') > '1225' or to_char(datum, 'mmdd') <= '0106' then 'Temporada de Verão'
			else 'Normal' end
			as periodo_negocio,	
		(datum + (1 - extract(day from datum))::integer + '1 month'::interval)::date - '1 day'::interval as ultimo_dia_mes*/	
	from (
		-- data inicial da carga 
		select '2017-01-01'::date + sequence.day as datum
		from generate_series(0,3652) as sequence(day)
		group by sequence.day
	     ) dq
	order by 1;
-----------------------------------------------------

---------------------------------------------------------------------------	

--truncate table dim_data cascade;
select * from dim_data;
	
-- Atualiza NM_MES
UPDATE dim_data SET nm_mes='Janeiro' WHERE nm_mes='january';
UPDATE dim_data SET nm_mes='Fevereiro' WHERE nm_mes='february';
UPDATE dim_data SET nm_mes='Marçoo' WHERE nm_mes='march';
UPDATE dim_data SET nm_mes='Abril' WHERE nm_mes='april';
UPDATE dim_data SET nm_mes='Maio' WHERE nm_mes='may';
UPDATE dim_data SET nm_mes='Junho' WHERE nm_mes='june';
UPDATE dim_data SET nm_mes='Julho' WHERE nm_mes='july';
UPDATE dim_data SET nm_mes='Agosto' WHERE nm_mes='august';
UPDATE dim_data SET nm_mes='Setembro' WHERE nm_mes='september';
UPDATE dim_data SET nm_mes='Outubro' WHERE nm_mes='october';
UPDATE dim_data SET nm_mes='Novembro' WHERE nm_mes='november';
UPDATE dim_data SET nm_mes='Dezembro' WHERE nm_mes='december';


-- Atualiza NM_SEMANA

UPDATE dim_data SET nm_dia_semana='Segunda-feira' WHERE nm_dia_semana='monday';
UPDATE dim_data SET nm_dia_semana='Terça-feira' WHERE nm_dia_semana='tuesday';
UPDATE dim_data SET nm_dia_semana='Quarta-feira' WHERE nm_dia_semana='wednesday';
UPDATE dim_data SET nm_dia_semana='Quinta-feira' WHERE nm_dia_semana='thursday';
UPDATE dim_data SET nm_dia_semana='Sexta-feira' WHERE nm_dia_semana='friday';
UPDATE dim_data SET nm_dia_semana='Sábado' WHERE nm_dia_semana='saturday';
UPDATE dim_data SET nm_dia_semana='Domingo' WHERE nm_dia_semana='sunday';
		
select * from dim_data;
