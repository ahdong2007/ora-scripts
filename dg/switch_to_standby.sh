#!/bin/bash

. ~/.bash_profile

$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF
alter database commit to switchover to standby;
shutdown immediate;
exit;
EOF

$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF
startup mount;
alter database recover managed standby database disconnect from session;
exit;
EOF