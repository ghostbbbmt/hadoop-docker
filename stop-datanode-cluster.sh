#!/bin/bash

docker-compose -f docker-compose-datanode-cluster.yml down

if [ $? -eq 0 ]; then
    echo "Done stopping Hadoop Datanode Cluster Docker container"
else
    echo "Failed to stop Hadoop Datanode Cluster Docker container. Retry with sudo or check the error message"
fi
