#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: InfluxDB
# Configures password for Kapacitor
# ==============================================================================
declare secret

secret=$(</data/secret)

sed -i "s/password.*/password = \"${secret}\"/" \
    /etc/kapacitor/kapacitor.conf

if bashio::config.true 'ssl'; then
    sed -i "s/http:/https:/" /etc/kapacitor/kapacitor.conf
fi
