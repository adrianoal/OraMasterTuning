SELECT      i.owner,
            i.index_name AS "Index Name", 
            nvl(i.num_rows,0) AS "Rows",           
            ROUND((nvl(i.leaf_blocks,0) * p.value)/1024/1024,2) AS "Size MB", 
            i.last_analyzed AS "Last Analyzed"
FROM        dba_indexes i,
            v$parameter p
WHERE       i.owner = UPPER(NVL('&P_OWNER',i.owner))
AND         p.name = 'db_block_size'
ORDER by    4 desc;