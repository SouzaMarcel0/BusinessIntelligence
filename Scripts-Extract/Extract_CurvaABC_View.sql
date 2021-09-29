

-- Script para usado para criar VIEW para Curva ABC com dados de vendas


select item, valor_total, Total_Geral, Percentual, perc_acu,
case 
 when perc_acu <= 80 then 'A'
 when perc_acu <=95 then 'B'
 else 'C'
 end Classe
from(
select item, valor_total, Total_Geral, Percentual,sum(Percentual) 
over(order by percentual desc) as perc_acu
from(
select item , valor_total , sum (valor_total) over () as Total_Geral,
cast (valor_total as numeric (15,3)) / cast (sum (valor_total) over () as numeric(15,3)) * 100 as Percentual
from (
select produto as item, sum (subtract) as valor_total
from st_venda sv  -- base de dados de onde foi obtido os dados
group by produto 
order by 2 desc) d) d1) d2


--

