#!/bin/bash

#Retrieve the parameters from the command line
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

#Verify that the number of parameters given in the CLI
if [ "$#" -ne 5 ]; then
    echo "Incorrect number of arguments given"
    exit 1
fi

hostname=$(hostname -f)

#Gather the system informations
lscpu_out=`lscpu`
cpu_number=$(echo "$lscpu_out"  | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(echo "$lscpu_out" | grep "Architecture:" | awk '{print $2}')
cpu_model=$(echo "$lscpu_out" | grep "Model name:" | awk -F: '{print $2}' | xargs)
cpu_mhz=$(echo "$lscpu_out" | grep "CPU MHz:" | awk '{print $3}' | xargs)
l2_cache=$(echo "$lscpu_out" | grep "L2 cache:" | awk '{print $3}' | xargs)
total_mem=$(vmstat --unit M | tail -1 | awk '{print $4}')
timestamp=$(date +"%Y-%m-%d %T")

#Gather the usage informations
memory_free=$(vmstat --unit M | tail -1 | awk -v col="4" '{print $col}')
cpu_idle=$(vmstat | tail -1 | awk -v col="15" '{print $col}')
cpu_kernel=$(vmstat | tail -1 | awk -v col="14" '{print $col}')
disk_io=$(vmstat --unit M -d | tail -1 | awk -v col="10" '{print $col}')
disk_available=$(df -h / | tail -1 | awk '{print $4}')

#Print to the console the informations
echo "Hostname: $hostname"
echo "Number of CPUs: $cpu_number"

exit 0;
