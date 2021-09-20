insert into dim_vendedor
	(sk_vendedor, 
	nk_vendedor, 
	nm_vendedor, 
	sexo_vendedor, 
	cargo_vendedor, 
	etl_versao, 
	etl_dt_inicio, 
	etl_dt_fim)
	select
		0, -- sk_produto (registro default no pdi)
		'*** não identificado ***', 
		'*** não identificado ***', 
		'*** não identificado ***', 
		'*** não identificado ***', 
		-1, -- etl_nr_versao
		'01/01/1900 23:59:59', -- etl_dt_inicio
		'01/01/9999 23:59:59' -- etl_dt_final
	where not exists 
		(select 1 
		from dim_vendedor
		where sk_vendedor=0 );
		
select * from dim_vendedor;
