FROM --platform=linux/amd64 ubuntu:22.04
#
LABEL maintainer="javier.godino@acqua.net.ar"
#
# ====================================
# ARGUMENTOS DE CONSTRUCCION
# ====================================
# -------------------------------------
# ARG Java 
# -------------------------------------
#
ARG javaFolder=/var/java
ARG javaType=JDK
#ARG javaJDKImage=OpenJDK8U-jdk_x64_linux_hotspot_8u362b09.tar.gz
#ARG javaJDKRootFolder=jdk8u362-b09
#
#
ARG javaJDKImage=OpenJDK17U-jdk_x64_linux_hotspot_17.0.17_10.tar.gz
ARG javaJDKRootFolder=jdk-17.0.17+10
#
# curl -L -o OpenJDK17U-jdk_x64_linux_hotspot_17.0.17_10.tar.gz \
# "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.17+10/OpenJDK17U-jdk_x64_linux_hotspot_17.0.17_10.tar.gz"
#
# -------------------------------------
# ARG MULESOFT
# -------------------------------------
#
ARG muleVersion=4.8.0
ARG mule_env=dev
#
ARG MULEAPP_GROUP_ID=com.sota
ARG MULEAPP_ARTIFACT_ID=mule
ARG MULEAPP_VERSION=1.0.0

# -------------------------------------
# ARG Repository 
# -------------------------------------
#
ARG ATINA_REPOSITORY_PROTOCOL=https
ARG ATINA_REPOSITORY_URL=jfrog.atina-connection.com/artifactory/libs-release
#
# ====================================
# VARIABLES DE AMBIENTE
# ====================================
#
# -------------------------------------
# ENV Java 
# -------------------------------------
#
ENV JAVA_HOME ${javaFolder}/${javaJDKRootFolder}
ENV PATH="${JAVA_HOME}/bin:${PATH}"
#
# -------------------------------------
# ENV Mulesfot 
# -------------------------------------
#  
ENV muleVersion ${muleVersion}
ENV mule_env ${mule_env}
ENV MULE_HOME /opt/mule/mule-standalone-${muleVersion}
#
# Aplication que sera deployada. Se descarga desde el repositorio.
# Ver mule-start.sh
#
ENV MULEAPP_GROUP_ID ${MULEAPP_GROUP_ID}  
ENV MULEAPP_ARTIFACT_ID ${MULEAPP_ARTIFACT_ID}  
ENV MULEAPP_VERSION ${MULEAPP_VERSION}  
#
# -------------------------------------
# ENV Repository 
# ------------------------------------- 
#
ENV ATINA_REPOSITORY_PROTOCOL ${ATINA_REPOSITORY_PROTOCOL} 
ENV ATINA_REPOSITORY_URL ${ATINA_REPOSITORY_URL}
#
# ====================================
# Configuración de timezone y locale 
# antes de instalar paquetes
# ====================================
#
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Buenos_Aires
ENV LANG=es_AR.UTF-8
ENV LANGUAGE=es_AR.UTF-8
ENV LC_ALL=es_AR.UTF-8
#
# ====================================
# Actualizacion del Ubuntu
# ====================================
#
RUN apt-get update && apt-get install -y \
    wget \
    iproute2 \
    net-tools \
    bzip2 \
    unzip \
    curl \
    locales \
    jq \
    libfreetype6 \
    libfontconfig1 \
    fonts-dejavu \
    fonts-dejavu-extra \
    fontconfig \
    tzdata \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ====================================
# Set TimeZone
# ====================================

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

# ====================================
# Configuración de Locale
# ====================================

RUN locale-gen es_AR.UTF-8 && \
    update-locale LANG=es_AR.UTF-8
#
#
# ===================================================
# Instalacion de Java OpenJDK Modificado 64 Bits JDK
# ===================================================
#
# Descargas: https://download.eclipse.org/temurin-compliance/temurin/
# 
RUN mkdir ${javaFolder}
RUN cd ${javaFolder} 
COPY java64/${javaJDKImage} ${javaFolder}/
RUN tar xf ${javaFolder}/${javaJDKImage} -C ${javaFolder}
RUN /usr/bin/update-alternatives --install /usr/bin/java java ${javaFolder}/${javaJDKRootFolder}/bin/java 1
RUN rm ${javaFolder}/${javaJDKImage} 
  
# ====================================
# Creacion de Variable LOCALIP
# ====================================
#
RUN LOCALIP=$(hostname  -I) 
#  
# ====================================
# Instalacion de Mule Server
# ====================================
# 
RUN mkdir /opt/mule
RUN cd /opt/mule
COPY images/mule-standalone-${muleVersion}.tar.gz /opt/mule/
RUN tar xvzf /opt/mule/mule-standalone-${muleVersion}.tar.gz -C /opt/mule
#
# Copiar configuraciones
# 
COPY images/wrapper.conf /opt/mule/mule-standalone-${muleVersion}/conf
COPY images/tls-default.conf /opt/mule/mule-standalone-${muleVersion}/conf
RUN rm /opt/mule/mule-standalone-${muleVersion}.tar.gz
#
# Crear archivo de build date
#
RUN date +%Y%m%d%H%M%S >/opt/mule/build-date.txt
#
# ====================================
# Instalacion de JDE Atina Microserver
# ====================================
#
RUN mkdir -p /tmp/sota && \
    mkdir -p /home/sota/mule/logs
#
# ====================================
# Start
# ====================================

COPY docker-entrypoint.sh /
COPY docker-entrypoint-stop.sh /
COPY entypoints/* /docker-entrypoint.d/

RUN chmod +x /docker-entrypoint.sh \
             /docker-entrypoint-stop.sh \
             /docker-entrypoint.d/mule-start.sh \
             /docker-entrypoint.d/mule-stop.sh \
             /docker-entrypoint.d/mule-update.sh \
             /docker-entrypoint.d/mule-copy.sh

VOLUME ["/opt/mule/mule-standalone-${muleVersion}/logs", \
        "/opt/mule/mule-standalone-${muleVersion}/apps", \
        "/home/sota/mule/logs"] 

EXPOSE 8081
EXPOSE 8082

ENTRYPOINT ["./docker-entrypoint.sh"]