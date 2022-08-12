FROM centos:7

ADD ./bin/echo-all /usr/local/bin/echo-all

RUN setcap cap_net_raw=+ep /usr/local/bin/echo-all

CMD ["/usr/local/bin/echo-all"]
