#!/bin/bash

docker-compose -f docker-compose-datanode-cluster.yml -d up

if [ $? -eq 0 ]; then
    echo "Done starting Hadoop Datanode Cluster Docker container"
else
    echo "Failed to start Hadoop Datanode Cluster Docker container Retry with sudo or check the error message"
fi
