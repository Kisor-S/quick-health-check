##########################################

#Author: Kishore
#Date  : 04/24

#Monitor the general health of a server(CPU, Memory, Disk, Network, Services)

#Version: v1

##########################################

#Enable strict mode to exit on error
set -euo  pipefail

#Define variables for colors to format the output
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

#Function to print the status messages
print_status() {
        local status=$1 # $1 is the status code (0 for success and non-zero for failure)
        local message=$2 # $2 is the message to display in output

        if [ "$status" -eq 0 ]; then
                echo -e "${GREEN} [OK]${RESET} $message" # if the status is 0, print [OK] and print message in green
        else
                echo -e "${RED} [FAIL]${RESET} $message" # if the status is non-zer0, print [FAIL] and print message in RED
        fi
}

#Start the health check of the node

echo "=============Node Health check============="

#1. Check CPU Load (only 1-minute avearge)

cpu_load=$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1 | xargs) # Using 'uptime' to get load averages and extracting only the 1-minute load value
cpu_threshold=1.5 # set CPU load threshold value

cpu_check=$(echo "$cpu_load > $cpu_threshold" | bc -l) # Compare the current CPU load with the threshold using 'bc' for comparison

print_status "$cpu_check" "CPU Load: $cpu_load" # Print the CPU status (OK if load is below threshold, FAIL otherwise)

# 2. Check Memory Usage

# Extracting the free memory and total memory from the 'free' command
mem_free=$(free -m | awk '/^Mem:/ {print $4}')
mem_total=$(free -m | awk '/^Mem:/ {print $2}')

mem_percent=$((100 - mem_free * 100 / mem_total)) # Calculate memory usage percentage

# If memory usage is less than 90%, it's OK, otherwise FAIL
if [ "$mem_percent" -lt 90 ]; then
    mem_status=0
else
    mem_status=1
fi

print_status "$mem_status" "Memory usage: ${mem_percent}% used" # Print memory status

# 3. Check Disk Usage on Root Filesystem (/)

disk_usage=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

# If disk usage is less than 90%, it's OK, otherwise FAIL
if [ "$disk_usage" -lt 90 ]; then
    disk_status=0
else
    disk_status=1
fi

print_status "$disk_status" "Disk usage on /: ${disk_usage}% used"  # Print disk usage status


# 4. Ping Test - Check if the network is reachable by pinging Google's DNS (8.8.8.8)

ping -c 1 8.8.8.8 > /dev/null 2>&1 # Ping google DNS to verify network connection
ping_status=$? # Check if the ping was successful (0 means success)
                                                                                      
print_status "$ping_status" "Network: Ping to 8.8.8.8" # Print network status (OK if ping succeeded, FAIL if it failed)

# 5. Check if critical service (e.g., sshd) is running

# Using 'systemctl' to check the status of the 'sshd' service
if systemctl is-active --quiet sshd; then
    print_status 0 "Service 'sshd' is running"
else
    print_status 1 "Service 'sshd' is NOT running"
fi

# End of health check output
echo "==========================================="
                                                         