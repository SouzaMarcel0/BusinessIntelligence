
-- ## Criação de Script automática, usando a ferramenta de Designer SQL_Power_Architect ##
-- ## O padrão de blocos de script se repete, então para facilitar, irei documentar um bloco para que possa servir de 
-- base de conhecimento para entender todo o conteúdo.
-- ## Após o entendimento do bloco de criação das tabelas, vá para a linha 358 e entenda a criação dos relacionamentos entre as tabelas

-- Criando a Sequence no banco de dados para ser a chave Artifical autoincremental

CREATE SEQUENCE public.snow_flake_operador_cartao_sk_operador_cartao_seq;

-- Criando a tabela/dimensão_snowflake Operador_Cartão_Credito

CREATE TABLE public.SNOW_FLAKE_OPERADOR_CARTAO (
                SK_OPERADOR_CARTAO INTEGER NOT NULL DEFAULT nextval('public.snow_flake_operador_cartao_sk_operador_cartao_seq'),
                NK_SNOWFLAKE_OPERADOR_CARTAO INTEGER NOT NULL,
                NM_SNOWFLAKE_OPERADOR VARCHAR NOT NULL,
                COD_BANDEIRA_CARTAO INTEGER NOT NULL,
                NM_BANDEIRA_CARTAO VARCHAR(60) NOT NULL,
                TX_DESCONTO_CART_DEBITO REAL NOT NULL,
                TX_DESCONTO_CART_CRED_AVSITA REAL NOT NULL,
                TX_DESCONTO_CART_CRED_APRAZO REAL NOT NULL,
                CONSTRAINT snow_flake_operador_cartao_pk PRIMARY KEY (SK_OPERADOR_CARTAO)
);

/* Comentários que servirão como Metadados dos dados inseridos

COMMENT ON COLUMN public.SNOW_FLAKE_OPERADOR_CARTAO.NK_SNOWFLAKE_OPERADOR_CARTAO IS 'É o código da adquirente processa as vendas em cartão de Cred./Deb.';
COMMENT ON COLUMN public.SNOW_FLAKE_OPERADOR_CARTAO.NM_SNOWFLAKE_OPERADOR IS 'É o nome da adquirente processa as vendas em cartão de Cred./Deb.';
COMMENT ON COLUMN public.SNOW_FLAKE_OPERADOR_CARTAO.NM_BANDEIRA_CARTAO IS 'É o nome da bandeira do cartao. EX; VISA, MASTERCARD, etc.';
COMMENT ON COLUMN public.SNOW_FLAKE_OPERADOR_CARTAO.TX_DESCONTO_CART_DEBITO IS 'É a taxa cobrada pela operadora/Adquirente para oferecer o serviço. (1 dia)';
COMMENT ON COLUMN public.SNOW_FLAKE_OPERADOR_CARTAO.TX_DESCONTO_CART_CRED_AVSITA IS 'É a taxa que a cobra p/ processa as vendas em cartão de Cred. Rotativo (30 dias)';
COMMENT ON COLUMN public.SNOW_FLAKE_OPERADOR_CARTAO.TX_DESCONTO_CART_CRED_APRAZO IS 'É a taxa que a cobra p/ processa as vendas em cartão de Cred. Cred com 2 parcelas ou mais.';
*/

-- Alteração da Sequence criada

ALTER SEQUENCE public.snow_flake_operador_cartao_sk_operador_cartao_seq OWNED BY public.SNOW_FLAKE_OPERADOR_CARTAO.SK_OPERADOR_CARTAO;

CREATE SEQUENCE public.dim_forma_pgto_fornecedor_sk_forma_pgto_realizado_seq;

CREATE TABLE public.DIM_FORMA_PGTO_FORNECEDOR (
                SK_FORMA_PGTO_REALIZADO INTEGER NOT NULL DEFAULT nextval('public.dim_forma_pgto_fornecedor_sk_forma_pgto_realizado_seq'),
                NK_FORMA_PGTO_REALIZADO INTEGER NOT NULL,
                NM_FORMA_PGTO_FORNECEDOR VARCHAR NOT NULL,
                CONSTRAINT dim_forma_pgto_realizado_pk PRIMARY KEY (SK_FORMA_PGTO_REALIZADO)
);
COMMENT ON COLUMN public.DIM_FORMA_PGTO_FORNECEDOR.NK_FORMA_PGTO_REALIZADO IS 'É o código de pgto das compras realizadas';


