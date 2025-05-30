// file: README.md
# Docker-based Ansible Training Solution

## Overview
Spin up a privileged Docker-in-Docker (DIND) controller that launches 5 Ubuntu containers and 
configures them with Ansible, using a non-root `ansible` user with password-less sudo.

## Structure
```
.
├── Makefile
├── docker.d
│   ├── master.docker
│   ├── node.docker
│   └── entrypoint.sh
├── ansible
│   ├── ansible.cfg
│   ├── inventory.ini
│   └── playbook.yml
└── README.md
```

## Prerequisites
- Docker installed on the Ubuntu server  
- GNU Make  
- Git

## Usage
1. Clone the repo:  
   ```bash
   git clone <repo-url>
   cd <repo>
   ```
2. Build and launch
   ```bash
   make run
   ```
3. Enter the controller shell
   ```bash
   make shell
   ```
   Ansible will SSH in as ansible and apply the playbook automatically.

## Learning Outcomes
* Docker-in-Docker orchestration
* Building & launching multiple containers
* Password-less sudo & non-root SSH
* Ansible provisioning
