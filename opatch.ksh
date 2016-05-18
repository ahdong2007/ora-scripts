
cd $ORACLE_HOME/OPatch
./opatch lsinv
./opatch lsinv -all
./opatch lsinv -patch
./opatch lsinv -bugs_fixed
./opatch lsinv -detail


# 在安装 PSU 之前检查冲突
# ./opatch prereq CheckConflictAgainstOHWithDetail -ph ./13343438

# 安装PSU
# cd <>
# ./opatch apply


# post task
# cd $ORACLE_HOME/rdbms/admin
# sqlplus / as sysdba
# @catbundle.sql psu apply

sqlplus / AS SYSDBA
# @$ORACLE_HOME/cpu/CPUOct2006/catcpu.sql
# @$ORACLE_HOME/rdbms/admin/utlrp.sql

# opatch rollback -id <>
# cd $ORACLE_HOME/rdbms/admin
# @catbundle_PSU_<database SID>_ROLLBACK.sql
# @utlrp.sql