ALTER SEQUENCE public.dim_forma_pgto_fornecedor_sk_forma_pgto_realizado_seq OWNED BY public.DIM_FORMA_PGTO_FORNECEDOR.SK_FORMA_PGTO_REALIZADO;

CREATE SEQUENCE public.dim_forma_pgto_cliente_sk_forma_pgto_recebido_seq;

CREATE TABLE public.DIM_FORMA_PGTO_CLIENTE (
                SK_FORMA_PGTO_RECEBIDO INTEGER NOT NULL DEFAULT nextval('public.dim_forma_pgto_cliente_sk_forma_pgto_recebido_seq'),
                SK_OPERADOR_CARTAO INTEGER NOT NULL,
                NK_FORMA_PGTO INTEGER NOT NULL,
                NM_FORMA_PGTO VARCHAR(60) NOT NULL,
                CONSTRAINT dim_forma_pgto_cliente_pk PRIMARY KEY (SK_FORMA_PGTO_RECEBIDO)
);
COMMENT ON COLUMN public.DIM_FORMA_PGTO_CLIENTE.SK_FORMA_PGTO_RECEBIDO IS 'Chave artificial auto incremental';
COMMENT ON COLUMN public.DIM_FORMA_PGTO_CLIENTE.NK_FORMA_PGTO IS 'É o código do Pgto';


ALTER SEQUENCE public.dim_forma_pgto_cliente_sk_forma_pgto_recebido_seq OWNED BY public.DIM_FORMA_PGTO_CLIENTE.SK_FORMA_PGTO_RECEBIDO;

CREATE SEQUENCE public.dim_concorrente_sk_concorrente_seq;

CREATE TABLE public.DIM_CONCORRENTE (
                SK_CONCORRENTE INTEGER NOT NULL DEFAULT nextval('public.dim_concorrente_sk_concorrente_seq'),
                NK_CONCORRENTE INTEGER NOT NULL,
                NM_CONCORRENTE VARCHAR NOT NULL,
                ETL_VERSAO INTEGER,
                ETL_DATA_IN TIMESTAMP,
                ETL_DATA_FIM TIMESTAMP,
                DT_CARGA TIMESTAMP,
                CONSTRAINT dim_concorrente_pk PRIMARY KEY (SK_CONCORRENTE)
);
COMMENT ON COLUMN public.DIM_CONCORRENTE.SK_CONCORRENTE IS 'Chave artificial AutoIncrement';


ALTER SEQUENCE public.dim_concorrente_sk_concorrente_seq OWNED BY public.DIM_CONCORRENTE.SK_CONCORRENTE;

CREATE SEQUENCE public.dim_prod_fora_mix_sk_prod_fora_mix_seq;

CREATE TABLE public.DIM_PROD_FORA_MIX (
                SK_PROD_FORA_MIX INTEGER NOT NULL DEFAULT nextval('public.dim_prod_fora_mix_sk_prod_fora_mix_seq'),
                NK_PROD_FORA_MIX VARCHAR NOT NULL,
                DESC_PRODUTO VARCHAR(100) NOT NULL,
                ETL_VERSAO INTEGER,
                ETL_DATA_IN TIMESTAMP,
                ETL_DATA_FIM TIMESTAMP,
                DT_CARGA TIMESTAMP,
                CONSTRAINT dim_prod_fora_mix_pk PRIMARY KEY (SK_PROD_FORA_MIX)
);
COMMENT ON COLUMN public.DIM_PROD_FORA_MIX.NK_PROD_FORA_MIX IS 'Chave criada para cada linha de registro da planilha.';


