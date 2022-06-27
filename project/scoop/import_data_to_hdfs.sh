sqoop job --create fresh_day_import_job -- import \
--connect jdbc:mysql://localhost:3306/project?useSSL=False \
--username root --password-file file:///home/saif/project/env/password.pwd \
--table daily_transactions_data -m 1 \
--target-dir /user/saif/project/daily_data \
--incremental append --check-column custid  --last-value 0
