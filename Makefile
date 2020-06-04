CONTAINER_VERSION = 0.1
CONTAINER_TAG = min_jenkins:$(CONTAINER_VERSION)
CONTAINER_NAME = min_jenkins_container
TIME_ZONE = Asia/Tokyo
VOLUME_DRIVER = local
VOLUME_NAME = jenkins_home
PORT = 8080
ARCHIVE_NAME = jenkins_home_backup.tar.gz


.PHONY: all build run clean
all: run

build: .build

.build: Dockerfile
	docker build -t $(CONTAINER_TAG) .
	touch .build

run: build
	docker volume create -d $(VOLUME_DRIVER) $(VOLUME_OPTION) $(VOLUME_NAME)
	if [ -z "`docker ps | grep $(CONTAINER_NAME)`" ]; then \
		docker run -i -d --rm \
			--name $(CONTAINER_NAME) \
			-p $(PORT):8080 \
			-e TZ=$(TIME_ZONE) \
			-v $(VOLUME_NAME):/var/jenkins_home \
			$(CONTAINER_TAG); \
	fi

clean:
	-docker rm -f $(CONTAINER_NAME)
	rm .build


.PHONY: start stop restart
start: run

stop: clean

restart: stop start


.PHONY: backup restore remove_volume
backup: run
	docker run --rm \
		--volumes-from $(CONTAINER_NAME) \
		--volume `pwd`:/backup \
		busybox \
		tar cvzf /backup/$(ARCHIVE_NAME) -C /var/jenkins_home .

restore: run
	docker run --rm \
		--volumes-from $(CONTAINER_NAME) \
		--volume `pwd`:/restore \
		busybox \
		tar xvpzf /restore/$(ARCHIVE_NAME) -C /var/jenkins_home

remove_volume:
	docker volume rm $(VOLUME_NAME)
