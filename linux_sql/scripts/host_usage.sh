#!/bin/bash

#Giovanni De Franceschi

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


timestamp=$(date +"%Y-%m-%d %T")
hostname=$(hostname -f)

#Gather the usage informations
memory_free=$(vmstat --unit M | tail -1 | awk -v col="4" '{print $col}')
cpu_idle=$(vmstat | awk 'NR==3{print $15}')
cpu_kernel=$(vmstat | awk 'NR==3{print $14}')
disk_io=$(vmstat -d | awk 'NR==3{print $10}')
disk_available=$(df -BM / | awk 'NR==2{print $4}' | sed 's/M//')

echo $memory_free
echo $cpu_idle
echo $cpu_kernel
echo $disk_io
echo $disk_available

insert_statement="INSERT INTO host_usage (
	timestamp,
	host_id, 
	memory_free,
	cpu_idle, 
	cpu_kernel,
	disk_io, 
	disk_available 
) VALUES (
	'${timestamp}', 
	    (
      SELECT
        id
      FROM
        host_info
      WHERE
        hostname = '$hostname'
      LIMIT 2
	 ),  
	'${memory_free}',
	'${cpu_idle}', 
	'${cpu_kernel}',
	'${disk_io}', 
	'${disk_available}'
);"

export PGPASSWORD=$psql_password
psql -h $psql_host -U $psql_user -d $db_name -p $psql_port -c "$insert_statement"

exit $?

