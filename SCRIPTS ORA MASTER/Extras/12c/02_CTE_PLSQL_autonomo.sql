with function slow_me return number is 
   begin
      dbms_lock.sleep(1);
      return 1;
   end;
select level, slow_me() slow_me from dual connect by level < 10;