FROM ubuntu:jammy

EXPOSE 9083

RUN apt-get -qq update
RUN apt-get -qq install curl ssh openjdk-8-jdk krb5-user nmap
RUN apt-get -qq clean

ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_VERSION=3.3.3
ENV HIVE_HOME=/opt/hive
ENV HIVE_VERSION=3.1.3

RUN \
  curl -s "https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" | tar -xz -C /opt && \
  ln -s /opt/hadoop-${HADOOP_VERSION} ${HADOOP_HOME}

RUN \
  curl -s "https://dlcdn.apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz" | tar -xz -C /opt && \
  ln -s "/opt/apache-hive-${HIVE_VERSION}-bin" "${HIVE_HOME}"

ADD *.xml "${HIVE_HOME}/conf/"

RUN cp "${HIVE_HOME}/conf/hive-log4j2.properties.template" "${HIVE_HOME}/conf/hive-log4j2.properties"
RUN sed -i -e 's/property.hive.log.level =.*/property.hive.log.level = DEBUG/' "${HIVE_HOME}/conf/hive-log4j2.properties"

RUN \
    echo "export HADOOP_HOME=$HADOOP_HOME" >> "${HIVE_HOME}/conf/hive-env.sh" && \
    echo "export HADOOP_OPTS=\"-Dsun.security.krb5.debug=true\"" >> "${HIVE_HOME}/conf/hive-env.sh"

ADD init-script.sh /init-script.sh
ENTRYPOINT /init-script.sh
