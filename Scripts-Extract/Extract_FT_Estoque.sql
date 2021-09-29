
--- Extraindo dados de FATO_Estoque da Fonte/Source
--- Fonte: Banco de dados Firebird

SELECT m."DATA", m.PRODUTO , m."QUANTIDADE" , m.HISTORICO, m.OPERACAO, peio.ATUAL AS EStoque_Atual 
FROM MOVIESTOQUE m
FULL JOIN PRODS_ESTOQ_IMP_OUTR peio ON 
m.PRODUTO = peio.PRODUTO
WHERE historico IN (3,4,5,6,19,21) AND DATA >= '2018-01-01';

-- OBS: Data de corte para extração dos dados definimos aqui.