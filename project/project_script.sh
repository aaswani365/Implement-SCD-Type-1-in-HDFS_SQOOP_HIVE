#!bin/bash

#Pick the latest file from the directory

FILE=`ls -tp | grep -v /$ | tail -1`






echo "HAI picked ${FILE} THIS TIME"
echo "******************************************************************************"

echo "moving to the HDFS directory"

echo "*************************************************************************************"

hadoop fs -put  ${FILE} /user/saif/project/datasets/


echo "export the data from HDFS to mysql-database"

echo "--------------------------------------------------------------------------------------------------------"

sh /home/saif/project/scoop/export_data_mysql.sh

echo "EXPORTED TO MYSQL-DATABASE#############################################################"

echo "Exporting Done!!!!"

echo "run the sqoop job to get data into HDFS"

echo "--------------------------------------------------------------------------------------------------------"

sqoop job --exec fresh_day_import_job

echo "Got the data into HDFS"

echo "--------------------------------------------------------------------------------------------------------"

echo "loading the data into pre_tbl_orc_two"

hive -e "load data inpath '/user/saif/project/daily_data' into table pre_tbl_orc_two;"

echo "LOADED INTO pre_table***********************************************************************"

echo "Loading the data from pre_tbl_orc_two to tbl_orc_two"
echo "--------------------------------------------------------------------------------------------------------"

hive -f "/home/saif/project/refer/hive_file.hive"


echo "Truncate table pre_tbl_orc_two"

echo "--------------------------------------------------------------------------------------------------------"

hive -e "truncate table pre_tbl_orc_two;"

#load the data from tbl_orc_two to reconciliation
echo "--------------------------------------------------------------------------------------------------------"

hive -e "insert into reconciliation select * from tbl_orc_two;"

#Implement SCD-1 Logic

#drop the reconcile_view

hive -e "drop view reconcile_view;"

echo "executing reconcile query"
echo "--------------------------------------------------------------------------------------------------------"

hive -f "/home/saif/project/refer/hive_file1.hive"

echo "truncate the reporting_table"

echo "--------------------------------------------------------------------------------------------------------"

hive -e "truncate table reporting;"
echo "--------------------------------------------------------------------------------------------------------"

echo "report the result to the reporting_table"
echo "--------------------------------------------------------------------------------------------------------"

hive -e "insert into reporting select * from reconcile_view;"

#truncate the one and loading

hive -e "truncate table one;"

hive -e "insert into one select * from reporting;"

#truncate the tbl_orc_two

hive -e "truncate table  tbl_orc_two;"


#Truncate the table partition_table and load the data into it

hive -e "truncate table partition_table;"

echo "enable properties"
echo "--------------------------------------------------------------------------------------------------------"



#Load The data into partition_table





echo "HURRYYYYYYYYY!!!!!!!!!!!!!!!!!!!!!"
