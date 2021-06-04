openrc
touch /run/openrc/softlevel

service influxdb start

until influx; do
	sleep 1
done

influx -execute "CREATE USER admin WITH PASSWORD '${IDB_ADMIN_PASS}' WITH ALL PRIVILEGES;"
influx -execute "CREATE DATABASE metrics;"
influx -execute "CREATE USER telegraf_user WITH PASSWORD '${IDB_TELEGRAF_PASS}';"
influx -execute "GRANT ALL ON metrics TO telegraf_user;"
influx -execute "CREATE USER grafana_user WITH PASSWORD '${IDB_GRAFANA_PASS}';"
influx -execute "GRANT ALL ON metrics TO grafana_user;"

service influxdb stop

influxd -config /etc/influxdb.conf
