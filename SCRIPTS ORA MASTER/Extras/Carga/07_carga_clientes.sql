-- SP - HOMENS
BEGIN
  FOR I IN 1..10000
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'M',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || trunc(DBMS_RANDOM.VALUE(0, 1000)),
            'S�o Paulo', 28, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/
-- SP - MULHERES
BEGIN
  FOR I IN 1..3265
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'F',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || trunc(DBMS_RANDOM.VALUE(0, 1000)),
            'S�o Paulo', 28, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/
-- CE - HOMENS
BEGIN
  FOR I IN 1..1233
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'M',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || TRUNC(DBMS_RANDOM.VALUE(0, 1000)),
            'Fortaleza', 6, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/
-- CE - MULHERES
BEGIN
  FOR I IN 1..541
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'F',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || TRUNC(DBMS_RANDOM.VALUE(0, 1000)),
            'Fortaleza', 6, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/
-- DF - HOMENS
BEGIN
  FOR I IN 1..1234
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'M',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || TRUNC(DBMS_RANDOM.VALUE(0, 1000)),
            'Bras�lia', 7, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/
-- DF - MULHERES
BEGIN
  FOR I IN 1..321
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'F',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || TRUNC(DBMS_RANDOM.VALUE(0, 1000)),
            'Bras�lia', 7, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/
-- RJ - HOMENS
BEGIN
  FOR I IN 1..7345
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'M',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || TRUNC(DBMS_RANDOM.VALUE(0, 1000)),
            'Rio de Janeiro', 21, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/
-- RJ - MULHERES
BEGIN
  FOR I IN 1..3245
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'F',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || TRUNC(DBMS_RANDOM.VALUE(0, 1000)),
            'Rio de Janeiro', 21, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/
-- SC - HOMENS
BEGIN
  FOR I IN 1..933
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'M',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || TRUNC(DBMS_RANDOM.VALUE(0, 1000)),
            'Florian�polis', 26, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/
-- SC - MULHERES
BEGIN
  FOR I IN 1..3245
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'F',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || TRUNC(DBMS_RANDOM.VALUE(0, 1000)),
            'Florian�polis', 26, SYSDATE, 1, NULL);
  END LOOP;
 COMMIT;
END;
/
-- RN - HOMENS
BEGIN
  FOR I IN 1..3210
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'M',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || TRUNC(DBMS_RANDOM.VALUE(0, 1000)),
            'Natal', 22, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/
-- RN - MULHERES
BEGIN
  FOR I IN 1..956
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'F',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || TRUNC(DBMS_RANDOM.VALUE(0, 1000)),
            'Natal', 22, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/
-- BA - HOMENS
BEGIN
  FOR I IN 1..6523
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'M',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || TRUNC(DBMS_RANDOM.VALUE(0, 1000)),
            'Salvador', 5, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/
-- BA - MULHERES
BEGIN
  FOR I IN 1..4536
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'F',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || TRUNC(DBMS_RANDOM.VALUE(0, 1000)),
            'Salvador', 5, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/
-- MG - HOMENS
BEGIN
  FOR I IN 1..8541
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'M',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || TRUNC(DBMS_RANDOM.VALUE(0, 1000)),
            'Belo Horizonte', 14, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/
-- MG - MULHERES
BEGIN
  FOR I IN 1..8945
  LOOP
    INSERT INTO ECOMMERCE.CLIENTE VALUES
      (ECOMMERCE.SQ_CLIENTE.NEXTVAL, INITCAP(DBMS_RANDOM.STRING('l', '3')) || ' ' || INITCAP(DBMS_RANDOM.STRING('l', '5')), 'F',
          1, TRUNC(DBMS_RANDOM.VALUE(10000000000,99999999999)), SYSDATE - (DBMS_RANDOM.VALUE(0, 36500)), DBMS_RANDOM.STRING('l', '5') || '@com.br',
          DBMS_RANDOM.VALUE(10000000,99999999), 'R. ' || DBMS_RANDOM.STRING('l', '15') || ', ' || TRUNC(DBMS_RANDOM.VALUE(0, 1000)),
            'Belo Horizonte', 14, SYSDATE, 1, NULL);
  END LOOP;
  COMMIT;
END;
/