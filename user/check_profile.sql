
REM
REM list users granted with DBA/SYSDBA/SYSOPER/SYSASM privs
REM 06/06/2016 Mason Hua
REM

select *
  from dba_profiles
 order by 1,2;