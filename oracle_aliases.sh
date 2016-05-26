# Useful aliases for working with Oracle databases
export INST_TYPE=rdbms
export ORACLE_DBNAME=ocp
alias goalert="cd $ORACLE_BASE/$INST_TYPE/$ORACLE_DBNAME/$ORACLE_SID/trace"
alias goinit="cd $ORACLE_HOME/dbs"
alias gotns="cd $ORACLE_HOME/network/admin"
alias h="fc -l"
alias ll="ls -latr"
alias psg="ps -ef|grep ora_"
alias sqldba='sqlplus "/as sysdba"'
alias sqlasm='sqlplus "/as sysasm"'
