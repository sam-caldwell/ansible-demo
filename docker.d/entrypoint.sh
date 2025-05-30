// file: docker.d/entrypoint.sh
#!/bin/bash
set -e

# start Docker daemon
service docker start
sleep 5

# launch 5 SSH-enabled Ubuntu containers on ports 2221–2225
for i in $(seq 1 5); do
  docker run -d --name node$i -p $((2220+i)):22 ubuntu-ssh
done
sleep 5

# run Ansible playbook
ansible-playbook -i /ansible/inventory.ini /ansible/playbook.yml

# keep container alive for inspection
tail -f /dev/null
