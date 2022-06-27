sqoop export \
--connect jdbc:mysql://localhost:3306/project?useSSL=false \
--username root --password-file file:///home/saif/project/env/password.pwd \
--table daily_transactions_data -m 1 \
--export-dir /user/saif/project/datasets

