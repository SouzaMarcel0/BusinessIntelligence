
--- Extraindo dados de Vendedor da Fonte/Source
--- Fonte: Banco de dados Firebird

SELECT u."CODIGO" , u.NOME AS NOME_VENDEDOR, f.COMISSAOVISTA , f.COMISSAOPRAZO FROM USUARIOS u 
INNER JOIN FUNCIONARIOS f ON 
u.VENDEDOR_VINC = f."CODIGO" ;

