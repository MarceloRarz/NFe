create table configuracao (  
  cnpj varchar2(14),
  inscricaoestadual varchar2(20),
  razaosocial varchar(150),
  nomefantasia varchar2(150),
  dd varchar2(2),
  fone varchar2(9),
  cep varchar2(8),
  numero integer,
  logradouro varchar2(150),
  bairro varchar2(50),
  complemento varchar2(150),
  cidade varchar2(50),
  numeroserie varchar2(100),
  senhacertificado varchar2(10),
  uf varchar2(2),
  idcidade integer,
  ultimoNSU_CTE varchar2(20),
  ultimoNSU_NFE varchar2(20)
  ); 

create table nfe (
id number,
cnpj varchar2(14),
nsu varchar2(20),
serie varchar2(20),
numero varchar2(50),
razao_social varchar2(150),
inscricao_estadual varchar2(20),
tipo_nota varchar2(1),
chave varchar2(50),
data_emissao date,
data_consulta date,
data_download date,
situacao varchar2(1),
situacao_operacao varchar2(2),
dias_manifestacao number,
status integer
);
  
ALTER TABLE nfe ADD (
  CONSTRAINT nfe_pk PRIMARY KEY (ID));

CREATE SEQUENCE nfe_seq START WITH 1;  

create or replace
TRIGGER TR_NFe
BEFORE INSERT ON NFE 
FOR EACH ROW
declare 
  
BEGIN

    SELECT nfe_seq.Nextval
    INTO   :new.id
    FROM   dual;

END;  

create table cte (
id number,
chave varchar2(50),
data_emissao date,
data_consulta date,
situacao varchar2(1),
status integer
);  
  
  
ALTER TABLE cte ADD (
  CONSTRAINT cte_pk PRIMARY KEY (ID));

CREATE SEQUENCE cte_seq START WITH 1;  

create or replace
TRIGGER TR_CTe
BEFORE INSERT ON CTE 
FOR EACH ROW
declare 
  
BEGIN

    SELECT cte_seq.Nextval
    INTO   :new.id
    FROM   dual;

END;  

