#!/bin/bash

. ~/.bash_profile

$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF
alter database commit to switchover to primary;
alter database open;
exit;
EOF