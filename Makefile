
# -- Building the Images

rm:
	docker compose -p otree-demos-3 -f docker-compose.yaml -v down 
	docker volume ls | grep otree | awk '{print $$2}' | xargs docker volume rm
	docker network ls | grep otree | awk '{print $$2}' | xargs docker network rm

clean: rm
	echo "Removing volumes"

up:
	docker compose -p otree-demos-3 -f docker-compose.yaml up 

up-one:
	docker compose -p otree-demos-1 -f docker-compose-one.yaml up 

down:
	docker compose -p otree-demos-3 -f docker-compose.yaml down 

down-one:
	docker compose -p otree-demos-1 -f docker-compose-one.yaml down 


all: otree-server up
	echo "Built all images"

build:
	cd ./otree-server;docker build -t obeliss/otree-server .
