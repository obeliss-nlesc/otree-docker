

# Define a variable to check if Docker Desktop is installed
DOCKER_DESKTOP_CHECK := $(shell docker info 2>/dev/null | grep -i "Docker Desktop" || echo "")
TMP_COMPOSE_FILE := docker-compose.tmp.yaml
SED_COMMAND := sed  's/-\(database[0-9]*\)-\([0-9]*\)/_\1_\2/g' docker-compose.yaml > $(TMP_COMPOSE_FILE)

rm: 
	docker volume ls | grep otree | awk '{print $$2}' | xargs docker volume rm
	docker network ls | grep otree | awk '{print $$2}' | xargs docker network rm

clean: down rm
	echo "Removing volumes"

.PHONY: up
# Check if Docker desktop is installed (MacOS) container naming changes
# between docker desktop and docker cli some - are replaced with _
up: build
ifeq ($(strip $(DOCKER_DESKTOP_CHECK)),)
	@echo "Docker Desktop is not detected. Running docker-compose up."
	docker-compose --compatibility -p otree-demos-3 -f docker-compose.yaml up 
else
	@echo "Docker Desktop is detected. Running sed command and docker compose up."
	$(SED_COMMAND)
	docker compose --compatibility -p otree-demos-3 -f $(TMP_COMPOSE_FILE) up 
endif


down:
ifeq ($(strip $(DOCKER_DESKTOP_CHECK)),)
	docker-compose --compatibility -p otree-demos-3 -f docker-compose.yaml down 
else
	docker compose --compatibility -p otree-demos-3 -f $(TMP_COMPOSE_FILE) down
endif

# -- Building the Images
all: build up
	echo "Built all images"

build:
	cd ./otree-server;docker build -t obeliss/otree-server .