ALTER SEQUENCE public.dim_prod_fora_mix_sk_prod_fora_mix_seq OWNED BY public.DIM_PROD_FORA_MIX.SK_PROD_FORA_MIX;

CREATE SEQUENCE public.dim_meta_sk_meta_venda_seq;

CREATE TABLE public.DIM_META (
                SK_META_VENDA INTEGER NOT NULL DEFAULT nextval('public.dim_meta_sk_meta_venda_seq'),
                NK_META VARCHAR NOT NULL,
                DT_INICIO_META DATE NOT NULL,
                DT_FIM_META DATE NOT NULL,
                VL_META NUMERIC(12,2) NOT NULL,
                ETL_VERSAO INTEGER,
                ETL_DATA_IN TIMESTAMP,
                ETL_DT_FIM TIMESTAMP,
                DT_CARGA TIMESTAMP,
                CONSTRAINT dim_meta_pk PRIMARY KEY (SK_META_VENDA)
);
COMMENT ON COLUMN public.DIM_META.SK_META_VENDA IS 'Chave Artifical auto incremental';
COMMENT ON COLUMN public.DIM_META.NK_META IS 'É o código atribuido a Meta. Natual Key/Primary Key. Composição:M102019 onde: M=Meta, 10=Mes, 2019=Ano, Meta referente ao devido período.';
COMMENT ON COLUMN public.DIM_META.DT_INICIO_META IS 'É o primeiro dia do mês para sumarizar o valor correspondente da meta.';
COMMENT ON COLUMN public.DIM_META.DT_FIM_META IS 'É a data final de referência para a Meta do período';
COMMENT ON COLUMN public.DIM_META.VL_META IS 'É o Valor da Meta para o mês.';


ALTER SEQUENCE public.dim_meta_sk_meta_venda_seq OWNED BY public.DIM_META.SK_META_VENDA;

CREATE SEQUENCE public.dim_fornecedor_sk_fornecedor_seq;

CREATE TABLE public.DIM_FORNECEDOR (
                SK_FORNECEDOR INTEGER NOT NULL DEFAULT nextval('public.dim_fornecedor_sk_fornecedor_seq'),
                NK_FORNECEDOR INTEGER NOT NULL,
                NM_FORNECEDOR VARCHAR(100) NOT NULL,
                ETL_VERSAO INTEGER,
                ETL_DATA_IN TIMESTAMP,
                ETL_DATA_FIM TIMESTAMP,
                DT_CARGA TIMESTAMP,
                CONSTRAINT dim_fornecedor_pk PRIMARY KEY (SK_FORNECEDOR)
);
COMMENT ON COLUMN public.DIM_FORNECEDOR.SK_FORNECEDOR IS 'Chave Artificial
Sequence
Não reutilizar';
COMMENT ON COLUMN public.DIM_FORNECEDOR.NK_FORNECEDOR IS 'É a chave/código PK no Legado.';
COMMENT ON COLUMN public.DIM_FORNECEDOR.NM_FORNECEDOR IS 'Nome do Fornecedor. É a razão social do Fornecedor. No ETL pode ser modificado para nome Fantasia.';
COMMENT ON COLUMN public.DIM_FORNECEDOR.ETL_DATA_IN IS 'Nesta dimensão nenhum atributo é do tipo SCD tipo2.';
COMMENT ON COLUMN public.DIM_FORNECEDOR.ETL_DATA_FIM IS 'Nesta dimensão nenhum atributo é do tipo SCD tipo2.';


ALTER SEQUENCE public.dim_fornecedor_sk_fornecedor_seq OWNED BY public.DIM_FORNECEDOR.SK_FORNECEDOR;

CREATE SEQUENCE public.dim_data_sk_data_seq;

