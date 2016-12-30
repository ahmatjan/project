/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -N -e"select distinct userid from bgtserver_dashboard.add_status_fc_cq_action_20140224 where reason='budget_offline' and planid=0;" > userid

