with vw_lock AS (SELECT * FROM v$lock)
select
a.sid,
'is blocking',
(select 'sid:'||s.sid||' object:'||do.object_name||' rowid:'||
    dbms_rowid.rowid_create ( 1, ROW_WAIT_OBJ#, ROW_WAIT_FILE#, ROW_WAIT_BLOCK#, ROW_WAIT_ROW# )
    ||' sql_id:'||s.sql_id
   from v$session s, dba_objects do
    where s.sid=b.sid
    and s.ROW_WAIT_OBJ# = do.OBJECT_ID
) blockee,
b.sid,b.id1,b.id2
from vw_lock a, vw_lock b
where a.block = 1
and b.request > 0
and a.id1 = b.id1
and a.id2 = b.id2;