CREATE TABLE public.DIM_DATA (
                SK_DATA INTEGER NOT NULL DEFAULT nextval('public.dim_data_sk_data_seq'),
                DATA DATE NOT NULL,
                NR_ANO INTEGER NOT NULL,
                NR_MES INTEGER NOT NULL,
                NM_MES VARCHAR(60) NOT NULL,
                NR_DIA_MES INTEGER NOT NULL,
                NM_DIA_SEMANA VARCHAR(60) NOT NULL,
                NM_TRIMESTRE VARCHAR(60) NOT NULL,
                NR_ANO_TRIMESTRE VARCHAR(60) NOT NULL,
                ETL_DATA_IN TIMESTAMP,
                ETL_DATA_FIM TIMESTAMP,
                DT_CARGA TIMESTAMP,
                CONSTRAINT sk_data_pk PRIMARY KEY (SK_DATA)
);
COMMENT ON COLUMN public.DIM_DATA.SK_DATA IS 'Chave Artificial
Sequence
Não reutilizar';
COMMENT ON COLUMN public.DIM_DATA.ETL_DATA_IN IS 'Nesta dimensão nenhum atributo é do tipo SCD tipo2.';
COMMENT ON COLUMN public.DIM_DATA.ETL_DATA_FIM IS 'Nesta dimensão nenhum atributo é do tipo SCD tipo2.';


ALTER SEQUENCE public.dim_data_sk_data_seq OWNED BY public.DIM_DATA.SK_DATA;

CREATE TABLE public.FT_VENDAS_NAO_REALIZADAS (
                SK_DATA INTEGER NOT NULL,
                SK_META_VENDA INTEGER NOT NULL,
                SK_PROD_FORA_MIX INTEGER NOT NULL,
                SK_CONCORRENTE INTEGER NOT NULL,
                VL_VENDA_NAO_REALIZADA NUMERIC(18,2) NOT NULL,
                QTDE_ITENS INTEGER NOT NULL,
                DT_CARGA TIMESTAMP
);
COMMENT ON COLUMN public.FT_VENDAS_NAO_REALIZADAS.SK_DATA IS 'Chave Artificial Sequence Não reutilizar';
COMMENT ON COLUMN public.FT_VENDAS_NAO_REALIZADAS.SK_META_VENDA IS 'Chave Artifical auto incremental';
COMMENT ON COLUMN public.FT_VENDAS_NAO_REALIZADAS.SK_CONCORRENTE IS 'Chave artificial AutoIncrement';
COMMENT ON COLUMN public.FT_VENDAS_NAO_REALIZADAS.VL_VENDA_NAO_REALIZADA IS 'É o valor interno do Produto unitário ou do concorrente.';
COMMENT ON COLUMN public.FT_VENDAS_NAO_REALIZADAS.QTDE_ITENS IS 'Quantidade de itens não vendidos';


CREATE SEQUENCE public.dim_vendedor_sk_vendedor_seq;

CREATE TABLE public.DIM_VENDEDOR (
                SK_VENDEDOR INTEGER NOT NULL DEFAULT nextval('public.dim_vendedor_sk_vendedor_seq'),
                NK_VENDEDOR INTEGER NOT NULL,
                NM_VENDEDOR VARCHAR(100) NOT NULL,
                COMISSAO_VENDEDOR_AVISTA NUMERIC(20,2) NOT NULL,
                COMISSAO_VENDEDOR_APRAZO NUMERIC(20,2) NOT NULL,
                ETL_DATA_IN TIMESTAMP,
                ETL_DATA_FIM TIMESTAMP,
                ETL_VERSAO INTEGER,
                DT_CARGA TIMESTAMP,
                CONSTRAINT dim_vendedor_pk PRIMARY KEY (SK_VENDEDOR)
);
COMMENT ON COLUMN public.DIM_VENDEDOR.SK_VENDEDOR IS 'Chave Artificial
Sequence
Não reutilizar';
COMMENT ON COLUMN public.DIM_VENDEDOR.NK_VENDEDOR IS 'É o Código do Vendedor';
COMMENT ON COLUMN public.DIM_VENDEDOR.COMISSAO_VENDEDOR_AVISTA IS 'É o percentual de comissão vinculada ao vendedor para vendas a vista.';
COMMENT ON COLUMN public.DIM_VENDEDOR.COMISSAO_VENDEDOR_APRAZO IS 'É o percentual de comissão vinculada ao vendedor para vendas a prazo.';
COMMENT ON COLUMN public.DIM_VENDEDOR.ETL_DATA_IN IS 'Nesta dimensão nenhum atributo é do tipo SCD tipo2.';
COMMENT ON COLUMN public.DIM_VENDEDOR.ETL_DATA_FIM IS 'Nesta dimensão nenhum atributo é do tipo SCD tipo2.';


