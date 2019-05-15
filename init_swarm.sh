#! env bash
read -s -p "vm number to create from 1 to $UPLIMIT: " UPLIMIT

alias dm="docker-machine"
for NODE in `seq 1 $UPLIMIT`; do
  NODE_NAME=node-${NODE}
  dm rm --force $NODE_NAME
  dm create --driver virtualbox $NODE_NAME
done
alias dms="docker-machine ssh"
export IP=$(docker-machine ip node-1)
dms node-1 docker swarm init --advertise-addr $IP;
export JOIN_TOKEN=$(dms node-1 docker swarm join-token worker -q);
for NODE in `seq 2 $UPLIMIT`; do
  NODE_NAME="node-${NODE}"
  dms $NODE_NAME docker swarm join --token $JOIN_TOKEN $IP:2377
done;
dms node-1 "for NODE in $(seq 2 $UPLIMIT);do docker node promote node-$NODE;done"
