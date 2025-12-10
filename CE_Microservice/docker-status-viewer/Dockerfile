FROM alpine:latest
MAINTAINER javier.godino@acqua.net.ar
#
# ====================================
# ARGUMENTOS DE CONSTRUCCION
# ====================================
#
ARG API_STATUS_URL=https://localhost:8082/api/v1/status
ENV API_STATUS_URL ${API_STATUS_URL}
#
RUN apk --no-cache add curl
#  
# ====================================
# Start
# ====================================
#
COPY status-api.sh /usr/local/status-api.sh
RUN chmod +x /usr/local/status-api.sh
ENTRYPOINT ["sh", "/usr/local/status-api.sh"]
