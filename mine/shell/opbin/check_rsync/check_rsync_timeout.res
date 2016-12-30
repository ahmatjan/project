505      15979  0.0  0.0  5016  532 ?        S    14:00   0:00 rsync --bwlimit=20480 -av work@cp01-sf-toadbk03.cp01:/home/work/dashboard//./crontab/20150901_crontab.sh -p /home/yangkai04/shell/machine_work_dashboard/cp01-sf-toadbk03.cp01//./crontab/20150901_crontab.sh
505      15984  0.0  0.0 59896 4916 ?        S    14:00   0:00 ssh -l work cp01-sf-toadbk03.cp01 rsync --server --sender -vlogDtpr --bwlimit=20480 . /home/work/dashboard//./crontab/20150901_crontab.sh
505      18465  0.0  0.0  5440  896 ?        Ss   12:00   0:00 /bin/sh -c cd /home/yangkai04/opbin/crontab/bin && sh rsync_work_dashboard_dir.sh >rsync_work_dashboard_dir.sh.log 2>&1
505      18608  0.0  0.0  5576 1120 ?        S    12:00   0:02 sh rsync_work_dashboard_dir.sh
