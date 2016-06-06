

REM report everything about a user
REM check default tablespace
select username, default_tablespace
  from dba_users
 where username = '&username';
 
REM check user status
select username, account_status 
  from dba_users 
 where username = '&name';
 
REM check user profile
select du.username, du.profile, dp.resource_name, dp.limit
  from dba_users du, dba_profiles dp
 where du.profile = dp.profile
   and dp.resource_type = 'PASSWORD'
   and du.username = '&name'
 order by dp.resource_name;
 
REM check user granted roles
select grantee, granted_role 
  from dba_role_privs 
 where grantee = '&name';
 
REM check user directly granted system privs
select grantee, privilege 
  from dba_sys_privs 
 where grantee = upper('&name');

REM check user directly granted object privs
select grantee, owner||'.'||table_name as object, privilege 
  from dba_tab_privs
 where grantee = upper('&name');

REM the all privs a user has
-- system privs granted directly
select 'sys privs:' as type, grantee, privilege, null
  from dba_sys_privs 
 where grantee = upper('&name')
union all
-- object privs granted directly
select 'obj privs:' as type, grantee,  privilege, owner||'.'||table_name as object 
  from dba_tab_privs
 where grantee = upper('&name')
union all
-- role system privs
select 'sys privs:' as type, drp.grantee, rsp.privilege, null
  from dba_role_privs drp, role_sys_privs rsp
 where drp.granted_role = rsp.role
   and drp.grantee = '&name'
-- role object privs
union all
select 'obj privs:' as type, drp.grantee, rtp.privilege, rtp.owner||'.'||rtp.table_name as object
  from dba_role_privs drp, role_tab_privs rtp
 where drp.granted_role = rtp.role
   and drp.grantee = '&name'
union all
-- role role privs
select 'role privs:' as type, drp.grantee, rrp.granted_role, null
  from dba_role_privs drp, role_role_privs rrp
 where drp.granted_role = rrp.role
   and drp.grantee = '&name'
 order by type;
