#!/bin/bash
set -e

export ANSIBLE_HOST_KEY_CHECKING=False
echo "Launching 5 SSH-enabled Ubuntu nodes…"
for i in $(seq 1 5); do
  docker run -d --name node$i --network ansible-net ubuntu-ssh
done

echo "Waiting for SSH to come up…"
sleep 10

echo "Running Ansible playbook…"
ansible-playbook -i /opt/ansible/inventory.ini /opt/ansible/playbook.yml

echo "All done!  Container will now stay alive for inspection."
while true; do sleep 86400; done
