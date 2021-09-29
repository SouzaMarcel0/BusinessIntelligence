
--- Extraindo dados de FATO_Compra da Fonte/Source
--- Fonte: Banco de dados Firebird

SELECT 
c2."DATA" ,
c.CODIGOMESTRE ,
c2.FORNECEDOR,
c.PRODUTO,
QUANTIDADE ,
UNITARIO ,
DESCONTO ,
ACRESCIMO ,
SUBTOTAL
FROM COMPRADETALHE c 
inner JOIN COMPRAMESTRE c2 ON 
c.CODIGOMESTRE = c2.CODIGOMESTRE 
where "DATA" >= '2018-01-01';

-- OBS: Data de corte para extração dos dados definimos aqui.