ALTER SEQUENCE public.dim_vendedor_sk_vendedor_seq OWNED BY public.DIM_VENDEDOR.SK_VENDEDOR;

CREATE SEQUENCE public.dim_produto_sk_produto_seq;

CREATE TABLE public.DIM_PRODUTO (
                SK_PRODUTO INTEGER NOT NULL DEFAULT nextval('public.dim_produto_sk_produto_seq'),
                NK_PRODUTO INTEGER NOT NULL,
                NM_PRODUTO VARCHAR(80) NOT NULL,
                CD_CATEGORIA INTEGER,
                NM_CATEGORIA VARCHAR(60),
                CD_MARCA INTEGER,
                NM_MARCA VARCHAR(80) NOT NULL,
                DT_CADASTRO DATE NOT NULL,
                PRECO_UNI_CUSTO NUMERIC(12,4) NOT NULL,
                PRECO_UNI_VENDA NUMERIC(12,4) NOT NULL,
                QTDE_MINIMA_ESTOQUE NUMERIC(18,4) NOT NULL,
                ETL_DATA_IN TIMESTAMP,
                ETL_DATA_FIM TIMESTAMP,
                ETL_VERSAO INTEGER,
                DT_CARGA TIMESTAMP,
                CONSTRAINT dim_produto_pk PRIMARY KEY (SK_PRODUTO)
);
COMMENT ON COLUMN public.DIM_PRODUTO.SK_PRODUTO IS 'Chave Artificial
Sequence
Não reutilizar';
COMMENT ON COLUMN public.DIM_PRODUTO.NK_PRODUTO IS 'Código do produto no legado também alguns casos pode está como SKU';
COMMENT ON COLUMN public.DIM_PRODUTO.CD_MARCA IS 'Código da marca do Produto. 
OBS: Nem todo produto possui uma Marca associada, pois não é obrigatório para gravação, ou seja, não é garantia de ter o dado no Legado (ERP).';
COMMENT ON COLUMN public.DIM_PRODUTO.DT_CADASTRO IS 'Data de registro do produto no sistema';
COMMENT ON COLUMN public.DIM_PRODUTO.PRECO_UNI_CUSTO IS 'É o preço de custo do produto.';
COMMENT ON COLUMN public.DIM_PRODUTO.PRECO_UNI_VENDA IS 'É o preço atual de venda.';
COMMENT ON COLUMN public.DIM_PRODUTO.ETL_DATA_IN IS 'Para registrar o preço atual praticado, tanto de VENDA quanto de COMPRA dos produtos. SCD tipo 2.';
COMMENT ON COLUMN public.DIM_PRODUTO.ETL_DATA_FIM IS 'Para registrar o último preço praticado, tanto de VENDA quanto de COMPRA dos produtos. SCD tipo 2';


ALTER SEQUENCE public.dim_produto_sk_produto_seq OWNED BY public.DIM_PRODUTO.SK_PRODUTO;

