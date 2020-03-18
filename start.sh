#!/bin/bash

docker-compose -d up

if [ $? -eq 0 ]; then
    echo "Done starting Hadoop Docker containers"
else
    echo "Failed to start Hadoop Docker containers. Retry with sudo or check the error message"
fi
