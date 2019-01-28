FROM ubuntu:16.04
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install git net-tools nginx python3-pip
RUN pip3 install --upgrade setuptools pip
RUN pip3 install git+https://github.com/Supervisor/supervisor
RUN pip3 install uwsgi flask requests 
RUN useradd -ms /bin/bash aurora && \
    rm -f /etc/nginx/fastcgi.conf /etc/nginx/fastcgi_params && \
    rm -f /etc/nginx/snippets/fastcgi-php.conf /etc/nginx/snippets/snakeoil.conf
EXPOSE 80
COPY code/supervisord.conf /etc/supervisord.conf
COPY code/wsgi.ini /etc/uwsgi/wsgi.ini
RUN rm -f /etc/nginx/sites-available/default
COPY code/default /etc/nginx/sites-available/default
ENTRYPOINT ["/usr/local/bin/supervisord"]

