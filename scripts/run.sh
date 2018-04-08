#!/bin/sh

echo "Getting container ID of the Spark master..."

eval $(docker-machine env node-1)
NODE=$(docker service ps --format "{{.Node}}" spark_master)
eval $(docker-machine env $NODE)
CONTAINER_ID=$(docker ps --filter name=master --format "{{.ID}}")


echo "Copying count.py script to the Spark master..."

docker cp count.py $CONTAINER_ID:/tmp


echo "Running Spark job..."

docker exec $CONTAINER_ID \
  bin/spark-submit \
    --master spark://master:7077 \
    --class endpoint \
    /tmp/count.py
