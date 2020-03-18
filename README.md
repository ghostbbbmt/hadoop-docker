# Hadoop Clusters Deployment on Docker

This repository is based on [big-data-europe/docker-hadoop](https://github.com/big-data-europe/docker-hadoop)

## Hadoop version

The default version is 3.2.1.
To select other versions, please specify in the `docker-compose.yml`.
To know all supported versions, review all branches in [big-data-europe/docker-hadoop](https://github.com/big-data-europe/docker-hadoop)

## Requirements

- Latest Docker engine with docker-compose
- If you want to run Hadoop with many datanodes, all datanode clusters must be installed on Linux (see `docker-compose-datanode-clusters.yml` for the reason)

## How to run a basic HDFS cluster

To deploy a basic HDFS cluster, run:

```bash
./start.sh
```

Stop and remove all HDFS containers, network:

```bash
./stop.sh
```

Access all dashboards:

- Namenode: `http://localhost:9870`
- History server: `http://localhost:8188`
- Datanode: `http://localhost:9864`
- Nodemanager: `http://localhost:8042`
- Resource manager: `http://localhost:8088`

## Add a new Datanode Cluster

On the cluster machine, edit the `datanode-cluster.env` docker-compose file by replacing `10.0.0.4` with the IP of the Host machine of the Namenode container.

Then deploy the cluster:

```bash
./start-datanode-cluster.sh
```

Stop and remove the Datanode cluster:

```bash
./stop-datanode-cluster.sh
```

After succesfully cluster deployment, do the Namenode Dashboard > Datanodes. Make sure the new Datanode is added, binded its Host's IP Address and balanced with the correct number of HDFS blocks.

## Test Hadoop with the basic WordCount example

To test Hadoop, attach to the Namenode container:

```bash
docker exec -it namenode bash
```

Create a simple text as the input:

```bash
echo "This is a simple test for Hadoop" > test.txt
```

Then create the corresponding input folder on HDFS:

```bash
hadoop fs -mkdir -p input
```

And copy out test file to HDFS:

```bash
hdfs dfs -put test.txt input/test.txt
```

After preparing the input file, we will get the WordCount program for Hadoop 3.2.1 in the `hadoop-mapreduce-examples` executable jar file (If you use another Hadoop version, please change the path):

```bash
curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-mapreduce-examples/3.2.1/hadoop-mapreduce-examples-3.2.1.jar --output map_reduce.jar
```

Submit our WordCount Job to Hadoop (The program `wordcount` can have different names on each `hadoop-mapreduce-examples` version):

```bash
hadoop jar map_reduce.jar wordcount input output
```

If everything runs fine, we can see the output by requesting data from HDFS:

```bash
hdfs dfs -cat output/part-r-00000
```

Result:

```text
This    1
is      1
a       1
simple  1
test    1
for     1
Hadoop  1
```

## Configure Hadoop variables

See detail in [big-data-europe/docker-hadoop](https://github.com/big-data-europe/docker-hadoop)

## Uninstall Hadoop clusters

You can use my [Docker Commands Toolkt](https://github.com/ghostbbbmt/docker-commands) to clean your host machine

## Known issues

- Namenode will bind `namenode` as its host address. So downloading file via Namenode File System Browser will auto redirect to `http://namenode:9870/webhdfs/v1/....`, which cause errors.
