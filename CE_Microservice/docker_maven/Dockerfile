FROM ubuntu:18.04
MAINTAINER javier.godino@acqua.net.ar
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
ARG ATINA_REPOSITORY_PROTOCOL=http
ARG ATINA_REPOSITORY_URL=157.245.236.175:8081/artifactory/libs-release
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
# Actualizacion del Ubuntu
# ====================================
RUN apt update

# ====================================
# Set TimeZone
# ====================================
RUN export DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/America/BuenosAires /etc/localtime
RUN apt-get install -y tzdata
RUN dpkg-reconfigure --frontend noninteractive tzdata

# ====================================
# Instalacion de Software Requerido
# ====================================
RUN apt-get install -y wget
RUN apt-get install -y iproute2
RUN apt-get install -y net-tools 
RUN apt-get install -y bzip2
RUN apt-get install -y unzip
RUN apt-get install -y curl
RUN apt-get install -y locales
RUN apt-get install -y jq

# ====================================
# Instalacion de Idioma
# ====================================
#
RUN locale-gen es_ES.utf8
ENV LANG es_ES.utf8
ENV LANGUAGE es_ES.utf8  
ENV LC_ALL es_ES.utf8  
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
RUN mkdir -p /home/apps
RUN mkdir -p /home/repository
RUN mkdir -p /home/logs
#
# ====================================
# Start
# ====================================

COPY docker-entrypoint.sh /
COPY entypoints/* /docker-entrypoint.d/
RUN chmod +x /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.d/maven-start.sh
ENTRYPOINT ["./docker-entrypoint.sh"]