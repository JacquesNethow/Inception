FROM debian:oldstable

RUN apt update &&\
  apt upgrade -y &&\
  apt install -y mariadb-server procps


RUN mkdir -p /var/run/mysqld \
  && chown -R mysql:mysql /var/run/mysqld \
  && chmod 755 /var/run/mysqld

COPY ./conf/my.cnf /etc/mysql/my.cnf

COPY entrypoint.sh /

RUN chown mysql:mysql entrypoint.sh && chmod 754 entrypoint.sh


USER mysql
EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
