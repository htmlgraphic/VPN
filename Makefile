# Build a container via the command "make build"
# By Jason Gegere <jason@htmlgraphic.com>

TAG 		= 0.5.0
CONTAINER 	= vpn
IMAGE_REPO 	= htmlgraphic
IMAGE_NAME 	= $(IMAGE_REPO)/$(CONTAINER)


all:: help


help:
	@echo ""
	@echo "-- Help Menu for $(IMAGE_NAME):$(TAG)"
	@echo ""
	@echo "     make build		- Build image $(IMAGE_NAME):$(TAG)"
	@echo "     make push		- Push $(IMAGE_NAME):$(TAG) to public docker repo"
	@echo "     make run		- Run docker-compose and create local development environment"
	@echo "     make start		- Start the EXISTING container"
	@echo "     make stop		- Stop container"
	@echo "     make restart	- Stop and start container"
	@echo "     make rm		- Stop and remove container"
	@echo "     make state		- View state container"
	@echo "     make logs		- View logs in real time"

build:
	docker build --rm --no-cache \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		-t $(IMAGE_NAME):$(TAG) .

push:
	@echo "note: If the repository is set as an automated build you will NOT be able to push"
	docker push $(IMAGE_NAME):$(TAG)

run:
	docker run -d -p 500:500/udp -p 4500:4500/udp -p 1701:1701/tcp --privileged --name $(CONTAINER) $(IMAGE_NAME):$(TAG)

start:
	@echo "Starting $(CONTAINER)..."
	docker start $(CONTAINER) > /dev/null

stop:
	@echo "Stopping $(CONTAINER)..."
	docker stop $(CONTAINER) > /dev/null

restart: stop start

rm: stop
	@echo "Removing $(CONTAINER)..."
	docker rm $(CONTAINER) > /dev/null

state:
	docker ps -a | grep $(CONTAINER)

logs:
	@echo "Build $(CONTAINER)..."
	docker logs -f $(CONTAINER)
