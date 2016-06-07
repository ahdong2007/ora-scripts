-- Script Tested above 10g
﻿-- Create a new temporary segment tablespace specifically for creating the index.
-- CREATE TEMPORARY TABLESPACE tempindex tempfile 'filename' SIZE 20G ;
-- ALTER USER username TEMPORARY TABLESPACE tempindex;

REM PARALLEL_EXECUTION_MESSAGE_SIZE can be increased to improve throughput.
REM but need restart instance,and should be same in RAC environment
REM this doesn't make sense,unless high parallel degree

-- alter system set parallel_execution_message_size=65535 scope=spfile;

alter session set workarea_size_policy=MANUAL;
alter session set workarea_size_policy=MANUAL;

alter session set db_file_multiblock_read_count=512;
alter session set db_file_multiblock_read_count=512;

--In conclusion, in order to have the least amount of direct operations and
--have the maximum possible read/write batches these are the parameters to set:

alter session set events '10351 trace name context forever, level 128';

REM set sort_area_size to 700M or 1.6 * table_size
REM 10g bug need to set sort_area_size twice
REM remember large sort area size doesn't mean better performance
REM sometimes you should reduce below setting,and then sort may benefit from disk sort
REM and attention to avoid PGA swap

alter session set sort_area_size=734003200;
alter session set sort_area_size=734003200;

REM set sort area first,and then set SMRC for parallel slave
REM Setting this parameter can activate our previous setting of sort_area_size
REM and we can have large sort multiblock read counts.

alter session set "_sort_multiblock_read_count"=128;
alter session set "_sort_multiblock_read_count"=128;

alter session enable parallel ddl;

create [UNIQUE] index ...     [ONLINE] parallel [Np] nologging;

alter index .. logging;
alter index .. noparallel;

--TRY below underscore parameter while poor performance 

--alter session set "_shrunk_aggs_disable_threshold"=100; 

REM   _newsort_type=2 only works if the patch for bug:4655998 has been applied
REM   The fix for bug:4655998 has been included in the 10.2.0.4 patchset.
REM   got worse in most cases

--alter session set "_newsort_type" = 2; 
OR  
--alter session set "_newsort_enabled"=false;                        then use Sort V1 algorithm,got worse in most cases

rem !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!IMPORTANT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
rem If the performance of a query has degraded and the majority of the
rem time is spent in the function kghfrempty, and the function that called
rem kghfrempty was kxsfwa called from kksumc, then you may be encountering
rem this problem.
rem Workaround:
rem Reducing sort_area_size may help by reducing the amount of memory that
rem each sort allocates, particularly if the IO subsystem is underutilized.
rem The performance of some queries that involved large sorts degraded due
rem to the memory allocation pattern used by sort.
rem !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

REM setting below parameter only if you are loading data into new system
REM you should restore them after loading
--alter session set db_block_checking=false;
--alter system set db_block_checksum=false;