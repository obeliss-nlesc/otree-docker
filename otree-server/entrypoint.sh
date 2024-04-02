#!/usr/bin/env bash

# Wait for postgresql to start
until /usr/bin/pg_isready -d ${POSTGRES_DB} -h ${POSTGRES_HOST}  -p ${POSTGRES_PORT}  -U ${POSTGRES_USER}; do
	echo 'wait for postgres to start...'
  sleep 5
done

# Setup postgres database link. Environment vars 
# for database link are set in 'config.env'.
export DATABASE_URL=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}/${POSTGRES_DB}

# If run for the first time, set up databases
if [ ! -f "/opt/init/.done" ]; then
    echo "resetting db"
    /usr/bin/env python -u /usr/local/bin/otree resetdb --noinput \
    && touch /opt/init/.done
fi


app_path="/opt/otree"
echo "Installing exp from GIT repo ${GIT_EXP_URL}."
rm -rf ${app_path}
git clone ${GIT_EXP_URL} ${app_path}
echo "Installing dependencies."
pip install --no-cache-dir -r ${app_path}/requirements.txt
echo "Running prod server."
# Start oTree server
cd ${app_path} && otree runprodserver 80

 
