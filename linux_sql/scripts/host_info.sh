#!/bin/bash

hostname=$(hostname -f)
lscpu_out=$(lscpu)

cpu_number=$(echo "$lscpu_out" | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)

#hardware info
hostname=$hostname
cpu_number=$cpu_number
cpu_architecture=$(lscpu | grep "Architecture" | awk '/Architecture/{print $2; exit}')
cpu_model=$(lscpu | grep "Model" | awk '/Model/{print $2; exit}')
cpu_mhz=$(lscpu | grep "CPU MHz" | awk '/MHz/{print $3; exit}')
l2_cache=$(lscpu | grep "L2" | awk '/L2/{print $3; exit}')
total_mem=$(vmstat --unit M | tail -1 | awk '{print $4}')
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

#usage info
memory_free=$(vmstat --unit M | tail -1 | awk -v col="4" '{print $col}')
cpu_idle=$(vmstat | awk '{print $15}'| tail -1)
cpu_kernel=$(vmstat | awk '{print $14}' | tail -1)
disk_io=$(vmstat --unit M -d | tail -1 | awk -v col="10" '{print $col}')
disk_available=$(df $PWD | awk '/[0-9]%/{print $(NF-3)}')

