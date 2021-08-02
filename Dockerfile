FROM alpine:latest

RUN apk add --update-cache \
    bash curl mysql-client \
  && rm -rf /var/cache/apk/*

#RUN curl -L https://github.com/dolthub/dolt/releases/latest/download/install.sh | bash \

RUN curl -L https://github.com/dolthub/dolt/releases/latest/download/install.sh | bash \
    && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 

#WORKDIR /var/lib/dolt
RUN adduser -D -u 1000 dolt 

#RUN chown dolt /var/lib/dolt

USER dolt
#WORKDIR /var/lib/dolt

RUN dolt config --global --add user.name "Barry Bernoodle" \
    && dolt config --global --add user.email "barry@dogs.com" \
    && dolt init
    
#RUN dolt init

ENTRYPOINT ["dolt"]

CMD ["sql-server", "--config=sql-server.yml"]
