#!/bin/bash

docker-compose down

if [ $? -eq 0 ]; then
    echo "Done stopping Hadoop Docker containers"
else
    echo "Failed to stop Hadoop Docker containers. Retry with sudo or check the error message"
fi
