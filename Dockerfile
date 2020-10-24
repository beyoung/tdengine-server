FROM debian:stable-20200607 as downloader
RUN apt update -y && apt install curl -y
RUN curl https://www.taosdata.com/download/download-gettingStarted.php?pkg=tdengine_deb \
 --output /TDengine-server-Linux-x64.deb

FROM debian:stable-20200607-slim

COPY --from=downloader /TDengine-server-Linux-x64.deb /

COPY taos.cfg /etc/taos/taos.cfg

RUN mkdir -p /data/log/ && \
    dpkg -i /TDengine-server-Linux-x64.deb && \
    rm /TDengine-server-Linux-x64.deb && \
    echo "y" |cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENTRYPOINT ["taosd", "-c", "/etc/taos"]