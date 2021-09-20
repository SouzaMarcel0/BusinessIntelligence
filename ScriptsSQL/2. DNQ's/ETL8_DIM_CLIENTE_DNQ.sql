insert into dim_meta 
	(
	sk_meta_venda,
	nk_meta,
	vl_meta, 
	--email_cliente, 
	--sexo_cliente, 
	--cidade_cliente, 
	--uf_cliente,
    etl_versao,
    etl_data_in, 
	etl_dt_fim,
	dt_carga 
	)
	select 
		 0, -- sk_meta_venda (registro default no pdi)
		-1, -- nk_meta,
		-1,
		--'***N�o Identificado***',            -- nm_cliente
		--'*** n�o identificado ***',       -- email cliente
		--'*** n�o identificado ***',        -- sexo_cliente
		--'*** n�o identificado ***',       -- cidade_cliente
		--'*** n�o identificado ***',       -- uf_cliente
		-1, -- etl_versao
		'01/01/1900 23:59:59',             -- etl_dt_inicio
		'01/01/9999 23:59:59',          -- etl_dt_final
		date (current_date)		
		
	where not exists 
		(
		select 1 
		from dim_meta 
		where sk_meta_venda = 0
		);

truncate table dim_meta cascade;
select * from dim_meta dm ;




		
	/*
	 * Dimensão Não Qualificada - DNQ	
	*** não identificado *** -1 é quando a fato não acha a sk na dimensão	( 0 pentaho)
	*** não se aplica ***    -2 é quando o cruzamento entre fato e dimensão nao existe ou não faz sentido
	*** não informado ***    -3 é quando a stage passa nulo pra dimensão	*/
