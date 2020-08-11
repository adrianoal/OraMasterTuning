 indices compactados: create index cust_cidx1 on cust(last_name, first_name) compress 2;
 
  Reduced storage
    More rows stored in leaf blocks, which can result in less I/O when accessing a compressed index
    alter index cust_cidx1 rebuild compress 1;
   alter index cust_cidx1 rebuild nocompress