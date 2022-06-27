
hive -e "INSERT INTO tbl_orc_two 
select 
custid, 
username, 
quote_count, 
ip, 
entry_time, 
prp_1,
prp_2, 
prp_3, 
ms, 
http_type, 
purchase_category, 
total_count, 
purchase_sub_category, 
http_info, 
status_code,
year(to_date(from_unixtime(unix_timestamp(substr(entry_time,1,11),'dd/MMM/yyyy'))))as year,
month(to_date(from_unixtime(unix_timestamp(substr(entry_time,1,11),'dd/MMM/yyyy'))))as month
from pre_tbl_orc_two";
