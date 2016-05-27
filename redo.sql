--Report of online redo log file information
col group# format 999
col thread# format 999
col member format a20 wrap
col status format a10
col archived format a10
col fsize format 9999 heading "Size (MB)"
break on thread# skip 1 on group#

  select l.thread#
,        l.group#
,        f.member
,        l.archived
,        l.status
,        (bytes/1024/1024) fsize
    from v$log                          l
,        v$logfile                      f
   where f.group#                       = l.group#
order by 1, 2;

clear breaks;
exit;