CREATE TABLE public.FT_ESTOQUE_SNAPSHOT_PERIODICO (
                SK_DATA INTEGER NOT NULL,
                SK_PRODUTO INTEGER NOT NULL,
                TIPO_OPERACAO_E_S CHAR(1) NOT NULL,
                COD_HIST_MOVIMENTO INTEGER NOT NULL,
                QTDE_PROD_MOVIMENTADO NUMERIC(18,4) NOT NULL,
                SALDO_ESTOQUE_DIARIO NUMERIC(18,4) NOT NULL,
                DT_CARGA TIMESTAMP
);
COMMENT ON TABLE public.FT_ESTOQUE_SNAPSHOT_PERIODICO IS 'Não está sendo ultilizada PK na FATO';
COMMENT ON COLUMN public.FT_ESTOQUE_SNAPSHOT_PERIODICO.SK_DATA IS 'Chave Artificial
Sequence
Não reutilizar';
COMMENT ON COLUMN public.FT_ESTOQUE_SNAPSHOT_PERIODICO.SK_PRODUTO IS 'Chave Artificial
Sequence
Não reutilizar';
COMMENT ON COLUMN public.FT_ESTOQUE_SNAPSHOT_PERIODICO.TIPO_OPERACAO_E_S IS 'Identifica se a operação é de entrada ou saída de produtos.';
COMMENT ON COLUMN public.FT_ESTOQUE_SNAPSHOT_PERIODICO.COD_HIST_MOVIMENTO IS 'Identificar qual motivo o motivo da entrada/saida';
COMMENT ON COLUMN public.FT_ESTOQUE_SNAPSHOT_PERIODICO.QTDE_PROD_MOVIMENTADO IS 'É a quantidade referente ao movimento diário de Entrada de Produtos.';
COMMENT ON COLUMN public.FT_ESTOQUE_SNAPSHOT_PERIODICO.SALDO_ESTOQUE_DIARIO IS 'É o resultado da consulta diária do saldo do estoque.';


CREATE TABLE public.FT_COMPRA (
                SK_DATA INTEGER NOT NULL,
                SK_PRODUTO INTEGER NOT NULL,
                SK_FORNECEDOR INTEGER NOT NULL,
                COD_TRANS_DD INTEGER NOT NULL,
                QTDE_COMPRADDA INTEGER NOT NULL,
                VL_DESCONTO NUMERIC(18,2) NOT NULL,
                VL_COMPRA NUMERIC(18,2) NOT NULL,
                DT_CARGA TIMESTAMP NOT NULL,
                SK_FORMA_PGTO_REALIZADO INTEGER NOT NULL
);
COMMENT ON COLUMN public.FT_COMPRA.SK_DATA IS 'Chave Artificial
Sequence
Não reutilizar';
COMMENT ON COLUMN public.FT_COMPRA.SK_PRODUTO IS 'Chave Artificial
Sequence
Não reutilizar';
COMMENT ON COLUMN public.FT_COMPRA.SK_FORNECEDOR IS 'Chave Artificial
Sequence
Não reutilizar';
COMMENT ON COLUMN public.FT_COMPRA.COD_TRANS_DD IS 'Código da compra';


CREATE SEQUENCE public.dim_cliente_sk_cliente_seq;

CREATE TABLE public.DIM_CLIENTE (
                SK_CLIENTE INTEGER NOT NULL DEFAULT nextval('public.dim_cliente_sk_cliente_seq'),
                NK_CLIENTE INTEGER NOT NULL,
                NM_CLIENTE VARCHAR(100) NOT NULL,
                ETL_DATA_IN TIMESTAMP,
                ETL_DATA_FIM TIMESTAMP,
                ETL_VERSAO INTEGER,
                DT_CARGA TIMESTAMP,
                CONSTRAINT dim_cliente_pk PRIMARY KEY (SK_CLIENTE)
);
COMMENT ON TABLE public.DIM_CLIENTE IS 'DIMENSAO PARA CADASTRO DOS CLIENTES';
COMMENT ON COLUMN public.DIM_CLIENTE.SK_CLIENTE IS 'Chave Artificial
Sequence
Não reutilizar';
COMMENT ON COLUMN public.DIM_CLIENTE.NK_CLIENTE IS 'É o Código do cliente';
COMMENT ON COLUMN public.DIM_CLIENTE.NM_CLIENTE IS 'Nome completo';
COMMENT ON COLUMN public.DIM_CLIENTE.ETL_DATA_IN IS 'Nesta dimensão nenhum atributo é do tipo SCD tipo2.';
COMMENT ON COLUMN public.DIM_CLIENTE.ETL_DATA_FIM IS 'Nesta dimensão nenhum atributo é do tipo SCD tipo2.';


ALTER SEQUENCE public.dim_cliente_sk_cliente_seq OWNED BY public.DIM_CLIENTE.SK_CLIENTE;

