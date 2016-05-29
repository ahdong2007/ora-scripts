#!/bin/bash

# Oracle日常操作菜单
# cd $script_path

dba='sqlplus -S "/as sysdba"'

# 
check_wait_event() {

	sqlplus -S "/as sysdba" @wait_event.sql
}

# shutdown DB
shutdown_db() {
	sqlplus -S "/as sysdba" @shutdown.sql
}

# activate standby
activate_standby() {

	sqlplus -S "/as sysdba" @activate_standby.sql
}

# check online redo
check_redo() {

	sqlplus -S "/as sysdba" @redo.sql
}

# check rollback segments
check_rollback_segment() {
	sqlplus -S "/as sysdba" @roll.sql	
}