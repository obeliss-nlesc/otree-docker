FROM python:3.8-alpine

# This is based in parts on
# https://github.com/trr266/otree_docker

ENV APP_DIR=/opt/otree
ENV DJANGO_SETTINGS_MODULE 'settings'
ARG OTREE_APP_FOLDER=app
ARG OTREE_SOURCE=https://github.com/obeliss-nlesc/otree-core.git@feature/track_participant_ws


# app dirs
RUN mkdir -p ${APP_DIR} \
    && mkdir -p /opt/init

# dev tools
RUN apk -U add --no-cache bash g++ gcc musl-dev postgresql-client postgresql-dev git

# install otree from source
RUN pip install git+${OTREE_SOURCE}

# add it if you need it
#COPY ${OTREE_APP_FOLDER}/requirements.txt ${APP_DIR}

# Install requirements
#RUN pip install --no-cache-dir -r ${APP_DIR}/requirements.txt

# copy app source
#ADD ${OTREE_APP_FOLDER} ${APP_DIR}

# startup script
#ADD entrypoint.sh ${APP_DIR}
ADD entrypoint.sh /root/

#RUN chmod +x ${APP_DIR}/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

WORKDIR ${APP_DIR}
VOLUME /opt/init
#ENTRYPOINT ${APP_DIR}/entrypoint.sh
ENTRYPOINT /root/entrypoint.sh
EXPOSE 80
