FROM eclipse-temurin:11-jre-jammy
MAINTAINER javier.godino@acqua.net.ar
#
# ====================================
# ARGUMENTOS DE CONSTRUCCION
# ====================================
ENV ACTIVEMQ_VERSION 5.16.2
ENV ACTIVEMQ_HOME /opt/activemq 
#    
#
# ====================================
# Set TimeZone
# ====================================
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime && \
    apt-get update && \
    apt-get install -y tzdata && \
    dpkg-reconfigure --frontend noninteractive tzdata
#
# ====================================
# Instalacion ActiveMQ
# ====================================
#
RUN apt-get update && apt-get install -y wget && \
    wget https://archive.apache.org/dist/activemq/${ACTIVEMQ_VERSION}/apache-activemq-${ACTIVEMQ_VERSION}-bin.tar.gz && \
    tar -xzf apache-activemq-${ACTIVEMQ_VERSION}-bin.tar.gz && \
    mv apache-activemq-${ACTIVEMQ_VERSION} ${ACTIVEMQ_HOME} && \
    rm apache-activemq-${ACTIVEMQ_VERSION}-bin.tar.gz && \
    apt-get remove -y wget && apt-get clean && \
    mkdir -p ${ACTIVEMQ_HOME}/data 	
#
# ====================================
# Instalacion de Software Requerido
# ====================================
#
RUN apt-get install -y iproute2 net-tools locales jq && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
#
# ====================================
# Instalacion de Idioma
# ====================================
#
RUN locale-gen es_ES.UTF-8
ENV LANG es_ES.UTF-8
ENV LANGUAGE es_ES.UTF-8
ENV LC_ALL es_ES.UTF-8
#
# ====================================
# Expose Ports
# ====================================	
#
EXPOSE 61616 8161 5672
#	
# ====================================
# Copiar Configuracion
# ====================================
#
COPY activemq/conf/activemq.xml ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/broker.ks ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/broker.ts ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/broker-localhost.cert ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/client.ks ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/credentials.properties ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/credentials-enc.properties ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/groups.properties ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/java.security ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/jetty.xml ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/jetty-realm.properties ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/jmx.access ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/jmx.password ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/log4j.properties ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/logging.properties ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/login.config ${ACTIVEMQ_HOME}/conf
COPY activemq/conf/users.properties ${ACTIVEMQ_HOME}/conf 
#
# ====================================
# Start
# ====================================
ENTRYPOINT ["sh", "-c", "${ACTIVEMQ_HOME}/bin/activemq console"]