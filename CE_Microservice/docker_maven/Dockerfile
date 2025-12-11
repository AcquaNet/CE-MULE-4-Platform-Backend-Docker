FROM --platform=linux/amd64 ubuntu:22.04
#
LABEL MAINTAINER javier.godino@acqua.net.ar
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
ARG javaJDKImage=OpenJDK8U-jdk_x64_linux_hotspot_8u362b09.tar.gz
ARG javaJDKRootFolder=jdk8u362-b09
#
# -------------------------------------
# ARG MULESOFT
# -------------------------------------
#
ARG muleVersion=4.4.0
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
# 
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
RUN apt-get update && apt-get install -y \
    wget \
    iproute2 \
    net-tools \
    bzip2 \
    unzip \
    curl \
    locales \
    jq \
    tzdata \
    && rm -rf /var/lib/apt/lists/*
# ====================================
# Set TimeZone
# ====================================
#
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata
#
# ====================================
# Configuración de Locale
# ====================================
#
RUN locale-gen es_AR.UTF-8 && \
    update-locale LANG=es_AR.UTF-8
#
#
# ===================================================
# Instalacion de Java OpenJDK Modificado 64 Bits JDK
# ===================================================
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
# Install MAVEN
# ====================================
ARG MAVEN_VERSION=3.6.3
ARG USER_HOME_DIR="/root"
COPY images/apache-maven-${MAVEN_VERSION}-bin.tar.gz /tmp/apache-maven.tar.gz
ARG SHA=c35a1803a6e70a126e80b2b3ae33eed961f83ed74d18fcd16909b2d44d7dada3203f1ffe726c17ef8dcca2dcaa9fca676987befeadc9b9f759967a8cb77181c0
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries
RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
COPY images/settings.xml /usr/share/maven/conf/

# ====================================
# Instalacion de JDE Atina Microserver
# ====================================
#
RUN mkdir -p /home
RUN mkdir -p /home/apps && \
    mkdir -p /home/repository && \
    mkdir -p /home/logs
#
#
# ====================================
# Start
# ====================================

COPY docker-entrypoint.sh /
COPY entypoints/* /docker-entrypoint.d/
RUN chmod +x /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.d/maven-start.sh
ENTRYPOINT ["./docker-entrypoint.sh"]