CREATE TABLE public.FT_VENDA (
                SK_PRODUTO INTEGER NOT NULL,
                SK_VENDEDOR INTEGER NOT NULL,
                SK_CLIENTE INTEGER NOT NULL,
                SK_DATA INTEGER NOT NULL,
                SK_META_VENDA INTEGER NOT NULL,
                SK_FORMA_PGTO_RECEBIDO INTEGER NOT NULL,
                TIPO_VENDA_DD VARCHAR(60) NOT NULL,
                COD_TRANS_DD INTEGER NOT NULL,
                QTDE_ITENS_VENDA INTEGER NOT NULL,
                VL_DESCONTO_DERIVADA NUMERIC(18,2) NOT NULL,
                VL_VENDA_AVISTA NUMERIC(18,2) NOT NULL,
                VL_VENDA_PARCELADO NUMERIC(18,2) NOT NULL,
                VL_VENDA_A_VISTA_CART_DEB NUMERIC(18,2) NOT NULL,
                VL_VENDA_A_VISTA_CART_CRED NUMERIC(18,2) NOT NULL,
                VL_VENDA_A_PRAZO_CART_CRED NUMERIC(18,2) NOT NULL,
                DT_CARGA TIMESTAMP NOT NULL
);
COMMENT ON TABLE public.FT_VENDA IS 'Não está sendo ultilizada PK na FATO';
COMMENT ON COLUMN public.FT_VENDA.SK_CLIENTE IS 'Chave Artificial
Sequence
Não reutilizar';
COMMENT ON COLUMN public.FT_VENDA.SK_META_VENDA IS 'Chave Artifical auto incremental';
COMMENT ON COLUMN public.FT_VENDA.SK_FORMA_PGTO_RECEBIDO IS 'Chave artificial auto incremental';
COMMENT ON COLUMN public.FT_VENDA.TIPO_VENDA_DD IS 'É para identificar se a venda foi:
1. FISCAL
2. NAO FISCAL
Origem: TABELA > VENDAMESTRE
        COLUNA > REFERENCIA + HISTORICO';
COMMENT ON COLUMN public.FT_VENDA.COD_TRANS_DD IS 'Código da venda';
COMMENT ON COLUMN public.FT_VENDA.QTDE_ITENS_VENDA IS 'Quantidade de itens por venda realizada. COUNT.';
COMMENT ON COLUMN public.FT_VENDA.VL_DESCONTO_DERIVADA IS 'Valor de desconto por Produto.
OBS: Não considerar para análise, pois o Desconto é dado por VENDA, no case em Tela.';
COMMENT ON COLUMN public.FT_VENDA.VL_VENDA_AVISTA IS 'Valor da Venda pago A Vista. Este Campo será calculado nas condições: Se as COLUNAS: PARCELADO;A_VISTA_CART_DEB; A_VISTA_CART_CRED; A_PRAZO_CART_CRED For IGUAL a 0, ENTÃO este Atributo receberá o Valor Referente ao Cálculo: SUBTOTAL-DESCONTO.';
COMMENT ON COLUMN public.FT_VENDA.VL_VENDA_PARCELADO IS 'Valor da Venda pago A Prazo';
COMMENT ON COLUMN public.FT_VENDA.VL_VENDA_A_VISTA_CART_DEB IS 'Valor da Venda pago A vista no Cartão de Debito';
COMMENT ON COLUMN public.FT_VENDA.VL_VENDA_A_VISTA_CART_CRED IS 'Valor da Venda pago A vista no Cartão de Credito';
COMMENT ON COLUMN public.FT_VENDA.VL_VENDA_A_PRAZO_CART_CRED IS 'Valor da Venda pago A Prazo no Cartão de Credito';

-- Abaixo está a inclusão de chaves SK nas Tabelas FATO

