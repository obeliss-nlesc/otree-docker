#!/usr/bin/env bash

# Wait for postgress to start
until /usr/bin/pg_isready -d ${POSTGRES_DB} -h ${POSTGRES_HOST}  -p ${POSTGRES_PORT}  -U ${POSTGRES_USER}; do
	echo 'wait for postgres to start...'
	sleep 5
done

# Setup postgres database link. Environment vars 
# for database link are set in 'config.env'.
export DATABASE_URL=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}/${POSTGRES_DB}

# If run for the first time, set up databases
if [ ! -f "/opt/init/.done" ]; then
    echo "reseting db"
    /usr/bin/env python -u /usr/local/bin/otree resetdb --noinput \
    && touch /opt/init/.done
fi


# Check if /opt/otree is empty and install the demo apps if so 
app_path="/opt/otree"
if [ -z "$(ls -A $app_path)" ]; then
      echo "No app found installing demo apps."
      rm -rf ${app_path}
      cd /opt && echo y > yes && otree startproject otree < yes
      echo "Installing dependancies."
      pip install --no-cache-dir -r ${app_path}/requirements.txt
      echo "Running prod server."
      cd $app_path && otree runprodserver 80
    else
      echo "Installing dependancies."
      pip install --no-cache-dir -r ${app_path}/requirements.txt
      echo "Running prod server."
      # Start oTree server
      cd ${app_path} && otree runprodserver 80
fi

 
