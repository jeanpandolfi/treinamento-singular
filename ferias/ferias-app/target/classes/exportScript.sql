
    CREATE ALIAS dateDiffInDays FOR "org.opensingular.lib.support.persistence.util.H2Functions.dateDiffInDays";
INSERT INTO DBSINGULAR.TB_MODULO (CO_MODULO, NO_MODULO, URL_CONEXAO)  VALUES
(
'FERIAS',
'FERIAS',
'https://localhost:8443/'
);


insert into dbsingular.tb_parametro (CO_PARAMETRO, CO_MODULO, NO_PARAMETRO, VL_PARAMETRO) values (1 ,'FERIAS','ADMIN_HASH_PASSWORD','0aca995b93addee9348dcef9016c0f9624dfae3a');
insert into dbsingular.tb_parametro (CO_PARAMETRO, CO_MODULO, NO_PARAMETRO, VL_PARAMETRO) values (2, 'FERIAS','ADMIN_USERNAME','singular');
/*Esse Script é um default, provavelmente deverá ser alterado para suportar o ator especifico do cliente.*/

/*==============================================================*/
/* Table: TB_ATOR                                               */
/*==============================================================*/
CREATE TABLE DBSINGULAR.TB_ATOR (
   CO_ATOR  INTEGER NOT NULL,
   CO_USUARIO           VARCHAR(60)          NOT NULL,
  CONSTRAINT PK_ATOR PRIMARY KEY (CO_ATOR)
);

/*==============================================================*/
/* View: VW_ATOR                                    */
/*==============================================================*/
create view DBSINGULAR.VW_ATOR AS
SELECT A.CO_ATOR, A.CO_USUARIO as CO_USUARIO, A.CO_USUARIO as NO_ATOR, ' ' as DS_EMAIL
FROM DBSINGULAR.TB_ATOR A;


