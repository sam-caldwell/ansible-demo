.PHONY: build run shell

build:
	@docker build -t ubuntu-dind-ansible -f docker.d/master.docker .

run: build
	@docker run --privileged --name training -d \
	  -v $(PWD)/ansible:/ansible ubuntu-dind-ansible

shell:
	@docker exec -it training bash

clean:
	@docker rm -f training node1 node2 node3 node4 node5 || true
	@docker rmi -f ubuntu-dind-ansible ubuntu-ssh || true
