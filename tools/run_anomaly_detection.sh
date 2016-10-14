#!/bin/bash
echo scp anomaly detection jar to spark/0:/tmp/anomaly-detection_2.10-1.0.jar
juju scp ./bin/anomaly-detection_2.10-1.0.jar spark/0:/tmp
echo Submit job
juju run --unit spark/0 "su ubuntu -c 'time /usr/bin/spark-submit --class MainRun --total-executor-cores 5 /tmp/anomaly-detection_2.10-1.0.jar --master spark://127.0.0.1 > /tmp/spark_job_results.txt'"
echo get results
juju scp spark/0:/tmp/spark_job_results.txt ../results/spark_job_results-$(date +%H.%M-%d%m%y)
echo clean up
juju run --unit spark/0 "rm /tmp/spark_job_results.txt"
