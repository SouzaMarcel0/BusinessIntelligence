
-- -- Registro Default na Tabela DIM_FORMA_PGTO para que PDi execute a carga sem problemas.

insert into dim_forma_pgto
	(sk_forma_pgto, 
	nk_forma_pgto, 
	nm_forma_pgto, 
	etl_versao, 
	etl_dt_inicio, 
	etl_dt_fim)
	select
		0, -- sk_forma_pgto (registro default no pdi)
		'*** não identificado ***', 
		'*** não identificado ***', 
		-1, -- etl_nr_versao
		'01/01/1900 23:59:59', -- etl_dt_inicio
		'01/01/9999 23:59:59' -- etl_dt_final
	where not exists 
		(select 1 
		from dim_forma_pgto
		where sk_forma_pgto=0 );
		
select * from dim_forma_pgto;
