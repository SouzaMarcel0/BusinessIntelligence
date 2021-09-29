-- Registro Default na Tabela DIM_PRODUTO para que PDi execute a carga sem problemas.

insert into dim_produto
	(sk_produto, 
	nk_produto, 
	nm_produto, 
	cd_categoria_produto, 
	nm_categoria_produto, 
	cd_sub_categoria_produto, 
	nm_sub_categoria_produto,
	etl_versao, 
	etl_dt_inicio, 
	etl_dt_fim)
		select
		0, -- sk_produto (registro default no pdi)
		'*** não identificado ***', 
		'*** não identificado ***', 
		-1, 
		'*** não identificado ***', 
		-1, 
		'*** não identificado ***',
		-1, -- etl_nr_versao
		'01/01/1900 23:59:59', -- etl_dt_inicio
		'01/01/9999 23:59:59' -- etl_dt_final
		where not exists 
			( select 1 
			  from dim_produto
			  where sk_produto=0 );	
			  
			  
select * from dim_produto;
select * from dim_data dd ;
	/*	
	*** não identificado *** -1 é quando a fato não acha a sk na dimensão	( 0 pentaho)
	*** não se aplica ***    -2 é quando o cruzamento entre fato e dimensão nao existe ou não faz sentido
	*** não informado ***    -3 é quando a stage passa nulo pra dimensão	*/
