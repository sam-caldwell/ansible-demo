.PHONY: build network run shell clean

build:
	# build node image first
	docker build -t ubuntu-ssh -f docker.d/node.docker .
	# then build controller
	docker build -t ubuntu-dind-ansible -f docker.d/master.docker .

network:
	# create a network for ansible + nodes
	docker network create ansible-net || true

run: build network
	# run controller on ansible-net so it can resolve "node1"… through Docker DNS
	docker run --name training -it \
	  --network ansible-net \
	  -v $(PWD)/ansible:/opt/ansible \
	  -v /var/run/docker.sock:/var/run/docker.sock \
	  ubuntu-dind-ansible
	sleep 2
	docker ps

shell:
	docker exec -it training bash

stop:
	docker kill training node1 node2 node3 node4 node5 || true
	docker rm -f training node1 node2 node3 node4 node5 || true

clean: stop
	docker rmi -f ubuntu-dind-ansible ubuntu-ssh || true