ALTER TABLE public.DIM_FORMA_PGTO_CLIENTE ADD CONSTRAINT snow_flake_operador_cartao_dim_forma_pgto_cliente_fk
FOREIGN KEY (SK_OPERADOR_CARTAO)
REFERENCES public.SNOW_FLAKE_OPERADOR_CARTAO (SK_OPERADOR_CARTAO)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_COMPRA ADD CONSTRAINT dim_forma_pgto_fornecedor_ft_compra_fk
FOREIGN KEY (SK_FORMA_PGTO_REALIZADO)
REFERENCES public.DIM_FORMA_PGTO_FORNECEDOR (SK_FORMA_PGTO_REALIZADO)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_VENDA ADD CONSTRAINT dim_forma_pgto_cliente_ft_venda_fk
FOREIGN KEY (SK_FORMA_PGTO_RECEBIDO)
REFERENCES public.DIM_FORMA_PGTO_CLIENTE (SK_FORMA_PGTO_RECEBIDO)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_VENDAS_NAO_REALIZADAS ADD CONSTRAINT dim_concorrente_ft_vendas_nao_realizadas_fk
FOREIGN KEY (SK_CONCORRENTE)
REFERENCES public.DIM_CONCORRENTE (SK_CONCORRENTE)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_VENDAS_NAO_REALIZADAS ADD CONSTRAINT dim_prod_fora_mix_ft_vendas_nao_realizadas_fk
FOREIGN KEY (SK_PROD_FORA_MIX)
REFERENCES public.DIM_PROD_FORA_MIX (SK_PROD_FORA_MIX)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_VENDAS_NAO_REALIZADAS ADD CONSTRAINT dim_meta_ft_vendas_nao_realizadas_fk
FOREIGN KEY (SK_META_VENDA)
REFERENCES public.DIM_META (SK_META_VENDA)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_VENDA ADD CONSTRAINT dim_meta_ft_venda_fk
FOREIGN KEY (SK_META_VENDA)
REFERENCES public.DIM_META (SK_META_VENDA)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_COMPRA ADD CONSTRAINT dim_fornecedor_ft_compra_fk
FOREIGN KEY (SK_FORNECEDOR)
REFERENCES public.DIM_FORNECEDOR (SK_FORNECEDOR)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_VENDA ADD CONSTRAINT dim_data_ft_venda_fk
FOREIGN KEY (SK_DATA)
REFERENCES public.DIM_DATA (SK_DATA)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_COMPRA ADD CONSTRAINT dim_data_ft_compra_fk
FOREIGN KEY (SK_DATA)
REFERENCES public.DIM_DATA (SK_DATA)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_ESTOQUE_SNAPSHOT_PERIODICO ADD CONSTRAINT dim_data_ft_estoque_snapshot_periodico_fk
FOREIGN KEY (SK_DATA)
REFERENCES public.DIM_DATA (SK_DATA)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_VENDAS_NAO_REALIZADAS ADD CONSTRAINT dim_data_ft_vendas_nao_realizadas_fk
FOREIGN KEY (SK_DATA)
REFERENCES public.DIM_DATA (SK_DATA)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_VENDA ADD CONSTRAINT dim_vendedor_ft_venda_fk
FOREIGN KEY (SK_VENDEDOR)
REFERENCES public.DIM_VENDEDOR (SK_VENDEDOR)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_VENDA ADD CONSTRAINT dim_produto_ft_venda_fk
FOREIGN KEY (SK_PRODUTO)
REFERENCES public.DIM_PRODUTO (SK_PRODUTO)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_COMPRA ADD CONSTRAINT dim_produto_ft_compra_fk
FOREIGN KEY (SK_PRODUTO)
REFERENCES public.DIM_PRODUTO (SK_PRODUTO)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_ESTOQUE_SNAPSHOT_PERIODICO ADD CONSTRAINT dim_produto_ft_estoque_snapshot_periodico_fk
FOREIGN KEY (SK_PRODUTO)
REFERENCES public.DIM_PRODUTO (SK_PRODUTO)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.FT_VENDA ADD CONSTRAINT dim_cliente_ft_venda_fk
FOREIGN KEY (SK_CLIENTE)
REFERENCES public.DIM_CLIENTE (SK_CLIENTE)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;