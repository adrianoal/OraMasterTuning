CREATE TABLESPACE ECOMMERCE_I DATAFILE '+DATA1/pdbxe_ecommerce_i.idx' SIZE 100M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED NOLOGGING -- BLOCKSIZE 32768;
                                                                                                                        -- NOLOGGING, deixar de criar log, em algumas situacoes