sqlplus -prelim / as sysdba
oradebug setmypid
oradebug unlimit
oradebug hanganalyze 3
oradebug dump systemstate 266
REM ......间隔一定时间，如20秒，执行下一次数据采集
oradebug hanganalyze 3 
oradebug dump systemstate 266