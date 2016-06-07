PROMPT Print the details of the Users Tablespace Quotas
TTITLE left _date center ' Database Users Space Quotas by Tablespace' skip 2 "Quotas by Tablespace"
COL un          format a25              heading 'User Name'
COL ta          format a25              heading 'Tablespace'
COL usd         format 9,999,999        heading 'K Used'
COL maxb        format 9,999,999        heading 'Max K '

SELECT   tablespace_name ta, username un, bytes / 1024 usd,
         max_bytes / 1024 maxb
    FROM dba_ts_quotas
   WHERE MAX_BYTES!=-1
ORDER BY tablespace_name, username;

set linesize 140 pagesize 1400

SELECT
  username,
  tablespace_name,
  privilege
FROM (
  SELECT
    grantee username, 'Any Tablespace' tablespace_name, privilege
  FROM (
    -- first get the users with direct grants
    SELECT
      p1.grantee grantee, privilege
    FROM
      dba_sys_privs p1
    WHERE
      p1.privilege='UNLIMITED TABLESPACE'
    UNION ALL
    -- and then the ones with UNLIMITED TABLESPACE through a role...
    SELECT
      r3.grantee, granted_role privilege
    FROM
      dba_role_privs r3
      START WITH r3.granted_role IN (
          SELECT
            DISTINCT p4.grantee
          FROM
            dba_role_privs r4, dba_sys_privs p4
          WHERE
            r4.granted_role=p4.grantee
            AND p4.privilege = 'UNLIMITED TABLESPACE')
    CONNECT BY PRIOR grantee = granted_role)
    -- we just whant to see the users not the roles
  WHERE grantee IN (SELECT username FROM dba_users) OR grantee = 'PUBLIC'
  UNION ALL
  -- list the user with unimited quota on a dedicated tablespace
  SELECT
    username,tablespace_name,'DBA_TS_QUOTA' privilege
  FROM
    dba_ts_quotas
  WHERE
    max_bytes = -1 )
WHERE tablespace_name LIKE UPPER('SYSTEM')
    OR tablespace_name = 'Any Tablespace';