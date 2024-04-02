
# -- Building the Images

rm: 
	docker volume ls | grep otree | awk '{print $$2}' | xargs docker volume rm
	docker network ls | grep otree | awk '{print $$2}' | xargs docker network rm

clean: down rm
	echo "Removing volumes"

up: build
	docker compose -p otree-demos-3 -f docker-compose.yaml up 

down:
	docker compose -p otree-demos-3 -f docker-compose.yaml down 

all: build up
	echo "Built all images"

build:
	cd ./otree-server;docker build -t obeliss/otree-server .
