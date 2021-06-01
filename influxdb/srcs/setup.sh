# !/bin/sh
rc-service influxdb start
telegraf &
sleep 2
