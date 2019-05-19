FROM saltstack/salt:latest
USER root
RUN apk add --no-cache --update libxml2-dev libxslt-dev
RUN pip3 install --no-cache-dir napalm
USER salt