--Favor alterar para IDENTITY caso o banco não suporte SEQUENCE.
CREATE SEQUENCE DBSINGULAR.SQ_CO_ATOR  START WITH 1 INCREMENT BY 1;


    create table DBSINGULAR.RL_HIST_CONT_REQ_VER_ANOTACAO (
        CO_HISTORICO number(19,0) not null,
        CO_VERSAO_ANOTACAO number(19,0) not null
    ); 

    create table DBSINGULAR.RL_PAPEL_TAREFA (
        CO_PAPEL_TAREFA number(10,0) not null,
        CO_DEFINICAO_PAPEL number(10,0) not null,
        CO_DEFINICAO_TAREFA number(10,0) not null,
        primary key (CO_PAPEL_TAREFA)
    ); 

    create table DBSINGULAR.RL_PERMISSAO_PROCESSO (
        CO_DEFINICAO_PROCESSO number(19,0) not null,
        TP_PERMISSAO char(1 char) not null,
        primary key (CO_DEFINICAO_PROCESSO, TP_PERMISSAO),
        check (TP_PERMISSAO IN ('A', 'I', 'C', 'R'))
    ); 

    create table DBSINGULAR.RL_PERMISSAO_TAREFA (
        CO_PERMISSAO_TAREFA number(10,0) not null,
        CO_PERMISSAO varchar2(500 char) not null,
        CO_DEFINICAO_TAREFA number(10,0) not null,
        primary key (CO_PERMISSAO_TAREFA)
    ); 

    create table DBSINGULAR.TB_ANEXO_FORMULARIO (
        CO_ARQUIVO number(19,0) not null,
        CO_VERSAO_FORMULARIO number(19,0) not null,
        primary key (CO_ARQUIVO, CO_VERSAO_FORMULARIO)
    ); 

    create table DBSINGULAR.TB_ANOTACAO_FORMULARIO (
        CO_CHAVE_ANOTACAO varchar2(200 char) not null,
        CO_VERSAO_FORMULARIO number(19,0) not null,
        CO_VERSAO_ANOTACAO_ATUAL number(19,0),
        primary key (CO_CHAVE_ANOTACAO, CO_VERSAO_FORMULARIO)
    ); 

    create table DBSINGULAR.TB_ARQUIVO (
        CO_ARQUIVO number(19,0) not null,
        CO_CONTEUDO_ARQUIVO number(19,0) not null,
        DT_CRIACAO timestamp not null,
        TX_SHA1 varchar2(40 char) not null,
        NO_ARQUIVO varchar2(200 char) not null,
        NU_BYTES number(19,0) not null,
        primary key (CO_ARQUIVO)
    ); 

    create table DBSINGULAR.TB_CACHE_CAMPO (
        CO_CACHE_CAMPO number(19,0) not null,
        DS_CAMINHO_CAMPO varchar2(255 char),
        CO_TIPO_FORMULARIO number(19,0),
        primary key (CO_CACHE_CAMPO)
    ); 

    create table DBSINGULAR.TB_CACHE_VALOR (
        CO_CACHE_VALOR number(19,0) not null,
        DT_VALOR timestamp,
        NU_VALOR number(19,2),
        DS_VALOR varchar2(1024 char),
        CO_CACHE_CAMPO number(19,0),
        CO_VERSAO_FORMULARIO number(19,0),
        CO_PARENT number(19,0),
        primary key (CO_CACHE_VALOR)
    ); 

    create table DBSINGULAR.TB_CAIXA (
        CO_CAIXA number(19,0) not null,
        DS_CAIXA varchar2(500 char),
        NO_ICONE varchar2(100 char) not null,
        NO_CAIXA varchar2(100 char) not null,
        CO_MODULO varchar2(30 char) not null,
        primary key (CO_CAIXA)
    ); 

    create table DBSINGULAR.TB_CATEGORIA (
        CO_CATEGORIA number(10,0) not null,
        NO_CATEGORIA varchar2(100 char) not null,
        primary key (CO_CATEGORIA)
    ); 

    create table DBSINGULAR.TB_CONTEUDO_ARQUIVO (
        CO_CONTEUDO_ARQUIVO number(19,0) not null,
        BL_CONTEUDO blob not null,
        TX_SHA1 varchar2(40 char) not null,
        DT_INCLUSAO timestamp not null,
        NU_BYTES number(19,0) not null,
        primary key (CO_CONTEUDO_ARQUIVO)
    ); 

    create table DBSINGULAR.TB_DEFINICAO_PAPEL (
        CO_DEFINICAO_PAPEL number(10,0) not null,
        SG_PAPEL varchar2(100 char) not null,
        NO_PAPEL varchar2(300 char) not null,
        CO_DEFINICAO_PROCESSO number(10,0) not null,
        primary key (CO_DEFINICAO_PAPEL)
    ); 

    create table DBSINGULAR.TB_DEFINICAO_PROCESSO (
        CO_DEFINICAO_PROCESSO number(10,0) not null,
        NO_CLASSE_JAVA varchar2(500 char) not null,
        SG_PROCESSO varchar2(200 char) not null,
        NO_PROCESSO varchar2(200 char) not null,
        CO_CATEGORIA number(10,0),
        CO_MODULO varchar2(30 char) not null,
        primary key (CO_DEFINICAO_PROCESSO)
    ); 

    create table DBSINGULAR.TB_DEFINICAO_REQUISICAO (
        CO_DEFINICAO_REQUISICAO number(19,0) not null,
        NO_DEFINICAO_REQUISICAO varchar2(300 char) not null,
        CO_TIPO_FORMULARIO number(19,0) not null,
        CO_MODULO varchar2(30 char) not null,
        primary key (CO_DEFINICAO_REQUISICAO)
    ); 

    create table DBSINGULAR.TB_DEFINICAO_TAREFA (
        CO_DEFINICAO_TAREFA number(10,0) not null,
        SG_TAREFA varchar2(100 char) not null,
        TP_ESTRATEGIA_SEGURANCA varchar2(1 char),
        CO_DEFINICAO_PROCESSO number(10,0) not null,
        primary key (CO_DEFINICAO_TAREFA),
        check (TP_ESTRATEGIA_SEGURANCA IS NULL OR (TP_ESTRATEGIA_SEGURANCA IN ('D','E')))
    ); 

    create table DBSINGULAR.TB_DESTINATARIO_EMAIL (
        CO_DESTINATARIO_EMAIL number(19,0) not null,
        TX_ENDERECO varchar2(100 char) not null,
        TP_ENVIO varchar2(3 char) not null,
        DT_ENVIO timestamp,
        CO_EMAIL number(19,0) not null,
        primary key (CO_DESTINATARIO_EMAIL),
        check (TP_ENVIO IN ('To','Cc','Bcc'))
    ); 

    create table DBSINGULAR.TB_EMAIL (
        CO_EMAIL number(19,0) not null,
        TX_CONTEUDO clob not null,
        DT_CRIACAO timestamp not null,
        TX_RESPONDER_PARA varchar2(200 char),
        TX_ASSUNTO varchar2(200 char) not null,
        primary key (CO_EMAIL)
    ); 

    create table DBSINGULAR.TB_EMAIL_ARQUIVO (
        CO_EMAIL number(19,0) not null,
        CO_ARQUIVO number(19,0) not null
    ); 

    create table DBSINGULAR.TB_FORMULARIO (
        CO_FORMULARIO number(19,0) not null,
        CO_VERSAO_ATUAL number(19,0),
        CO_TIPO_FORMULARIO number(19,0) not null,
        primary key (CO_FORMULARIO)
    ); 

    create table DBSINGULAR.TB_FORMULARIO_REQUISICAO (
        CO_FORMULARIO_REQUISICAO number(19,0) not null,
        ST_FORM_PRINCIPAL varchar2(1 char) not null,
        CO_RASCUNHO_ATUAL number(19,0),
        CO_FORMULARIO number(19,0),
        CO_REQUISICAO number(19,0) not null,
        CO_DEFINICAO_TAREFA number(10,0),
        primary key (CO_FORMULARIO_REQUISICAO),
        check (ST_FORM_PRINCIPAL IN ('S','N'))
    ); 

    create table DBSINGULAR.TB_FUNCIONALIDADE_REQUISICAO (
        CO_FUNCIONALIDADE varchar2(300 char) not null,
        CO_MODULO_SINGULAR varchar2(50 char) not null,
        CO_PERMISSAO varchar2(50 char) not null,
        primary key (CO_FUNCIONALIDADE, CO_MODULO_SINGULAR, CO_PERMISSAO)
    ); 

    create table DBSINGULAR.TB_HISTORICO_CONTEUDO_REQUISIC (
        CO_HISTORICO number(19,0) not null,
        DT_HISTORICO timestamp not null,
        CO_AUTOR number(10,0),
        CO_REQUISITANTE number(19,0),
        CO_REQUISICAO number(19,0) not null,
        CO_INSTANCIA_TAREFA number(10,0),
        primary key (CO_HISTORICO)
    ); 

    create table DBSINGULAR.TB_HISTORICO_INSTANCIA_TAREFA (
        CO_HISTORICO_ALOCACAO number(10,0) not null,
        DT_INICIO_ALOCACAO timestamp not null,
        DS_COMPLEMENTO long,
        DT_FIM_ALOCACAO timestamp,
        CO_ATOR_ALOCADO number(10,0),
        CO_ATOR_ALOCADOR number(10,0),
        CO_INSTANCIA_TAREFA number(10,0) not null,
        CO_TIPO_HISTORICO_TAREFA number(10,0) not null,
        primary key (CO_HISTORICO_ALOCACAO)
    ); 

    create table DBSINGULAR.TB_HISTORICO_VERSAO_FORMULARIO (
        CO_VERSAO_FORMULARIO number(19,0) not null,
        CO_HISTORICO number(19,0) not null,
        ST_FORM_PRINCIPAL varchar2(1 char) not null,
        primary key (CO_VERSAO_FORMULARIO, CO_HISTORICO)
    ); 

    create table DBSINGULAR.TB_INSTANCIA_PAPEL (
        CO_INSTANCIA_PAPEL number(10,0) not null,
        DT_CRIACAO timestamp not null,
        CO_ATOR_ALOCADOR number(10,0),
        CO_INSTANCIA_PROCESSO number(10,0) not null,
        CO_DEFINICAO_PAPEL number(10,0) not null,
        CO_ATOR number(10,0) not null,
        primary key (CO_INSTANCIA_PAPEL)
    ); 

    create table DBSINGULAR.TB_INSTANCIA_PROCESSO (
        CO_INSTANCIA_PROCESSO number(10,0) not null,
        DT_INICIO timestamp not null,
        DS_INSTANCIA_PROCESSO varchar2(300 char),
        DT_FIM timestamp,
        CO_VERSAO_PROCESSO number(10,0) not null,
        CO_INSTANCIA_TAREFA_PAI number(10,0),
        CO_ATOR_CRIADOR number(10,0),
        primary key (CO_INSTANCIA_PROCESSO)
    ); 

    create table DBSINGULAR.TB_INSTANCIA_TAREFA (
        CO_INSTANCIA_TAREFA number(10,0) not null,
        DT_INICIO timestamp not null,
        DT_FIM timestamp,
        DT_ESPERADA_FIM timestamp,
        NU_VERSAO number(10,0),
        CO_ATOR_ALOCADO number(10,0),
        CO_VERSAO_TRANSICAO_EXECUTADA number(10,0),
        CO_INSTANCIA_PROCESSO number(10,0) not null,
        CO_ATOR_CONCLUSAO number(10,0),
        CO_VERSAO_TAREFA number(10,0) not null,
        primary key (CO_INSTANCIA_TAREFA)
    ); 

    create table DBSINGULAR.TB_MODULO (
        CO_MODULO varchar2(30 char) not null,
        URL_CONEXAO varchar2(300 char) not null,
        NO_MODULO varchar2(100 char) not null,
        primary key (CO_MODULO)
    ); 

    create table DBSINGULAR.TB_PARAMETRO (
        CO_PARAMETRO number(19,0) not null,
        NO_PARAMETRO varchar2(100 char) not null,
        VL_PARAMETRO varchar2(1000 char) not null,
        CO_MODULO varchar2(30 char) not null,
        primary key (CO_PARAMETRO)
    ); 

    create table DBSINGULAR.TB_RASCUNHO (
        CO_RASCUNHO number(19,0) not null,
        DT_EDICAO timestamp not null,
        DT_INICIO timestamp not null,
        CO_FORMULARIO number(19,0) not null,
        primary key (CO_RASCUNHO)
    ); 

    create table DBSINGULAR.TB_REQUISICAO (
        CO_REQUISICAO number(19,0) not null,
        DS_REQUISICAO varchar2(200 char),
        CO_REQUISITANTE number(19,0),
        CO_DEFINICAO_PROCESSO number(10,0),
        CO_INSTANCIA_PROCESSO number(10,0),
        CO_REQUISICAO_PAI number(19,0),
        CO_DEFINICAO_REQUISICAO number(19,0) not null,
        CO_REQUISICAO_RAIZ number(19,0),
        primary key (CO_REQUISICAO)
    ); 

    create table DBSINGULAR.TB_REQUISITANTE (
        CO_REQUISITANTE number(19,0) not null,
        NU_CPF_CNPJ varchar2(14 char),
        ID_PESSOA varchar2(200 char) not null,
        DS_NOME varchar2(200 char) not null,
        TP_PESSOA varchar2(1 char) default 'J' not null,
        primary key (CO_REQUISITANTE),
        check (TP_PESSOA IN ('J','F'))
    ); 

    create table DBSINGULAR.TB_TIPO_FORMULARIO (
        CO_TIPO_FORMULARIO number(19,0) not null,
        SG_TIPO_FORMULARIO varchar2(200 char) not null,
        NU_VERSAO_CACHE number(19,0) not null,
        NO_LABEL_FORMULARIO varchar2(200 char),
        primary key (CO_TIPO_FORMULARIO)
    ); 

    create table DBSINGULAR.TB_TIPO_HISTORICO_TAREFA (
        CO_TIPO_HISTORICO_TAREFA number(10,0) not null,
        DS_TIPO_HISTORICO_TAREFA varchar2(100 char) not null,
        primary key (CO_TIPO_HISTORICO_TAREFA)
    ); 

    create table DBSINGULAR.TB_TIPO_VARIAVEL (
        CO_TIPO_VARIAVEL number(10,0) not null,
        DS_TIPO_VARIAVEL varchar2(100 char) not null,
        NO_CLASSE_JAVA varchar2(300 char) not null,
        primary key (CO_TIPO_VARIAVEL)
    ); 

    create table DBSINGULAR.TB_VARIAVEL (
        CO_VARIAVEL number(10,0) not null,
        NO_VARIAVEL varchar2(100 char) not null,
        VL_VARIAVEL clob,
        CO_INSTANCIA_PROCESSO number(10,0) not null,
        CO_TIPO_VARIAVEL number(10,0) not null,
        primary key (CO_VARIAVEL)
    ); 

    create table DBSINGULAR.TB_VARIAVEL_EXECUCAO_TRANSICAO (
        CO_VARIAVEL_EXECUCAO_TRANSICAO number(10,0) not null,
        DT_HISTORICO timestamp not null,
        NO_VARIAVEL varchar2(100 char) not null,
        VL_NOVO long,
        CO_INSTANCIA_TAREFA_DESTINO number(10,0) not null,
        CO_INSTANCIA_PROCESSO number(10,0) not null,
        CO_INSTANCIA_TAREFA_ORIGEM number(10,0) not null,
        CO_TIPO_VARIAVEL number(10,0) not null,
        CO_VARIAVEL number(10,0),
        primary key (CO_VARIAVEL_EXECUCAO_TRANSICAO)
    ); 

    create table DBSINGULAR.TB_VERSAO_ANOTACAO_FORMULARIO (
        CO_VERSAO_ANOTACAO number(19,0) not null,
        CO_AUTOR_INCLUSAO number(10,0),
        DT_INCLUSAO timestamp not null,
        XML_ANOTACAO clob not null,
        CO_CHAVE_ANOTACAO varchar2(200 char) not null,
        CO_VERSAO_FORMULARIO number(19,0) not null,
        primary key (CO_VERSAO_ANOTACAO)
    ); 

    create table DBSINGULAR.TB_VERSAO_FORMULARIO (
        CO_VERSAO_FORMULARIO number(19,0) not null,
        NU_VERSAO_CACHE number(19,0),
        CO_AUTOR_INCLUSAO number(10,0),
        DT_INCLUSAO timestamp not null,
        ST_INDEXADO char(1 char),
        XML_CONTEUDO clob not null,
        CO_FORMULARIO number(19,0) not null,
        primary key (CO_VERSAO_FORMULARIO)
    ); 

    create table DBSINGULAR.TB_VERSAO_PROCESSO (
        CO_VERSAO_PROCESSO number(10,0) not null,
        DT_VERSAO timestamp not null,
        CO_DEFINICAO_PROCESSO number(10,0) not null,
        primary key (CO_VERSAO_PROCESSO)
    ); 

    create table DBSINGULAR.TB_VERSAO_TAREFA (
        CO_VERSAO_TAREFA number(10,0) not null,
        NO_TAREFA varchar2(300 char) not null,
        CO_TIPO_TAREFA number(10,0) not null,
        CO_VERSAO_PROCESSO number(10,0) not null,
        CO_DEFINICAO_TAREFA number(10,0) not null,
        primary key (CO_VERSAO_TAREFA)
    ); 

    create table DBSINGULAR.TB_VERSAO_TRANSICAO (
        CO_VERSAO_TRANSICAO number(10,0) not null,
        SG_TRANSICAO varchar2(100 char) not null,
        NO_TRANSICAO varchar2(300 char) not null,
        TP_TRANSICAO varchar2(1 char) default 'E' not null,
        CO_VERSAO_TAREFA_DESTINO number(10,0) not null,
        CO_VERSAO_TAREFA_ORIGEM number(10,0) not null,
        primary key (CO_VERSAO_TRANSICAO)
    ); 

    alter table DBSINGULAR.RL_HIST_CONT_REQ_VER_ANOTACAO 
        add constraint UK_HIST_CONT_REQ_VER_ANOT unique (CO_VERSAO_ANOTACAO, CO_HISTORICO); 

    create index IX_CLASSE_DEFINICAO on DBSINGULAR.TB_DEFINICAO_PROCESSO (NO_CLASSE_JAVA asc); 

    create index TB_DEFINICAO_REQUISICAO on DBSINGULAR.TB_DEFINICAO_REQUISICAO (CO_MODULO asc, NO_DEFINICAO_REQUISICAO asc); 

    alter table DBSINGULAR.TB_EMAIL_ARQUIVO 
        add constraint UK_EMAIL_ARQUIVO unique (CO_ARQUIVO); 

    create index IX_FORMULARIO_PRINCIPAL on DBSINGULAR.TB_FORMULARIO_REQUISICAO (ST_FORM_PRINCIPAL asc, CO_REQUISICAO asc); 

    create index IX_HISTORICO_INSTANCIA_TAREFA on DBSINGULAR.TB_HISTORICO_INSTANCIA_TAREFA (CO_INSTANCIA_TAREFA asc, DT_INICIO_ALOCACAO asc); 

    create index IX_INSTANCIA_PROCESSO on DBSINGULAR.TB_INSTANCIA_PROCESSO (CO_VERSAO_PROCESSO asc, DT_INICIO asc); 

    create index IX_GRUPO_NOME on DBSINGULAR.TB_MODULO (NO_MODULO asc); 

    create index IX_GRUPO_CONEXAO on DBSINGULAR.TB_MODULO (URL_CONEXAO asc); 

    create index IX_PARAMETRO on DBSINGULAR.TB_PARAMETRO (CO_MODULO asc, NO_PARAMETRO asc); 

    create index IX_TIPO_FORMULARIO on DBSINGULAR.TB_TIPO_FORMULARIO (SG_TIPO_FORMULARIO asc); 

    create index IX_PROCESSO on DBSINGULAR.TB_VERSAO_PROCESSO (CO_DEFINICAO_PROCESSO asc, DT_VERSAO asc); 

    alter table DBSINGULAR.RL_HIST_CONT_REQ_VER_ANOTACAO 
        add constraint FK_VER_ANOTACAO_HIST_CONT_REQ 
        foreign key (CO_VERSAO_ANOTACAO) 
        references DBSINGULAR.TB_VERSAO_ANOTACAO_FORMULARIO; 

    alter table DBSINGULAR.RL_HIST_CONT_REQ_VER_ANOTACAO 
        add constraint FK_HIST_CONT_REQ_VER_ANOTACAO 
        foreign key (CO_HISTORICO) 
        references DBSINGULAR.TB_HISTORICO_CONTEUDO_REQUISIC; 

    alter table DBSINGULAR.RL_PAPEL_TAREFA 
        add constraint FK_PPL_TAR_DEFINICAO_PAPEL 
        foreign key (CO_DEFINICAO_PAPEL) 
        references DBSINGULAR.TB_DEFINICAO_PAPEL; 

    alter table DBSINGULAR.RL_PAPEL_TAREFA 
        add constraint FK_PPL_TAR_DEFINICAO_TAREFA 
        foreign key (CO_DEFINICAO_TAREFA) 
        references DBSINGULAR.TB_DEFINICAO_TAREFA; 

    alter table DBSINGULAR.RL_PERMISSAO_PROCESSO 
        add constraint FK_PERM_PROCES_DEFI_PROCES 
        foreign key (CO_DEFINICAO_PROCESSO) 
        references DBSINGULAR.TB_DEFINICAO_PROCESSO; 

    alter table DBSINGULAR.RL_PERMISSAO_TAREFA 
        add constraint FK_PERM_TAR_DEFINICAO_TAREFA 
        foreign key (CO_DEFINICAO_TAREFA) 
        references DBSINGULAR.TB_DEFINICAO_TAREFA; 

    alter table DBSINGULAR.TB_ANEXO_FORMULARIO 
        add constraint FK_ANX_FORM_CO_ARQUIVO 
        foreign key (CO_ARQUIVO) 
        references DBSINGULAR.TB_ARQUIVO; 

    alter table DBSINGULAR.TB_ANEXO_FORMULARIO 
        add constraint FK_ANX_FORM_VERSAO_FORMULARIO 
        foreign key (CO_VERSAO_FORMULARIO) 
        references DBSINGULAR.TB_VERSAO_FORMULARIO; 

    alter table DBSINGULAR.TB_ANOTACAO_FORMULARIO 
        add constraint FK_ANOT_FORM_VERSAO_FORMULARIO 
        foreign key (CO_VERSAO_FORMULARIO) 
        references DBSINGULAR.TB_VERSAO_FORMULARIO; 

    alter table DBSINGULAR.TB_ANOTACAO_FORMULARIO 
        add constraint FK_ANOT_FORM_VER_ANOT_ATUAL 
        foreign key (CO_VERSAO_ANOTACAO_ATUAL) 
        references DBSINGULAR.TB_VERSAO_ANOTACAO_FORMULARIO; 

    alter table DBSINGULAR.TB_CACHE_CAMPO 
        add constraint FK_CACHE_CAMPO_TIPO_FORMULARIO 
        foreign key (CO_TIPO_FORMULARIO) 
        references DBSINGULAR.TB_TIPO_FORMULARIO; 

    alter table DBSINGULAR.TB_CACHE_VALOR 
        add constraint FK_CACHE_VALOR_CACHE_CAMPO 
        foreign key (CO_CACHE_CAMPO) 
        references DBSINGULAR.TB_CACHE_CAMPO; 

    alter table DBSINGULAR.TB_CACHE_VALOR 
        add constraint FK_CACHE_VAL_VERSAO_FORMULARIO 
        foreign key (CO_VERSAO_FORMULARIO) 
        references DBSINGULAR.TB_VERSAO_FORMULARIO; 

    alter table DBSINGULAR.TB_CACHE_VALOR 
        add constraint FK_CACHE_VALOR_CO_PARENT 
        foreign key (CO_PARENT) 
        references DBSINGULAR.TB_CACHE_VALOR; 

    alter table DBSINGULAR.TB_CAIXA 
        add constraint FK_CAIXA_CO_MODULO 
        foreign key (CO_MODULO) 
        references DBSINGULAR.TB_MODULO; 

    alter table DBSINGULAR.TB_DEFINICAO_PAPEL 
        add constraint FK_DEFI_PPL_DEFINICAO_PROCESSO 
        foreign key (CO_DEFINICAO_PROCESSO) 
        references DBSINGULAR.TB_DEFINICAO_PROCESSO; 

    alter table DBSINGULAR.TB_DEFINICAO_PROCESSO 
        add constraint FK_DEFIN_PROCES_CATEGORIA 
        foreign key (CO_CATEGORIA) 
        references DBSINGULAR.TB_CATEGORIA; 

    alter table DBSINGULAR.TB_DEFINICAO_PROCESSO 
        add constraint FK_DEFIN_PROCES_MODULO 
        foreign key (CO_MODULO) 
        references DBSINGULAR.TB_MODULO; 

    alter table DBSINGULAR.TB_DEFINICAO_REQUISICAO 
        add constraint FK_DEFI_REQ_TIPO_FORMULARIO 
        foreign key (CO_TIPO_FORMULARIO) 
        references DBSINGULAR.TB_TIPO_FORMULARIO; 

    alter table DBSINGULAR.TB_DEFINICAO_REQUISICAO 
        add constraint FK_DEFI_REQ_MODULO 
        foreign key (CO_MODULO) 
        references DBSINGULAR.TB_MODULO; 

    alter table DBSINGULAR.TB_DEFINICAO_TAREFA 
        add constraint FK_DEFI_TAR_DEFINICAO_PROCESSO 
        foreign key (CO_DEFINICAO_PROCESSO) 
        references DBSINGULAR.TB_DEFINICAO_PROCESSO; 

    alter table DBSINGULAR.TB_DESTINATARIO_EMAIL 
        add constraint FK_DESTINATARIO_EMAIL_CO_EMAIL 
        foreign key (CO_EMAIL) 
        references DBSINGULAR.TB_EMAIL; 

    alter table DBSINGULAR.TB_EMAIL_ARQUIVO 
        add constraint FK_EMAIL_ARQUIVO_ARQUIVO 
        foreign key (CO_ARQUIVO) 
        references DBSINGULAR.TB_ARQUIVO; 

    alter table DBSINGULAR.TB_EMAIL_ARQUIVO 
        add constraint FK_EMAIL_ARQUIVO_EMAIL 
        foreign key (CO_EMAIL) 
        references DBSINGULAR.TB_EMAIL; 

    alter table DBSINGULAR.TB_FORMULARIO 
        add constraint FK_FORMULARIO_VERSAO_ATUAL 
        foreign key (CO_VERSAO_ATUAL) 
        references DBSINGULAR.TB_VERSAO_FORMULARIO; 

    alter table DBSINGULAR.TB_FORMULARIO 
        add constraint FK_FORMULARIO_TIPO_FORMULARIO 
        foreign key (CO_TIPO_FORMULARIO) 
        references DBSINGULAR.TB_TIPO_FORMULARIO; 

    alter table DBSINGULAR.TB_FORMULARIO_REQUISICAO 
        add constraint FK_FORM_REQ_RASCUNHO_ATUAL 
        foreign key (CO_RASCUNHO_ATUAL) 
        references DBSINGULAR.TB_RASCUNHO; 

    alter table DBSINGULAR.TB_FORMULARIO_REQUISICAO 
        add constraint FK_FORM_REQ_FORMULARIO 
        foreign key (CO_FORMULARIO) 
        references DBSINGULAR.TB_FORMULARIO; 

    alter table DBSINGULAR.TB_FORMULARIO_REQUISICAO 
        add constraint FK_FORMO_REQ_REQUISICAO 
        foreign key (CO_REQUISICAO) 
        references DBSINGULAR.TB_REQUISICAO; 

    alter table DBSINGULAR.TB_FORMULARIO_REQUISICAO 
        add constraint FK_FORM_REQ_DEFINICAO_TAREFA 
        foreign key (CO_DEFINICAO_TAREFA) 
        references DBSINGULAR.TB_DEFINICAO_TAREFA; 

    alter table DBSINGULAR.TB_HISTORICO_CONTEUDO_REQUISIC 
        add constraint FK_HIST_CTD_REQ_REQUISITANTE 
        foreign key (CO_REQUISITANTE) 
        references DBSINGULAR.TB_REQUISITANTE; 

    alter table DBSINGULAR.TB_HISTORICO_CONTEUDO_REQUISIC 
        add constraint FK_HIST_CTD_REQ_REQ 
        foreign key (CO_REQUISICAO) 
        references DBSINGULAR.TB_REQUISICAO; 

    alter table DBSINGULAR.TB_HISTORICO_CONTEUDO_REQUISIC 
        add constraint FK_HIST_CTD_REQ_INSTANCIA_TRF 
        foreign key (CO_INSTANCIA_TAREFA) 
        references DBSINGULAR.TB_INSTANCIA_TAREFA; 

    alter table DBSINGULAR.TB_HISTORICO_INSTANCIA_TAREFA 
        add constraint FK_HIST_INST_TAR_INST_TAR 
        foreign key (CO_INSTANCIA_TAREFA) 
        references DBSINGULAR.TB_INSTANCIA_TAREFA; 

    alter table DBSINGULAR.TB_HISTORICO_INSTANCIA_TAREFA 
        add constraint FK_HIST_INST_TAR_TP_HIST_TAR 
        foreign key (CO_TIPO_HISTORICO_TAREFA) 
        references DBSINGULAR.TB_TIPO_HISTORICO_TAREFA; 

    alter table DBSINGULAR.TB_HISTORICO_VERSAO_FORMULARIO 
        add constraint FK_HIST_VER_FORM_VER_FORM 
        foreign key (CO_VERSAO_FORMULARIO) 
        references DBSINGULAR.TB_VERSAO_FORMULARIO; 

    alter table DBSINGULAR.TB_HISTORICO_VERSAO_FORMULARIO 
        add constraint FK_HIST_VER_FORM_HISTORICO 
        foreign key (CO_HISTORICO) 
        references DBSINGULAR.TB_HISTORICO_CONTEUDO_REQUISIC; 

    alter table DBSINGULAR.TB_INSTANCIA_PAPEL 
        add constraint FK_INST_PPL_INSTANCIA_PROCESSO 
        foreign key (CO_INSTANCIA_PROCESSO) 
        references DBSINGULAR.TB_INSTANCIA_PROCESSO; 

    alter table DBSINGULAR.TB_INSTANCIA_PAPEL 
        add constraint FK_INST_PPL_DEFINICAO_PAPEL 
        foreign key (CO_DEFINICAO_PAPEL) 
        references DBSINGULAR.TB_DEFINICAO_PAPEL; 

    alter table DBSINGULAR.TB_INSTANCIA_PROCESSO 
        add constraint FK_INST_PROCES_VERSAO_PROCESSO 
        foreign key (CO_VERSAO_PROCESSO) 
        references DBSINGULAR.TB_VERSAO_PROCESSO; 

    alter table DBSINGULAR.TB_INSTANCIA_PROCESSO 
        add constraint FK_INST_PROCES_INST_TAR_PAI 
        foreign key (CO_INSTANCIA_TAREFA_PAI) 
        references DBSINGULAR.TB_INSTANCIA_TAREFA; 

    alter table DBSINGULAR.TB_INSTANCIA_TAREFA 
        add constraint FK_INST_TAR_VER_TRAN_EXEC 
        foreign key (CO_VERSAO_TRANSICAO_EXECUTADA) 
        references DBSINGULAR.TB_VERSAO_TRANSICAO; 

    alter table DBSINGULAR.TB_INSTANCIA_TAREFA 
        add constraint FK_INST_TAR_PROCES_ATOR_CRIDR 
        foreign key (CO_INSTANCIA_PROCESSO) 
        references DBSINGULAR.TB_INSTANCIA_PROCESSO; 

    alter table DBSINGULAR.TB_INSTANCIA_TAREFA 
        add constraint FK_INST_TAR_VERSAO_TAREFA 
        foreign key (CO_VERSAO_TAREFA) 
        references DBSINGULAR.TB_VERSAO_TAREFA; 

    alter table DBSINGULAR.TB_PARAMETRO 
        add constraint FK_PARAMETRO_MODULO 
        foreign key (CO_MODULO) 
        references DBSINGULAR.TB_MODULO; 

    alter table DBSINGULAR.TB_RASCUNHO 
        add constraint FK_RASCUNHO_FORMULARIO 
        foreign key (CO_FORMULARIO) 
        references DBSINGULAR.TB_FORMULARIO; 

    alter table DBSINGULAR.TB_REQUISICAO 
        add constraint FK_REQ_REQUISITANTE 
        foreign key (CO_REQUISITANTE) 
        references DBSINGULAR.TB_REQUISITANTE; 

    alter table DBSINGULAR.TB_REQUISICAO 
        add constraint FK_REQ_DEFINICAO_PROCESSO 
        foreign key (CO_DEFINICAO_PROCESSO) 
        references DBSINGULAR.TB_DEFINICAO_PROCESSO; 

    alter table DBSINGULAR.TB_REQUISICAO 
        add constraint FK_REQ_INSTANCIA_PROCESSO 
        foreign key (CO_INSTANCIA_PROCESSO) 
        references DBSINGULAR.TB_INSTANCIA_PROCESSO; 

    alter table DBSINGULAR.TB_REQUISICAO 
        add constraint FK_REQ_REQUISICAO_PAI 
        foreign key (CO_REQUISICAO_PAI) 
        references DBSINGULAR.TB_REQUISICAO; 

    alter table DBSINGULAR.TB_REQUISICAO 
        add constraint FK_REQ_DEFINICAO_REQUISICAO 
        foreign key (CO_DEFINICAO_REQUISICAO) 
        references DBSINGULAR.TB_DEFINICAO_REQUISICAO; 

    alter table DBSINGULAR.TB_REQUISICAO 
        add constraint FK_REQ_REQUISICAO_RAIZ 
        foreign key (CO_REQUISICAO_RAIZ) 
        references DBSINGULAR.TB_REQUISICAO; 

    alter table DBSINGULAR.TB_VARIAVEL 
        add constraint FK_VARIAVEL_INSTANCIA_PROCESSO 
        foreign key (CO_INSTANCIA_PROCESSO) 
        references DBSINGULAR.TB_INSTANCIA_PROCESSO; 

    alter table DBSINGULAR.TB_VARIAVEL 
        add constraint FK_VARIAVEL_TIPO_VARIAVEL 
        foreign key (CO_TIPO_VARIAVEL) 
        references DBSINGULAR.TB_TIPO_VARIAVEL; 

    alter table DBSINGULAR.TB_VARIAVEL_EXECUCAO_TRANSICAO 
        add constraint FK_VAR_EXEC_TRANS_DEST 
        foreign key (CO_INSTANCIA_TAREFA_DESTINO) 
        references DBSINGULAR.TB_INSTANCIA_TAREFA; 

    alter table DBSINGULAR.TB_VARIAVEL_EXECUCAO_TRANSICAO 
        add constraint FK_VAR_EXEC_TRANS_INST_PROCES 
        foreign key (CO_INSTANCIA_PROCESSO) 
        references DBSINGULAR.TB_INSTANCIA_PROCESSO; 

    alter table DBSINGULAR.TB_VARIAVEL_EXECUCAO_TRANSICAO 
        add constraint FK_VAR_EXEC_TRANS_TAR_ORIGEM 
        foreign key (CO_INSTANCIA_TAREFA_ORIGEM) 
        references DBSINGULAR.TB_INSTANCIA_TAREFA; 

    alter table DBSINGULAR.TB_VARIAVEL_EXECUCAO_TRANSICAO 
        add constraint FK_VAR_EXEC_TRANS_TP_VAR 
        foreign key (CO_TIPO_VARIAVEL) 
        references DBSINGULAR.TB_TIPO_VARIAVEL; 

    alter table DBSINGULAR.TB_VARIAVEL_EXECUCAO_TRANSICAO 
        add constraint FK_VAR_EXEC_TRANS_VAR 
        foreign key (CO_VARIAVEL) 
        references DBSINGULAR.TB_VARIAVEL; 

    alter table DBSINGULAR.TB_VERSAO_ANOTACAO_FORMULARIO 
        add constraint FK_VER_ANOT_FORM_CHV_ANOT 
        foreign key (CO_CHAVE_ANOTACAO, CO_VERSAO_FORMULARIO) 
        references DBSINGULAR.TB_ANOTACAO_FORMULARIO; 

    alter table DBSINGULAR.TB_VERSAO_FORMULARIO 
        add constraint FK_VER_FORM_FORMULARIO 
        foreign key (CO_FORMULARIO) 
        references DBSINGULAR.TB_FORMULARIO; 

    alter table DBSINGULAR.TB_VERSAO_PROCESSO 
        add constraint FK_VER_PROCES_DEFI_PROCES 
        foreign key (CO_DEFINICAO_PROCESSO) 
        references DBSINGULAR.TB_DEFINICAO_PROCESSO; 

    alter table DBSINGULAR.TB_VERSAO_TAREFA 
        add constraint FK_VER_TAR_VERSAO_PROCESSO 
        foreign key (CO_VERSAO_PROCESSO) 
        references DBSINGULAR.TB_VERSAO_PROCESSO; 

    alter table DBSINGULAR.TB_VERSAO_TAREFA 
        add constraint FK_VER_TAR_DEFINICAO_TAREFA 
        foreign key (CO_DEFINICAO_TAREFA) 
        references DBSINGULAR.TB_DEFINICAO_TAREFA; 

    alter table DBSINGULAR.TB_VERSAO_TRANSICAO 
        add constraint FK_VER_TRANS_VER_TAR_DEST 
        foreign key (CO_VERSAO_TAREFA_DESTINO) 
        references DBSINGULAR.TB_VERSAO_TAREFA; 

    alter table DBSINGULAR.TB_VERSAO_TRANSICAO 
        add constraint FK_VER_TRANS_VER_TAR_ORIG 
        foreign key (CO_VERSAO_TAREFA_ORIGEM) 
        references DBSINGULAR.TB_VERSAO_TAREFA; 

    create sequence DBSINGULAR.SQ_CO_ARQUIVO; 

    create sequence DBSINGULAR.SQ_CO_CACHE_CAMPO; 

    create sequence DBSINGULAR.SQ_CO_CACHE_VALOR; 

    create sequence DBSINGULAR.SQ_CO_CAIXA; 

    create sequence DBSINGULAR.SQ_CO_CATEGORIA; 

    create sequence DBSINGULAR.SQ_CO_CONTEUDO_ARQUIVO; 

    create sequence DBSINGULAR.SQ_CO_DEFINICAO_PROCESSO; 

    create sequence DBSINGULAR.SQ_CO_DEFINICAO_REQUISICAO; 

    create sequence DBSINGULAR.SQ_CO_DEFINICAO_TAREFA; 

    create sequence DBSINGULAR.SQ_CO_DESTINATARIO_EMAIL; 

    create sequence DBSINGULAR.SQ_CO_EMAIL; 

    create sequence DBSINGULAR.SQ_CO_FORMULARIO; 

    create sequence DBSINGULAR.SQ_CO_FORMULARIO_REQUISICAO; 

    create sequence DBSINGULAR.SQ_CO_HISTORICO; 

    create sequence DBSINGULAR.SQ_CO_HISTORICO_ALOCACAO; 

    create sequence DBSINGULAR.SQ_CO_INSTANCIA_PAPEL; 

    create sequence DBSINGULAR.SQ_CO_INSTANCIA_PROCESSO; 

    create sequence DBSINGULAR.SQ_CO_INSTANCIA_TAREFA; 

    create sequence DBSINGULAR.SQ_CO_PAPEL; 

    create sequence DBSINGULAR.SQ_CO_PAPEL_TAREFA; 

    create sequence DBSINGULAR.SQ_CO_PARAMETRO; 

    create sequence DBSINGULAR.SQ_CO_PERMISSAO_TAREFA; 

    create sequence DBSINGULAR.SQ_CO_PROCESSO; 

    create sequence DBSINGULAR.SQ_CO_RASCUNHO; 

    create sequence DBSINGULAR.SQ_CO_REQUISICAO; 

    create sequence DBSINGULAR.SQ_CO_REQUISITANTE; 

    create sequence DBSINGULAR.SQ_CO_TAREFA; 

    create sequence DBSINGULAR.SQ_CO_TIPO_FORMULARIO; 

    create sequence DBSINGULAR.SQ_CO_TIPO_HISTORICO_TAREFA; 

    create sequence DBSINGULAR.SQ_CO_TIPO_VARIAVEL; 

    create sequence DBSINGULAR.SQ_CO_TRANSICAO; 

    create sequence DBSINGULAR.SQ_CO_VARIAVEL; 

    create sequence DBSINGULAR.SQ_CO_VERSAO_ANOTACAO; 

    create sequence DBSINGULAR.SQ_CO_VERSAO_FORMULARIO; 

    create sequence DBSINGULAR.SQ_VARIAVEL_EXECUCAO_TRANSICAO; 
