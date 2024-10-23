FROM debian:oldstable

RUN apt update -y && apt upgrade -y && \
	apt install nginx -y && apt install openssl -y

RUN openssl req -batch -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
	-keyout /etc/ssl/private/jramondo.key \
	-out /etc/ssl/certs/jramondo.crt

COPY ./conf/jramondo.42.fr /etc/nginx/sites-available/jramondo.42.fr
RUN ln -s /etc/nginx/sites-available/jramondo.42.fr /etc/nginx/sites-enabled/jramondo.42.fr

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]