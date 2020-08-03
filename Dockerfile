FROM debian:stable-20200607-slim

COPY TDengine-server-2.0.0.0-Linux-x64.deb /

COPY taos.cfg /etc/taos/taos.cfg

RUN mkdir -p /data/log/ && \
    dpkg -i /TDengine-server-2.0.0.0-Linux-x64.deb && \
    rm /TDengine-server-2.0.0.0-Linux-x64.deb && \
    echo "y" |cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENTRYPOINT ["taosd", "-c", "/etc/taos"]
