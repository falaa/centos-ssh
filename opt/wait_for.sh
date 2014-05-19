#!/bin/bash

# usage: ./wait_for.sh $SERVICE_PORT_65432_TCP_ADDR $SERVICE_PORT_65432_TCP_PORT

until $(: </dev/tcp/$1/$2)
do
    sleep 1
done