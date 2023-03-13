#!/bin/bash

#Giovanni De Franceschi

#store the parameters as variables
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5


#Check how many arguments have been provided at launch
if [ "$#" -ne 5 ]; then
    echo "Incorrect number of arguments given"
    exit 1
fi

#Retrieve and store the node specifications
hostname=$(hostname -f)
lscpu_out=$(lscpu)

cpu_number=$(echo "$lscpu_out" | awk '/^CPU\(s\)/{print $2}')
cpu_architecture=$(echo "$lscpu_out" | awk '/^Architecture/{print $2}')
cpu_model=$(echo "$lscpu_out" | awk '/^Model name/{print $3,$4,$5}')
cpu_mhz=$(echo "$lscpu_out" | awk '/^CPU MHz/{print $3}')
l2_cache=$(echo "$lscpu_out" | awk '/^L2 cache/{print int($3)}')
total_mem=$(vmstat --unit M | awk 'NR==3{print $4}')
timestamp=$(date +"%Y-%m-%d %T") 


#print the varaibles values
echo "Hostname: $hostname"
echo "Number of CPUs: $cpu_number"
echo "CPU Architecture: $cpu_architecture"
echo "CPU Model: $cpu_model"
echo "CPU Speed (MHz): $cpu_mhz"
echo "L2 Cache Size (KB): $l2_cache"
echo "Total Memory (MB): $total_mem"
echo "Timestamp: $timestamp"


insert_stmt="INSERT INTO host_info (
hostname, \
cpu_number, \
cpu_architecture, \
cpu_model, \
cpu_mhz, \
L2_cache, \
total_mem, \
timestamp) VALUES (
'$hostname', \
'$cpu_number', \
'$cpu_architecture', \
'$cpu_model', \
'$cpu_mhz', \
'$l2_cache', \
'$total_mem', \
'$timestamp');"

# save the password as global variable and execute
export PGPASSWORD=$psql_password
psql -h "$psql_host" -p "$psql_port" -d "$db_name" -U "$psql_user" -c "$insert_stmt"
exit $?

