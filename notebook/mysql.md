在arch linux中使用mysql(MariaDB).
<https://wiki.archlinux.org/title/MariaDB_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)>

```bash
sudo pacman -S mysql
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/MySQL
# start
cd /usr
sudo /usr/bin/mysqld_safe --datadir='/var/lib/MySQL'
# stop
sudo mysqladmin shutdown
```

mycli: pip3 install mycli
