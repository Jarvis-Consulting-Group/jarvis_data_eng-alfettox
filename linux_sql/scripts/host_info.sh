
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
    echo "Illegal number of parameters"
    exit 1
fi

#Retrieve and store the node specifications
hostname=$(hostname -f)
lscpu_out=$(lscpu)
cpu_number=$(lscpu | egrep "^CPU\(s\)\:" | awk '{print $2}')
hostname=$hostname
cpu_number=$cpu_number
cpu_architecture=$(lscpu | grep "Architecture" | awk '/Architecture/{print $2; exit}')
cpu_model=$(lscpu | grep "Model" | awk '/Model/{print $2; exit}')
cpu_mhz=$(lscpu | grep "CPU MHz" | awk '/MHz/{print $3; exit}')
l2_cache=$(lscpu | grep "L2" | awk '/L2/{print $3; exit}')
total_mem=$(vmstat --unit M | tail -1 | awk '{print $4}')
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

#Retrieve and store the usage informations
memory_free=$(vmstat --unit M | tail -1 | awk -v col="4" '{print $col}')
cpu_idle=$(vmstat | awk '{print $15}'| tail -1)
cpu_kernel=$(vmstat | awk '{print $14}' | tail -1)
disk_io=$(vmstat --unit M -d | tail -1 | awk -v col="10" '{print $col}')
disk_available=$(df $PWD | awk '/[0-9]%/{print $(NF-3)}')

#Find the id in host_info table
#host_id="(SELECT id FROM host_info WHERE hostname='$hostname')";

#Define the insertion statement
insert_stmt="INSERT INTO host_usage(id, hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, l2_cache, total_mem)
VALUES('$host_id','$hostname','$cpu_number','$cpu_architecture','$cpu_model','$cpu_mhz','$l1_cache','$total_mem')"

#print the inserted statement to the terminal
echo "$insert_stmt";

#Save the password as global variable
export PGPASSWORD=$psql_password 

#Execute the statement
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
exit $?
