select segment_name, tablespace_name, r.status, 
    (initial_extent/1024) InitialExtent,(next_extent/1024) NextExtent, 
    max_extents, v.curext CurExtent 
    From dba_rollback_segs r, v$rollstat v 
    Where r.segment_id = v.usn(+) 
    order by segment_name;
 exit;