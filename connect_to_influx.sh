#!/bin/sh

# IF NOT ALREADY DONE, MAKE DB W/ curl -X POST "http://<pod-ip>:8086/query" --data-urlencode "q=CREATE DATABASE <database-name>"

export NEXRAN_XAPP=`sudo kubectl get svc -n ricxapp --field-selector metadata.name=service-ricxapp-nexran-rmr -o jsonpath='{.items[0].spec.clusterIP}'`
export INFLUXDB_IP=`sudo kubectl get svc -n ricxapp --field-selector metadata.name=ricxapp-influxdb -o jsonpath='{.items[0].spec.clusterIP}'`
export INFLUXDB_URL="http://${INFLUXDB_IP}:8086/"

curl -L -X PUT http://$NEXRAN_XAPP:8000/v1/appconfig -H "Content-type: application/json" -d '{"kpm_interval_index":18,"influxdb_url":"'$INFLUXDB_URL'?db=nexran"}'
