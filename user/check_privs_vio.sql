
REM
REM list users granted with DBA/SYSDBA/SYSOPER/SYSASM privs
REM 06/06/2016 Mason Hua
REM
select grantee, granted_role as granted
  from dba_role_privs
 where granted_role in ('DBA',
                        'DATAPUMP_EXP_FULL_DATABASE',
                        'DATAPUMP_EXP_FULL_DATABASE',
                        'EXP_FULL_DATABASE',
                        'EXP_FULL_DATABASE',
                        'IMP_FULL_DATABASE',
                        'DELETE_CATALOG_ROLE',
                        'SELECT_CATALOG_ROLE')
   and grantee not in ('SYS',
                       'SYSTEM',
                       'SYSMAN',
                       'DATAPUMP_IMP_FULL_DATABASE',
                       'DBA',
                       'EXP_FULL_DATABASE',
                       'IMP_FULL_DATABASE',
                       'OEM_MONITOR',
                       'DATAPUMP_EXP_FULL_DATABASE')
union all
select username, 'sysdba/oper/asm'
  from v$pwfile_users
 where username not in ('SYS',
                        'SYSTEM')
   and (sysdba = 'TRUE' or sysoper = 'TRUE' or sysasm = 'TRUE')
 order by grantee
