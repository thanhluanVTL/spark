# STANDAONE
## Master
### Start
#### Method 1
/opt/spark/bin/spark-class org.apache.spark.deploy.master.Master

#### Method 2
/opt/spark/sbin/start-master.sh

### Stop
/opt/spark/sbin/stop-master.sh



## Worker
### Start
#### Method 1
/opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://spark-master:7077

#### Method 2
/opt/spark/sbin/start-worker.sh spark://spark-master:7077

### Stop
/opt/spark/sbin/stop-worker.sh



service ssh start
sudo service ssh start

ssh luanvt@172.20.0.3

docker exec -it master /bin/bash
docker exec -it worker-a /bin/bash
docker exec -it worker-b /bin/bash

/opt/spark/sbin/start-all.sh

spark-submit --master spark://172.20.0.2:7077 /opt/spark/work-dir/test.py


# USEFUL LINK
https://archive.apache.org/dist/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz