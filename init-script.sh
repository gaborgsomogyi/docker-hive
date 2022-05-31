#!/bin/bash

cp /share/krb5.conf /etc

$HIVE_HOME/bin/hive --service metastore

while true; do sleep infinity; done
