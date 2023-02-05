#!/bin/bash

echo "[TUTORIAL-RUNNER] loading prices..."
TOMORROW=$(date --date="next day" '+%Y-%m-%d')
echo "Hour,Price
${TOMORROW}T00:00:00,10
${TOMORROW}T01:00:00,11
${TOMORROW}T02:00:00,12
${TOMORROW}T03:00:00,15
${TOMORROW}T04:00:00,18
${TOMORROW}T05:00:00,17
${TOMORROW}T06:00:00,10.5
${TOMORROW}T07:00:00,9
${TOMORROW}T08:00:00,9.5
${TOMORROW}T09:00:00,9
${TOMORROW}T10:00:00,8.5
${TOMORROW}T11:00:00,10
${TOMORROW}T12:00:00,8
${TOMORROW}T13:00:00,5
${TOMORROW}T14:00:00,4
${TOMORROW}T15:00:00,4
${TOMORROW}T16:00:00,5.5
${TOMORROW}T17:00:00,8
${TOMORROW}T18:00:00,12
${TOMORROW}T19:00:00,13
${TOMORROW}T20:00:00,14
${TOMORROW}T21:00:00,12.5
${TOMORROW}T22:00:00,10
${TOMORROW}T23:00:00,7" > prices-tomorrow.csv

docker cp prices-tomorrow.csv flexmeasures-server-1:/app
docker exec -it flexmeasures-server-1 bash -c "flexmeasures add beliefs --sensor-id 3 --source toy-user prices-tomorrow.csv --timezone utc"

echo "[TUTORIAL-RUNNER] creating schedule ..."
docker exec -it flexmeasures-server-1 bash -c "flexmeasures add schedule for-storage --sensor-id 2 --consumption-price-sensor 3 \
    --start ${TOMORROW}T07:00+01:00 --duration PT12H --soc-at-start 50% \
    --roundtrip-efficiency 90%"
# we also want to use --as-job here (testing the queuing), but for some reason using exec with -c and a command, the container can't see the redis port

echo "[TUTORIAL-RUNNER] displaying schedule..."
docker exec -it flexmeasures-server-1 bash -c "flexmeasures show beliefs --sensor-id 2 --start ${TOMORROW}T07:00:00+01:00 --duration PT12H"
