# !/bin/sh
rc-service influxdb start
telegraf &
sleep infinite
