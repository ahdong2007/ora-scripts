set linesize 140 pagesize 1400
col os_username for a30
col userhost for a30
col terminal for a30

select os_username,userhost,terminal,username,count(*)
  from dba_audit_trail
 where returncode = 1017
 group by os_username,userhost,username,terminal
 having count(*)>10
 /