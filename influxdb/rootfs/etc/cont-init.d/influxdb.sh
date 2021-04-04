#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: InfluxDB
# Configures InfluxDB
# ==============================================================================

# Configures authentication
if bashio::config.true 'auth'; then
    sed -i 's/auth-enabled=.*/auth-enabled=true/' /etc/influxdb/influxdb.conf
else
    bashio::log.warning "InfluxDB authentication protection is disabled!"
    bashio::log.warning "This is NOT recommended!!!"
fi

# Configures usage reporting to InfluxDB
if bashio::config.false 'reporting'; then
    sed -i 's/reporting-disabled=.*/reporting-disabled=true/' /etc/influxdb/influxdb.conf
    bashio::log.info "Reporting of usage stats to InfluxData is disabled."
fi

declare certfile
declare keyfile

if bashio::config.true 'ssl'; then
    certfile=$(bashio::config 'certfile')
    keyfile=$(bashio::config 'keyfile')

    sed -i 's/https-enabled=.*/https-enabled=true/' /etc/influxdb/influxdb.conf
    sed -i "s#https-certificate=.*#https-certificate=\"/ssl/${certfile}\"#" \
        /etc/influxdb/influxdb.conf
    sed -i "s#https-private-key=.*#https-private-key=\"/ssl/${keyfile}\"#" \
        /etc/influxdb/influxdb.conf
fi
