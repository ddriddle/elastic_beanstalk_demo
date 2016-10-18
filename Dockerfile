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
RUN        mkdir /var/log/uwsgi
RUN        chown -R uwsgi:uwsgi /var/log/uwsgi

ADD        mysite ${APP_DIR}
ADD 	   requirements.txt ${APP_DIR}
RUN        virtualenv venv
RUN        . venv/bin/activate; pip install -r requirements.txt

ENV        PORT                   8080
# AWS does not like variables...
EXPOSE     8080

ENV        DJANGO_SETTINGS_MODULE mysite.settings

ENV        UWSGI_CHDIR            ${APP_DIR}
ENV        UWSGI_MODULE           mysite.wsgi:application
# ENV        UWSGI_WSGI_FILE        ??????
ENV        UWSGI_NUM_PROCESSES    1
ENV        UWSGI_NUM_THREADS      15
ENV        UWSGI_UID              uwsgi
ENV        UWSGI_GID              uwsgi
# Why do we need/want a log file? Docker apps should logsto stderr.
ENV        UWSGI_LOG_FILE         /var/log/uwsgi/uwsgi.log
ENV        UWSGI_HTTP_SOCKET      :${PORT}
ENV        UWSGI_MASTER           TRUE
ENV        UWSGI_VACUUM           TRUE
ENV        UWSGI_VIRTUALENV       venv

ENV	   RDS_HOSTNAME		  tf-20161018162448609406890kzt.cgfflaxjadvk.us-west-2.rds.amazonaws.com
ENV	   RDS_PORT               5432
ENV	   RDS_DB_NAME 		  postgres
ENV	   RDS_USERNAME           postgres
ENV	   RDS_PASSWORD           postgres

ENTRYPOINT [ "/usr/local/bin/uwsgi" ]
