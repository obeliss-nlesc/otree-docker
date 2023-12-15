
# -- Building the Images

rm-volumes:
	bash -c "docker volume ls | grep otree | awk '{print $$2}' | xargs docker volume rm"

up:
	docker compose -p otree-demos-3 -f docker-compose.yaml up 

up-one:
	docker compose -p otree-demos-1 -f docker-compose-one.yaml up 

down:
	docker compose -p otree-demos-3 -f docker-compose.yaml -v down 

down-one:
	docker compose -p otree-demos-1 -f docker-compose-one.yaml down 


all: otree-server up
	echo "Built all images"

otree-server:
	docker build \
		-f otree-server/Dockerfile \
		-t obeliss/otree-server .
