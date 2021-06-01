#!/bin/sh
telegraf &
/usr/sbin/grafana-server --homepath=/usr/share/grafana