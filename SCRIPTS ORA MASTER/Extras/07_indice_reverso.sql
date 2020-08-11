-- criar indice de chave reversa (nao funciona em bitmap ou IOT):
create index INDEX_NAME on TABELA(coluna) reverse;

-- alterar indice nao reverso para reverso
alter index f_regs_idx1 rebuild reverse;

-- alterar indice reverso para nao reverso
alter index f_regs_idx1 rebuild noreverse;
