# Build a container via the command "make build"
# By Jason Gegere <jason@htmlgraphic.com>

VERSION 			= 0.5.0
NAME 				= vpn
IMAGE_REPO 	= htmlgraphic
IMAGE_NAME 	= $(IMAGE_REPO)/$(NAME)

all:: help


help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "     make build		- Build image $(IMAGE_NAME):$(VERSION)"
	@echo "     make push		- Push $(IMAGE_NAME):$(VERSION) to public docker repo"
	@echo "     make run		- Run docker-compose and create local development environment"
	@echo "     make start		- Start the EXISTING $(NAME) container"
	@echo "     make stop		- Stop $(NAME) container"
	@echo "     make restart	- Stop and start $(NAME) container"
	@echo "     make rm		- Stop and remove $(NAME) container"
	@echo "     make state		- View state $(NAME) container"
	@echo "     make logs		- View logs in real time"

build:
	docker build --rm --no-cache -t $(IMAGE_NAME):$(VERSION) .

push:
	@echo "note: If the repository is set as an automated build you will NOT be able to push"
	#docker push $(IMAGE_NAME):$(VERSION)
	docker tag -f $(IMAGE_NAME):$(VERSION) $(IMAGE_REPO)/vpn-l2tp:$(VERSION)
	docker push $(IMAGE_REPO)/vpn-l2tp:$(VERSION)
	docker login tutum.co
	docker tag -f $(IMAGE_NAME):$(VERSION) tutum.co/html/vpn:$(VERSION)
	docker tag -f $(IMAGE_NAME):$(VERSION) tutum.co/html/vpn:latest
	docker push tutum.co/html/vpn:$(VERSION)
	docker push tutum.co/html/vpn:latest

run:
	docker run -d -p 500:500/udp -p 4500:4500/udp -p 1701:1701/tcp --privileged --name $(NAME) $(IMAGE_NAME):$(VERSION)

start:
	@echo "Starting $(NAME)..."
	docker start $(NAME) > /dev/null

stop:
	@echo "Stopping $(NAME)..."
	docker stop $(NAME) > /dev/null

restart: stop start

rm: stop
	@echo "Removing $(NAME)..."
	docker rm $(NAME) > /dev/null

state:
	docker ps -a | grep $(NAME)

logs:
	@echo "Build $(NAME)..."
	docker logs -f $(NAME)
