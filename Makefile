.PHONY: build run shell clean

build:
	# build node image first
	docker build -t ubuntu-ssh -f docker.d/node.docker .
	# then build controller (with only the CLI)
	docker build -t ubuntu-dind-ansible -f docker.d/master.docker .

run: build
	docker run --rm --name training -d \
	  -v $(PWD)/ansible:/opt/ansible \
	  -v /var/run/docker.sock:/var/run/docker.sock \
	  ubuntu-dind-ansible

shell:
	docker exec -it training bash

clean:
	# stop & remove containers
	docker rm -f training node1 node2 node3 node4 node5 || true
	# remove images
	docker rmi -f ubuntu-dind-ansible ubuntu-ssh || true