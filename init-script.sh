#!/bin/bash

export JAVA_HOME=$(ls -d /usr/lib/jvm/java-1.8.0-openjdk*)
echo "Detected JAVA_HOME=${JAVA_HOME}"

echo "export JAVA_HOME=${JAVA_HOME}" >> "${HIVE_HOME}/conf/hive-env.sh"

cp /share/krb5.conf /etc

"${HIVE_HOME}/bin/hive" --service metastore

while true; do sleep infinity; done
