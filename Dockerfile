FROM       python:2.7
# https://docs.djangoproject.com/en/1.10/howto/deployment/wsgi/uwsgi/
# https://uwsgi.readthedocs.io/en/latest/Configuration.html
# http://uwsgi-docs.readthedocs.io/en/latest/Options.html
# https://hynek.me/articles/virtualenv-lives/
# https://glyph.twistedmatrix.com/2015/03/docker-deploy-double-dutch.html

ENV        APP_DIR /var/app
WORKDIR    ${APP_DIR}

RUN        pip install --no-cache-dir uwsgi
RUN        useradd uwsgi -s /bin/false
# Why are we logging? How does logging work in EB?
#RUN       mkdir /var/log/uwsgi
#RUN       chown -R uwsgi:uwsgi /var/log/uwsgi

ADD        protoapp_deploy ${APP_DIR}
ADD 	   requirements.txt ${APP_DIR}

RUN	   apt-get update; apt-get install -y memcached postgresql-client

RUN        virtualenv venv
RUN        . venv/bin/activate; pip install --no-cache-dir -r requirements.txt

ENV        PORT                   8080
EXPOSE     ${PORT}

ENV        DJANGO_SETTINGS_MODULE protoapp_deploy.settings

ENV	   MEMCACHED_HOSTNAME	  django-app-test.x0zvy6.cfg.usw2.cache.amazonaws.com
ENV	   MEMCACHED_PORT	  11211

ENV	   RDS_ENGINE	  	  django.db.backends.postgresql_psycopg2
ENV	   RDS_DB_NAME 		  postgres
ENV	   RDS_HOSTNAME		  tf-20161018162448609406890kzt.cgfflaxjadvk.us-west-2.rds.amazonaws.com
ENV	   RDS_PORT               5432
ENV	   RDS_USERNAME           postgres
ENV	   RDS_PASSWORD           postgres

ENV        UWSGI_CHDIR            ${APP_DIR}
ENV        UWSGI_STATIC_MAP	  /static=/var/app/static

ENV        UWSGI_MODULE           protoapp_deploy.wsgi:application
ENV        UWSGI_NUM_PROCESSES    1
ENV        UWSGI_NUM_THREADS      15
ENV        UWSGI_UID              uwsgi
ENV        UWSGI_GID              uwsgi

ENV        UWSGI_HTTP_SOCKET      :${PORT}
ENV        UWSGI_MASTER           TRUE
ENV        UWSGI_VACUUM           TRUE
ENV        UWSGI_VIRTUALENV       venv

RUN        . venv/bin/activate; python manage.py collectstatic --no-input 

ENTRYPOINT [ "/usr/local/bin/uwsgi" ]
